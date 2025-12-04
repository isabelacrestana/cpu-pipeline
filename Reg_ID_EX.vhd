LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 84 bits
ENTITY Reg_ID_EX IS 
	PORT(
		Clk   : IN STD_LOGIC;
		D     : IN STD_LOGIC_VECTOR(83 DOWNTO 0);
		Q     : OUT STD_LOGIC_VECTOR(83 DOWNTO 0)
		-- mapeamento:
		-- 83 a 82 : WB (RegWrite, MemtoReg)
	   -- 81 a 80 : M  (MemWrite, MemRead)
	   -- 79 a 76 : EX (ALUop(2bits), ALUSrc, RegDst)
		-- 75 a 60 : PcPlus4
		-- 59 a 44 : Read_data1
		-- 43 a 28 : Read_data2
		-- 27 a 12 : Imed_extend
		-- 11 a 8  : rs
		-- 7  a 4  : rt
		-- 3  a 0  : rd	
		
 	);
END Reg_ID_EX;

ARCHITECTURE behavior OF Reg_ID_EX IS
BEGIN
	PROCESS(Clk)
	BEGIN
		IF FALLING_EDGE(Clk) THEN	
				Q <= D;

		END IF;
	END PROCESS;
		
END behavior;