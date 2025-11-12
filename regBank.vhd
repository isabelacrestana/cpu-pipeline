LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.components.all;

ENTITY regBank IS
	PORT ( writeData                                   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);    -- dado que sera escrito
			 readData1, readData2                        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);   -- dados lidos de rs e rt
			 writeRegister, readRegister1, readRegister2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);     -- regWrite: sinal de escrita
			 regWrite, clock, resetn                     : IN STD_LOGIC
			);
END regBank;

ARCHITECTURE behavioral OF regBank IS
	TYPE dataIn IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(15 downto 0);
   SIGNAL regsDataIn : dataIn;   -- dados que entram nos registradores
	
	TYPE dataOut IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(15 downto 0);
   SIGNAL regsDataOut : dataOut; -- dados que saem dos buffers tri-state
	
	SIGNAL regsIn  : STD_LOGIC_VECTOR(15 DOWNTO 0);  -- sinais para rIn de cada registrador
	SIGNAL regsOut1, regsOut2 : STD_LOGIC_VECTOR(15 DOWNTO 0);  -- gates de cada buffer de caga registrador

BEGIN
	-- instanciando os 16 registradores
	reg01 : register16bits PORT MAP(writeData, clock, resetn, regsIn(0),  regsDataIn(0)) ;
	reg02 : register16bits PORT MAP(writeData, clock, resetn, regsIn(1),  regsDataIn(1)) ;
	reg03 : register16bits PORT MAP(writeData, clock, resetn, regsIn(2),  regsDataIn(2)) ;
	reg04 : register16bits PORT MAP(writeData, clock, resetn, regsIn(3),  regsDataIn(3)) ;
	reg05 : register16bits PORT MAP(writeData, clock, resetn, regsIn(4),  regsDataIn(4)) ;
	reg06 : register16bits PORT MAP(writeData, clock, resetn, regsIn(5),  regsDataIn(5)) ;
	reg07 : register16bits PORT MAP(writeData, clock, resetn, regsIn(6),  regsDataIn(6)) ;
	reg08 : register16bits PORT MAP(writeData, clock, resetn, regsIn(7),  regsDataIn(7)) ;
	reg09 : register16bits PORT MAP(writeData, clock, resetn, regsIn(8),  regsDataIn(8)) ;
	reg10 : register16bits PORT MAP(writeData, clock, resetn, regsIn(9),  regsDataIn(9)) ;
	reg11 : register16bits PORT MAP(writeData, clock, resetn, regsIn(10), regsDataIn(10));
	reg12 : register16bits PORT MAP(writeData, clock, resetn, regsIn(11), regsDataIn(11));
	reg13 : register16bits PORT MAP(writeData, clock, resetn, regsIn(12), regsDataIn(12));
	reg14 : register16bits PORT MAP(writeData, clock, resetn, regsIn(13), regsDataIn(13));
	reg15 : register16bits PORT MAP(writeData, clock, resetn, regsIn(14), regsDataIn(14));
	reg16 : register16bits PORT MAP(writeData, clock, resetn, regsIn(15), regsDataIn(15));
	
	-- instanciando os buffers tri-state
	buffer01: bufferTriState PORT MAP(regsDataIn(0),  regsOut1(0)  OR regsOut2(0),  regsDataOut(0)) ;
	buffer02: bufferTriState PORT MAP(regsDataIn(1),  regsOut1(1)  OR regsOut2(1),  regsDataOut(1)) ;
	buffer03: bufferTriState PORT MAP(regsDataIn(2),  regsOut1(2)  OR regsOut2(2),  regsDataOut(2)) ;
	buffer04: bufferTriState PORT MAP(regsDataIn(3),  regsOut1(3)  OR regsOut2(3),  regsDataOut(3)) ;
	buffer05: bufferTriState PORT MAP(regsDataIn(4),  regsOut1(4)  OR regsOut2(4),  regsDataOut(4)) ;
	buffer06: bufferTriState PORT MAP(regsDataIn(5),  regsOut1(5)  OR regsOut2(5),  regsDataOut(5)) ;
	buffer07: bufferTriState PORT MAP(regsDataIn(6),  regsOut1(6)  OR regsOut2(6),  regsDataOut(6)) ;
	buffer08: bufferTriState PORT MAP(regsDataIn(7),  regsOut1(7)  OR regsOut2(7),  regsDataOut(7)) ;
	buffer09: bufferTriState PORT MAP(regsDataIn(8),  regsOut1(8)  OR regsOut2(8),  regsDataOut(8)) ;
	buffer10: bufferTriState PORT MAP(regsDataIn(9),  regsOut1(9)  OR regsOut2(9),  regsDataOut(9)) ;
	buffer11: bufferTriState PORT MAP(regsDataIn(10), regsOut1(10) OR regsOut2(10), regsDataOut(10));
	buffer12: bufferTriState PORT MAP(regsDataIn(11), regsOut1(11) OR regsOut2(11), regsDataOut(11));
	buffer13: bufferTriState PORT MAP(regsDataIn(12), regsOut1(12) OR regsOut2(12), regsDataOut(12));
	buffer14: bufferTriState PORT MAP(regsDataIn(13), regsOut1(13) OR regsOut2(13), regsDataOut(13));
	buffer15: bufferTriState PORT MAP(regsDataIn(14), regsOut1(14) OR regsOut2(14), regsDataOut(14));
	buffer16: bufferTriState PORT MAP(regsDataIn(15), regsOut1(15) OR regsOut2(15), regsDataOut(15));
	
	
	PROCESS(clocK)
	BEGIN
		-- ESCRITA (só escreve na subida do clock e quando regWrite vale 1)
		IF RISING_EDGE(clock) AND regWrite = '1' THEN			
			CASE writeRegister IS
				WHEN "0000" =>
					regsIn <= "0000000000000001";
				
				WHEN "0001" =>
					regsIn <= "0000000000000010";
				
				WHEN "0010" =>
					regsIn <= "0000000000000100";
				
				WHEN "0011" =>
					regsIn <= "0000000000001000";
				
				WHEN "0100" =>
					regsIn <= "0000000000010000";
				
				WHEN "0101" =>
					regsIn <= "0000000000100000";
				
				WHEN "0110" =>
					regsIn <= "0000000001000000";
				
				WHEN "0111" =>
					regsIn <= "0000000010000000";
				
				WHEN "1000" =>
					regsIn <= "0000000100000000";
				
				WHEN "1001" =>
					regsIn <= "0000001000000000";
				
				WHEN "1010" =>
					regsIn <= "0000010000000000";
				
				WHEN "1011" =>
					regsIn <= "0000100000000000";
				
				WHEN "1100" =>
					regsIn <= "0001000000000000";
					
				WHEN "1101" =>
					regsIn <= "0010000000000000";

				WHEN "1110" =>
					regsIn <= "0100000000000000";
				
				WHEN "1111" =>
					regsIn <= "1000000000000000";
					
				WHEN OTHERS => 
					regsIn <= (others => '0');
					
			END CASE;
		END IF;
	END PROCESS;
			
	-- LEITURA (é assincrona, portanto nao depende do clock)
	-- habilita o gate do buffer correto e regData recebe a saída do buffer correspondente
	PROCESS(readRegister1, regsDataOut)
		BEGIN
			CASE readRegister1 IS
				WHEN "0000" =>
					regsOut1 <= "0000000000000001";
					readData1 <= regsDataOut(0);
				
				WHEN "0001" =>
					regsOut1 <= "0000000000000010";
					readData1 <= regsDataOut(1);
				
				WHEN "0010" =>
					regsOut1 <= "0000000000000100";
					readData1 <= regsDataOut(2);
				
				WHEN "0011" =>
					regsOut1 <= "0000000000001000";
					readData1 <= regsDataOut(3);
				
				WHEN "0100" =>
					regsOut1 <= "0000000000010000";
					readData1 <= regsDataOut(4);
				
				WHEN "0101" =>
					regsOut1 <= "0000000000100000";
					readData1 <= regsDataOut(5);
				
				WHEN "0110" =>
					regsOut1 <= "0000000001000000";
					readData1 <= regsDataOut(6);
				
				WHEN "0111" =>
					regsOut1 <= "0000000010000000";
					readData1 <= regsDataOut(7);
				
				WHEN "1000" =>
					regsOut1 <= "0000000100000000";
					readData1 <= regsDataOut(8);
				
				WHEN "1001" =>
					regsOut1 <= "0000001000000000";
					readData1 <= regsDataOut(9);
				
				WHEN "1010" =>
					regsOut1 <= "0000010000000000";
					readData1 <= regsDataOut(10);
				
				WHEN "1011" =>
					regsOut1 <= "0000100000000000";
					readData1 <= regsDataOut(11);
				
				WHEN "1100" =>
					regsOut1 <= "0001000000000000";
					readData1 <= regsDataOut(12);
				
				WHEN "1101" =>
					regsOut1 <= "0010000000000000";
					readData1 <= regsDataOut(13);
				
				WHEN "1110" =>
					regsOut1 <= "0100000000000000";
					readData1 <= regsDataOut(14);
				
				WHEN "1111" =>
					regsOut1 <= "1000000000000000";
					readData1 <= regsDataOut(15);
					
				WHEN OTHERS => 
					regsOut1 <= (others => '0');
	
			END CASE;

		END PROCESS;
		
		PROCESS(readRegister2, regsDataOut)
		BEGIN
			CASE readRegister2 IS
				WHEN "0000" =>
					regsOut2 <= "0000000000000001";
					readData2 <= regsDataOut(0);
				
				WHEN "0001" =>
					regsOut2 <= "0000000000000010";
					readData2 <= regsDataOut(1);
				
				WHEN "0010" =>
					regsOut2 <= "0000000000000100";
					readData2 <= regsDataOut(2);
				
				WHEN "0011" =>
					regsOut2 <= "0000000000001000";
					readData2 <= regsDataOut(3);
				
				WHEN "0100" =>
					regsOut2 <= "0000000000010000";
					readData2 <= regsDataOut(4);
				
				WHEN "0101" =>
					regsOut2 <= "0000000000100000";
					readData2 <= regsDataOut(5);
				
				WHEN "0110" =>
					regsOut2 <= "0000000001000000";
					readData2 <= regsDataOut(6);
				
				WHEN "0111" =>
					regsOut2 <= "0000000010000000";
					readData2 <= regsDataOut(7);
				
				WHEN "1000" =>
					regsOut2 <= "0000000100000000";
					readData2 <= regsDataOut(8);
				
				WHEN "1001" =>
					regsOut2 <= "0000001000000000";
					readData2 <= regsDataOut(9);
				
				WHEN "1010" =>
					regsOut2 <= "0000010000000000";
					readData2 <= regsDataOut(10);
				
				WHEN "1011" =>
					regsOut2 <= "0000100000000000";
					readData2 <= regsDataOut(11);
				
				WHEN "1100" =>
					regsOut2 <= "0001000000000000";
					readData2 <= regsDataOut(12);
				
				WHEN "1101" =>
					regsOut2 <= "0010000000000000";
					readData2 <= regsDataOut(13);
				
				WHEN "1110" =>
					regsOut2 <= "0100000000000000";
					readData2 <= regsDataOut(14);
				
				WHEN "1111" =>
					regsOut2 <= "1000000000000000";
					readData2 <= regsDataOut(15);
					
				WHEN OTHERS => 
					regsOut2 <= (others => '0');
					
			END CASE;				
		END PROCESS;
			
END behavioral;