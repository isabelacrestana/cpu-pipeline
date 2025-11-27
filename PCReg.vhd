LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY PCReg IS
	PORT (D                  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Clock, Rin, Reset  : IN STD_LOGIC;
		   Q                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END PCReg;

ARCHITECTURE behavior OF PCReg IS
BEGIN
	PROCESS (Clock, Rin, Reset)
	BEGIN
	
		IF Reset = '1' THEN
			Q <= "0000000000000000";
		
		ELSIF FALLING_EDGE(Clock) THEN
			IF Rin = '1' THEN 
				Q <= D;
			END IF;
		END IF;
		
	END PROCESS;
	
END behavior;