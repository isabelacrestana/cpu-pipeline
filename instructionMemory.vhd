LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instructionMemory IS
    GENERIC (
        NUM_BITS : INTEGER := 16
    );
	 
    PORT( 
         address     : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);		  
		   instruction : OUT STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
         clk         : IN STD_LOGIC
        );
END instructionMemory;

ARCHITECTURE Behavioral OF instructionMemory IS
	 -- mudar tamanho da memoria depois para 2**16 - 1
    TYPE memArray IS ARRAY(0 to 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL mem            : memArray;
	 SIGNAL numericAddress : INTEGER;
	 
BEGIN
   
	numericAddress <= TO_INTEGER(UNSIGNED(address));
		         
	PROCESS(clk) 
	BEGIN	
		IF RISING_EDGE(clk) THEN 
			instruction(15 DOWNTO 8) <= mem(numericAddress);
			instruction(7 DOWNTO 0)  <= mem(numericAddress + 1);
		END IF;	
	END PROCESS;
	
END Behavioral;