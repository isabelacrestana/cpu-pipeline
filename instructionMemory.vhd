LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instructionMemory IS
    GENERIC (
        NUM_BITS : INTEGER := 16
    );
	 
    PORT( 
         address     : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);		  
		   instruction : OUT STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0)
        );
END instructionMemory;

ARCHITECTURE Behavioral OF instructionMemory IS
	-- mudar tamanho da memoria depois para 2**16 - 1
	TYPE memArray IS ARRAY(0 to 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	-- instrucoes já pre-definidas
	SIGNAL mem            : memArray := (
	
	
	--LW R2, 0(R4)      ; R2 = 0
	0 => "00101000", 1 => "01000000",
	
	--LW R1, 2(R4)      ; R1 = 1
	2 => "00101000", 3 => "00100010",
	
	--LW R5, 4(R4)      ; R5 = 5
	4 => "00101000", 5 => "10100100",
	
	--LW R3, 6(R4)      ; R3 = 0 (contador)
	6 => "00101000", 7 => "01100110",

	--LW R6, 2(R4)      ; R6 = 1  (registrador fixo para incremento)
	8 => "00101000", 9 => "11000010",

	--LOOP:
	--	 BEQ R3, R5, FIM
	10 => "10001010", 11 => "01100101",

	--	 ADD R0, R1, R2   ; temp = R1 + R2
	12 => "01100010", 13 => "01000000",

	--	 ADD R2, R1, R4   ; R2 = R1
	14 => "01100010", 15 => "10000100",

	--	 ADD R1, R0, R4   ; R1 = temp
	16 => "01100000", 17 => "10000010",

	--	 ADD R3, R3, R6   ; contador++
	18 => "01100110", 19 => "11000110",

	--	 J LOOP
	20 => "10100000", 21 => "00000101",


	--FIM:
	--	 NOP
	22 => "00000000", 23 => "00000000",
	

		OTHERS => (OTHERS => '0')		
	);
	SIGNAL numericAddress : INTEGER := 0;
	 
BEGIN
   
	numericAddress <= TO_INTEGER(UNSIGNED(address));
		         
	PROCESS(address) 
	BEGIN	
		-- formato usado: big-endian
		instruction(15 DOWNTO 8) <= mem(numericAddress);
		instruction(7 DOWNTO 0)  <= mem(numericAddress+1);
	END PROCESS;
	
END Behavioral;