
TYPE
	VisuPage_typ : 	STRUCT  (*Structure type for page control*)
		CurrenPage : UINT; (*Current page index*)
		NewPage : UINT; (*New page index*)
		SetOldPage : UINT; (*Set old page page index*)
		SetPage : UINT; (*Set page index*)
		StartingBar : UINT; (*Starting page bar graph*)
		TON_Boot : TON; (*Timer for bar graph in booting page *)
		BootingText : USINT; (*Text for description in booting page*)
	END_STRUCT;
END_TYPE
