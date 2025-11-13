LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- registrador de 32 bits
ENTITY Reg_IF_ID IS 
	PORT(	
			Clk   : IN STD_LOGIC;
			D     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			Q     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			wr    : IN STD_LOGIC;	-- sinal de escrita (IF/ID Write)
			flush : IN STD_LOGIC -- sinal de reset do registrador
			-- mapeamento 
			-- 31 a 16 : PC + 4
			-- 15 a 0  : instrucao 
 	);
END Reg_IF_ID;

ARCHITECTURE behavior OF Reg_IF_ID IS
BEGIN
	PROCESS(Clk, flush, wr)
	BEGIN
		IF RISING_EDGE(Clk) THEN
			IF flush = '1' THEN
				Q <= (OTHERS => '0');
			
			ELSIF wr = '1' THEN		
				Q <= D;
				
			END IF;
		END IF;
	END PROCESS;
		
END behavior;