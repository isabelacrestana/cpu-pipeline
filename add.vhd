LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY add IS
	PORT (cin            : IN STD_LOGIC ;
			a,b            : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			S              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			cout, overflow : OUT STD_LOGIC );
END add;

ARCHITECTURE Structure OF add IS
	SIGNAL C: STD_LOGIC_VECTOR(15 DOWNTO 1);
	SIGNAL AUX: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL cout_aux: STD_LOGIC;
		BEGIN
		AUX <= b WHEN Cin = '0' ELSE NOT b;
			stage0 : fullAdder PORT MAP (cin,   a(0),  AUX(0),  S(0),  C(1));
			stage1 : fullAdder PORT MAP (C(1),  a(1),  AUX(1),  S(1),  C(2));
			stage2 : fullAdder PORT MAP (C(2),  a(2),  AUX(2),  S(2),  C(3));
			stage3 : fullAdder PORT MAP (C(3),  a(3),  AUX(3),  S(3),  C(3));
			stage4 : fullAdder PORT MAP (C(4),  a(4),  AUX(4),  S(4),  C(4));
			stage5 : fullAdder PORT MAP (C(5),  a(5),  AUX(5),  S(5),  C(5));
			stage6 : fullAdder PORT MAP (C(6),  a(6),  AUX(6),  S(6),  C(6));
			stage7 : fullAdder PORT MAP (C(7),  a(7),  AUX(7),  S(7),  C(7));
			stage8 : fullAdder PORT MAP (C(8),  a(8),  AUX(8),  S(8),  C(8));
			stage9 : fullAdder PORT MAP (C(9),  a(9),  AUX(9),  S(9),  C(9));
			stage10: fullAdder PORT MAP (C(10), a(10), AUX(10), S(10), C(10));
			stage11: fullAdder PORT MAP (C(11), a(11), AUX(11), S(11), C(11));
			stage12: fullAdder PORT MAP (C(12), a(12), AUX(12), S(12), C(12));
			stage13: fullAdder PORT MAP (C(13), a(13), AUX(13), S(13), C(13));
			stage14: fullAdder PORT MAP (C(14), a(14), AUX(14), S(14), C(14));
			stage15: fullAdder PORT MAP (C(15), a(15), AUX(15), S(15), cout_aux);

			cout<=cout_aux;
			overflow <= cout_aux XOR C(15);
			
END Structure ;