LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shiftLeftJump IS
	PORT (DataIn  : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
			DataOut : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
			);
END shiftLeftJump;

ARCHITECTURE behavior OF shiftLeftJump IS
BEGIN		
	DataOut(13 DOWNTO 1) <= DataIn(12 DOWNTO 0);
	DataOut(0) <= '0';
END behavior;
