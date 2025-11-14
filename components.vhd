LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE components IS

	COMPONENT register16bits
		PORT (D                  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				Clock, Rin         : IN STD_LOGIC;
				Q                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;	
	
	COMPONENT fullAdder 
		PORT (cin:  IN STD_LOGIC;
				a, b: IN STD_LOGIC;
				S:    OUT STD_LOGIC;
				cout: OUT STD_LOGIC);
	
	END COMPONENT;
	
	COMPONENT adder
		PORT (A, B   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				Result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
				);
	END COMPONENT;
	
	COMPONENT rippleCarry
		PORT (cin            : IN STD_LOGIC ;
				a,b            : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				S              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				cout, overflow : OUT STD_LOGIC );
	END COMPONENT;
	
	COMPONENT bufferTriState
		PORT (Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				Gate : IN STD_LOGIC;
				Q    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
		
	COMPONENT Forward_Unit
		PORT (EX_MEM_RegWrite: IN STD_LOGIC;
				MEM_WB_RegWrite: IN STD_LOGIC;
				EX_MEM_Rd: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				MEM_WB_Rd: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				ID_EX_Rs: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				ID_EX_Rt: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Forward_A: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
				Forward_B: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mux2to1
		PORT (a,b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				s   : IN STD_LOGIC;
				y   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mux3to1
		PORT (a,b,c : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			s     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			y     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mux2to1_8bits
		PORT (a,b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			s   : IN STD_LOGIC;
			y   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
	END COMPONENT;
	
	COMPONENT Control
		PORT(Opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
			  ID_Flush: OUT STD_LOGIC;
			  Control_Signals: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			  Branch: OUT STD_LOGIC;
			  Jump: OUT STD_LOGIC);	  
	END COMPONENT;
	
	COMPONENT shiftLeftJump
		PORT (DataIn  : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
			   DataOut : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
			);
	END COMPONENT;
	
	COMPONENT shiftLeftBranch
		PORT (DataIn  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			   DataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
	END COMPONENT;
	
	COMPONENT signalExtend
		PORT (DataIn  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				DataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Reg_IF_ID 
		PORT(	
				Clk   : IN STD_LOGIC;
				D     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				Q     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				wr    : IN STD_LOGIC;	
				flush : IN STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT Reg_ID_EX 
		PORT(
		Clk: IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(79 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Reg_EX_MEM
		PORT(	
			Clk : IN STD_LOGIC;
			D   : IN  STD_LOGIC_VECTOR(39 DOWNTO 0);
			Q   : OUT STD_LOGIC_VECTOR(39 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Reg_MEM_WB
		PORT(	
			Clk : IN STD_LOGIC;
			D   : IN  STD_LOGIC_VECTOR(37 DOWNTO 0);
			Q   : OUT STD_LOGIC_VECTOR(37 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ALU_Control
		PORT(
			Function_code: IN STD_LOGIC;
			ALUop: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUaction: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT alu
		PORT(	
			a, b      : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			operation : IN STD_LOGIC;
			result    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			 );
	END COMPONENT;
	
	COMPONENT Hazard_Detection_Unit
		PORT(
			IF_ID_Rs, IF_ID_Rt: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ID_EX_Rt: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ID_EX_MemRead: IN STD_LOGIC;
			PC_Write, IF_ID_Write: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT instructionMemory 
		GENERIC (
        NUM_BITS : INTEGER := 16
					);
	 
		PORT( 
         address     : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);		  
		   instruction : OUT STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
         clk         : IN STD_LOGIC
        );
	END COMPONENT;
	
	COMPONENT dataMemory 
		GENERIC (
	  NUM_BITS : INTEGER := 16
					);
 
		PORT ( 
	  writeData : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);		  
	  readData  : OUT STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
	  address   : IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
	  memWrite  : IN STD_LOGIC;
	  memRead   : IN STD_LOGIC;
	  clk       : IN STD_LOGIC
			  );
	END COMPONENT;
	
	COMPONENT comparator
		PORT (A,B                  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		   Branch_Taken         : OUT STD_LOGIC
			  );
	END COMPONENT;
	
	COMPONENT regBank
		PORT ( writeData                                : IN STD_LOGIC_VECTOR(15 DOWNTO 0);    -- dado que sera escrito
			 readData1, readData2                        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);   -- dados lidos de rs e rt
			 writeRegister, readRegister1, readRegister2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);     -- regWrite: sinal de escrita
			 regWrite, clock                             : IN STD_LOGIC
			);
   END COMPONENT;
	
END components;
