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
 *	design: 	array slicing without loop
 *	date:		14.02.2018
 *	version:	1.0
 *
 */

module slice (
	input [32:0] a,
	output [7:0] temp
	);

//to avoid race conditions in latched body
assign temp [7] = a[30];
assign temp [6] = a[29];
assign temp [5] = a[28];
assign temp [4] = a[27];
assign temp [3] = a[26];
assign temp [2] = a[25];
assign temp [1] = a[24];
assign temp [0] = a[23];

//alternatively
// assign temp [7:0] = a[30:23];

// code below can only be used in clocked body
// initial begin
// for (i=0; i<8 ; i++) begin
// 	temp_a [7-i] <= a [size-2-i];
// 	temp_b [7-i] <= b [size-2-i];
//  end
// end

endmodule