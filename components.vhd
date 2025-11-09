LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE components IS

	COMPONENT register16bits
		PORT (D                  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				Clock, Resetn, Rin : IN STD_LOGIC;
				Q                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;	
	
END components;
