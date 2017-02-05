module  Missile ( input Reset, frame_clk,
						input [9:0] Xstart, Ystart,
						input [1:0] TankType,
						input Missile_on,
						input Missile_Collision,
						output logic [9:0]  MissileX, MissileY,
						output logic [1:0] MissileType,
						output logic MissileDisplay);
				
logic finish;
parameter [9:0] MissileStep = 10'd2;

enum logic [1:0] {WAIT, MOVE,INIT} state, next_state;


//state transition
always_ff @ (posedge frame_clk or posedge Reset) 
begin
	if (Reset) 
		begin
		state <= WAIT;
		end 
	else
		begin
		state <= next_state;
		end
end


//location update
always_ff @ (posedge frame_clk) 
	begin
	if (state == INIT)
		begin
		MissileX <= Xstart;
		MissileY <= Ystart;
		MissileType <= TankType;
		finish   <= 1'b0;
		MissileDisplay <= 1'b1;
		end
	else if (state == MOVE)
		begin
		if (MissileX > 0 && MissileX < 256 && MissileY > 0 && MissileY < 256)
			begin
			if (!Missile_Collision)
				begin
			case(MissileType)
			2'b00:
			MissileY <= MissileY - MissileStep;
			2'b10:
			MissileY <= MissileY + MissileStep;
			2'b01:
			MissileX <= MissileX - MissileStep;
			2'b11:
			MissileX <= MissileX + MissileStep;
			endcase
				end
				
			else begin
			finish <= 1'b1;
			MissileDisplay <= 1'b0;
			end
			end
		else
			begin
			finish <= 1'b1;
			MissileDisplay <= 1'b0;
			end
		end
end


//state transition
always_comb begin
	next_state = state;
	case (state)
		WAIT: begin
			if (Missile_on == 1'b1)
				next_state = INIT;
		end
		INIT:begin
			next_state = MOVE;
		end
			
		MOVE: begin
			if (finish)
				next_state = WAIT;
		end
	endcase
end

endmodule

    