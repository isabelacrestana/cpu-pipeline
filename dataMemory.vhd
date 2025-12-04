LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY dataMemory IS
	GENERIC (
	  NUM_BITS : INTEGER := 16
	);
 
	PORT ( 
	  writeData : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);		  
	  readData  : OUT STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
	  address   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	  memWrite  : IN STD_LOGIC;
	  memRead   : IN STD_LOGIC;
	  clk       : IN STD_LOGIC
	  );
END dataMemory;

ARCHITECTURE Behavioral OF dataMemory IS 
	-- mudar tamanho da memoria depois para 2**16 - 1
	TYPE memArray IS ARRAY(0 TO 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL mem            : memArray := (
		0 => "00000000", 1 => "00000000",
		2 => "00000000", 3 => "00000001",
		4 => "00000000", 5 => "00000110",
		OTHERS => (OTHERS => '0')		
	);
	SIGNAL numericAddress : INTEGER;
	 
BEGIN
	numericAddress <= TO_INTEGER(UNSIGNED(address));
	PROCESS(address, memWrite, memRead, writeData, clk)
	BEGIN
		 IF RISING_EDGE(clk) THEN

			  IF memWrite = '1' THEN
					mem(numericAddress) <= writeData(15 DOWNTO 8);
					mem(numericAddress + 1) <= writeData(7 DOWNTO 0);
			  END IF;

			  IF memRead = '1' THEN
					readData(15 DOWNTO 8) <= mem(numericAddress);
					readData(7 DOWNTO 0)  <= mem(numericAddress + 1);
			  END IF;

		 END IF;
	END PROCESS;
	 
END Behavioral;