

// Inverse Sbox lookup table for inv_subBytes module

module inv_sbox (/*AUTOARG*/
   // Outputs
   result,
   // Inputs
   index
   );

input [0:7] index;

output [0:7] result;

reg [0:7] value;


always @*
	begin
	case(index)	
	   8'h00: value = 8'h52;
	   8'h01: value = 8'h09;
	   8'h02: value = 8'h6a;
	   8'h03: value = 8'hd5;
	   8'h04: value = 8'h30;
	   8'h05: value = 8'h36;
	   8'h06: value = 8'ha5;
	   8'h07: value = 8'h38;
	   8'h08: value = 8'hbf;
	   8'h09: value = 8'h40;
	   8'h0a: value = 8'ha3;
	   8'h0b: value = 8'h9e;
	   8'h0c: value = 8'h81;
	   8'h0d: value = 8'hf3;
	   8'h0e: value = 8'hd7;
	   8'h0f: value = 8'hfb;

	   8'h10: value = 8'h7c;
	   8'h11: value = 8'he3;
	   8'h12: value = 8'h39;
	   8'h13: value = 8'h82;
	   8'h14: value = 8'h9b;
	   8'h15: value = 8'h2f;
	   8'h16: value = 8'hff;
	   8'h17: value = 8'h87;
	   8'h18: value = 8'h34;
	   8'h19: value = 8'h8e;
	   8'h1a: value = 8'h43;
	   8'h1b: value = 8'h44;
	   8'h1c: value = 8'hc4;
	   8'h1d: value = 8'hde;
	   8'h1e: value = 8'he9;
	   8'h1f: value = 8'hcb;

	   8'h20: value = 8'h54;
	   8'h21: value = 8'h7b;
	   8'h22: value = 8'h94;
	   8'h23: value = 8'h32;
	   8'h24: value = 8'ha6;
	   8'h25: value = 8'hc2;
	   8'h26: value = 8'h23;
	   8'h27: value = 8'h3d;
	   8'h28: value = 8'hee;
	   8'h29: value = 8'h4c;
	   8'h2a: value = 8'h95;
	   8'h2b: value = 8'h0b;
	   8'h2c: value = 8'h42;
	   8'h2d: value = 8'hfa;
	   8'h2e: value = 8'hc3;
	   8'h2f: value = 8'h4e;

	   8'h30: value = 8'h08;
	   8'h31: value = 8'h2e;
	   8'h32: value = 8'ha1;
	   8'h33: value = 8'h66;
	   8'h34: value = 8'h28;
	   8'h35: value = 8'hd9;
	   8'h36: value = 8'h24;
	   8'h37: value = 8'hb2;
	   8'h38: value = 8'h76;
	   8'h39: value = 8'h5b;
	   8'h3a: value = 8'ha2;
	   8'h3b: value = 8'h49;
	   8'h3c: value = 8'h6d;
	   8'h3d: value = 8'h8b;
	   8'h3e: value = 8'hd1;
	   8'h3f: value = 8'h25;

	   8'h40: value = 8'h72;
	   8'h41: value = 8'hf8;
	   8'h42: value = 8'hf6;
	   8'h43: value = 8'h64;
	   8'h44: value = 8'h86;
	   8'h45: value = 8'h68;
	   8'h46: value = 8'h98;
	   8'h47: value = 8'h16;
	   8'h48: value = 8'hd4;
	   8'h49: value = 8'ha4;
	   8'h4a: value = 8'h5c;
	   8'h4b: value = 8'hcc;
	   8'h4c: value = 8'h5d;
	   8'h4d: value = 8'h65;
	   8'h4e: value = 8'hb6;
	   8'h4f: value = 8'h92;

	   8'h50: value = 8'h6c;
	   8'h51: value = 8'h70;
	   8'h52: value = 8'h48;
	   8'h53: value = 8'h50;
	   8'h54: value = 8'hfd;
	   8'h55: value = 8'hed;
	   8'h56: value = 8'hb9;
	   8'h57: value = 8'hda;
	   8'h58: value = 8'h5e;
	   8'h59: value = 8'h15;
	   8'h5a: value = 8'h46;
	   8'h5b: value = 8'h57;
	   8'h5c: value = 8'ha7;
	   8'h5d: value = 8'h8d;
	   8'h5e: value = 8'h9d;
	   8'h5f: value = 8'h84;

	   8'h60: value = 8'h90;
	   8'h61: value = 8'hd8;
	   8'h62: value = 8'hab;
	   8'h63: value = 8'h00;
	   8'h64: value = 8'h8c;
	   8'h65: value = 8'hbc;
	   8'h66: value = 8'hd3;
	   8'h67: value = 8'h0a;
	   8'h68: value = 8'hf7;
	   8'h69: value = 8'he4;
	   8'h6a: value = 8'h58;
	   8'h6b: value = 8'h05;
	   8'h6c: value = 8'hb8;
	   8'h6d: value = 8'hb3;
	   8'h6e: value = 8'h45;
	   8'h6f: value = 8'h06;

	   8'h70: value = 8'hd0;
	   8'h71: value = 8'h2c;
	   8'h72: value = 8'h1e;
	   8'h73: value = 8'h8f;
	   8'h74: value = 8'hca;
	   8'h75: value = 8'h3f;
	   8'h76: value = 8'h0f;
	   8'h77: value = 8'h02;
	   8'h78: value = 8'hc1;
	   8'h79: value = 8'haf;
	   8'h7a: value = 8'hbd;
	   8'h7b: value = 8'h03;
	   8'h7c: value = 8'h01;
	   8'h7d: value = 8'h13;
	   8'h7e: value = 8'h8a;
	   8'h7f: value = 8'h6b;

	   8'h80: value = 8'h3a;
	   8'h81: value = 8'h91;
	   8'h82: value = 8'h11;
	   8'h83: value = 8'h41;
	   8'h84: value = 8'h4f;
	   8'h85: value = 8'h67;
	   8'h86: value = 8'hdc;
	   8'h87: value = 8'hea;
	   8'h88: value = 8'h97;
	   8'h89: value = 8'hf2;
	   8'h8a: value = 8'hcf;
	   8'h8b: value = 8'hce;
	   8'h8c: value = 8'hf0;
	   8'h8d: value = 8'hb4;
	   8'h8e: value = 8'he6;
	   8'h8f: value = 8'h73;

	   8'h90: value = 8'h96;
	   8'h91: value = 8'hac;
	   8'h92: value = 8'h74;
	   8'h93: value = 8'h22;
	   8'h94: value = 8'he7;
	   8'h95: value = 8'had;
	   8'h96: value = 8'h35;
	   8'h97: value = 8'h85;
	   8'h98: value = 8'he2;
	   8'h99: value = 8'hf9;
	   8'h9a: value = 8'h37;
	   8'h9b: value = 8'he8;
	   8'h9c: value = 8'h1c;
	   8'h9d: value = 8'h75;
	   8'h9e: value = 8'hdf;
	   8'h9f: value = 8'h6e;

	   8'ha0: value = 8'h47;
	   8'ha1: value = 8'hf1;
	   8'ha2: value = 8'h1a;
	   8'ha3: value = 8'h71;
	   8'ha4: value = 8'h1d;
	   8'ha5: value = 8'h29;
	   8'ha6: value = 8'hc5;
	   8'ha7: value = 8'h89;
	   8'ha8: value = 8'h6f;
	   8'ha9: value = 8'hb7;
	   8'haa: value = 8'h62;
	   8'hab: value = 8'h0e;
	   8'hac: value = 8'haa;
	   8'had: value = 8'h18;
	   8'hae: value = 8'hbe;
	   8'haf: value = 8'h1b;

	   8'hb0: value = 8'hfc;
	   8'hb1: value = 8'h56;
	   8'hb2: value = 8'h3e;
	   8'hb3: value = 8'h4b;
	   8'hb4: value = 8'hc6;
	   8'hb5: value = 8'hd2;
	   8'hb6: value = 8'h79;
	   8'hb7: value = 8'h20;
	   8'hb8: value = 8'h9a;
	   8'hb9: value = 8'hdb;
	   8'hba: value = 8'hc0;
	   8'hbb: value = 8'hfe;
	   8'hbc: value = 8'h78;
	   8'hbd: value = 8'hcd;
	   8'hbe: value = 8'h5a;
	   8'hbf: value = 8'hf4;

	   8'hc0: value = 8'h1f;
	   8'hc1: value = 8'hdd;
	   8'hc2: value = 8'ha8;
	   8'hc3: value = 8'h33;
	   8'hc4: value = 8'h88;
	   8'hc5: value = 8'h07;
	   8'hc6: value = 8'hc7;
	   8'hc7: value = 8'h31;
	   8'hc8: value = 8'hb1;
	   8'hc9: value = 8'h12;
	   8'hca: value = 8'h10;
	   8'hcb: value = 8'h59;
	   8'hcc: value = 8'h27;
	   8'hcd: value = 8'h80;
	   8'hce: value = 8'hec;
	   8'hcf: value = 8'h5f;

	   8'hd0: value = 8'h60;
	   8'hd1: value = 8'h51;
	   8'hd2: value = 8'h7f;
	   8'hd3: value = 8'ha9;
	   8'hd4: value = 8'h19;
	   8'hd5: value = 8'hb5;
	   8'hd6: value = 8'h4a;
	   8'hd7: value = 8'h0d;
	   8'hd8: value = 8'h2d;
	   8'hd9: value = 8'he5;
	   8'hda: value = 8'h7a;
	   8'hdb: value = 8'h9f;
	   8'hdc: value = 8'h93;
	   8'hdd: value = 8'hc9;
	   8'hde: value = 8'h9c;
	   8'hdf: value = 8'hef;

	   8'he0: value = 8'ha0;
	   8'he1: value = 8'he0;
	   8'he2: value = 8'h3b;
	   8'he3: value = 8'h4d;
	   8'he4: value = 8'hae;
	   8'he5: value = 8'h2a;
	   8'he6: value = 8'hf5;
	   8'he7: value = 8'hb0;
	   8'he8: value = 8'hc8;
	   8'he9: value = 8'heb;
	   8'hea: value = 8'hbb;
	   8'heb: value = 8'h3c;
	   8'hec: value = 8'h83;
	   8'hed: value = 8'h53;
	   8'hee: value = 8'h99;
	   8'hef: value = 8'h61;

	   8'hf0: value = 8'h17;
	   8'hf1: value = 8'h2b;
	   8'hf2: value = 8'h04;
	   8'hf3: value = 8'h7e;
	   8'hf4: value = 8'hba;
	   8'hf5: value = 8'h77;
	   8'hf6: value = 8'hd6;
	   8'hf7: value = 8'h26;
	   8'hf8: value = 8'he1;
	   8'hf9: value = 8'h69;
	   8'hfa: value = 8'h14;
	   8'hfb: value = 8'h63;
	   8'hfc: value = 8'h55;
	   8'hfd: value = 8'h21;
	   8'hfe: value = 8'h0c;
	   8'hff: value = 8'h7d;

	endcase
 end

 assign result = value;

endmodule


