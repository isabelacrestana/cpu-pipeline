LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALU_Control IS
		PORT(
			Function_code: IN STD_LOGIC;
			ALUop: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUaction: OUT STD_LOGIC
		);
END ALU_Control;

ARCHITECTURE control_behavior OF ALU_Control IS
	BEGIN
	
		PROCESS(ALUOp, Function_code)
		 BEGIN
			CASE ALUOp IS
				
				WHEN "00" => --ADD
					ALUaction <=  '0';
				
				WHEN "01" => --SUB
					ALUaction <=  '1';
				
				WHEN "10" => -- FUNCTION CODE(ADD/SUB)
					IF Function_code = '0' THEN
						ALUaction <= '0';
						
					ELSIF Function_code = '1' THEN
						ALUaction <= '1';
						
					END IF;
					
				WHEN OTHERS => 
					ALUaction <= '0'; -- Caso não for uma das opções, se faz soma
					
			END CASE;
			 
		END PROCESS;
		


END control_behavior;