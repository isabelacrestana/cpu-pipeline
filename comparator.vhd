LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator IS
	PORT (A,B                  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		   Branch_Taken               : OUT STD_LOGIC
			);
END comparator;

ARCHITECTURE behavior OF comparator IS
	SIGNAL result_aux : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	result_aux <= A XNOR B; 
	PROCESS(result_aux, Branch_Taken)
	BEGIN
		IF result_aux = "1111111111111111" THEN
			Branch_Taken <= '1';
		ELSE
			Branch_Taken <= '0';
		END IF;
	END PROCESS;
END behavior;