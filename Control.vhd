LIBRARY ieee ;
USE ieee.std_logic_1164.all;

ENTITY Control IS 
	PORT(
		Opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bits de opcode
		ID_Flush: OUT STD_LOGIC;
		Control_Signals: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);  -- 8 sinais utilizados. OBS: AluOp usa dois bits, com isso 7 + 2 = 9
		Jump: OUT STD_LOGIC
	);
END Control;

ARCHITECTURE behavior OF Control IS

	SIGNAL RegWrite, MemtoReg, Branch, MemWrite, MemRead, ALUSrc, RegDst: STD_LOGIC;
	SIGNAL ALUOp: STD_LOGIC_VECTOR(1 DOWNTO 0); --00(ADD) , 01(SUB) , 10( CAMPO ADD/SUB)
	
	BEGIN
		PROCESS(Opcode)
			BEGIN
				RegWrite <= '0'; --WB
				MemtoReg <= '0'; --WB
				Branch <= '0';	--M
				MemWrite <= '0'; --M
				MemRead <= '0';  --M
				ALUSrc  <= '0';  --EX
				ALUOp   <= "00";  --EX
				RegDst  <= '0';  --EX
				ID_Flush <= '0';
				Jump <= '0';
				
			CASE Opcode IS
				WHEN "000" =>  --NOP
					ID_Flush <= '1'; -- ZERA OS SINAIS DE CONTROLE
					Jump <= '0';
					RegWrite <= '0'; 
					MemtoReg <= '0'; 
					Branch <= '0';	
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  
					ALUOp   <= "00";  
					RegDst  <= '0';  
				
				WHEN "001" =>  --LW
					RegWrite <= '1'; -- ESCREVE NO REG_DST
					MemtoReg <= '0'; 
					Branch <= '0';	
					MemWrite <= '0'; 
					MemRead <= '1';  
					ALUSrc  <= '1';  -- USA O IMEDIATO
					ALUOp   <= "00"; -- SOMA
					RegDst  <= '0';  -- Rt
					
				WHEN "010" =>  --SW
					RegWrite <= '0'; 
					MemtoReg <= '0'; -- 0 OU 1 PODE SER QUALQUER UM
					Branch <= '0';	
					MemWrite <= '1'; 
					MemRead <= '0';  
					ALUSrc  <= '1';  -- USA O IMEDIATO
					ALUOp   <= "00"; -- SOMA
					RegDst  <= '0';  -- 0 OU 1 PODE SER QUALQUER UM
					
				WHEN "011" =>  --R_TYPE
					RegWrite <= '1'; -- ESCREVE NO REG_DST
					MemtoReg <= '1';
					Branch <= '0';	
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  -- USA O IMEDIATO
					ALUOp   <= "10"; -- CAMPO ADD/SUB
					RegDst  <= '1';  -- Rd
					
				WHEN "100" =>  --BEQ 
					RegWrite <= '0'; 
					MemtoReg <= '1'; -- 0 OU 1 PODE SER QUALQUER UM
					Branch <= '1';	
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';    
					ALUOp   <= "01";  
					RegDst  <= '1'; -- 0 OU 1 PODE SER QUALQUER UM  
					
				WHEN "101" =>  --JMP
					Jump <= '1';
					RegWrite <= '0'; 
					MemtoReg <= '1'; -- COMO JA RESOLVE NO SEGUNDO ESTAGIO, TANTO FAZ OS SINAIS AQUI
					Branch <= '0';	
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI 
					ALUOp   <= "00"; -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI 
					RegDst  <= '1';  -- COMO JA RESOLVE NO SEGUNDO 	ESTAGIO, TANTO FAZ OS SINAIS AQUI
					
				WHEN OTHERS => --Opcode invalido
				
					ID_Flush <= '1';
					RegWrite <= '0'; 
					MemtoReg <= '0';
				   Branch <= '0';		
					MemWrite <= '0'; 
					MemRead <= '0';  
					ALUSrc  <= '0';  
					ALUOp   <= "00"; 
					RegDst  <= '0';
			 END CASE;
			 
			END PROCESS;
			
		 -- Concatena os 9 bits de controle na ordem: [8]RegDst, [7]ALUSrc, [6-5]ALUOp, [4]Branch, [3]MemRead, [2]MemWrite, [1]MemtoReg, [0]RegWrite
		 Control_Signals <= RegDst & ALUSrc & ALUOp & Branch & MemRead & MemWrite & MemtoReg & RegWrite;
END behavior;