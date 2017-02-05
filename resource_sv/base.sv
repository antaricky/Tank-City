module base(output logic [5:0] rgb[0:15][0:15]);
assign rgb = '{
'{
5'd0,5'd1,5'd0,5'd1,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0
},
'{
5'd0,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0
},
'{
5'd0,5'd0,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0
},
'{
5'd0,5'd0,5'd0,5'd1,5'd1,5'd1,5'd2,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0
},
'{
5'd0,5'd0,5'd0,5'd0,5'd0,5'd1,5'd1,5'd2,5'd1,5'd1,5'd1,5'd0,5'd0,5'd1,5'd1,5'd0
},
'{
5'd0,5'd0,5'd0,5'd0,5'd0,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd1,5'd1,5'd0
},
'{
5'd0,5'd0,5'd1,5'd0,5'd0,5'd0,5'd1,5'd1,5'd2,5'd1,5'd0,5'd0,5'd1,5'd1,5'd0,5'd0
},
'{
5'd0,5'd0,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0
},
'{
5'd0,5'd0,5'd1,5'd2,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0
},
'{
5'd0,5'd0,5'd0,5'd1,5'd0,5'd0,5'd1,5'd1,5'd2,5'd1,5'd0,5'd0,5'd1,5'd1,5'd0,5'd0
},
'{
5'd0,5'd0,5'd0,5'd0,5'd0,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd1,5'd1,5'd0
},
'{
5'd0,5'd0,5'd0,5'd0,5'd0,5'd1,5'd1,5'd2,5'd1,5'd1,5'd1,5'd0,5'd0,5'd1,5'd1,5'd0
},
'{
5'd0,5'd0,5'd0,5'd1,5'd1,5'd1,5'd2,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0
},
'{
5'd0,5'd0,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0
},
'{
5'd0,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0
},
'{
5'd0,5'd1,5'd0,5'd1,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0
}};
endmodule
