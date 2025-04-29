module gem_rom
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
		if(({row_reg, col_reg}==6'b000000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b000001)) color_data = 12'b001000010101;
		if(({row_reg, col_reg}==6'b000010)) color_data = 12'b010000111001;
		if(({row_reg, col_reg}==6'b000011)) color_data = 12'b010100111010;
		if(({row_reg, col_reg}==6'b000100)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b000101)) color_data = 12'b010000101000;
		if(({row_reg, col_reg}==6'b000110)) color_data = 12'b001000010101;

		if(({row_reg, col_reg}==6'b000111)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b001000)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b001001)) color_data = 12'b010000111001;
		if(({row_reg, col_reg}==6'b001010)) color_data = 12'b101110101101;
		if(({row_reg, col_reg}>=6'b001011) && ({row_reg, col_reg}<6'b001110)) color_data = 12'b010100111010;

		if(({row_reg, col_reg}>=6'b001110) && ({row_reg, col_reg}<6'b010000)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b010000)) color_data = 12'b010100111010;
		if(({row_reg, col_reg}==6'b010001)) color_data = 12'b010000101000;
		if(({row_reg, col_reg}>=6'b010010) && ({row_reg, col_reg}<6'b010110)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b010110)) color_data = 12'b110010111101;

		if(({row_reg, col_reg}==6'b010111)) color_data = 12'b010100111010;
		if(({row_reg, col_reg}==6'b011000)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b011001)) color_data = 12'b010000101000;
		if(({row_reg, col_reg}==6'b011010)) color_data = 12'b010100111001;
		if(({row_reg, col_reg}>=6'b011011) && ({row_reg, col_reg}<6'b011110)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b011110)) color_data = 12'b011001001010;

		if(({row_reg, col_reg}==6'b011111)) color_data = 12'b010100111001;
		if(({row_reg, col_reg}==6'b100000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}>=6'b100001) && ({row_reg, col_reg}<6'b100011)) color_data = 12'b010100111010;
		if(({row_reg, col_reg}==6'b100011)) color_data = 12'b100110001011;
		if(({row_reg, col_reg}==6'b100100)) color_data = 12'b010100111010;
		if(({row_reg, col_reg}==6'b100101)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b100110)) color_data = 12'b010100111001;

		if(({row_reg, col_reg}>=6'b100111) && ({row_reg, col_reg}<6'b101001)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b101001)) color_data = 12'b010100111001;
		if(({row_reg, col_reg}==6'b101010)) color_data = 12'b010000111001;
		if(({row_reg, col_reg}>=6'b101011) && ({row_reg, col_reg}<6'b101101)) color_data = 12'b011000111011;
		if(({row_reg, col_reg}==6'b101101)) color_data = 12'b011001001011;
		if(({row_reg, col_reg}==6'b101110)) color_data = 12'b011000111011;

		if(({row_reg, col_reg}>=6'b101111) && ({row_reg, col_reg}<6'b110010)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b110010)) color_data = 12'b010100111001;
		if(({row_reg, col_reg}==6'b110011)) color_data = 12'b010100111010;
		if(({row_reg, col_reg}==6'b110100)) color_data = 12'b010101001010;
		if(({row_reg, col_reg}==6'b110101)) color_data = 12'b010100111010;

		if(({row_reg, col_reg}>=6'b110110) && ({row_reg, col_reg}<6'b111011)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==6'b111011)) color_data = 12'b011001001011;
		if(({row_reg, col_reg}==6'b111100)) color_data = 12'b011000111011;

		if(({row_reg, col_reg}>=6'b111101) && ({row_reg, col_reg}<=6'b111111)) color_data = 12'b011111111111;
	end
endmodule