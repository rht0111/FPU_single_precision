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
 *	design: 	8-bit adder
 *	date:		13.02.2018
 *	version:	1.0
 *
 */

module adder (
	input a, b, cin,
	output s, cout
);

wire w1, w2, w3;

xor (w1, a, b);
xor (s, w1, cin);
and (w2, w1, cin);
and (w3, a, b);
or (cout, w2, w3);

endmodule


module adder_8bit (
 	input [7:0] a ,b,
 	// input cin,
 	output [7:0] s
 	// output cout
 	);

wire cin , cout;
wire [6:0] c;

localparam zero = 1'b0;
assign cin = zero;

adder f0(
	.a(a[0]),
	.b(b[0]),
	.cin(cin),
	.s(s[0]),
	.cout(c[0])
	);

genvar i;
generate
	for (i=1; i<7; i++) begin
		adder f[i](
			.a(a[i]),
			.b(b[i]),
			.cin(c[i-1]),
			.s(s[i]),
			.cout(c[i])
			);
	end 
endgenerate

adder f7(
	.a(a[7]),
	.b(b[7]),
	.cin(c[6]),
	.s(s[7]),
	.cout(cout)
	);

endmodule