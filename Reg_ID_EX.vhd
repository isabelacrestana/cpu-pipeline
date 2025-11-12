LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 85 bits
ENTITY Reg_ID_EX IS 
	PORT(
		Clk: IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(84 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(84 DOWNTO 0)
		
		-- mapeamento:
		-- 84 a 81 : EX   (ALUSrc, AluOp(2 bits) and RegDst)
	   -- 80 a 78 : M    (MemWrite, MemRead, Branch)
	   -- 77 a 76 : WB   (memToReg and regWrite)
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