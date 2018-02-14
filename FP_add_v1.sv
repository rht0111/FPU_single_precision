/***
 *                .-'''-.                              
 *               '   _    \                            
 *             /   /` '.   \    .        .--.          
 *            .   |     \  '  .'|        |__|          
 *    .-,.--. |   '      |  '<  |        .--.     .|   
 *    |  .-. |\    \     / /  | |        |  |   .' |_  
 *    | |  | | `.   ` ..' /   | | .'''-. |  | .'     | 
 *    | |  | |    '-...-'`    | |/.'''. \|  |'--.  .-' 
 *    | |  '-                 |  /    | ||  |   |  |   
 *    | |                     | |     | ||__|   |  |   
 *    | |                     | |     | |       |  '.' 
 *    |_|                     | '.    | '.      |   /  
 *                            '---'   '---'     `'-'   
 *
 *
 *	design: 	floating point (IEEE 754) adder without clk or reset, with limited functionality to accept 32-bit positive binary as inputs.
 *	date:		12.02.2018
 *	version:	1.0
 *
 */

 module fpa #(parameter size = 32)
 	(input logic [size-1 : 0] a, [size-1 : 0] b,
 	output logic [size-1 : 0] s
 	);

logic [7:0] temp_a;
logic [7:0] temp_b;
logic sign_a , sign_b , sign_c;
logic [7:0] exp_a , exp_b;
logic [23:0] exp_a1 , exp_b1 , exp_t , exp_t1;
logic [7:0] temp_c , temp_c1 , temp_d , temp_d1;

localparam bias = 8'h81;
localparam bias1 = 8'h7f;
localparam a1 = 32'h420f0000;
localparam b1 = 32'h41a40000;

assign temp_c = bias;
assign temp_c1 = bias1;
assign a = a1;
assign b = b1;

slice slice1 (
	.a(a),
	.temp(temp_a)
	);

slice slice2 (
	.a(b),
	.temp(temp_b)
	);

assign sign_a = a [size-1];
assign sign_b = b [size-1];
assign sign_c = sign_a & sign_b;

adder_8bit add1 (
	.a(temp_a),
	.b(temp_c),
	.s(exp_a)
	);

adder_8bit add2 (
	.a(temp_b),
	.b(temp_c),
	.s(exp_b)
	);

slice_m slice3 (
	.a(a),
	.temp(exp_a1)
	);

slice_m slice4 (
	.a(b),
	.temp(exp_b1)
	);

bit [1:0] i = 2'b00;

always_comb begin

	if (exp_a >= exp_b) begin
		assign temp_d = exp_a - exp_b;
		assign i = temp_d;
		assign exp_t = exp_b1 >> i;
		assign exp_t1 = exp_a1 + exp_t;
		assign temp_d1 = exp_a + temp_c1;
	end
	else if (exp_a <= exp_b) begin
		assign temp_d = exp_b - exp_a;
		assign i = temp_d;
		assign exp_t = exp_a1 >> i;
		assign exp_t1 = exp_t + exp_b1;
		assign temp_d1 = exp_b + temp_c1;
	end
end

assign s [31] = sign_c;

assign s [30] = temp_d1 [7];
assign s [29] = temp_d1 [6];
assign s [28] = temp_d1 [5];
assign s [27] = temp_d1 [4];
assign s [26] = temp_d1 [3];
assign s [25] = temp_d1 [2];
assign s [24] = temp_d1 [1];
assign s [23] = temp_d1 [0];

assign s [22] = exp_t1 [22];
assign s [21] = exp_t1 [21];
assign s [20] = exp_t1 [20];
assign s [19] = exp_t1 [19];
assign s [18] = exp_t1 [18];
assign s [17] = exp_t1 [17];
assign s [16] = exp_t1 [16];
assign s [15] = exp_t1 [15];

assign s [14] = exp_t1 [14];
assign s [13] = exp_t1 [13];
assign s [12] = exp_t1 [12];
assign s [11] = exp_t1 [11];
assign s [10] = exp_t1 [10];
assign s [9] = exp_t1 [9];
assign s [8] = exp_t1 [8];
assign s [7] = exp_t1 [7];

assign s [6] = exp_t1 [6];
assign s [5] = exp_t1 [5];
assign s [4] = exp_t1 [4];
assign s [3] = exp_t1 [3];
assign s [2] = exp_t1 [2];
assign s [1] = exp_t1 [1];
assign s [0] = exp_t1 [0];

endmodule