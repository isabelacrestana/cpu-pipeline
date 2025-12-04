LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY mux2to1 IS
	PORT (a,b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			s   : IN STD_LOGIC;
			y   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
END mux2to1;

ARCHITECTURE behavior OF mux2to1 IS
BEGIN
	PROCESS(s)
	BEGIN
		IF s = '0' THEN
			y(15 DOWNTO 0) <= a(15 DOWNTO 0);
		ELSE
			y(15 DOWNTO 0) <= b(15 DOWNTO 0);
		END IF;
	END PROCESS;
END behavior;