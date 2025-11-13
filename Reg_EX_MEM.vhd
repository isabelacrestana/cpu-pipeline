LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 40 bits
ENTITY Reg_EX_MEM IS 
	PORT(	
			Clk : IN STD_LOGIC;
			D   : IN  STD_LOGIC_VECTOR(40 DOWNTO 0);
			Q   : OUT STD_LOGIC_VECTOR(40 DOWNTO 0)
			
			-- mapeamento 
			-- 39 a 38 : M  (MemWrite, MemRead)
			-- 37 a 36 : WB (memToReg and regWrite)
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