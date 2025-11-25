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
		-- LW R1, 2(R2)
		0 => "00100100",  1 => "00100010",   -- R1 <- 6

		-- LW R2, 2(R0)
		2 => "00100000",  3 => "01000010",   -- R2 <- 6

		-- ADD R3, R1, R2
		4 => "01100010",  5 => "01000110",   -- R3 <- 12

		-- SW R3, 0(R1)
		6 => "01000010",  7 => "01100000",   -- MEM[6] <- 12

		-- BEQ R1, R2, 14
		8 => "10000010",  9 => "01000111",   -- PC <- 24

		-- JMP 64 (pulando para o endereço 64)
		--10 => "10100000", 11 => "00100000",

		-- LW R0, 0(R1)
		24 => "00100010", 25 => "00000000",  -- R0 <- MEM[6] (equivalente a 12)

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