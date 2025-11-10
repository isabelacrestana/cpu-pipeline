LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY adder IS
	PORT (A, B   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
END adder;

ARCHITECTURE behavior OF adder IS
	SIGNAL cout, overflow: std_logic; 
BEGIN
	adder : rippleCarry PORT MAP ('0', A, B, Result, cout, overflow);

END behavior;
