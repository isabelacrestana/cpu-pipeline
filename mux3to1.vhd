LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY mux3to1 IS
	PORT (a,b,c : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			s     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			y     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
END mux3to1;

ARCHITECTURE behavior OF mux3to1 IS
BEGIN
	PROCESS(s, a, b, c)
	BEGIN
		IF s = "00" THEN
			y <= a;
		ELSIF s = "01" THEN
			y <= b;
		ELSIF s = "10" THEN
			y <= c;
		ELSE
			y <= "0000000000000000";
		END IF;
	END PROCESS;
END behavior;