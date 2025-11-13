LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 40 bits
ENTITY Reg_EX_MEM IS 
	PORT(	
			Clk : IN STD_LOGIC;
			D   : IN  STD_LOGIC_VECTOR(39 DOWNTO 0);
			Q   : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)
			
			-- mapeamento 
			-- 39 a 38 : WB  (RegWrite, MemtoReg)
			-- 37 a 36 : M ( MemWrite, MemRead)
			-- 35 a 20 : Alu_Result
			-- 19 a 4  : Alu_B
			-- 3 a 0   : rtOrRdNum 
 	);
END Reg_EX_MEM;

ARCHITECTURE behavior OF Reg_EX_MEM IS
BEGIN
	PROCESS(Clk)
	BEGIN
		IF Clk'EVENT AND Clk='1' THEN		
			Q <= D;
		END IF;
	END PROCESS;
		
END behavior;