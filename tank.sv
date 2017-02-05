
module  Tank ( input Reset, frame_clk,
					input [7:0] keycode,
					//input [9:0] WallXSize1, WallYSize1, WallX1, WallY1,
					input Tank_Collision,
					input  [0:1] Collision_Type,
               output [9:0]  TankX, TankY,
					output [1:0] TankType,
					output [9:0] Xstart, Ystart,
					output Missile_on,
					output Tank_Explosion);
    
    logic [9:0] Tank_X_Pos, Tank_Y_Pos, Tank_Size/*Tank_X_Motion,Tank_Y_Motion*/;
	 
	 
	 
    parameter [9:0] Tank_X_Center=0;  // Center position on the X axis
    parameter [9:0] Tank_Y_Center=239;  // Center position on the Y axis
    parameter [9:0] Tank_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Tank_X_Max=256;     // Rightmost point on the X axis
    parameter [9:0] Tank_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Tank_Y_Max=256;     // Bottommost point on the Y axis
    parameter [9:0] Tank_X_Step=1;      // Step size on the X axis
    parameter [9:0] Tank_Y_Step=1;      // Step size on the Y axis
	 parameter [7:0] up = 8'h1d;
	 parameter [7:0] down = 8'h1b;
	 parameter [7:0] left = 8'h1c;
	 parameter [7:0] right = 8'h23;
	 parameter [7:0] space = 8'h29;

    assign Tank_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Tank
        if (Reset)  // Asynchronous Reset
        begin 
            //Tank_Y_Motion <= 10'd0; //Tank_Y_Step;
				//Tank_X_Motion <= 10'd0; //Tank_X_Step;
				Tank_Explosion<= 1'b0;
				Tank_Y_Pos <= Tank_Y_Center;
				Tank_X_Pos <= Tank_X_Center;
        end
        
		  else
			begin 
				TankType <=TankType;
				 unique case (keycode)
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
									end
									
									if (Collision_Type == 2'd1)
									begin
										Tank_Explosion <= 1'd1;
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
							
						space: //space key for missile
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
						default:
						begin
						end
						
							
				endcase

		end  
    end
	
	
	
	always_comb
	begin
	if (keycode == space)
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
