module ps_controller(input Clk,Reset,
							input [7:0] keyCode,
							input keypress,
							output [7:0] key1);

							
logic [7:0] data1,data2;
always_ff @ (posedge Clk)

if (Reset)
begin

	data1<= 8'h00;
	data2<= 8'h00;
end

else
begin
	
	if (keypress == 1'b1)
	begin
		if(!data1 && !data2)
			begin
			data1 <= keyCode;
			end
		else if (data1 != 8'h00 && !data2)
			begin
			if (data1 == keyCode)
				begin
				//do nothing
				end
			else
				begin
				data2 <= data1;
				data1 <= keyCode;
				end
			end
		
	end
	else
	begin
		
		if (data2 == 8'h00)
			begin
			if (keyCode != data1)
			begin
			// if the key being released is not data1, 
			// it means that second key is released but the first key is still pressed, so do nothing until the keyCode == data1 
			end
			else
			begin
				data1<= 8'h00;
			end
			end
		else
		begin
		if (keyCode == data1)
			
			begin
				data1 <= data2;
				data2 <= 8'h00;
			end
		else if (keyCode == data2)
			begin
				data2 <=8'h00;
			end
		end
	end
	
		
end

assign key1 = data1;
endmodule
	
	