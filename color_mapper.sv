module  color_mapper ( input Clk,
							  input        [9:0] DrawX,DrawY,TankX,TankY,WallX1,WallY1, WallXSize1, WallYSize1,
							  input 			[9:0] MissileX, MissileY,
							  input			[1:0] TankType, MissileType,
							  input					MissileDisplay,
							  input 			[9:0] WallX2,WallY2,WallXSize2,WallYSize2,
							  input 			[9:0] WallX3,WallY3,WallXSize3,WallYSize3,
							  //AI part
							  input 			[9:0] AI_TankX,AI_TankY,
							  input 			[9:0] AI_MissileX, AI_MissileY,
							  input			[1:0] AI_TankType, AI_MissileType,
							  input					AI_MissileDisplay,
							  input 			[1:0] AI_death, tank_death,
							  
                       output logic [7:0]  Red, Green, Blue );
							  
			
			

	logic [7:0] mypalette[0:17][0:2];
	//logic [4:0] tank_Y [0:127][0:15];
	//logic [4:0] tank_S [0:127][0:15];
	logic [5:0] tank_P [0:127][0:15];
	logic [5:0] tank_G  [0:127][0:15];
	logic [5:0] Game_Over [0:31][0:15];
	logic [5:0] wall  [0:15][0:15];
	logic [5:0] steel [0:15][0:15];
	logic [5:0] base  [0:15][0:15];
	logic [5:0] wall1	[0:15][0:15];
	logic [5:0] missile1 [0:31][0:15];
	//FOR AI
	logic [5:0] missile2 [0:31][0:15];
	
	logic wall_on3;
	logic wall_on2;
	logic tank_on;
	logic wall_on1;
	logic missile_on1;
	
	logic game_over;
	
	logic AI_tank_on;
	logic AI_missile_on1;
	
	parameter [9:0] game_overX = 10'd112;
	parameter [9:0] game_overY = 10'd120;
	
	logic [9:0] Size = 10'd16;
	logic [5:0] TankColorIndex;
	logic [5:0] AI_TankColorIndex;
	logic [5:0]	WallColorIndex1;
	logic [5:0]	WallColorIndex2;
	logic [5:0]	WallColorIndex3;
	logic [5:0] MissileColorIndex;
	logic [5:0] AI_MissileColorIndex;
	logic [5:0] Game_overColorIndex;
	
	logic [5:0]	CurrColorIndex;
	
	palette p(.palette(mypalette));
	//tank_yellow tankY(.rgb(tank_Y));
	//tank_silver tankS(.rgb(tank_S));
	tank_purple tankP(.rgb(tank_P));//USED AS AI tank color
	tank_green  tankG(.rgb(tank_G));
	wall			w1	  (.rgb(wall1 ));
	bullet		miss (.rgb(missile1));
	bullet		ai_miss (.rgb(missile2));
	gameover   over(.rgb(Game_Over));
	always_comb
	begin
		if (AI_death || tank_death)
			begin
			game_over = 1;
			end
		else 
			begin
			game_over = 0;
			end
	end
	always_comb
	begin:tank_proc
		if (DrawX>=TankX && DrawX<TankX+Size && DrawY>=TankY && DrawY <TankY+Size)
			begin
				tank_on = 1;
			end
		else
			begin
				tank_on = 0;
			end
		if (DrawX>=WallX1 && DrawX <WallX1 +WallXSize1 && DrawY>=WallY1 && DrawY < WallY1 + WallYSize1)
			begin	
				wall_on1 = 1;
			end
		else 
			begin		
				wall_on1 = 0;
			end
		if (DrawX>=WallX2 && DrawX <WallX2 +WallXSize2 && DrawY>=WallY2 && DrawY < WallY2 + WallYSize2)	
			begin
				wall_on2 = 1;
			end
		else
			begin
				wall_on2 = 0;
			end
		if (DrawX>=WallX3 && DrawX <WallX3 +WallXSize3 && DrawY>=WallY3 && DrawY < WallY3 + WallYSize3)	
			begin
				wall_on3 = 1;
			end
		else
			begin
				wall_on3 = 0;
			end
		if (DrawX>=MissileX && DrawX < MissileX + 10'd8 && DrawY>=MissileY && DrawY < MissileY + 10'd16)
			begin
				missile_on1 = 1;
			end
		else
			begin
				missile_on1 = 0;
			end
			
		if (DrawX>=AI_TankX && DrawX<AI_TankX+Size && DrawY>=AI_TankY && DrawY <AI_TankY+Size)
			begin
				AI_tank_on = 1;
			end
		else
			begin
				AI_tank_on = 0;
			end
			
		if (DrawX>=AI_MissileX && DrawX < AI_MissileX + 10'd8 && DrawY>= AI_MissileY && DrawY < AI_MissileY + 10'd16)
			begin
				AI_missile_on1 = 1;
			end
		else
			begin
				AI_missile_on1 = 0;
			end
	
	end
	
	
	always_comb
	begin:color_pick
			if (tank_on)
				begin
					if (TankType == 2'b00)
						begin
							TankColorIndex = tank_G[DrawX-TankX][DrawY-TankY];
						end
					else if (TankType == 2'b01)
						begin
							TankColorIndex = tank_G[DrawX-TankX+32][DrawY-TankY];
						end
					else if (TankType == 2'b10)
						begin
							TankColorIndex = tank_G[DrawX-TankX+64][DrawY-TankY];
						end
					else
						begin
							TankColorIndex = tank_G[DrawX-TankX+96][DrawY-TankY];
						end
				
				end
			else
				begin
					TankColorIndex = tank_G[0][0];
				end
			//
			if (AI_tank_on)
				begin
					if (AI_TankType == 2'b00)
						begin
							AI_TankColorIndex = tank_P[DrawX-AI_TankX][DrawY-AI_TankY];
						end
					else if (AI_TankType == 2'b01)
						begin
							AI_TankColorIndex = tank_P[DrawX-AI_TankX+32][DrawY-AI_TankY];
						end
					else if (AI_TankType == 2'b10)
						begin
							AI_TankColorIndex = tank_P[DrawX-AI_TankX+64][DrawY-AI_TankY];
						end
					else
						begin
							AI_TankColorIndex = tank_P[DrawX-AI_TankX+96][DrawY-AI_TankY];
						end
				
				end
			else
				begin
					AI_TankColorIndex = tank_P[0][0];
				end
			
			//wall
			if (wall_on1)
				begin
				
				WallColorIndex1 = wall1[(DrawX - WallX1)%16][(DrawY - WallY1)%16];
				
				end
					
			else
				begin
				
				WallColorIndex1 = tank_G[0][0];
				
				end
			if (wall_on2)
				begin
				WallColorIndex2 = wall1[(DrawX - WallX2)%16][(DrawY - WallY2)%16];
				end
			else
				begin
				WallColorIndex2 = tank_G[0][0];
				end
			if (wall_on3)
				begin
				WallColorIndex3 = wall1[(DrawX - WallX3)%16][(DrawY - WallY3)%16];
				end
			else
				begin
				WallColorIndex3 = tank_G[0][0];
				end
			//missile	
			if (MissileDisplay)
				begin
				if(missile_on1)
					begin
					if (MissileType == 2'b00)
						begin
							MissileColorIndex = missile1[DrawX-MissileX][DrawY-MissileY];
						end
					else if (MissileType == 2'b01)
						begin
							MissileColorIndex = missile1[DrawX-MissileX+8][DrawY-MissileY];
						end
					else if (MissileType == 2'b10)
						begin
							MissileColorIndex = missile1[DrawX-MissileX+16][DrawY-MissileY];
						end
					else
						begin
							MissileColorIndex = missile1[DrawX-MissileX+24][DrawY-MissileY];
						end
				
					end
				else
					begin
						MissileColorIndex = missile1[0][0];
					end
				end
				
				else 
					begin
						MissileColorIndex = missile1[0][0];
					end
					
			//ai missile
			if (AI_MissileDisplay)
				begin
				if(AI_missile_on1)
					begin
					if (AI_MissileType == 2'b00)
						begin
							AI_MissileColorIndex = missile2[DrawX-AI_MissileX][DrawY-AI_MissileY];
						end
					else if (AI_MissileType == 2'b01)
						begin
							AI_MissileColorIndex = missile2[DrawX-AI_MissileX+8][DrawY-AI_MissileY];
						end
					else if (AI_MissileType == 2'b10)
						begin
							AI_MissileColorIndex = missile2[DrawX-AI_MissileX+16][DrawY-AI_MissileY];
						end
					else
						begin
							AI_MissileColorIndex = missile2[DrawX-AI_MissileX+24][DrawY-AI_MissileY];
						end
				
					end
				else
					begin
						AI_MissileColorIndex = missile2[0][0];
					end
				end
				
				else 
					begin
						AI_MissileColorIndex = missile2[0][0];
					end
				
			if (game_over)
			begin
				Game_overColorIndex = Game_Over[DrawX - 10'd112][DrawY - 10'd120];
			end
			
			else begin
				Game_overColorIndex = Game_Over[0][0];
			end
								
	end
	
	always_comb
		begin
			if  (game_over)
				begin
				Red = mypalette[Game_overColorIndex][0];
				Green = mypalette[Game_overColorIndex][1];
				Blue = mypalette[Game_overColorIndex][2];
				end
			else begin
			if (TankColorIndex != 4'd0 && tank_on == 1'b1)
				begin
					Red = mypalette[TankColorIndex][0];
					Green = mypalette[TankColorIndex][1];
					Blue = mypalette[TankColorIndex][2];
					
				end
			else if (AI_TankColorIndex != 4'd0 && AI_tank_on == 1'b1)
				begin
					Red = mypalette[AI_TankColorIndex][0];
					Green = mypalette[AI_TankColorIndex][1];
					Blue = mypalette[AI_TankColorIndex][2];
					
				end
				
			else if (WallColorIndex1 != 4'd0 && wall_on1 == 1'b1)
				begin
					Red = mypalette[WallColorIndex1][0];
					Green = mypalette[WallColorIndex1][1];
					Blue = mypalette[WallColorIndex1][2];
				end
			else if (WallColorIndex2 != 4'd0 && wall_on2 == 1'b1)
				begin
					Red = mypalette[WallColorIndex2][0];
					Green = mypalette[WallColorIndex2][1];
					Blue = mypalette[WallColorIndex2][2];
				end
			else if (WallColorIndex3 != 4'd0 && wall_on3 == 1'b1)
				begin
					Red = mypalette[WallColorIndex3][0];
					Green = mypalette[WallColorIndex3][1];
					Blue = mypalette[WallColorIndex3][2];
				end
				
			else if (MissileColorIndex != 4'd0 && missile_on1 == 1'b1)
				begin
					Red = mypalette[MissileColorIndex][0];
					Green = mypalette[MissileColorIndex][1];
					Blue = mypalette[MissileColorIndex][2];
				end
				
			else if (AI_MissileColorIndex != 4'd0 && AI_missile_on1 == 1'b1)
				begin
					Red = mypalette[AI_MissileColorIndex][0];
					Green = mypalette[AI_MissileColorIndex][1];
					Blue = mypalette[AI_MissileColorIndex][2];
				end
				
			else
				begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
				end
			end
			
		end
	
endmodule
