LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY signalExtend IS
	PORT (DataIn  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			DataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
END signalExtend;

ARCHITECTURE behavior OF signalExtend IS
BEGIN
	PROCESS(DataIn)
	BEGIN
		IF DataIn(4) = '1' THEN
			DataOut(15 DOWNTO 5) <= "11111111111";
		ELSE
			DataOut(15 DOWNTO 5) <= "00000000000";
		END IF;
	END PROCESS;
		
	DataOut(4 DOWNTO 0) <= DataIn(4 DOWNTO 0);

END behavior;
