module SerialEmulator(
	CLK,
	Dout
);

input CLK;
output reg Dout;
reg [7:0] dataStream ;
reg [2:0] count;

initial begin
	Dout=1'd0;	
	dataStream=8'b01111000;
	count=3'd0;
end

always@(posedge CLK)begin
	count=count+3'd1;	
	
	case(count)
		3'd0:Dout=dataStream[0];
		3'd1:Dout=dataStream[1];
		3'd2:Dout=dataStream[2];
		3'd3:Dout=dataStream[3];
		3'd4:Dout=dataStream[4];
		3'd5:Dout=dataStream[5];
		3'd6:Dout=dataStream[6];
		3'd7:Dout=dataStream[7];
	endcase
	
end
endmodule
