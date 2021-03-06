`timescale 1ns/1ns
module aes_decryptor(
	clk, rst,
	key_i, key_valid_i, 
	dat_i, dat_valid_i, 
	dat_ready_o, dat_o, dat_valid_o,
	led_proc_o,
	out_ready_i, out_write_o, out_write_counter_o, out_eof_o
);

	input clk, rst;
	input key_valid_i, dat_valid_i;
	input [31:0] key_i;
	input [31:0] dat_i;
   // Output backpressure //
   input out_ready_i;
   /////////////////////////
	output dat_ready_o; 
	output [31:0] dat_o;
	output dat_valid_o;
   ///// Initiate write /////
   output out_write_o;
   output out_eof_o;
   output out_write_counter_o;
   //////////////////////////
   output led_proc_o;

endmodule
