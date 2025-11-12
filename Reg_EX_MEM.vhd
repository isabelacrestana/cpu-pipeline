LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 42 bits
ENTITY Reg_EX_MEM IS 
	PORT(	
			Clk : IN STD_LOGIC;
			D   : IN  STD_LOGIC_VECTOR(41 DOWNTO 0);
			Q   : OUT STD_LOGIC_VECTOR(41 DOWNTO 0)
			
			-- mapeamento 
			-- 41 a 39 : M  (MemWrite, MemRead, Branch)
			-- 38 a 37 : WB (memToReg and regWrite)
			-- 36      : zero
			-- 35 a 20 : Alu_Out
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