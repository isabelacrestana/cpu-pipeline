LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY cpu IS
	PORT (Clock_50 : IN STD_LOGIC;
  
			HEX7, HEX6, HEX5, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
					  
			KEY  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);    -- posicao 0 = ENABLE  
			LEDR : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- 0: adiantamento forward unit, 1: harzard de load

		  );
END cpu;

ARCHITECTURE behavior OF cpu IS

	SIGNAL r0, r1, r2, r3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	-- mudanca na frequencia do clock
	
	CONSTANT max: INTEGER := 100000000;			-- Ciclo do clock (é ajustável)
	CONSTANT half: INTEGER := max/2;				-- Meio Ciclo
	SIGNAL clockticks: INTEGER RANGE 0 TO max;-- Conta cada ciclo do clock de entrada
	SIGNAL clock: STD_LOGIC;	

	-- sinais internos	
	SIGNAL pcDataIn : STD_LOGIC_VECTOR(15 DOWNTO 0);  -- dado que entra no PC
	SIGNAL pcDataOut : STD_LOGIC_VECTOR(15 DOWNTO 0); -- dado que sai do PC
	SIGNAL pcWrite : STD_LOGIC := '0'; -- sinal para habilitar escrita no PC
	
	SIGNAL instruction : STD_LOGIC_VECTOR(15 DOWNTO 0);   -- saída da memoria de inst (depois do fetch)
	SIGNAL pcPlus2Res : STD_LOGIC_VECTOR(15 DOWNTO 0);    -- PC já incrementado (saída do somador)
	
	SIGNAL branchTarget : STD_LOGIC_VECTOR(15 DOWNTO 0); -- endereco do salto do branch
	SIGNAL pcSource : STD_LOGIC := '0'; -- sinal de controle do mux PC Source
	SIGNAL pcSourceOut : STD_LOGIC_VECTOR(15 DOWNTO 0); -- saída do mux PC Source
	
	SIGNAL jumpTarget : STD_LOGIC_VECTOR(15 DOWNTO 0); -- endereco de salto do jump
	SIGNAL jump : STD_LOGIC; -- sinal de controle do mux Jump
	
	SIGNAL ifIdWrite : STD_LOGIC;  -- sinal para habilitar escrita
	SIGNAL ifFlush : STD_LOGIC;    -- sinal para zerar o reg
	
	SIGNAL If_Id_Out : STD_LOGIC_VECTOR(31 DOWNTO 0); -- conteudo do reg IF/ID
	
	
	SIGNAL writeData: STD_LOGIC_VECTOR(15 DOWNTO 0); -- -- dado que sera escrito no regBank
	SIGNAL readData1: STD_LOGIC_VECTOR(15 DOWNTO 0);   -- dados lidos de rs
	SIGNAL readData2: STD_LOGIC_VECTOR(15 DOWNTO 0);   -- dados lidos de rT
	SIGNAL writeRegister: STD_LOGIC_VECTOR(3 DOWNTO 0); -- registrador que sera escrito o dado
	SIGNAL readRegister1: STD_LOGIC_VECTOR(3 DOWNTO 0); -- registrador que sera lido o dado 1
	SIGNAL readRegister2: STD_LOGIC_VECTOR(3 DOWNTO 0); -- registrador que sera lido o dado 2

	SIGNAL signExtend_Out: STD_LOGIC_VECTOR(15 DOWNTO 0); -- saida do Sign Extend
	
	SIGNAL shiftLeftBranch_out: STD_LOGIC_VECTOR(15 DOWNTO 0); -- saida do shift left 1 para o branch
	SIGNAL shiftLeftJump_Out: STD_LOGIC_VECTOR(13 DOWNTO 0); -- saida do shift left 1 para o jump
	
	SIGNAL branchAndBranchTaken: STD_LOGIC;
	
	SIGNAL flush_hazard_detec: STD_LOGIC; -- Sinal de flush caso haja hazard com load
	SIGNAL ID_Flush: STD_LOGIC; -- sinal de flush para instrução NOP 
	SIGNAL Flush: STD_LOGIC; -- sinal de flush apos o OR que entra no MUX de flush
	SIGNAL controlSignals: STD_LOGIC_VECTOR(7 DOWNTO 0); -- Sinais de controle
	SIGNAL signalsOut: STD_LOGIC_VECTOR(7 DOWNTO 0); -- Saida dos sinais do MUX de ID_Flush
	
	SIGNAL branch: STD_LOGIC; --sinal de controle para determinar se há uma instrucao de BEQ
	SIGNAL branchTaken: STD_LOGIC; --sinal de controle para determinar se há uma instrucao de BEQ
	
	SIGNAL Id_Ex_Out: STD_LOGIC_VECTOR(83 DOWNTO 0); -- conteudo do reg ID/EX
	
	
	SIGNAL aluSrc_Out: STD_LOGIC_VECTOR(15 DOWNTO 0); -- output do mux alu src
	SIGNAL MemtoReg_Out: STD_LOGIC_VECTOR(15 DOWNTO 0); -- output do mux MemtoReg
	
	SIGNAL Forward_A: STD_LOGIC_VECTOR(1 DOWNTO 0); -- sinal de controle do mux de forward A
	SIGNAL Forward_B: STD_LOGIC_VECTOR(1 DOWNTO 0); -- sinal de controle do mux de forward B
	
	SIGNAL ALU_SrcA: STD_LOGIC_VECTOR(15 DOWNTO 0); -- Entrada A da ALU
	SIGNAL ALU_SrcB: STD_LOGIC_VECTOR(15 DOWNTO 0); -- Entrada B da ALU
	
	SIGNAL ALU_opcode: STD_LOGIC; -- Operação que a ALU irá fazer, 0(add) or 1(sub)
	SIGNAL Alu_result: STD_LOGIC_VECTOR(15 DOWNTO 0); -- Resultado da ALU
	
	SIGNAL Reg_Destiny: STD_LOGIC_VECTOR(3 DOWNTO 0); -- Registrador Destino(rt or rd)
	
	SIGNAL Ex_Mem_Out: STD_LOGIC_VECTOR(39 DOWNTO 0); -- conteudo do reg EX/MEM
	
	
	SIGNAL readDataMem: STD_LOGIC_VECTOR(15 DOWNTO 0); -- conteudo lido da memoria de dados
	
	SIGNAL Mem_Wb_Out: STD_LOGIC_VECTOR(37 DOWNTO 0); -- conteudo do reg MEM/WB 
	SIGNAL address_out:  STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN


	hex_pc: sevenSegs PORT MAP(pcDataOut(3 DOWNTO 0), HEX5);
	hex_r0: sevenSegs PORT MAP(r0, HEX3); 
	hex_r1: sevenSegs PORT MAP(r1, HEX2); 
	hex_r2: sevenSegs PORT MAP(r2, HEX1); 
	hex_r3: sevenSegs PORT MAP(r3, HEX0); 	
	
	hex_MemtoReg_Out: sevenSegs PORT MAP( ALU_SrcB(3 DOWNTO 0), HEX7);
	hex_debug: sevenSegs PORT MAP(Ex_Mem_Out(7 DOWNTO 4), HEX6);

	LEDR(2) <= clock;
	
	-- 1 caso haja adiantamento
	PROCESS(Forward_A, Forward_B) 
	BEGIN
		IF (Forward_A = "10") OR (Forward_B = "10") OR (Forward_A = "01") OR (Forward_B = "01")THEN
			LEDR(0) <= '1';
		ELSE
			LEDR(0) <= '0';
		END IF;
	END PROCESS;
	
	-- 1 caso tenha stall
	LEDR(1) <= NOT pcWrite;

	
	
	-- 1° ESTÁGIO PIPELINE
	
		-- PC
		PC: PCReg PORT MAP(pcDataIn, clock, pcWrite, NOT KEY(0), pcDataOut);
	
		-- Memoria de Instrucoes
		Instuction_Memory: instructionMemory PORT MAP(pcDataOut, instruction, clock);
	
		-- PC + 2 Adder               constante 2 para entrar no somador
		PC_Adder : adder PORT MAP(pcDataOut, "0000000000000010", pcPlus2Res);

		-- Mux PC Source
		Mux_PC_Source: mux2to1 PORT MAP(pcPlus2Res, branchTarget, pcSource, pcSourceOut);
	
		-- Mux Jump
		Mux_Jump : mux2to1 PORT MAP(pcSourceOut, jumpTarget, jump, pcDataIn);
			
		-- Registrador IF/ID
		Register_IF_ID : Reg_IF_ID PORT MAP(clock, pcPlus2Res & instruction, If_Id_Out, ifIdWrite, ifFlush);
		
		
------------------------------
	
	-- 2° ESTÁGIO PIPELINE
	
		writeData     <= MemtoReg_Out;
		writeRegister <= Mem_Wb_Out(3 DOWNTO 0);
		readRegister1 <= If_Id_Out(12 DOWNTO 9);
		readRegister2 <= If_Id_Out( 8 DOWNTO 5);
	
		-- RegBank																																--reg write--
		Reg_Bank: regBank PORT MAP(writeData, readData1, readData2, writeRegister, readRegister1, readRegister2, Mem_Wb_Out(37), clock, NOT KEY(2), r0, r1, r2, r3);
		
		-- Signal Extend
		Signal_Extend: signalExtend PORT MAP(If_Id_Out(4 DOWNTO 0), signExtend_Out);
		
		-- ShiftLeft Branch
		Shift_Left_Branch: shiftLeftBranch PORT MAP(signExtend_Out, shiftLeftBranch_out);
		
		-- Branch Adder				  --------pc+2----------	
		Branch_Adder: Adder PORT MAP(If_Id_Out(31 DOWNTO 16), shiftLeftBranch_out, branchTarget);
				
		-- ShiftLeft Jump
		Shift_Left_Jump: shiftLeftJump PORT MAP(If_Id_Out(12 DOWNTO 0), shiftLeftJump_Out);
		
		-- Jump Address Concatenation 
							-- 2 bits do pc+2 -- 
		jumpTarget <= If_Id_Out(31 DOWNTO 30) & shiftLeftJump_Out;
		
		-- Control                    -- opcode da instrucao --
		Control_unit: Control PORT MAP(If_Id_Out(15 DOWNTO 13), ID_Flush, controlSignals, branch, jump);
		
		-- Hazard Detection Unit                                    rs (est 2)         reg t (estagio 2)        rt (est 3)        MemRead (est 3) 
		HazardDetection_Unit: Hazard_Detection_Unit PORT MAP(If_Id_Out(12 DOWNTO 9), If_Id_Out(8 DOWNTO 5), Id_Ex_Out(7 DOWNTO 4), Id_Ex_Out(76), flush_hazard_detec, pcWrite, ifIdWrite);
		
		-- Comparator (xnor) (branch)                    
		Comparator_Hardware: comparator PORT MAP(readData1, readData2, branchTaken);
		
		-- Branch and BranchTaken
		branchAndBranchTaken <= branchTaken AND branch;
		
		ifFlush  <= branchAndBranchTaken;
		pcSource <= branchAndBranchTaken;
		
		-- ID_Flush OR flush_hazard_detec
		Flush <= ID_Flush OR flush_hazard_detec;
		
		-- MUX ID Flush                                  -- para bublle --
		MUX_ID_Flush: mux2to1_8bits PORT MAP(controlSignals, "00000000", Flush, signalsOut);
		
		-- Reg ID/EX                                                 -- pc+2 --                                                          -- rs --                -- rt --                 -- rd --
		Register_ID_EX: Reg_ID_EX PORT MAP(Clock, signalsOut & If_Id_Out(31 DOWNTO 16) & readData1 & readData2 & signExtend_Out & If_Id_Out(12 DOWNTO 9) & If_Id_Out(8 DOWNTO 5) & If_Id_Out(4 DOWNTO 1), Id_Ex_Out);
		
------------------------------

	-- 3° ESTÁGIO PIPELINE
	
		-- Mux AluSource                 -- readData2 --          -- imed ext --        -- aluSrc --
		MUX_ALU_Src: mux2to1 PORT MAP(Id_Ex_Out(43 DOWNTO 28), Id_Ex_Out(27 DOWNTO 12), Id_Ex_Out(77), aluSrc_Out);
		
		-- Mux Forward_A                    readData1 (2 est)    dado do 5 est    Alu Result (4 est) 
		MUX_Forward_A: mux3to1 PORT MAP(Id_Ex_Out(59 DOWNTO 44), MemtoReg_Out, Ex_Mem_Out(35 DOWNTO 20), Forward_A, ALU_SrcA);
		
		-- Mux Forward_B               dado do 2 est  dado do 5 est      alu result (4 est)
		MUX_Forward_B: mux3to1 PORT MAP(aluSrc_Out,  MemtoReg_Out,  Ex_Mem_Out(35 DOWNTO 20), Forward_B, ALU_SrcB);
		
		-- Mux Reg_Dst                    -- rt --                 -- rd --         -- regDst -- 
		MUX_Reg_Dst: mux2to1_4bits PORT MAP(Id_Ex_Out(7 DOWNTO 4), Id_Ex_Out(3 DOWNTO 0), Id_Ex_Out(76), Reg_Destiny);
		
		-- ALU_Control                     -- function --         -- AluOp --         
		ALU_Controler: ALU_Control PORT MAP(Id_Ex_Out(12), Id_Ex_Out(79 DOWNTO 78), ALU_opcode);
		
		-- Forward Unity                     -- regWrite --  -- memWrite --      -- rtOrRdNum --       -- rtOrRdNum--               -- rs --               -- rt --  
		Forward_Unity: Forward_Unit PORT MAP(Ex_Mem_Out(39),  Mem_Wb_Out(37), Ex_Mem_Out(3 DOWNTO 0), Mem_Wb_Out(3 DOWNTO 0), Id_Ex_Out(11 DOWNTO 8), Id_Ex_Out(7 DOWNTO 4), Forward_A, Forward_B);
		
		-- ALU 
		ULA: alu PORT MAP(ALU_SrcA, ALU_SrcB, ALU_opcode, Alu_result);
		
		-- Reg EX/MEM                                  -- sinais de WB --                                       
		Register_EX_MEM: Reg_Ex_Mem PORT MAP(clock, iD_Ex_Out(83 DOWNTO 80) & Alu_result & Alu_SrcB & Reg_Destiny, Ex_Mem_Out);
		
------------------------------
		
	-- 4° ESTÁGIO PIPELINE
	
		-- Data Memory                      -- Alu_B --                         -- AluResult  --        -- memWrite --   -- memRead --                 
		Data_Memory: dataMemory PORT MAP(Ex_Mem_Out(19 DOWNTO 4), readDataMem, Ex_Mem_Out(35 DOWNTO 20), Ex_Mem_Out(37), Ex_Mem_Out(36), clock, address_out);
		 
		-- Reg MEM/WB                                -- WB signals --                           -- AluResult --           -- rtOrRdNum --
		Register_MEM_WB: Reg_MEM_WB PORT MAP(clock, Ex_Mem_Out(39 DOWNTO 38) & readDataMem & Ex_Mem_Out(35 DOWNTO 20) & Ex_Mem_Out(3 DOWNTO 0), Mem_Wb_Out);
		
------------------------------

	-- 5° ESTÁGIO PIPELINE
	
		-- Mux MemToReg                    -- AluResult --           -- memData --        -- memToReg --
		Mux_MemtoReg: mux2to1 PORT MAP(Mem_Wb_Out(19 DOWNTO 4), Mem_Wb_Out(35 DOWNTO 20), Mem_Wb_Out(36), MemtoReg_Out);
		
		
----- ALTERANDO FREQUENCIA DO CLOCK --------
	ClockDivide: PROCESS
	BEGIN
		WAIT UNTIL Clock_50'EVENT and Clock_50 = '1';
		IF clockticks < max THEN
			 clockticks <= clockticks + 1;
		ELSE
			 clockticks <= 0;
		END IF;
		IF clockticks < half THEN
			 clock <= '0';
		ELSE
			 clock <= '1';
		END IF;
  END PROCESS;


END behavior;