LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY mux2to1_4bits IS
	PORT (a,b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			s   : IN STD_LOGIC;
			y   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
END mux2to1_4bits;

ARCHITECTURE behavior OF mux2to1_4bits IS
BEGIN
	PROCESS(s)
	BEGIN
		IF s = '0' THEN
			y <= a;
		ELSE
			y <= b;
		END IF;
	END PROCESS;
END behavior;