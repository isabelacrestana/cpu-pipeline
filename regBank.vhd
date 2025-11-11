LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.components.all;

ENTITY regBank IS
	PORT ( writeData                                   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			 readData1, readData2                        :  OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			 writeRegister, readRegister1, readRegister2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 regWrite, clock, resetn                     : IN STD_LOGIC
			);
END regBank;

ARCHITECTURE behavioral OF regBank IS
	TYPE data IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(15 downto 0);
   SIGNAL regsData : data;
	
	SIGNAL regsIn : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	-- instanciando os 16 registradores
	reg01 : register16bits PORT MAP(writeData, clock, resetn, regsIn(0),  regsData(0)) ;
	reg02 : register16bits PORT MAP(writeData, clock, resetn, regsIn(1),  regsData(1)) ;
	reg03 : register16bits PORT MAP(writeData, clock, resetn, regsIn(2),  regsData(2)) ;
	reg04 : register16bits PORT MAP(writeData, clock, resetn, regsIn(3),  regsData(3)) ;
	reg05 : register16bits PORT MAP(writeData, clock, resetn, regsIn(4),  regsData(4)) ;
	reg06 : register16bits PORT MAP(writeData, clock, resetn, regsIn(5),  regsData(5)) ;
	reg07 : register16bits PORT MAP(writeData, clock, resetn, regsIn(6),  regsData(6)) ;
	reg08 : register16bits PORT MAP(writeData, clock, resetn, regsIn(7),  regsData(7)) ;
	reg09 : register16bits PORT MAP(writeData, clock, resetn, regsIn(8),  regsData(8)) ;
	reg10 : register16bits PORT MAP(writeData, clock, resetn, regsIn(9), regsData(9));
	reg11 : register16bits PORT MAP(writeData, clock, resetn, regsIn(10), regsData(10));
	reg12 : register16bits PORT MAP(writeData, clock, resetn, regsIn(11), regsData(11));
	reg13 : register16bits PORT MAP(writeData, clock, resetn, regsIn(12), regsData(12));
	reg14 : register16bits PORT MAP(writeData, clock, resetn, regsIn(13), regsData(13));
	reg15 : register16bits PORT MAP(writeData, clock, resetn, regsIn(14), regsData(14));
	reg16 : register16bits PORT MAP(writeData, clock, resetn, regsIn(15), regsData(15));
	
	PROCESS(clocK)
	BEGIN
		-- ESCRITA
		IF RISING_EDGE(clock) THEN
			-- zera todos os enables
			  regsIn <= (others => '0');
			  IF regWrite = '1' THEN
					regsIn(to_integer(unsigned(writeRegister))) <= '1';
			  END IF;
		END IF;
		
		-- LEITURA
		IF FALLING_EDGE(clock) THEN
				-- mux 1 de leitura
			readData1 <= regsData(TO_INTEGER(UNSIGNED(readRegister1)));	
			-- mux 2 de leitura
			readData2 <= regsData(TO_INTEGER(UNSIGNED(readRegister2)));
		 END IF;
	END PROCESS;

END behavioral;