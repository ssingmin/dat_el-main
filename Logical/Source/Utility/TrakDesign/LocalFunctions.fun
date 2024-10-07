
{REDUND_ERROR} FUNCTION solveEquSys : BOOL (*solve the linear matrix equation A*x = b*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		A : REFERENCE TO ARRAY[0..35] OF LREAL;
		b : REFERENCE TO ARRAY[0..5] OF LREAL;
		solution : REFERENCE TO ARRAY[0..5] OF LREAL;
	END_VAR
	VAR
		x : ARRAY[0..5] OF LREAL;
		b_A : ARRAY[0..35] OF LREAL;
		i0 : INT;
		j : INT;
		ipiv : ARRAY[0..5] OF INT;
		jy : INT;
		c : INT;
		iy : INT;
		ix : INT;
		smax : LREAL;
		k : INT;
		s : LREAL;
		ijA : INT;
	END_VAR
END_FUNCTION
