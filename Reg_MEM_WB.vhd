LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 38 bits
ENTITY Reg_MEM_WB IS 
	PORT(	
			Clk : IN STD_LOGIC;
			D   : IN  STD_LOGIC_VECTOR(37 DOWNTO 0);
			Q   : OUT STD_LOGIC_VECTOR(37 DOWNTO 0);	
			
			-- mapeamento 
			-- 37 a 36 : WB
			-- 35 a 20 : memData
			-- 19 a 4  : Alu_result
			-- 3  a 0  : rtOrRdNum
 	);
END Reg_MEM_WB;

ARCHITECTURE behavior OF Reg_MEM_WB IS
BEGIN
	PROCESS(Clk)
	BEGIN
		IF Clk'EVENT AND Clk='1' THEN		
			Q <= D;
		END IF;
	END PROCESS;
		
END behavior;