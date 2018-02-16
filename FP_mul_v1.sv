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
 *	design: 	floating point (IEEE 754) multiplier without clk or reset, works with limited inputs
 *	date:		12.02.2018
 *	version:	1.0
 *
 */

// http://www.rfwireless-world.com/Tutorials/floating-point-tutorial.html
// http://www.ecs.umass.edu/ece/koren/arith/simulator/FPMul/
// http://weitz.de/ieee/
// http://steve.hollasch.net/cgindex/coding/ieeefloat.html

 module fpm #(parameter size = 32 )
 	(input logic [size-1 : 0] a, [size-1 : 0] b,
 	output logic [size-1 : 0] c
 	);

//	A = -0.45 ; 32'b 1 1111 1101 1100 1100 1100 1100 1100 110 ; 32'hFEE66666

//	B =	+0.56 ; 32'b 0 1111 1110 0001 1110 1011 1000 0101 000 ; 32'h7F0F5C28

//	C =	-0.252 ; 32'b 1 1111 1101 0000 0010 0000 1100 0100 011 ; 32'hFE810623

logic sign_a , sign_b , sign_c;
logic [7:0] exp_a , exp_b , exp_c;
logic [23:0] mant_a , mant_b , mant_c;
logic [47:0] mant_c1;
bit m;

localparam a1 = 32'hFEE66666;
localparam b1 = 32'h7F0F5C28;
localparam p_zero = 32'h00000000;
localparam n_zero = 32'h80000000;
localparam p_infinity = 32'h7f800000;
localparam n_infinity = 32'hff800000;
localparam bias = 8'h7f;
localparam emax = 8'h7f;
localparam emin = 8'hfe;

assign a = a1;
assign b = b1;

assign sign_a = a [size-1];
assign sign_b = b [size-1];
// assign sign_c = sign_a ^ sign_b;
// assign c [31] = sign_c;

assign exp_a = a [size-2 : 23] - bias;
assign exp_b = b [size-2 : 23] - bias;

assign mant_a [23] = 1'b1;
assign mant_a [22:0] = a [size-10 : 0];
assign mant_b [23] = 1'b1;
assign mant_b [22:0] = b [size-10 : 0];

assign mant_c1 = mant_a * mant_b;
assign m = mant_c1[47];
// assign mant_c [23:0] = mant_c1 [47:24]; //loosing precision

initial begin
	
	if (a === p_zero || a === n_zero || b === p_zero || b === n_zero ) begin
		// assign c = 32'bx0000000000000000000000000000000;
		assign exp_c = 8'h00;
		assign mant_c = 24'h000000;
		assign sign_c = 1'bx;
	end 
	else if (a === p_infinity || a === n_infinity || b === p_infinity || b === n_infinity ) begin
		// assign c = 32'bx1111111100000000000000000000000;
		assign exp_c = 8'hff;
		assign mant_c = 24'h000000;
		assign sign_c = 1'bx;
	end 

	else if (m == 1'b1) begin //normalizing mantissa
		assign exp_c = exp_a + exp_b + 1'b1;
		if (exp_c >= emax) begin
			// assign c = 32'bx1111111100000000000000000000000;
			assign exp_c = 8'hff;
			assign mant_c = 24'h000000;
			assign sign_c = 1'bx;
		end 
		else if (exp_c <= emin) begin
			// assign c = 32'bx0000000000000000000000000000000;
			assign exp_c = 8'h00;
			assign mant_c = 24'h000000;
			assign sign_c = 1'bx;
		end 
		else begin
		assign mant_c = mant_c1 [47 : 24];
		assign sign_c = sign_a ^ sign_b;
		end 
	end
	else begin
		assign exp_c = exp_a + exp_b; 
		if (exp_c >= emax) begin
			// assign c = 32'bx1111111100000000000000000000000;
			assign exp_c = 8'hff;
			assign mant_c = 24'h000000;
			assign sign_c = 1'bx;
		end 
		else if (exp_c <= emin) begin
			// assign c = 32'bx0000000000000000000000000000000;
			assign exp_c = 8'h00;
			assign mant_c = 24'h000000;
			assign sign_c = 1'bx;
		end 
		else begin
			assign mant_c = mant_c1 [47 : 24];
			assign sign_c = sign_a ^ sign_b;
		end
	end 
end

assign c[31] = sign_c;
assign c[30:23] = exp_c;
assign c[22:0] = mant_c[22:0];

endmodule