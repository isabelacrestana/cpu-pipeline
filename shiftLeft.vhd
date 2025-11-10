LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shiftLeft IS
	PORT (DataIn  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			DataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
END shiftLeft;

ARCHITECTURE behavior OF shiftLeft IS
BEGIN		
	DataOut(15 DOWNTO 2) <= DataIn(13 DOWNTO 0);
	DataOut(1 DOWNTO 0) <= "00";
END behavior;
