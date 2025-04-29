module head_rom
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
		if(({row_reg, col_reg}==7'b0000000)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=7'b0000001) && ({row_reg, col_reg}<7'b0001000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b0001000)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=7'b0001001) && ({row_reg, col_reg}<7'b0010000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b0010000)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=7'b0010001) && ({row_reg, col_reg}<7'b0011000)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b0011000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==7'b0011001)) color_data = 12'b110101000100;
		if(({row_reg, col_reg}==7'b0011010)) color_data = 12'b110101010101;
		if(({row_reg, col_reg}==7'b0011011)) color_data = 12'b110001100110;
		if(({row_reg, col_reg}==7'b0011100)) color_data = 12'b110001110111;
		if(({row_reg, col_reg}==7'b0011101)) color_data = 12'b110100110011;
		if(({row_reg, col_reg}==7'b0011110)) color_data = 12'b110101010101;

		if(({row_reg, col_reg}==7'b0011111)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=7'b0100000) && ({row_reg, col_reg}<7'b0100010)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==7'b0100010)) color_data = 12'b111100110011;
		if(({row_reg, col_reg}==7'b0100011)) color_data = 12'b110101000100;
		if(({row_reg, col_reg}==7'b0100100)) color_data = 12'b111000100010;
		if(({row_reg, col_reg}==7'b0100101)) color_data = 12'b111100010001;
		if(({row_reg, col_reg}==7'b0100110)) color_data = 12'b000100000000;

		if(({row_reg, col_reg}>=7'b0100111) && ({row_reg, col_reg}<7'b0101001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b0101001)) color_data = 12'b111100010001;
		if(({row_reg, col_reg}==7'b0101010)) color_data = 12'b111000100010;
		if(({row_reg, col_reg}==7'b0101011)) color_data = 12'b110101010101;
		if(({row_reg, col_reg}==7'b0101100)) color_data = 12'b111000100010;
		if(({row_reg, col_reg}==7'b0101101)) color_data = 12'b111000010001;
		if(({row_reg, col_reg}==7'b0101110)) color_data = 12'b111100010001;

		if(({row_reg, col_reg}>=7'b0101111) && ({row_reg, col_reg}<7'b0110001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=7'b0110001) && ({row_reg, col_reg}<7'b0110011)) color_data = 12'b111000100010;
		if(({row_reg, col_reg}==7'b0110011)) color_data = 12'b110101000100;
		if(({row_reg, col_reg}==7'b0110100)) color_data = 12'b111000100010;
		if(({row_reg, col_reg}==7'b0110101)) color_data = 12'b111100000000;
		if(({row_reg, col_reg}==7'b0110110)) color_data = 12'b111100010001;

		if(({row_reg, col_reg}==7'b0110111)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=7'b0111000) && ({row_reg, col_reg}<7'b0111010)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==7'b0111010)) color_data = 12'b111100110011;
		if(({row_reg, col_reg}==7'b0111011)) color_data = 12'b110101000100;
		if(({row_reg, col_reg}==7'b0111100)) color_data = 12'b111000100010;
		if(({row_reg, col_reg}==7'b0111101)) color_data = 12'b111100010001;

		if(({row_reg, col_reg}>=7'b0111110) && ({row_reg, col_reg}<7'b1000000)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b1000000)) color_data = 12'b111011111111;
		if(({row_reg, col_reg}==7'b1000001)) color_data = 12'b110101010101;
		if(({row_reg, col_reg}>=7'b1000010) && ({row_reg, col_reg}<7'b1000110)) color_data = 12'b110101000100;
		if(({row_reg, col_reg}==7'b1000110)) color_data = 12'b110101010101;

		if(({row_reg, col_reg}==7'b1000111)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b1001000)) color_data = 12'b111011111111;
		if(({row_reg, col_reg}==7'b1001001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b1001010)) color_data = 12'b000000010001;

		if(({row_reg, col_reg}>=7'b1001011) && ({row_reg, col_reg}<7'b1010000)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b1010000)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=7'b1010001) && ({row_reg, col_reg}<7'b1011000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b1011000)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=7'b1011001) && ({row_reg, col_reg}<=7'b1011111)) color_data = 12'b011111111111;
	end
endmodule