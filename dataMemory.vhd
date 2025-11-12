library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dataMemory IS
    generic (
        NUM_BITS : integer := 16
    );
	 
    Port ( 
        writeData : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);		  
		  readData  : OUT STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
        address   : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
        memWrite  : IN STD_LOGIC;
		  memRead   : IN STD_LOGIC;
        reset     : IN STD_LOGIC;
        clk       : IN STD_LOGIC
        );
END dataMemory;

architecture Behavioral OF dataMemory IS
    
	 -- mudar tamanho da memoria depois para 2**16 - 1
    TYPE memArray IS ARRAY((2**8)-1 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
        
    SIGNAL mem            : memArray;
    SIGNAL dataOut        : STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
	
	 SIGNAL numericAddress : integer;
BEGIN
    
	 numericAddress <= TO_INTEGER(UNSIGNED(address));
	 
    readData <= dataOut;
        
    PROCESS(clk, reset) 
    BEGIN	
        IF RISING_EDGE(clk) THEN 
            IF memRead = '1' THEN
                dataOut(15 DOWNTO 8) <= mem(numericAddress);
					 dataOut(7 DOWNTO 0)  <= mem(numericAddress + 1);

				 ELSIF memWrite = '1' THEN
                mem(numericAddress)     <= writeData(15 DOWNTO 8);
					 mem(numericAddress + 1) <= writeData(7 DOWNTO 0);
            END IF;
				
        END IF;
    END PROCESS;
END Behavioral;