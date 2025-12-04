LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bufferTriState IS
	PORT (Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Gate : IN STD_LOGIC;
		   Q    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END bufferTriState;

ARCHITECTURE behavior OF bufferTriState IS
	BEGIN
	PROCESS(Data, Gate)
	BEGIN
		CASE (GATE) IS
			WHEN '1' => Q <= Data;
			WHEN OTHERS => Q <= "ZZZZZZZZZZZZZZZZ";
		END CASE;
	END PROCESS;
	
END behavior;