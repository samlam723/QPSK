module QPSKtoplevel(
	CLKin,
	CLKout,
	SDI,
	LDAC,
	RESET,
	SYNC
);

input CLKin;
output wire CLKout,SDI,LDAC,RESET,SYNC;
wire c0,c1,c2,SDE;
wire [11:0] symbelData;

assign CLKout=c0;

pll pll(
	.inclk0(CLKin),
	.c0(c0),
	.c1(c1),
	.c2(c2)
);

SerialEmulator SE(
	.CLK(c2),
	.Dout(SDE)
);

QPSK QPSK(
	.Din(SDE),
	.DCLKin(c2),
	.SCLKin(c1),
	.Sout(symbelData)
);

DAControl DACout(
	.datain(symbelData),
	.CKDin(c1),
	.CLKin(c0),
	.Dout(SDI),
	.LDAC(LDAC),
	.RESET(RESET),
	.SYNC(SYNC)
);

endmodule
