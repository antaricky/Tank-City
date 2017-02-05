
module  final_poject 	( input         CLOCK_50,
                       input[3:0]    KEY, //bit 0 is set up as Reset
							  output [6:0]  HEX0, HEX1, //HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
							  output [8:0]  LEDG,
							  //output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  VGA_R,					//VGA Red
							                VGA_G,					//VGA Green
												 VGA_B,					//VGA Blue
							  output        VGA_CLK,				//VGA Clock
							                VGA_SYNC_N,			//VGA Sync signal
												 VGA_BLANK_N,			//VGA Blank signal
												 VGA_VS,					//VGA virtical sync signal	
												 VGA_HS,					//VGA horizontal sync signal
							  //ps2 interface
							  input PS2_KBCLK,
							  input PS2_KBDAT
											);
    
    logic Reset_h, vssig, Clk;
    logic [9:0] drawxsig, drawysig, Tankxsig, Tankysig;
	 logic [1:0] TankTypesig;
	 logic [7:0] keycode;
	 
    
	 assign Clk = CLOCK_50;
    assign {Reset_h}=~ (KEY[0]);  // The push buttons are active low
	 assign VGA_VS = vssig;
	 assign LEDG[0] = keypress;
	 
	//vga controller
   vga_controller vgasync_instance(.*, .Reset(Reset_h), .hs(VGA_HS), .vs(vssig), .pixel_clk(VGA_CLK), .blank(VGA_BLANK_N), 
	
													.sync(VGA_SYNC_N), .DrawX(drawxsig), .DrawY(drawysig));
   
	//PS2 keyboard
	logic keypress;
	logic [7:0] keyCode;
	
	keyboard my_key(.Clk, .psClk(PS2_KBCLK), .psData(PS2_KBDAT), .reset(Reset_h), .keyCode, .press(keypress));
	ps_controller ps_inst(.Clk, .Reset(Reset_h), .keyCode, .keypress, .key1(keycode));
	
	//Tank1 and missile1
	logic[9:0] MissileStartX1, MissileStartY1, MissileX1,MissileY1;
	logic [1:0] MissileType1;
	logic MissileDisplay1,Missile_on1;
	logic Missile_Collision1;
	logic Tank_Collision1;
	logic Tank_Explosion;
	logic [0:1] Collision_Type1;
	
   Tank Tank_instance(.Reset(Reset_h), .frame_clk(vssig), .keycode(keycode),
							 
							 .Tank_Collision(Tank_Collision1), .Collision_Type(AI_Collision_Type1), .TankX(Tankxsig), .TankY(Tankysig), .TankType(TankTypesig),
							 
							 .Xstart(MissileStartX1),.Ystart(MissileStartY1), .Missile_on(Missile_on1), .Tank_Explosion(Tank_Explosion));
							 
	Missile missile1	(.Reset(Reset_h), .frame_clk(vssig), .Xstart(MissileStartX1), .Ystart(MissileStartY1), 
	
						.TankType(TankTypesig), .Missile_on(Missile_on1), .Missile_Collision(Missile_Collision1), .MissileX(MissileX1), .MissileY(MissileY1),
						
						.MissileType(MissileType1), .MissileDisplay(MissileDisplay1));
	
	
	///AI1 and AI_Missile1
	logic [9:0] AI_Tankxsig, AI_Tankysig;
	logic [1:0] AI_TankTypesig;
	
	logic [9:0] AI_MissileStartX1, AI_MissileStartY1, AI_MissileX1,AI_MissileY1;
	logic [1:0] AI_MissileType1;
	logic AI_MissileDisplay1,AI_Missile_on1;
	logic AI_Missile_Collision1;
	logic AI_Tank_Collision1;
	logic AI_Tank_Explosion;
	logic [0:1] AI_Collision_Type1;
	
	AI ai_inst(.Reset(Reset_h), .frame_clk(vssig),
							 .trackX(Tankxsig),.trackY(Tankysig),
	
							 .Tank_Collision(AI_Tank_Collision1), .Collision_Type(Collision_Type1), .TankX(AI_Tankxsig), .TankY(AI_Tankysig), .TankType(AI_TankTypesig),
							 
							 .Xstart(AI_MissileStartX1),.Ystart(AI_MissileStartY1), .Missile_on(AI_Missile_on1), .Tank_Explosion(AI_Tank_Explosion));
							 
   Missile AI_missile1	(.Reset(Reset_h), .frame_clk(vssig), .Xstart(AI_MissileStartX1), .Ystart(AI_MissileStartY1), 
	
						.TankType(AI_TankTypesig), .Missile_on(AI_Missile_on1), .Missile_Collision(AI_Missile_Collision1), .MissileX(AI_MissileX1), .MissileY(AI_MissileY1),
						
						.MissileType(AI_MissileType1), .MissileDisplay(AI_MissileDisplay1));
						
	
	
	//walls
	logic [9:0]WallX1,WallY1,WallXSize1, WallYSize1;
	logic [9:0]XSize1 =	2;
	logic [9:0]YSize1 = 	4; 
	logic [9:0]Xcoord1 = 2;
	logic [9:0]Ycoord1 = 4;
	
	Wall Wall1 (.Xsize(XSize1), .Ysize(YSize1), .Xcoord(Xcoord1), .Ycoord(Ycoord1), .WallX(WallX1), .WallY(WallY1), .WallYsize(WallYSize1), .WallXsize(WallXSize1));
	
	logic [9:0]WallX2,WallY2,WallXSize2, WallYSize2;
	logic [9:0]XSize2 =	2;
	logic [9:0]YSize2 = 	4; 
	logic [9:0]Xcoord2 = 10;
	logic [9:0]Ycoord2 = 4;
	
	Wall Wall2 (.Xsize(XSize2), .Ysize(YSize2), .Xcoord(Xcoord2), .Ycoord(Ycoord2), .WallX(WallX2), .WallY(WallY2), .WallYsize(WallYSize2), .WallXsize(WallXSize2));
	
	
	logic [9:0]WallX3,WallY3,WallXSize3, WallYSize3;
	logic [9:0]XSize3 =	10;
	logic [9:0]YSize3 = 	2; 
	logic [9:0]Xcoord3 = 2;
	logic [9:0]Ycoord3 = 11;
	Wall Wall3 (.Xsize(XSize3), .Ysize(YSize3), .Xcoord(Xcoord3), .Ycoord(Ycoord3), .WallX(WallX3), .WallY(WallY3), .WallYsize(WallYSize3), .WallXsize(WallXSize3));
	//collision
	logic Base_Collision;
	
	collision collide_inst(.Clk(vssig), .keycode(keycode), .TankX(Tankxsig), .TankY(Tankysig), 
	
	.WallY1Size1(WallYSize1), .WallX1Size1(WallXSize1),.WallX1(WallX1), .WallY1(WallY1), 
	
	.WallY1Size2(WallYSize2), .WallX1Size2(WallXSize2),.WallX2(WallX2), .WallY2(WallY2),
	
	.WallX1Size3(WallXSize3), .WallY1Size3(WallYSize3), .WallX3(WallX3), .WallY3(WallY3),
	
	.AI_TankX(AI_Tankxsig), .AI_TankY(AI_Tankysig),.AI_Tanktype(AI_TankTypesig),
	
	.MissileX(MissileX1), .MissileY(MissileY1), .MissileType(MissileType1), .Missile_Collision(Missile_Collision1),
	
	.AI_MissileX(AI_MissileX1), .AI_MissileY(AI_MissileY1),.AI_MissileType(AI_MissileType1),.AI_Missile_Collision(AI_Missile_Collision1),
	
	.Tank_Collision(Tank_Collision1), .Base_Collision, .Collision_Type(Collision_Type1),.AI_Tank_Collision(AI_Tank_Collision1),
	.AI_Collision_Type(AI_Collision_Type1));
	
	
	//color mapper 
   color_mapper color_instance(.Clk, .DrawX(drawxsig), .DrawY(drawysig),
	
										 .TankX(Tankxsig), .TankY(Tankysig), .WallX1,.WallY1, .WallXSize1, .WallYSize1,
										 
										 .WallX2,.WallY2,.WallXSize2,.WallYSize2,
										 
										  .WallX3,.WallY3,.WallXSize3,.WallYSize3,
	
										 .MissileX(MissileX1),.MissileY(MissileY1),
										 
										 .TankType(TankTypesig), .MissileType(MissileType1), .MissileDisplay(MissileDisplay1),
										 
										 //death
										 .AI_death(AI_Tank_Explosion), .tank_death(Tank_Explosion),
										 //AI
										 
										 .AI_TankX(AI_Tankxsig), .AI_TankY(AI_Tankysig),
										 
										 .AI_MissileX(AI_MissileX1), .AI_MissileY(AI_MissileY1),
										 
										 .AI_TankType(AI_TankTypesig), .AI_MissileType(AI_MissileType1),
										 .AI_MissileDisplay(AI_MissileDisplay1),
										 
										  //RGB
										 .Red(VGA_R), .Green(VGA_G), .Blue(VGA_B) );
	 							  
	HexDriver hex_inst_0 (keyCode[3:0],  HEX0);
	HexDriver hex_inst_1 (keyCode[7:4],  HEX1);
	//HexDriver hex_inst_2 (keycode[11:8], HEX2);
	//HexDriver hex_inst_3 (keycode[15:12], HEX3);
	
	
    

endmodule
