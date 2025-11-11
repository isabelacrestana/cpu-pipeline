LIBRARY ieee ;
USE ieee.std_logic_1164.all;

ENTITY Reg_ID_EX IS 
	PORT(
		Clk: IN STD_LOGIC;
		EX: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- SINAIS DE EX
		M: IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- SINAIS DE M
		WB: IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- SINAIS DE WB
		PCplus4: IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- PC+4
		Read_data1: IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- conteudo de rs
		Read_data2: IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- conteudo de rt
		Imed_extended: IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- imediato extendido de 16 bits
		rs,rt,rd: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- número dos registradores
		
		EX_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- SINAIS DE EX
		M_OUT: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- SINAIS DE M
		WB_OUT: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- SINAIS DE WB
		PCplus4_OUT: OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- PC+4
		Read_data1_OUT: OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- conteudo de rs
		Read_data2_OUT: OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- conteudo de rt
		Imed_extended_OUT: OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- imediato extendido de 16 bits
		rs_OUT,rt_OUT,rd_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- número dos registradores
 	);
END Reg_ID_EX;

ARCHITECTURE behavior OF Reg_ID_EX IS

	BEGIN
	
		PROCESS(Clk)
		  BEGIN
			IF Clk'EVENT AND Clk='1' THEN
				EX_OUT <= EX; 
				M_OUT <= M;
				WB_OUT <= WB;
				PCplus4_OUT <= PCplus4;
				Read_data1_OUT <= Read_data1;
				Read_data2_OUT <= Read_data2;
				Imed_extended_OUT <= Imed_extended;
				rs_OUT <= rs;
				rt_OUT <= rt;
				rd_OUT <= rd;
			END IF;
		  END PROCESS;
		
	END behavior;