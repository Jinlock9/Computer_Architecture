`ifndef __HAZARD_V__
`define __HAZARD_v__

module hazard_detection_unit (
    input branch,
    input id_ex_rd_mem,
    input id_ex_wr_mem,
    input [4:0] id_ex_rd,
    input [4:0] if_id_rs1,
    input [4:0] if_id_rs2,

    // HAZARD CONTROL
    output logic if_id_enable,
    output logic id_ex_enable,
    // HAZARD TYPE
    output logic data_hazard,
    output logic structure_hazard
);

    always_comb begin
        if_id_enable = `NON_HAZARD;
        id_ex_enable = `NON_HAZARD;
        data_hazard = `NON_HAZARD;
        structure_hazard = `NON_HAZARD;

        // DATA HAZARD
        if (id_ex_rd_mem && (id_ex_rd != `ZERO_REG) && ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2))) begin
			id_ex_enable = `HAZARD;
			if_id_enable = `HAZARD;
			data_hazard = `HAZARD;
		end
        // STRUCTURE HAZARD
		if ((id_ex_rd_mem || id_ex_wr_mem) && (branch == `BRANCH_NOT_TAKEN)) begin
			structure_hazard = `HAZARD;
		end
    end

endmodule : hazard_detection_unit

`endif // __HAZARD_V__