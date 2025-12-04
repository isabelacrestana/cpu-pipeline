LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY register16bits IS
	PORT (D                  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Clock, Rin, Reset  : IN STD_LOGIC;
		   Q                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END register16bits;

ARCHITECTURE behavior OF register16bits IS
BEGIN
	PROCESS (Clock, Rin)
	BEGIN
		IF Reset = '1' THEN
			Q <= "0000000000000000";
		
		ELSIF (Clock'EVENT AND Clock='1') THEN
			IF Rin = '1' THEN 
				Q <= D;
			END IF;
		END IF;
	END PROCESS;
	
END behavior;