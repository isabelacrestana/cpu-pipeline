LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE components IS

	COMPONENT register16bits
		PORT (D                  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				Clock, Resetn, Rin : IN STD_LOGIC;
				Q                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;	
	
	COMPONENT fullAdder 
		PORT (cin:  IN STD_LOGIC;
				a, b: IN STD_LOGIC;
				S:    OUT STD_LOGIC;
				cout: OUT STD_LOGIC);
	
	END COMPONENT;
	
	COMPONENT rippleCarry
		PORT (cin            : IN STD_LOGIC ;
				a,b            : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				S              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				cout, overflow : OUT STD_LOGIC );
	END COMPONENT;
	
END components;
