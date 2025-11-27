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
	
	-- instrucoes já pre-definidas
	SIGNAL mem            : memArray := (
	
		-- LW R5, 6(R0)
		0 => "00100000", 1 => "10100110",
		
		-- LW R4, 2(R0)
		2 => "00100000", 3 => "10000010",
		
		-- LW R2, 0(R0)
		4 => "00100000", 5 => "01000000",
		
		-- LW R3, 4(R0)
		6 => "00100000", 7 => "01100100",
		
	-- LOOP:
		-- BEQ R1, R5, FIM
		8 => "10000010", 9 => "10100100",
		
		-- ADD R1, R1, R4
		10 => "01100010", 11 => "10000010",
		
		-- ADD R2, R2, R3
		12 => "01100100", 13 => "01100100",
		
		-- SUB R2, R2, R4
		14 => "01100100", 15 => "10000101",
		-- J LOOP
		16 => "10100000", 17 => "00000100",
		
	-- FIM:
		-- SW R2, 0(R1)
		18 => "01000010" , 19 => "01000000",
		
		-- LW R0, 0(R1)
		20 => "00100010" , 21 => "00000000",

		OTHERS => (OTHERS => '0')		
	);
	SIGNAL numericAddress : INTEGER;
	 
BEGIN
   
	numericAddress <= TO_INTEGER(UNSIGNED(address));
		         
	PROCESS(address) 
	BEGIN	
		-- formato usado: big-endian
		instruction(15 DOWNTO 8) <= mem(numericAddress);
		instruction(7 DOWNTO 0)  <= mem(numericAddress+1);
	END PROCESS;
	
END Behavioral;