LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE work.components.all;

-- alu
ENTITY alu IS 
	PORT(	
			a, b      : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			operation : IN STD_LOGIC;
			result    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
 	);
END alu;


ARCHITECTURE Behavior OF alu IS
	SIGNAL addRes, subRes    : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL cout, overflow : STD_LOGIC; -- overflow para futura implementacao de excecao 
BEGIN
	add: rippleCarry PORT MAP('0', a, b, addRes, cout, overflow);
	sub: rippleCarry PORT MAP('1', a, b, subRes, cout, overflow);
	
	PROCESS(a, b, operation)
	BEGIN
		IF operation = '0' THEN
			result <= addRes;
		ELSE
			result <= subRes;
		END IF;
	END PROCESS;
	
END Behavior;