`define HALF_CYCLE 250

`timescale 1ns/100ps

module testbench();

	logic [63:0] value; // inputs
	logic quit, clock, reset;

	logic [31:0] result; // output
	logic done;

	// wire [63:0] cres = a/a; // ANSWER

	// wire correct = (cres===result)|~done;

    ISR isr0(
                .reset(reset),
                .value(value),
                .clock(clock),
                .result(result),
                .done(done));

	// always @(posedge clock)
	// 	#(`HALF_CYCLE-5) if(!correct) begin 
	// 		$display("Incorrect at time %4.0f",$time);
	// 		$display("cres = %h result = %h",cres,result);
	// 		$finish;
	// 	end

	always begin
		#`HALF_CYCLE;
		clock=~clock;
	end

	// Some students have had problems just using "@(posedge done)" because their
	// "done" signals glitch (even though they are the output of a register). This
	// prevents that by making sure "done" is high at the clock edge.
	task wait_until_done;
		forever begin : wait_loop
			@(posedge done);
			@(negedge clock);
			if(done) disable wait_until_done;
		end
	endtask



	initial begin
		$dumpvars;
		$monitor("Time:%4.0f done:%b value:%h product:%h result:%h",$time,done,value,cres,result);
		value=25;
		reset=1;
		clock=0;
		start=1;
		#2000;

		@(negedge clock);
		reset=0;
		@(negedge clock);
		start=0;
		wait_until_done();
		start=1;
		value=-24;
		@(negedge clock);
		start=0;
		wait_until_done();
		// @(negedge clock);
		// start=1;
		// a=-20;
		// b=5;
		// @(negedge clock);
		// start=0;
		// wait_until_done();
		// quit = 0;
		// quit <= #1000000 1;
		// while(~quit) begin
		// 	start=1;
		// 	a={$random,$random};
		// 	b={$random,$random};
		// 	@(negedge clock);
		// 	start=0;
		// 	wait_until_done();
		// end
		$finish;
	end

endmodule



  
  
