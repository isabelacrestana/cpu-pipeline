LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Hazard_Detection_Unit IS
		PORT(
			IF_ID_Rs, IF_ID_Rt: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ID_EX_Rt: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ID_EX_MemRead: IN STD_LOGIC;
			Flush: OUT STD_lOGIC;
			PC_Write, IF_ID_Write: OUT STD_LOGIC
		);

END Hazard_Detection_Unit;

		 
ARCHITECTURE load_detection OF Hazard_Detection_Unit IS

	BEGIN
		
		
		PROCESS(IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, ID_EX_MemRead)
		BEGIN
			PC_Write <= '1';
			IF_ID_Write <= '1';
			IF (ID_EX_MemRead = '1') AND 
           ((ID_EX_Rt = IF_ID_Rs) OR (ID_EX_Rt = IF_ID_Rt)) THEN
				
				Flush <= '1';
				PC_Write <= '0';
				IF_ID_Write <= '0';
			END IF;
		 END PROCESS;

END load_detection;