LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY cpu IS
	PORT (Clock_50 : IN STD_LOGIC
		  -- mapear os 3 displays 7 segs para os regs 1, 2 e 3
		  -- mapear display 7 segs do PC
		  );
END cpu;

ARCHITECTURE behavior OF cpu IS

	-- sinais internos
	

BEGIN
	
	-- 1° ESTÁGIO PIPELINE
	
		-- PC
	
		-- Memoria de Instrucoes
	
		-- PC + 2 Adder

		-- Mux PC Source
	
		-- Mux Jump
	
		-- Registrador IF/ID
		
------------------------------
	
	-- 2° ESTÁGIO PIPELINE
	
		-- RegBank
	
		-- Branch Adder
	
		-- ShiftLeft Branch

		-- Signal Extend
	
		-- ShiftLeft Jump
	
		-- Control
		
		-- Hazard Detection
		
		-- Comparator (xnor)
		
		-- Branch and BranchTaken
		
		-- MUX ID Flush
		
		-- Reg ID/EX
		
------------------------------

	-- 3° ESTÁGIO PIPELINE
	
		-- Mux AluSource
	
		-- Mux Forward_A
	
		-- Mux Forward_B
		
		-- Mux Reg_Dst

		-- ALU_Control
			
		-- Forward Unity
		
		-- ALU
		
		-- Reg EX/MEM
		
------------------------------
		
	-- 4° ESTÁGIO PIPELINE
	
		-- Data Memory
		
------------------------------

	-- 5° ESTÁGIO PIPELINE
	
		-- Mux MemToReg


END behavior;