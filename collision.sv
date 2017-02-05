module collision(input Clk,
					  input [7:0]keycode,
					  input [9:0]  TankX, TankY,WallX1Size1, WallY1Size1, WallX1, WallY1,
					  input [9:0] WallX1Size2, WallY1Size2, WallX2, WallY2,
					  input [9:0] WallX1Size3, WallY1Size3, WallX3, WallY3,
					  //
					  input [9:0]  AI_TankX, AI_TankY,
					  input [1:0] AI_Tanktype,
					  input [9:0]  AI_MissileX, AI_MissileY,
					  input [1:0] AI_MissileType,
					  //
					  
					  input [9:0]  MissileX, MissileY,
					  input [1:0] 	MissileType,
					  output logic Missile_Collision, AI_Missile_Collision,
					  //
					  output logic Tank_Collision,Base_Collision,AI_Tank_Collision,
					  output logic [0:1] Collision_Type, AI_Collision_Type
					  );
					   
	parameter [9:0] Tank_X_Min=0;       // Leftmost point on the X axis
   parameter [9:0] Tank_X_Max=256;     // Rightmost point on the X axis
   parameter [9:0] Tank_Y_Min=0;       // Topmost point on the Y axis
   parameter [9:0] Tank_Y_Max=256;     // Bottommost point on the Y axis				  
	//Tank parameter
	parameter [9:0] Tank_X_Step=10'd1;      // Step size on the X axis
	parameter [9:0] Tank_Y_Step=10'd1;      // Step size on the Y axis
	parameter [9:0] Tank_Size = 10'd16;
	
	//Missile parameter
	parameter [9:0] MissileStep = 10'd2;
	parameter [9:0] MissileWidth = 10'd8;
	parameter [9:0] MissileHeight = 10'd16;
	
	//keyboard parameter
	parameter [7:0] up = 8'h1d;
	parameter [7:0] down = 8'h1b;
	parameter [7:0] left = 8'h1c;
	parameter [7:0] right = 8'h23;
	parameter [7:0] space = 8'h29;
	
	//base parameter
	parameter [9:0] BaseX = 10'd120;
	parameter [9:0] BaseXSize  = 10'd16;
	parameter [9:0] BaseY = 10'd240;
	parameter [9:0] BaseYSize = 10'd16;
	//parameter [9:0] Size  = 10'd16;


	
/////////////////////// 
//Tank1 Wall1 collision
///////////////////////

always_comb
	begin
	unique case (keycode)
	
		up: //up
		begin
		
			if ((TankY - Tank_Y_Step == WallY1 + WallY1Size1) && (TankX + Tank_Size > WallX1) && (TankX < WallX1 + WallX1Size1))
				begin	
					Tank_Collision = 1'b1;
					//Collision_Type = 2'd1;
				end
			else if ((TankY - Tank_Y_Step == AI_TankY + Tank_Size) && (TankX +Tank_Size > AI_TankX) && (TankX < AI_TankX + Tank_Size))
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end	
			else if ((TankY - Tank_Y_Step == WallY2 + WallY1Size2) && (TankX + Tank_Size > WallX2) && (TankX < WallX2 + WallX1Size2))
				begin	
					Tank_Collision = 1'b1;
					//Collision_Type = 2'd1;
				end
			else if ((TankY - Tank_Y_Step == WallY3 + WallY1Size3) && (TankX + Tank_Size > WallX3) && (TankX < WallX3 + WallX1Size3))
				begin	
					Tank_Collision = 1'b1;
					//Collision_Type = 2'd1;
				end
			else
				begin
					Tank_Collision = 1'b0;
					//Collision_Type = 2'd0;
				end
			
		end
		down: //down
		begin
		
			if ((TankY + Tank_Size + Tank_Y_Step == WallY1) &&( TankX + Tank_Size > WallX1) && (TankX < WallX1 + WallX1Size1))//within the bounds of the wall
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if ((TankY + Tank_Size +Tank_Y_Step == AI_TankY) && (TankX +Tank_Size > AI_TankX) && (TankX < AI_TankX + Tank_Size))
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if ((TankY + Tank_Size + Tank_Y_Step == WallY2) &&( TankX + Tank_Size > WallX2) && (TankX < WallX2 + WallX1Size2))//within the bounds of the wall
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if ((TankY + Tank_Size + Tank_Y_Step == WallY3) &&( TankX + Tank_Size > WallX3) && (TankX < WallX3 + WallX1Size3))//within the bounds of the wall
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else
			begin
				Tank_Collision = 1'b0;
				//Collision_Type = 2'd0;
			end
		end
		left: //left
		begin
			if(((TankX - Tank_X_Step) == WallX1 + WallX1Size1)&&(TankY +Tank_Size > WallY1) && (TankY < WallY1 + WallY1Size1))//within the bounds of wall
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if ((TankX - Tank_X_Step == AI_TankX + Tank_Size) && (TankY +Tank_Size > AI_TankY) && (TankY < AI_TankY + Tank_Size))
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end	
			else if(((TankX - Tank_X_Step) == WallX2 + WallX1Size2)&&(TankY +Tank_Size > WallY2) && (TankY < WallY2 + WallY1Size2))//within the bounds of wall
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if(((TankX - Tank_X_Step) == WallX3 + WallX1Size3)&&(TankY +Tank_Size > WallY3) && (TankY < WallY3 + WallY1Size3))//within the bounds of wall
			begin
				Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else
				begin
				Tank_Collision = 1'b0;
				//Collision_Type = 2'd0;
				end
		end
		right: //right
		begin
		if((TankX + Tank_Size + Tank_X_Step == WallX1)   &&(TankY +Tank_Size > WallY1) && (TankY < WallY1 + WallY1Size1))
		begin
			Tank_Collision = 1'b1;
			//Collision_Type = 2'd1;
			end
		else if ((TankX + Tank_Size + Tank_X_Step == AI_TankX) && (TankY +Tank_Size > AI_TankY) && (TankY < AI_TankY + Tank_Size)) //tank on tank collision
			begin
			Tank_Collision = 1'b1;
			//Collision_Type = 2'd1;
			end
		else if((TankX + Tank_Size + Tank_X_Step == WallX2)   &&(TankY +Tank_Size > WallY2) && (TankY < WallY2 + WallY1Size2))
		begin
			Tank_Collision = 1'b1;
			//Collision_Type = 2'd1;
			end
		else if((TankX + Tank_Size + Tank_X_Step == WallX3)   &&(TankY +Tank_Size > WallY3) && (TankY < WallY3 + WallY1Size3))
		begin
			Tank_Collision = 1'b1;
			//Collision_Type = 2'd1;
			end
		else
			begin
				Tank_Collision = 1'b0;
				//Collision_Type = 2'd0;
			end
		end
		
		default:
		begin
			Tank_Collision = 1'b0;
			//Collision_Type = 2'd0;
		end
		endcase
end
//////////////////////////	
//Missile1 Wall1 and AI collision
//////////////////////////

always_comb
	begin
	unique case(MissileType)
	2'b00:
	//up
	if((MissileY - MissileStep <= WallY1 + WallY1Size1)&&(MissileY > WallY1 )&&(MissileX + MissileWidth >= WallX1) && (MissileX <= WallX1 + WallX1Size1))
	
		begin
		Missile_Collision = 1'b1;
		Collision_Type = 2'd0;
		end
	else if ((MissileY - MissileStep <= AI_TankY + Tank_Size)&&(MissileY > AI_TankY) && (MissileX+MissileWidth	> AI_TankX) && (MissileX < AI_TankX + Tank_Size))
		begin
		Missile_Collision = 1'b1;
		Collision_Type = 2'd1;
		end
	else if((MissileY - MissileStep <= WallY2 + WallY1Size2)&&(MissileY > WallY2 )&&(MissileX + MissileWidth >= WallX2) && (MissileX <= WallX2 + WallX1Size1))
		begin
		Missile_Collision = 1'b1;
		Collision_Type = 2'd0;
		end
	else if((MissileY - MissileStep <= WallY3 + WallY1Size3)&&(MissileY > WallY3 )&&(MissileX + MissileWidth >= WallX3) && (MissileX <= WallX3 + WallX1Size3))
		begin
		Missile_Collision = 1'b1;
		Collision_Type = 2'd0;
		end
	else
		begin
		Missile_Collision = 1'b0;
		Collision_Type = 2'd0;
		end
	
	2'b10:
	//down
	if ((MissileY + MissileHeight + MissileStep >= WallY1) && (MissileY + MissileHeight <  WallY1 + WallY1Size1)&&(MissileX + MissileWidth >= WallX1) && (MissileX <= WallX1 + WallX1Size1))//within the bounds of the wall
			begin
				Missile_Collision = 1'b1;
				Collision_Type = 2'd0;
			end
	else if ((MissileY + MissileHeight+ MissileStep >= AI_TankY ) && (MissileY + MissileHeight <  AI_TankY + Tank_Size)&& (MissileX+MissileWidth	> AI_TankX) && (MissileX < AI_TankX + Tank_Size))
		begin
			Missile_Collision = 1'b1;
			Collision_Type = 2'd1;
		end
	else if ((MissileY + MissileHeight + MissileStep >= WallY2) && (MissileY + MissileHeight <  WallY2 + WallY1Size2)&&(MissileX + MissileWidth >= WallX2) && (MissileX <= WallX2 + WallX1Size2))//within the bounds of the wall
			begin
				Missile_Collision = 1'b1;
				Collision_Type = 2'd0;
			end
	else if ((MissileY + MissileHeight + MissileStep >= WallY3) && (MissileY + MissileHeight <  WallY3 + WallY1Size3)&&(MissileX + MissileWidth >= WallX3) && (MissileX <= WallX3 + WallX1Size3))//within the bounds of the wall
			begin
				Missile_Collision = 1'b1;
				Collision_Type = 2'd0;
			end
	else
			begin
				Missile_Collision = 1'b0;
				Collision_Type = 2'd0;
			end
	
	2'b01:
	//left
	if(((MissileX - MissileStep) <= WallX1 + WallX1Size1)&& (MissileX > WallX1 )&&(MissileY + 10'd16 >= WallY1) && (MissileY <= WallY1 + WallY1Size1))//within the bounds of wall
			begin
				Missile_Collision = 1'b1;
				Collision_Type = 2'd0;
				end
	else if ((MissileX - MissileStep <= AI_TankX + Tank_Size )&& (MissileX > AI_TankX) && (MissileY+MissileHeight	> AI_TankY) && (MissileY < AI_TankY + Tank_Size))
		begin
			Missile_Collision = 1'b1;
			Collision_Type = 2'd1;
		end	
	else if(((MissileX - MissileStep) <= WallX2 + WallX1Size2)&& (MissileX > WallX2 )&&(MissileY + 10'd16 >= WallY2) && (MissileY <= WallY2 + WallY1Size2))//within the bounds of wall
			begin
				Missile_Collision = 1'b1;
				Collision_Type = 2'd0;
				end
	else if(((MissileX - MissileStep) <= WallX3 + WallX1Size3)&& (MissileX > WallX3 )&&(MissileY + 10'd16 >= WallY3) && (MissileY <= WallY3 + WallY1Size3))//within the bounds of wall
			begin
				Missile_Collision = 1'b1;
				Collision_Type = 2'd0;
				end
	else
			begin
				Missile_Collision = 1'b0;
				Collision_Type = 2'd0;
			end
	2'b11:
	//right
	if((MissileX + MissileWidth + MissileStep >= WallX1)&&(MissileX + MissileWidth < WallX1 + WallX1Size1)&&(MissileY + 10'd16 >= WallY1) && (MissileY <= WallY1 + WallY1Size1))
	begin
				Missile_Collision = 1'b1;
				Collision_Type = 2'd0;
				end
	else if ((MissileX + MissileWidth + MissileStep >= AI_TankX  )&& (MissileX + MissileWidth < AI_TankX + Tank_Size)&& (MissileY+MissileHeight	> AI_TankY) && (MissileY < AI_TankY + Tank_Size))
		begin
			Missile_Collision = 1'b1;
			Collision_Type = 2'd0;
		end
	else if((MissileX + MissileWidth + MissileStep >= WallX2)&&(MissileX + MissileWidth < WallX2 + WallX1Size2)&&(MissileY + 10'd16 >= WallY2) && (MissileY <= WallY2 + WallY1Size2))
		begin
			Missile_Collision = 1'b1;
			Collision_Type = 2'd0;	
		end
	else if((MissileX + MissileWidth + MissileStep >= WallX3)&&(MissileX + MissileWidth < WallX3 + WallX1Size3)&&(MissileY + 10'd16 >= WallY3) && (MissileY <= WallY3 + WallY1Size3))
		begin
			Missile_Collision = 1'b1;
			Collision_Type = 2'd0;
		end
	else
			begin
				Missile_Collision = 1'b0;
				Collision_Type = 2'd0;
			end
	default:
		begin
			Missile_Collision = 1'b0;
			Collision_Type = 2'd0;
		end		
	endcase
	end
	
	
/////////////////////////////
//Missile1 and base collision
/////////////////////////////


always_comb
	begin
	unique case(MissileType)
	2'b00:
	//up
	if((MissileY - MissileStep <= BaseY + BaseYSize)&&(MissileY > BaseY )&&(MissileX + MissileWidth >= BaseX) && (MissileX <= BaseX + BaseXSize))
	
		begin
		Base_Collision = 1'b1;
		end
	else
		begin
		Base_Collision = 1'b0;
		end
	
	2'b10:
	//down
	if ((MissileY + MissileHeight + MissileStep >= BaseY) && (MissileY + MissileHeight <  BaseY + BaseYSize)&&(MissileX + MissileWidth >= BaseX) && (MissileX <= BaseX + BaseXSize))//within the bounds of the Base
			begin
				Base_Collision = 1'b1;
			end
			
	else
			begin
				Base_Collision = 1'b0;
			end
	
	2'b01:
	//left
	if(((MissileX - MissileStep) <= BaseX + BaseXSize)&& (MissileX > BaseX )&&(MissileY + 10'd16 >= BaseY) && (MissileY <= BaseY + BaseYSize))//within the bounds of Base
			begin
				Base_Collision = 1'b1;
				
				end
				
	else
			begin
				Base_Collision = 1'b0;
			end
	2'b11:
	//right
	if((MissileX + MissileWidth + MissileStep >= BaseX)&&(MissileX + MissileWidth < BaseX + BaseXSize)&&(MissileY + 10'd16 >= BaseY) && (MissileY <= BaseY + BaseYSize))
	begin
				Base_Collision = 1'b1;
				
				end
				
	else
			begin
				Base_Collision = 1'b0;
			end
			
	endcase
	end
	
/////////////////////// 
//AI Tank1 Wall1 collision
///////////////////////

always_comb
	begin
	unique case (AI_Tanktype)
	
		2'b00: //up
		begin
		
			if ((AI_TankY - Tank_Y_Step <= WallY1 + WallY1Size1) &&(AI_TankY > WallY1 )&& (AI_TankX + Tank_Size > WallX1) && (AI_TankX < WallX1 + WallX1Size1))
				begin	
					AI_Tank_Collision = 1'b1;
					//AI_Collision_Type = 2'd1;
				end
			else if((AI_TankY -Tank_Y_Step) <= Tank_Y_Min)	
				begin
					AI_Tank_Collision = 1'b1;
				end
			else if ((AI_TankY - Tank_Y_Step <= WallY2 + WallY1Size2)&&(AI_TankY > WallY2 ) && (AI_TankX + Tank_Size > WallX2) && (AI_TankX < WallX2 + WallX1Size2))
				begin	
					AI_Tank_Collision = 1'b1;
					//Collision_Type = 2'd1;
				end
			else if ((AI_TankY - Tank_Y_Step <= WallY3 + WallY1Size3)&&(AI_TankY > WallY3 ) && (AI_TankX + Tank_Size > WallX3) && (AI_TankX < WallX3 + WallX1Size3))
				begin	
					AI_Tank_Collision = 1'b1;
					//Collision_Type = 2'd1;
				end
			else
				begin
					AI_Tank_Collision = 1'b0;
					//Collision_Type = 2'd0;
				end
			
		end
		2'b10: //down
		begin
		
			if ((AI_TankY + Tank_Size + Tank_Y_Step >= WallY1)  && (AI_TankY + Tank_Size <  WallY1 + WallY1Size1)&&( AI_TankX + Tank_Size > WallX1) && (AI_TankX < WallX1 + WallX1Size1))//within the bounds of the wall
			begin
				AI_Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if ( ((AI_TankY + Tank_Size + Tank_Y_Step) >= Tank_Y_Max ))
				begin
					AI_Tank_Collision = 1'b1;
				end
			else if ((AI_TankY + Tank_Size + Tank_Y_Step >= WallY2) && (AI_TankY + Tank_Size <  WallY2 + WallY1Size2) &&( AI_TankX + Tank_Size > WallX2) && (AI_TankX < WallX2 + WallX1Size2))//within the bounds of the wall
			begin
				AI_Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if ((AI_TankY + Tank_Size + Tank_Y_Step >= WallY3) && (AI_TankY + Tank_Size <  WallY3 + WallY1Size3) &&( AI_TankX + Tank_Size > WallX3) && (AI_TankX < WallX3 + WallX1Size3))//within the bounds of the wall
			begin
				AI_Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else
			begin
				AI_Tank_Collision = 1'b0;
				//Collision_Type = 2'd0;
			end
		end
		2'b01: //left
		begin
			if(((AI_TankX - Tank_X_Step) <= WallX1 + WallX1Size1)&& (AI_TankX > WallX1)&&(AI_TankY +Tank_Size > WallY1) && (AI_TankY < WallY1 + WallY1Size1))//within the bounds of wall
			begin
				AI_Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if(((AI_TankX - (Tank_X_Step)) <= Tank_X_Min))
				begin
					AI_Tank_Collision = 1'b1;
				end
			else if(((AI_TankX - Tank_X_Step) <= WallX2 + WallX1Size2)&& (AI_TankX > WallX2)&&(AI_TankY +Tank_Size > WallY2) && (AI_TankY < WallY2 + WallY1Size2))//within the bounds of wall
			begin
				AI_Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end
			else if(((AI_TankX - Tank_X_Step) <= WallX3 + WallX1Size3)&& (AI_TankX > WallX3)&&(AI_TankY +Tank_Size > WallY3) && (AI_TankY < WallY3 + WallY1Size3))//within the bounds of wall
			begin
				AI_Tank_Collision = 1'b1;
				//Collision_Type = 2'd1;
			end	
			else
				begin
				AI_Tank_Collision = 1'b0;
				//Collision_Type = 2'd0;
				end
		end
		2'b11: //right
		begin
		if((AI_TankX + Tank_Size + Tank_X_Step >= WallX1) &&(AI_TankX + Tank_Size < WallX1 + WallX1Size1)&&(AI_TankY +Tank_Size > WallY1) && (AI_TankY < WallY1 + WallY1Size1))
		begin
			AI_Tank_Collision = 1'b1;
			//Collision_Type = 2'd1;
			end
		else if ( ((AI_TankX + Tank_Size + Tank_X_Step) >= Tank_X_Max) )
				begin
					AI_Tank_Collision = 1'b1;
				end	
		else if((AI_TankX + Tank_Size + Tank_X_Step >= WallX2)&&(AI_TankX + Tank_Size < WallX2 + WallX1Size2)   &&(AI_TankY +Tank_Size > WallY2) && (AI_TankY < WallY2 + WallY1Size2))
		begin
			AI_Tank_Collision = 1'b1;
			//Collision_Type = 2'd1;
			end
		else if((AI_TankX + Tank_Size + Tank_X_Step >= WallX3)&&(AI_TankX + Tank_Size < WallX3 + WallX1Size3)   &&(AI_TankY +Tank_Size > WallY3) && (AI_TankY < WallY3 + WallY1Size3))
		begin
			AI_Tank_Collision = 1'b1;
			//Collision_Type = 2'd1;
			end	
		else
			begin
				AI_Tank_Collision = 1'b0;
				//Collision_Type = 2'd0;
			end
		end
		
		default:
		begin
			AI_Tank_Collision = 1'b0;
			//Collision_Type = 2'd0;
		end
		endcase
end

/***********************
AI_MISSILE COlLision
***********************/
always_comb
	begin
	unique case(AI_MissileType)
	2'b00:
	//up
	if((AI_MissileY - MissileStep <= WallY1 + WallY1Size1)&&(AI_MissileY > WallY1 )&&(AI_MissileX + MissileWidth >= WallX1) && (AI_MissileX <= WallX1 + WallX1Size1))
	
		begin
		AI_Missile_Collision = 1'b1;
		AI_Collision_Type = 2'd0;
		end
	else if ((AI_MissileY - MissileStep <= TankY + Tank_Size)&&(AI_MissileY > TankY) && (AI_MissileX+MissileWidth	> TankX) && (AI_MissileX < TankX + Tank_Size))
		begin
		AI_Missile_Collision = 1'b1;
		AI_Collision_Type = 2'd1;
		end
	else if((AI_MissileY - MissileStep <= WallY2 + WallY1Size2)&&(AI_MissileY > WallY2 )&&(AI_MissileX + MissileWidth >= WallX2) && (AI_MissileX <= WallX2 + WallX1Size1))
		begin
		AI_Missile_Collision = 1'b1;
		AI_Collision_Type = 2'd0;
		end
	else if((AI_MissileY - MissileStep <= WallY3 + WallY1Size3)&&(AI_MissileY > WallY3 )&&(AI_MissileX + MissileWidth >= WallX3) && (AI_MissileX <= WallX3 + WallX1Size3))
		begin
		AI_Missile_Collision = 1'b1;
		AI_Collision_Type = 2'd0;
		end
	else
		begin
		AI_Missile_Collision = 1'b0;
		AI_Collision_Type = 2'd0;
		end
	
	2'b10:
	//down
	if ((AI_MissileY + MissileHeight + MissileStep >= WallY1) && (AI_MissileY + MissileHeight <  WallY1 + WallY1Size1)&&(AI_MissileX + MissileWidth >= WallX1) && (AI_MissileX <= WallX1 + WallX1Size1))//within the bounds of the wall
			begin
				AI_Missile_Collision = 1'b1;
				AI_Collision_Type = 2'd0;
			end
	else if ((AI_MissileY + MissileHeight+ MissileStep >= TankY ) && (AI_MissileY + MissileHeight <  TankY + Tank_Size)&& (AI_MissileX+MissileWidth	> TankX) && (AI_MissileX < TankX + Tank_Size))
		begin
			AI_Missile_Collision = 1'b1;
			AI_Collision_Type = 2'd1;
		end
	else if ((AI_MissileY + MissileHeight + MissileStep >= WallY2) && (AI_MissileY + MissileHeight <  WallY2 + WallY1Size2)&&(AI_MissileX + MissileWidth >= WallX2) && (AI_MissileX <= WallX2 + WallX1Size2))//within the bounds of the wall
			begin
				AI_Missile_Collision = 1'b1;
				AI_Collision_Type = 2'd0;
			end
	else if ((AI_MissileY + MissileHeight + MissileStep >= WallY3) && (AI_MissileY + MissileHeight <  WallY3 + WallY1Size3)&&(AI_MissileX + MissileWidth >= WallX3) && (AI_MissileX <= WallX3 + WallX1Size3))//within the bounds of the wall
			begin
				AI_Missile_Collision = 1'b1;
				AI_Collision_Type = 2'd0;
			end
	else
			begin
				AI_Missile_Collision = 1'b0;
				AI_Collision_Type = 2'd0;
			end
	
	2'b01:
	//left
	if(((AI_MissileX - MissileStep) <= WallX1 + WallX1Size1)&& (AI_MissileX > WallX1 )&&(AI_MissileY + 10'd16 >= WallY1) && (AI_MissileY <= WallY1 + WallY1Size1))//within the bounds of wall
			begin
				AI_Missile_Collision = 1'b1;
				AI_Collision_Type = 2'd0;
				
				end
	else if ((AI_MissileX - MissileStep <= TankX + Tank_Size )&& (AI_MissileX > TankX) && (AI_MissileY+MissileHeight	> TankY) && (AI_MissileY < TankY + Tank_Size))
		begin
			AI_Missile_Collision = 1'b1;
			AI_Collision_Type = 2'd1;
		end	
	else if(((AI_MissileX - MissileStep) <= WallX2 + WallX1Size2)&& (AI_MissileX > WallX2 )&&(AI_MissileY + 10'd16 >= WallY2) && (AI_MissileY <= WallY2 + WallY1Size2))//within the bounds of wall
			begin
				AI_Missile_Collision = 1'b1;
				AI_Collision_Type = 2'd0;
				
				end
	else if(((AI_MissileX - MissileStep) <= WallX3 + WallX1Size3)&& (AI_MissileX > WallX3 )&&(AI_MissileY + 10'd16 >= WallY3) && (AI_MissileY <= WallY3 + WallY1Size3))//within the bounds of wall
			begin
				AI_Missile_Collision = 1'b1;
				AI_Collision_Type = 2'd0;
				end
	else
			begin
				AI_Missile_Collision = 1'b0;
				AI_Collision_Type = 2'd0;
			end
	2'b11:
	//right
	if((AI_MissileX + MissileWidth + MissileStep >= WallX1)&&(AI_MissileX + MissileWidth < WallX1 + WallX1Size1)&&(AI_MissileY + 10'd16 >= WallY1) && (AI_MissileY <= WallY1 + WallY1Size1))
	begin
				AI_Missile_Collision = 1'b1;
				AI_Collision_Type = 2'd0;
				end
	else if ((AI_MissileX + MissileWidth + MissileStep >= TankX  )&& (AI_MissileX + MissileWidth < TankX + Tank_Size)&& (AI_MissileY+MissileHeight	> TankY) && (AI_MissileY < TankY + Tank_Size))
		begin
			AI_Missile_Collision = 1'b1;
			AI_Collision_Type = 2'd1;
		end
	else if((AI_MissileX + MissileWidth + MissileStep >= WallX2)&&(AI_MissileX + MissileWidth < WallX2 + WallX1Size2)&&(AI_MissileY + 10'd16 >= WallY2) && (AI_MissileY <= WallY2 + WallY1Size2))
		begin
			AI_Missile_Collision = 1'b1;
			AI_Collision_Type = 2'd0;
				
		end
	else if((AI_MissileX + MissileWidth + MissileStep >= WallX3)&&(AI_MissileX + MissileWidth < WallX3 + WallX1Size3)&&(AI_MissileY + 10'd16 >= WallY3) && (AI_MissileY <= WallY3 + WallY1Size3))
		begin
			AI_Missile_Collision = 1'b1;
			AI_Collision_Type = 2'd0;
				
		end
	else
			begin
				AI_Missile_Collision = 1'b0;
				AI_Collision_Type = 2'd0;
			end
	default:
		begin
			AI_Missile_Collision = 1'b0;
			AI_Collision_Type = 2'd0;
		end		
	endcase
	end										
endmodule
							