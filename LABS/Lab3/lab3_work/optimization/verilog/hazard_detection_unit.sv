`ifndef __HAZARD_V__
`define __HAZARD_v__

module hazard_detection_unit (
    input BRANCH branch,
    input id_ex_rd_mem,
    input id_ex_wr_mem,
    input [4:0] id_ex_rd,
    input [4:0] if_id_rs1,
    input [4:0] if_id_rs2,

    // HAZARD CONTROL
    output HAZARD if_id_enable,
    output HAZARD id_ex_enable,
    // HAZARD TYPE
    output HAZARD data_hazard,
    output HAZARD structure_hazard
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
			has_data_hazard = `HAZARD;
		end
        // STRUCTURE HAZARD
		if ((id_ex_rd_mem || id_ex_wr_mem) && (branch == `BRANCH_NOT_TAKEN)) begin
			has_structure_hazard = `HAZARD;
		end
    end

endmodule : hazard_detection_unit

`endif // __HAZARD_V__