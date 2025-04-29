module leaf_rom
	(
		input wire clk,
		input wire [2:0] row,
		input wire [2:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [2:0] row_reg;
	reg [2:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin
		if(({row_reg, col_reg}>=6'b000000) && ({row_reg, col_reg}<6'b000011)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b000011)) color_data = 12'b001010000010;
		if(({row_reg, col_reg}==6'b000100)) color_data = 12'b000100110001;
		if(({row_reg, col_reg}==6'b000101)) color_data = 12'b001010000010;
		if(({row_reg, col_reg}==6'b000110)) color_data = 12'b001110010011;

		if(({row_reg, col_reg}==6'b000111)) color_data = 12'b000100100001;
		if(({row_reg, col_reg}>=6'b001000) && ({row_reg, col_reg}<6'b001011)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b001011)) color_data = 12'b001001110010;
		if(({row_reg, col_reg}==6'b001100)) color_data = 12'b000100110001;
		if(({row_reg, col_reg}==6'b001101)) color_data = 12'b001110000010;
		if(({row_reg, col_reg}==6'b001110)) color_data = 12'b000100110001;

		if(({row_reg, col_reg}==6'b001111)) color_data = 12'b001010000010;
		if(({row_reg, col_reg}>=6'b010000) && ({row_reg, col_reg}<6'b010010)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b010010)) color_data = 12'b001110000011;
		if(({row_reg, col_reg}==6'b010011)) color_data = 12'b001001110010;
		if(({row_reg, col_reg}==6'b010100)) color_data = 12'b000100110001;
		if(({row_reg, col_reg}==6'b010101)) color_data = 12'b001000110010;
		if(({row_reg, col_reg}==6'b010110)) color_data = 12'b001110010011;

		if(({row_reg, col_reg}==6'b010111)) color_data = 12'b001010000010;
		if(({row_reg, col_reg}>=6'b011000) && ({row_reg, col_reg}<6'b011010)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b011010)) color_data = 12'b000100110001;
		if(({row_reg, col_reg}==6'b011011)) color_data = 12'b001001000001;
		if(({row_reg, col_reg}>=6'b011100) && ({row_reg, col_reg}<6'b011110)) color_data = 12'b000100110001;
		if(({row_reg, col_reg}==6'b011110)) color_data = 12'b001001010010;

		if(({row_reg, col_reg}==6'b011111)) color_data = 12'b001110000011;
		if(({row_reg, col_reg}==6'b100000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b100001)) color_data = 12'b001110010011;
		if(({row_reg, col_reg}==6'b100010)) color_data = 12'b001000110001;
		if(({row_reg, col_reg}==6'b100011)) color_data = 12'b001110010011;
		if(({row_reg, col_reg}>=6'b100100) && ({row_reg, col_reg}<6'b100110)) color_data = 12'b010010010100;
		if(({row_reg, col_reg}==6'b100110)) color_data = 12'b010010010011;

		if(({row_reg, col_reg}>=6'b100111) && ({row_reg, col_reg}<6'b101001)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b101001)) color_data = 12'b001000110001;
		if(({row_reg, col_reg}==6'b101010)) color_data = 12'b001110010011;
		if(({row_reg, col_reg}==6'b101011)) color_data = 12'b001010000010;
		if(({row_reg, col_reg}==6'b101100)) color_data = 12'b010010010100;
		if(({row_reg, col_reg}==6'b101101)) color_data = 12'b001110010011;

		if(({row_reg, col_reg}>=6'b101110) && ({row_reg, col_reg}<6'b110000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}>=6'b110000) && ({row_reg, col_reg}<6'b110010)) color_data = 12'b001110010011;

		if(({row_reg, col_reg}>=6'b110010) && ({row_reg, col_reg}<6'b111000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b111000)) color_data = 12'b001110010011;

		if(({row_reg, col_reg}>=6'b111001) && ({row_reg, col_reg}<=6'b111111)) color_data = 12'b011111111111;
	end
endmodule