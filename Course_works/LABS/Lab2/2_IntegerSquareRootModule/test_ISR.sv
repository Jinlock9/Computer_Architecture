`define HALF_CYCLE 250

`timescale 1ns/100ps

module testbench();

	logic [63:0] value; // inputs
	logic quit, clock, reset;

	logic [31:0] result; // output
	logic done;

	wire correct = ((result * result <= value) & ((result + 1) * (result + 1) > value)) | ~done;

    ISR isr0(
                .reset(reset),
                .value(value),
                .clock(clock),
                .result(result),
                .done(done));

	always @(posedge clock)
		#(`HALF_CYCLE-5) if(!correct) begin 
			$display("Incorrect at time %4.0f",$time);
			$display("result = %h",result);
			$finish;
		end

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
		$monitor("Time:%4.0f done:%b value:%d result:%d",$time,done,value,result);
		clock = 0;
		value = 25;
		reset = 1;
		#2000;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 24;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 26;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 0;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 1;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		$display("Simulation Success!");
		$finish;
	end

endmodule
