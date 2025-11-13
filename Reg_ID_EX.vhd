LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 80 bits
ENTITY Reg_ID_EX IS 
	PORT(
		Clk   : IN STD_LOGIC;
		D     : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
		Q     : OUT STD_LOGIC_VECTOR(79 DOWNTO 0)
		-- mapeamento:
		-- 79 a 78 : WB (RegWrite, MemtoReg)
	   -- 77 a 76 : M  (MemWrite, MemRead)
	   -- 75 a 72 : EX (ALUop(2bits), ALUSrc, RegDst)
		-- 71 a 56 : PcPlus4
		-- 55 a 40 : Read_data1
		-- 39 a 24 : Read_data2
		-- 23 a 8  : Imed_extend
		-- 7  a 4  : rt
		-- 3  a 0  : rd	
		
 	);
END Reg_ID_EX;

ARCHITECTURE behavior OF Reg_ID_EX IS
BEGIN
	PROCESS(Clk)
	BEGIN
		IF RISING_EDGE(Clk) THEN	
				Q <= D;

		END IF;
	END PROCESS;
		
END behavior;