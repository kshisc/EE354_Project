`timescale 1ns / 1ps
module random_generator(
    input [19:0] rand_seed,
    input new_apple, clock_1hz, reset, 
    input [9:0] x_apple, y_apple, margin,
    input [7:0] velocity,

    output [9:0] pos_x_rand, pos_y_rand
);

reg [19:0] rand_temp = 212702;
reg [9:0] x, y;

wire xor_sum;
assign xor_sum = rand_temp[1] ^ rand_temp[7] ^ rand_temp[11] ^ rand_temp[19];

always @(posedge clock_1hz) begin
    if (reset)
        rand_temp <= 212702;
    else if (new_apple) begin
        rand_temp <= {xor_sum, rand_temp[19:1]};

    // Generate random x and y inside margin-defined playable area
    x = (20+margin) + (rand_temp[9:0] % (590 - 2*margin));
    y = (20+margin) + (rand_temp[19:10] % (440 - 2*margin));
    end
end

assign pos_x_rand = x;
assign pos_y_rand = y;

endmodule