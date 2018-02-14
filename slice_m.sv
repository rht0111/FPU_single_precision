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
 *	design: 	array slicing without loop (for mantissa)
 *	date:		14.02.2018
 *	version:	1.0
 *
 */

module slice_m (
	input [32:0] a,
	output [7:0] temp
	);

//to avoid race conditions in latched body
assign temp [7] = 1'b1;
assign temp [6] = a[22];
assign temp [5] = a[21];
assign temp [4] = a[20];
assign temp [3] = a[19];
assign temp [2] = a[18];
assign temp [1] = a[17];
assign temp [0] = a[16];

endmodule