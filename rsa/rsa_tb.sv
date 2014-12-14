class transaction;
	// vars
	rand bit reset;

	// Checking the reset functionality
	function bit check_reset(logic out_valid_o, rsa_ready_o, aes_ready_o,
			led_pass_o, led_fail_o);

		return ((out_valid_o == '0) &&
				(rsa_ready_o == '1) &&
				(aes_ready_o == '1) &&
				(led_pass_o == '1) && /* both LEDS on during reset */
				(led_fail_o == '1));
	endfunction

	function bit check_stall(logic aes_ready_o, rsa_ready_o);
		return ((aes_ready_o == '0) &&
				(rsa_ready_o == '0));
	endfunction

	function void golden_result();
		// TODO later
	endfunction


endclass 


class testing_env;
	rand int unsigned rn;
	rand int unsigned rn2;

	bit reset;

	int reset_thresh;
	int stall_thresh;

	int iter;

	function void read_config(string filename);
		int file, chars_returned, seed, value;
		string param;
		file = $fopen(filename, "r");

		while(!$feof(file)) begin
			chars_returned = $fscanf(file, "%s %d", param, value);
			if("RANDOM_SEED" == param) begin
				seed = value;
				$srandom(seed);
			end else if("ITERATIONS" == param) begin
				iter = value;
			end else if("RESET_PROB" == param) begin
				reset_thresh = value;
			end else if("STALL_PROB" == param) begin
				stall_thresh = value;
			end else begin
				$display("Invalid parameter");
				$exit();
			end
		end
	endfunction

	function bit get_reset();
		return((rn % 1000) < reset_thresh);
	endfunction

	function bit get_stall();
		return((rn2 % 1000) < stall_thresh);
	endfunction

endclass


program rsa_tb (rsa_ifc.bench ds);

	transaction t; 
	testing_env v;

	int failures = 0;
	bit reset;

	initial begin
		t = new();
		v = new();
		v.read_config("config.txt");

		// Drive inputs for next cycles
		ds.cb.rst <= t.reset;

		// run reset for a little bit
		repeat(10) begin
		ds.cb.rst <= 1'b1;
		@(ds.cb);
		end

		ds.cb.rst <= 1'b0;
		@(ds.cb);

		// Iterate iter number of cycles
		repeat (v.iter) begin
			v.randomize();
			if(v.get_reset()) begin
				ds.cb.rst <= 1'b1;
				$display("%t : %s \n", $realtime, "Driving Reset");
			end else begin
				ds.cb.rst <= 1'b0;
				/* TODO later */
				if (v.get_stall()) begin
					ds.cb.stall <= 1'b1;
				end else begin
					ds.cb.stall <= 1'b0;
				end
			end

			@(ds.cb);

			if(v.get_reset()) begin
				$display("%t : %s \n", $realtime,
					t.check_reset(ds.cb.out_valid_o,
						ds.cb.rsa_ready_o, ds.cb.aes_ready_o,
						ds.cb.led_pass_o, ds.cb.led_fail_o)
					? "Pass-reset" : "Fail-reset");
			end else begin
				if (v.get_stall()) begin
					$display("%t : %s \n", $realtime,
						t.check_stall(ds.cb.aes_ready_o, ds.cb.rsa_ready_o)
						? "Pass-stall" : "Fail-stall");
				end
			end
			/* TODO: golden_output */
		end
	end
endprogram