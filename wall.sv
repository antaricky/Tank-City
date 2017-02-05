
module  Wall ( input [9:0] Xsize, Ysize, Xcoord, Ycoord,
               output logic [9:0]  WallX, WallY, 
					output logic [9:0] WallYsize, WallXsize);
    
    logic [9:0] Wall_X_Pos, Wall_X_Motion, Wall_Y_Pos, Wall_Y_Motion, Wall_Size;
	 

	

    assign WallXsize = 10'd16 * Xsize;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign WallYsize = 10'd16 * Ysize;
   
       
    assign WallX = 10'd16 * Xcoord;
   
    assign WallY = 10'd16 * Ycoord;
    

endmodule
