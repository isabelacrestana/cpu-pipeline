LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fullAdder IS
	PORT (cin:  IN STD_LOGIC;
		   a, b: IN STD_LOGIC;
		   S:    OUT STD_LOGIC;
			cout: OUT STD_LOGIC);
	
END fullAdder;
	
ARCHITECTURE logicFunction OF fullAdder IS	
	BEGIN
		S <= a XOR b XOR cin;
		cout <= (a AND b) OR (cin AND a) OR (cin AND b);
	END logicFunction;