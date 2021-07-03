module QPSK(
	Din,//serial data in
	DCLKin,//data in CLK(need to be 1/10 SCLKin)
	SCLKin,//Sample clock in	
	Sout,//Sample data out
);

input Din,DCLKin,SCLKin;
output wire [11:0]Sout;
reg [1:0]OutBuf;
reg Dadd,Dbuf;
reg [4:0]SymCount;
reg [4:0]addr;

ROM rom(
	.address(addr),
	.clock(SCLKin),
	.q(Sout)
);
	
initial begin
	addr=5'd0;
	Dbuf=1'b0;
	Dadd=1'b0;
	SymCount=5'd0;
end

always @(posedge DCLKin)begin
	Dadd=~Dadd;
	if(Dadd)Dbuf=Din;
	else OutBuf={Dbuf,Din};
end
	
always @(posedge SCLKin)begin
	
	if(SymCount==5'd19)begin
		SymCount=5'd0;
		case(OutBuf)
			2'b00:addr=5'd0;
			2'b01:addr=5'd5;
			2'b10:addr=5'd10;
			2'b11:addr=5'd15;
		endcase
	end
	else begin
		SymCount=SymCount+5'd1;
		if(addr==5'd19)addr=5'd0;
		else addr=addr+5'd1;
	end
end
endmodule

	