LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Forward_Unit IS
		PORT(
			EX_MEM_RegWrite: IN STD_LOGIC;
			MEM_WB_RegWrite: IN STD_LOGIC;
			EX_MEM_Rd: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			MEM_WB_Rd: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ID_EX_Rs: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ID_EX_Rt: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Forward_A: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			Forward_B: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
END Forward_Unit;

ARCHITECTURE forwarding_logic OF Forward_Unit IS

	BEGIN
		PROCESS(EX_MEM_RegWrite,MEM_WB_RegWrite,EX_MEM_Rd,MEM_WB_Rd,ID_EX_Rs,ID_EX_Rt)
			BEGIN
				IF (EX_MEM_RegWrite = '1' AND (EX_MEM_Rd = ID_EX_Rs)) THEN --1a
					Forward_A <= "10";
					
				ELSIF(MEM_WB_RegWrite = '1' AND (MEM_WB_Rd = ID_EX_Rs)) THEN --2a OBS: AQUI JA É TRATADO PARA HAZARD DUPLO, POIS ESSA CONDICAO SÓ SERA ALCANÇADA SE A DE CIMA NÃO FOR VERDADEIRA
					Forward_A <= "01";
					
				ELSE
					Forward_A <= "00";
				END IF;
				
				
				IF(EX_MEM_RegWrite = '1' AND (EX_MEM_Rd = ID_EX_Rt)) THEN --1b
					Forward_B <= "10";
					
				ELSIF(MEM_WB_RegWrite = '1' AND (MEM_WB_Rd = ID_EX_Rt)) THEN --2b OBS: AQUI JA É TRATADO PARA HAZARD DUPLO, POIS ESSA CONDICAO SÓ SERA ALCANÇADA SE A DE CIMA NÃO FOR VERDADEIRA
					Forward_B <= "01";
				
				ELSE
					Forward_B <= "00";
					
				END IF;
		END PROCESS;

END forwarding_logic;