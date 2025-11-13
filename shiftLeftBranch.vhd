LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shiftLeftBranch IS
	PORT (DataIn  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			DataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
END shiftLeftBranch;

ARCHITECTURE behavior OF shiftLeftBranch IS
BEGIN		
	DataOut(15 DOWNTO 1) <= DataIn(14 DOWNTO 0);
	DataOut(0) <= '0';
END behavior;
