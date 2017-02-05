module AI     ( input Reset, frame_clk,
					input  [9:0] trackX,trackY,
					input  Tank_Collision,
					input  [0:1] Collision_Type,
               output [9:0] TankX, TankY,
					output [1:0] TankType,
					output [9:0] Xstart, Ystart,
					output Missile_on,
					output Tank_Explosion);
					
	logic [9:0] Tank_X_Pos, Tank_Y_Pos, Tank_Size/*Tank_X_Motion,Tank_Y_Motion*/;
	 assign Tank_Size = 16;
	 
	 
    parameter [9:0] Tank_X_Center=200;  // Center position on the X axis
    parameter [9:0] Tank_Y_Center=200;  // Center position on the Y axis
    parameter [9:0] Tank_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Tank_X_Max=256;     // Rightmost point on the X axis
    parameter [9:0] Tank_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Tank_Y_Max=256;     // Bottommost point on the Y axis
    parameter [9:0] Tank_X_Step=1;      // Step size on the X axis
    parameter [9:0] Tank_Y_Step=1;      // Step size on the Y axis
	 
	 parameter [1:0] up = 2'd0;
	 parameter [1:0] down = 2'd1;
	 parameter [1:0] left = 2'd2;
	 parameter [1:0] right = 2'd3;
	 parameter [7:0] space = 8'h29;
	
	 logic [7:0] direction;
	 
	 logic lfsr_en;
	 logic [7:0] lfsr_out;
	 logic AI_shoot;
	 
	 lfsr lfsr_inst(.Clk(frame_clk), .Reset, .enable(lfsr_en), .out(lfsr_out) );
	 assign direction = lfsr_out % 8'd4;
	 assign AI_shoot = lfsr_out[0];

		always_comb
		begin
		
		if (Tank_Collision == 1'b1 || TankX % 10'd64 == 0 || TankY % 10'd48 == 0)
		begin
			lfsr_en = 1;
		end
		
		else
			begin
			lfsr_en = 0;
			end
		
		end
	/*	
	always_comb
	
	begin
	
	if (Tank_Collision)
	
				begin
					if (TankType == 2'b00)//up
					begin
						direction = right;
					end
					else if (TankType == 2'b10)//down
					begin
					direction = left;
					end
					else if (TankType == 2'b01)//left
					begin
					direction = up;
					end
					else //right
					begin
					direction = down;
					end
				end
	else
			begin
				 direction = lfsr_out % 8'd4;
			end
	*/
	 /*
	logic [9:0] diffX,diffY;

	 
	logic [19:0] counter;
	always_comb //@(posedge frame_clk)
	begin
	
	//diffX = Tank_X_Pos - trackX;
	//diffY = Tank_Y_Pos - trackY;
	diffX = trackX - Tank_X_Pos;
	diffY = trackY - Tank_Y_Pos;
	end
	
	always_ff @(posedge frame_clk)
	//begin
	
		if (Reset)
			begin
			counter <= 20'h00000;
			end
		else
		begin
	
			if (counter < 20'hf0000)
			begin
				counter<= counter + 20'h00001;
			end
		
			else 
			begin
		
				counter <=20'h00000;
				if (Tank_Collision)
				begin
					if (TankType == 2'b00)//up
					begin
						direction <= right;
					end
					else if (TankType == 2'b10)//down
					begin
					direction <= left;
					end
					else if (TankType == 2'b01)//left
					begin
					direction <= up;
					end
					else //right
					begin
					direction <= down;
					end
				end
				else
				
				begin
					if(diffX > 0 && diffY >0)
					begin
						if (diffX > diffY)
							begin
								direction <= up;
								//direction <= down;
							end
						else
							begin
								direction <= left;
								//direction <= right;
							end
					end
		
					else if(diffX > 0 && diffY < 0)
					begin
						if (diffX + diffY > 0)
							begin
								direction <= down;
								//direction <= up;
							end
						else
							begin
								direction <= left;
								//direction <= right;
							end
					end
   
					else if(diffX < 0 && diffY < 0)
					begin
						if (diffX > diffY)
							begin
								direction <= down;
								//direction <= left;
							end
						else
							begin
								direction <= right;
								//direction <= up;
							end
					end
		
					else if(diffX <0 && diffY > 0)
					begin
						if (diffX + diffY > 0)
							begin
								direction <= right;
								//direction <= left;
							end
						else
							begin
								direction <= up;
								//direction <= down;
							end
					end
					
					else
					begin
						if(diffX == 0)
							begin
								if (diffY > 0)
									begin
										direction <= up;
										//direction <= down;
									end
								else
									begin
										direction <= down;
										//direction <= up;
									end
							end
						else if (diffY == 0)
							begin
								if(diffX > 0)
									begin
										direction <= left;
										//direction <= right;
									end
								else
									begin
										direction <= right;
										//direction <= left;
									end
							end
					end 
				//end
			//end
		//end
	//end
	*/
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Tank
        if (Reset)  // Asynchronous Reset
        begin 
            Tank_Explosion <= 1'b0;
				Tank_Y_Pos <= Tank_Y_Center;
				Tank_X_Pos <= Tank_X_Center;
        end
        
		  else
			begin 
				TankType <=TankType;
				 unique case (direction)
						up: //up
							begin
								TankType <= 2'b00;
								if ((Tank_Y_Pos + (~(Tank_Y_Step) + 1'b1)) > Tank_Y_Min)
								begin
									if (Tank_Collision)//if collide
								
										begin
										
										end
									
									else
									begin
										Tank_X_Pos <= Tank_X_Pos;
										Tank_Y_Pos <=Tank_Y_Pos+ (~ (Tank_Y_Step) + 1'b1);
									end
								
									if (Collision_Type == 2'd1)
									begin
										Tank_Explosion <= 1'd1;
									end
									
								end
							end
							
						down: //down
							begin
								TankType <=2'b10;
								if ( ((Tank_Y_Pos + Tank_Size + Tank_Y_Step) < Tank_Y_Max ))
									begin
									if (Tank_Collision)//if (!Tank_Collision)
										begin
									
										end
									else 
										begin
												Tank_X_Pos <= Tank_X_Pos;
												Tank_Y_Pos<=Tank_Y_Pos+ (Tank_Y_Step);
										end
										
										if (Collision_Type == 2'd1)
											begin
										Tank_Explosion <= 1'd1;
									end
									end
									
							end
						left: //left
							begin
							TankType <=2'b01;
								if(((Tank_X_Pos + (~ (Tank_X_Step) + 1'b1)) > Tank_X_Min))
									begin
									if (Tank_Collision)//if (!Tank_Collision)

										begin
										
										end
									else
										begin
											Tank_Y_Pos <= Tank_Y_Pos;
											Tank_X_Pos<=Tank_X_Pos+ (~ (Tank_X_Step) + 1'b1); 
										end
									if (Collision_Type == 2'd1)
									begin
										Tank_Explosion <= 1'd1;
									end
								end
							end
							
						right: //right
							begin
							TankType <=2'b11;
								if ( ((Tank_X_Pos + Tank_Size + Tank_X_Step) < Tank_X_Max) )
								begin
								if (Tank_Collision)//if (!Tank_Collision)
								
										begin
										
										end
								
								else
									begin
										Tank_Y_Pos <= Tank_Y_Pos;
										Tank_X_Pos <= Tank_X_Pos + Tank_X_Step;
									end
								if (Collision_Type == 2'd1)
									begin
										Tank_Explosion <= 1'd1;
									end
								end
						end
						
						default:
						begin
						end
						
							
						endcase
						
						if (AI_shoot) //space key for missile
							begin
								if (TankType == 2'b00)//up
								begin
									Xstart <= Tank_X_Pos + 10'd4;
									Ystart <= Tank_Y_Pos;
									//Missile_on <= 1'b1;
									
								end
								else if (TankType == 2'b01)//left
								begin
									Xstart <= Tank_X_Pos;
									Ystart <= Tank_Y_Pos;
									//Missile_on <= 1'b1;
									
								end
								else if (TankType == 2'b10)//down
								begin
									Xstart <= Tank_X_Pos + 10'd4;
									Ystart <= Tank_Y_Pos + 10'd16;
									//Missile_on <= 1'b1;
									
								end
								else 								//right
								begin
									Xstart <= Tank_X_Pos + 10'd16;
									Ystart <= Tank_Y_Pos;
									//Missile_on <= 1'b1;
									
								end
							end


		end  
    end
	
	
	
	always_comb
	begin
	if (AI_shoot)
		begin
		Missile_on = 1'b1;
		end
	else 
		begin
		Missile_on = 1'b0;
		end
	end
	
	
	
	
    assign TankX = Tank_X_Pos;
    assign TankY = Tank_Y_Pos;
    

endmodule
