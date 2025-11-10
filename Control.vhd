LIBRARY ieee ;
USE ieee.std_logic_1164.all;

ENTITY Control IS 
	PORT(
		Opcode: STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bits de opcode
		ID_Flush: OUT STD_LOGIC;
		Control_Signals: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- 7 sinais utilizados. OBS: AluOp usa dois bits, com isso 6 + 2 = 8
	);
END stateMachine;

ARCHITECTURE behavior OF Control IS

	SIGNAL RegWrite, MemtoReg, MemWrite, MemRead, ALUSrc, RegDst: STD_LOGIC;
	SIGNAL ALUOp: STD_LOGIC_VECTOR(1 DOWNTO 0); --00(ADD) , 01(SUB) , 10( CAMPO ADD/SUB)
	
		PROCESS(Opcode)
			BEGIN
				RegWrite <= '0'; --WB
				MemtoReg <= '0'; --WB
				MemWrite <= '0'; --M
				MemRead <= '0';  --M
				ALUSrc  <= '0';  --EX
				ALUOp   <= '0';  --EX
				RegDst  <= '0';  --EX
				ID_Flush <= '0';
				
			CASE Opcode IS
				WHEN '000' =>  --NOP
					ID_Flush <= '1'; -- ZERA OS SINAIS DE CONTROLE 
					RegWrite <= '0'; 
					MemtoReg <= '0'; 
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  
					ALUOp   <= '0';  
					RegDst  <= '0';  
				
				WHEN '001' =>  --LW
					RegWrite <= '1'; -- ESCREVE NO REG_DST
					MemtoReg <= '0'; 
					MemWrite <= '0'; 
					MemRead <= '1';  
					ALUSrc  <= '1';  -- USA O IMEDIATO
					ALUOp   <= '00'; -- SOMA
					RegDst  <= '0';  -- Rt
					
				WHEN '010' =>  --SW
					RegWrite <= '0'; 
					MemtoReg <= '0'; -- 0 OU 1 PODE SER QUALQUER UM 
					MemWrite <= '1'; 
					MemRead <= '0';  
					ALUSrc  <= '1';  -- USA O IMEDIATO
					ALUOp   <= '00'; -- SOMA
					RegDst  <= '0';  -- 0 OU 1 PODE SER QUALQUER UM
					
				WHEN '011' =>  --R_TYPE
					RegWrite <= '1'; -- ESCREVE NO REG_DST
					MemtoReg <= '1'; 
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  -- USA O IMEDIATO
					ALUOp   <= '10'; -- CAMPO ADD/SUB
					RegDst  <= '1';  -- Rd
					
				WHEN '100' =>  --BEQ 
					RegWrite <= '0'; 
					MemtoReg <= '1'; -- COMO JA RESOLVE NO SEGUNDO ESTAGIO, TANTO FAZ OS SINAIS AQUI
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI 
					ALUOp   <= '00'; -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI 
					RegDst  <= '1';  -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI 
					
				WHEN '101' =>  --JMP
					RegWrite <= '0'; 
					MemtoReg <= '1'; -- COMO JA RESOLVE NO SEGUNDO ESTAGIO, TANTO FAZ OS SINAIS AQUI
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI 
					ALUOp   <= '00'; -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI 
					RegDst  <= '1';  -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI
			 END CASE;
			 
			END PROCESS;
			
		 -- Concatena os 8 bits de controle na ordem: [7]RegDst, [6]ALUSrc, [5-4]ALUOp, [3]MemRead, [2]MemWrite, [1]MemtoReg, [0]RegWrite
		 Control_Signals <= RegDst & ALUSrc & ALUOp & MemRead & MemWrite & MemtoReg & RegWrite;
END behavior;