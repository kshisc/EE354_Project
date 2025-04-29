module tail_rom
	(
		input wire clk,
		input wire [3:0] row,
		input wire [2:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [3:0] row_reg;
	reg [2:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin



		if(({row_reg, col_reg}>=7'b0000000) && ({row_reg, col_reg}<7'b0011111)) color_data = 12'b000000000000;

		if(({row_reg, col_reg}==7'b0011111)) color_data = 12'b100100000000;
		if(({row_reg, col_reg}>=7'b0100000) && ({row_reg, col_reg}<7'b0100101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b0100101)) color_data = 12'b011100000000;
		if(({row_reg, col_reg}==7'b0100110)) color_data = 12'b100100000000;

		if(({row_reg, col_reg}==7'b0100111)) color_data = 12'b101100000000;
		if(({row_reg, col_reg}==7'b0101000)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b0101001)) color_data = 12'b001000000000;
		if(({row_reg, col_reg}>=7'b0101010) && ({row_reg, col_reg}<7'b0101100)) color_data = 12'b101100000000;
		if(({row_reg, col_reg}==7'b0101100)) color_data = 12'b100000000000;
		if(({row_reg, col_reg}==7'b0101101)) color_data = 12'b110100000000;
		if(({row_reg, col_reg}==7'b0101110)) color_data = 12'b110000000000;

		if(({row_reg, col_reg}==7'b0101111)) color_data = 12'b110100000000;
		if(({row_reg, col_reg}==7'b0110000)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b0110001)) color_data = 12'b001000000000;
		if(({row_reg, col_reg}==7'b0110010)) color_data = 12'b101100000000;
		if(({row_reg, col_reg}==7'b0110011)) color_data = 12'b100100000000;
		if(({row_reg, col_reg}==7'b0110100)) color_data = 12'b101000000000;

		if(({row_reg, col_reg}>=7'b0110101) && ({row_reg, col_reg}<7'b0111000)) color_data = 12'b110000000000;
		if(({row_reg, col_reg}>=7'b0111000) && ({row_reg, col_reg}<7'b0111101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b0111101)) color_data = 12'b111000000000;

		if(({row_reg, col_reg}>=7'b0111110) && ({row_reg, col_reg}<7'b1000000)) color_data = 12'b101100000000;
		if(({row_reg, col_reg}>=7'b1000000) && ({row_reg, col_reg}<7'b1000111)) color_data = 12'b000000000000;

		if(({row_reg, col_reg}==7'b1000111)) color_data = 12'b100000000000;



		if(({row_reg, col_reg}>=7'b1001000) && ({row_reg, col_reg}<=7'b1011111)) color_data = 12'b000000000000;
	end
endmodule