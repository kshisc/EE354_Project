module bird_rom
	(
		input wire clk,
		input wire [2:0] row,
		input wire [3:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [2:0] row_reg;
	reg [3:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin
		if(({row_reg, col_reg}>=7'b0000000) && ({row_reg, col_reg}<7'b0000111)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b0000111)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}==7'b0001000)) color_data = 12'b101010010110;
		if(({row_reg, col_reg}==7'b0001001)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}==7'b0001010)) color_data = 12'b100110000110;

		if(({row_reg, col_reg}>=7'b0001011) && ({row_reg, col_reg}<7'b0010110)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b0010110)) color_data = 12'b100010000101;
		if(({row_reg, col_reg}>=7'b0010111) && ({row_reg, col_reg}<7'b0011010)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b0011010)) color_data = 12'b101010010110;

		if(({row_reg, col_reg}>=7'b0011011) && ({row_reg, col_reg}<7'b0100101)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b0100101)) color_data = 12'b100010000110;
		if(({row_reg, col_reg}==7'b0100110)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b0100111)) color_data = 12'b111011101001;
		if(({row_reg, col_reg}==7'b0101000)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b0101001)) color_data = 12'b101010010110;

		if(({row_reg, col_reg}>=7'b0101010) && ({row_reg, col_reg}<7'b0110001)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b0110001)) color_data = 12'b100110010110;
		if(({row_reg, col_reg}>=7'b0110010) && ({row_reg, col_reg}<7'b0110100)) color_data = 12'b100110010111;
		if(({row_reg, col_reg}==7'b0110100)) color_data = 12'b100110010110;
		if(({row_reg, col_reg}>=7'b0110101) && ({row_reg, col_reg}<7'b0111001)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b0111001)) color_data = 12'b101110100111;
		if(({row_reg, col_reg}==7'b0111010)) color_data = 12'b100110000110;

		if(({row_reg, col_reg}>=7'b0111011) && ({row_reg, col_reg}<7'b1000001)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b1000001)) color_data = 12'b100110000110;
		if(({row_reg, col_reg}==7'b1000010)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b1000011)) color_data = 12'b111011011000;
		if(({row_reg, col_reg}==7'b1000100)) color_data = 12'b101110100111;
		if(({row_reg, col_reg}>=7'b1000101) && ({row_reg, col_reg}<7'b1000111)) color_data = 12'b110111011001;
		if(({row_reg, col_reg}>=7'b1000111) && ({row_reg, col_reg}<7'b1001001)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b1001001)) color_data = 12'b111011001001;
		if(({row_reg, col_reg}==7'b1001010)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}==7'b1001011)) color_data = 12'b011111111111;

		if(({row_reg, col_reg}==7'b1001100)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}==7'b1010000)) color_data = 12'b110110111000;
		if(({row_reg, col_reg}==7'b1010001)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}==7'b1010010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==7'b1010011)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b1010100)) color_data = 12'b100110010110;
		if(({row_reg, col_reg}==7'b1010101)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b1010110)) color_data = 12'b111011101001;
		if(({row_reg, col_reg}>=7'b1010111) && ({row_reg, col_reg}<7'b1011010)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}>=7'b1011010) && ({row_reg, col_reg}<7'b1011100)) color_data = 12'b110010111000;

		if(({row_reg, col_reg}==7'b1011100)) color_data = 12'b110010110111;
		if(({row_reg, col_reg}==7'b1100000)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b1100001)) color_data = 12'b101110100111;
		if(({row_reg, col_reg}==7'b1100010)) color_data = 12'b111011011000;
		if(({row_reg, col_reg}==7'b1100011)) color_data = 12'b110111011000;
		if(({row_reg, col_reg}==7'b1100100)) color_data = 12'b101010010110;
		if(({row_reg, col_reg}==7'b1100101)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b1100110)) color_data = 12'b111011101001;
		if(({row_reg, col_reg}>=7'b1100111) && ({row_reg, col_reg}<7'b1101001)) color_data = 12'b111011011001;
		if(({row_reg, col_reg}==7'b1101001)) color_data = 12'b111011101000;
		if(({row_reg, col_reg}>=7'b1101010) && ({row_reg, col_reg}<7'b1101100)) color_data = 12'b111011011000;

		if(({row_reg, col_reg}==7'b1101100)) color_data = 12'b110111001000;
		if(({row_reg, col_reg}>=7'b1110000) && ({row_reg, col_reg}<7'b1110010)) color_data = 12'b011111111111;
		if(({row_reg, col_reg}==7'b1110010)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}>=7'b1110011) && ({row_reg, col_reg}<7'b1110101)) color_data = 12'b100110010110;
		if(({row_reg, col_reg}==7'b1110101)) color_data = 12'b101010100111;
		if(({row_reg, col_reg}==7'b1110110)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}==7'b1110111)) color_data = 12'b101010100111;
		if(({row_reg, col_reg}==7'b1111000)) color_data = 12'b101010010111;
		if(({row_reg, col_reg}==7'b1111001)) color_data = 12'b100110000110;
		if(({row_reg, col_reg}>=7'b1111010) && ({row_reg, col_reg}<7'b1111100)) color_data = 12'b101010010110;

		if(({row_reg, col_reg}>=7'b1111100) && ({row_reg, col_reg}<=7'b1111100)) color_data = 12'b101110100111;
	end
endmodule