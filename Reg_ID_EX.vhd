LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 84 bits
ENTITY Reg_ID_EX IS 
	PORT(
		Clk   : IN STD_LOGIC;
		D     : IN STD_LOGIC_VECTOR(83 DOWNTO 0);
		Q     : OUT STD_LOGIC_VECTOR(83 DOWNTO 0);
		flush : IN STD_LOGIC -- sinal de reset (para bubble)
		
		-- mapeamento:
		-- 83 a 80 : EX (ALUSrc, AluOp(2 bits) and RegDst)
	   -- 79 a 78 : M  (MemWrite, MemRead)
	   -- 77 a 76 : WB (memToReg and regWrite)
		-- 75 a 59 : PcPlus4
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
	PROCESS(Clk, flush)
	BEGIN
		IF RISING_EDGE(Clk) THEN
			IF flush = '1' THEN
				Q <= (OTHERS => '0');
				
			ELSE		
				Q <= D;
				
			END IF;
		END IF;
	END PROCESS;
		
END behavior;