module DAControl(
	datain,
	CKDin,
	CLKin,
	Dout,
	LDAC,
	RESET,
	SYNC	
);
input [11:0] datain;
input CKDin,CLKin;
output reg Dout,LDAC,RESET,SYNC;
parameter opcode=3;//Write DAC Register
reg [11:0] inBuffer;
reg [23:0] outBuffer;
reg [4:0] state;

initial begin
	state=5'd0;
	Dout=1'b0;
	LDAC=1'b1;
	RESET=1'b1;
	SYNC=1'b1;
	outBuffer[19:0]=20'd0;
	outBuffer[23:20]=opcode;
end

always@ (posedge CKDin)begin
	inBuffer=datain;
	
end

always @(posedge CLKin)begin			
		case(state)
			5'd0:;
			5'd1:begin
				SYNC=1'b0;
				Dout=outBuffer[23];
				end
			5'd2:Dout=outBuffer[22];
			5'd3:Dout=outBuffer[21];
			5'd4:Dout=outBuffer[20];
			5'd5:Dout=outBuffer[19];
			5'd6:Dout=outBuffer[18];
			5'd7:Dout=outBuffer[17];
			5'd8:Dout=outBuffer[16];
			5'd9:Dout=outBuffer[15];
			5'd10:Dout=outBuffer[14];
			5'd11:Dout=outBuffer[13];
			5'd12:Dout=outBuffer[12];
			5'd13:Dout=outBuffer[11];
			5'd14:Dout=outBuffer[10];
			5'd15:Dout=outBuffer[9];
			5'd16:Dout=outBuffer[8];
			5'd17:Dout=outBuffer[7];
			5'd18:Dout=outBuffer[6];
			5'd19:Dout=outBuffer[5];
			5'd20:Dout=outBuffer[4];
			5'd21:Dout=outBuffer[3];
			5'd22:Dout=outBuffer[2];
			5'd23:Dout=outBuffer[1];
			5'd24:Dout=outBuffer[0];
			5'd25:begin
					SYNC=1'b1;
					state=5'd0;
					Dout=1'b1;
					outBuffer[19:8]=inBuffer;
				end
			default:begin
				SYNC=1'b1;
				state=5'd0;
				Dout=1'b1;
				outBuffer[19:8]=inBuffer;
				end
		endcase
		state=state+5'd1;
end
	

endmodule	

	
	