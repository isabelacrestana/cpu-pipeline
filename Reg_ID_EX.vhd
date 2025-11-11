LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 84 bits
ENTITY Reg_ID_EX IS 
	PORT(
		Clk: IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(83 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(83 DOWNTO 0)
		
		-- mapeamento:
		-- 83 a 80 : EX
	   -- 79 a 78 : M
	   -- 77 a 60 : WB
		-- 75 a 59 : PcPlus4
		-- 59 a 44 : Read_data1
		-- 43 a 28 : Read_data2
		-- 27 a 12  : Imed_extend
		-- 11 a 8  : rs
		-- 7  a 4  : rt
		-- 3  a 0  : rd	
		
 	);
END Reg_ID_EX;

ARCHITECTURE behavior OF Reg_ID_EX IS
	BEGIN
		PROCESS(Clk)
		  BEGIN
			IF Clk'EVENT AND Clk='1' THEN
				Q <= D;
			END IF;
		  END PROCESS;
		
	END behavior;