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
	output [23:0] temp
	);

//to avoid race conditions in latched body
assign temp [23] = 1'b1;
assign temp [22] = a[22];
assign temp [21] = a[21];
assign temp [20] = a[20];
assign temp [19] = a[19];
assign temp [18] = a[18];
assign temp [17] = a[17];
assign temp [16] = a[16];

assign temp [15] = a[15];
assign temp [14] = a[14];
assign temp [13] = a[13];
assign temp [12] = a[12];
assign temp [11] = a[11];
assign temp [10] = a[10];
assign temp [9] = a[9];
assign temp [8] = a[8];

assign temp [7] = a[7];
assign temp [6] = a[6];
assign temp [5] = a[5];
assign temp [4] = a[4];
assign temp [3] = a[3];
assign temp [2] = a[2];
assign temp [1] = a[1];
assign temp [0] = a[0];

endmodule