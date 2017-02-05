module lfsr (input Clk,Reset,enable,
				 output [7:0] out);


logic        linear_feedback,linear_feedback2,linear_feedback3;


assign linear_feedback = ~(out[7] ^ out[2]);
//assign linear_feedback2 = (out[6] ^ out[2]);
//assign linear_feedback3 = (out[5] ^ out[4]);

always_ff @(posedge Clk)
	if (Reset) 
	begin
	out <= 8'h00;
	end 
	else if (enable) 
	begin
	out <= {out[6],out[5],
          out[4] ,out[3],
          out[2], out[1],
          out[0], linear_feedback};
end 

endmodule
