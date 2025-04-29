`timescale 1ns / 1ps
module dragon_top(
    input clock_100Mhz,
    input BtnL, BtnR, BtnU, BtnD, BtnC,

    output hSync, vSync,
    output [3:0] vgaR, vgaG, vgaB,

    output 	AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7,
    output 	Ca, Cb, Cc, Cd, Ce, Cf, Cg 
);

wire clock_1hz, clock_50Mhz;
wire [9:0] h_counter, v_counter;

wire signed [10:0] last_vel_x, last_vel_y;
wire [999:0] pos_x, pos_y;
wire [9:0] head_x, head_y;

assign head_x = pos_x[9:0];
assign head_y = pos_y[9:0];

reg [9:0] curr_apple_x, curr_apple_y;
wire [9:0] pos_x_rand, pos_y_rand;
parameter [19:0] rand_seed = 212702;

reg apple_eaten;
reg [9:0] length;

wire reset;
assign reset = BtnC;

wire [9:0] margin;
assign margin = (velocity-1) * 10;  

wire game_won;
assign game_won = (velocity==4? 1: 0);

reg [3:0] unit, tens, hundreds, thousands, h_unit, h_tens, h_hundreds, h_thousands;
reg [19:0] score = 0, high_score = 0;
reg [7:0] velocity = 1;
reg [9:0] apple_count = 0;

Clock_Divider_1s clock_1s(clock_1hz,clock_100Mhz,reset);
Clock_Divider_2 clock_by_two(clock_50Mhz,clock_100Mhz,reset);
random_generator random1(rand_seed,apple_eaten,clock_1hz,reset,curr_apple_x,curr_apple_y,margin,velocity,pos_x_rand,pos_y_rand);

vga_controller display1(
    .clk(clock_100Mhz),
    .rst(reset),               
    .x_input(pos_x),     
    .y_input(pos_y),     
    .length(length),
    .x_apple(curr_apple_x),
    .y_apple(curr_apple_y),
    .hSync(hSync),         
    .vSync(vSync),         
    .vgaR(vgaR),     
    .vgaG(vgaG),      
    .vgaB(vgaB),   
    .last_vel_x(last_vel_x),
    .last_vel_y(last_vel_y),
    .score(score),
    .high_score(high_score),
    .velocity(velocity),
    .margin(margin),
    .game_won(game_won)
);

position_controller control1 (
    .pos_x(pos_x),
    .pos_y(pos_y),
    .BtnL(BtnL),
    .BtnR(BtnR),
    .BtnU(BtnU),
    .BtnD(BtnD),
    .clock(clock_1hz),
    .reset(reset),
    .length(length),
    .velocity(velocity),
    .margin(margin),
    .x_apple(curr_apple_x),
    .y_apple(curr_apple_y),
    .last_vel_x(last_vel_x),
    .last_vel_y(last_vel_y)
);


assign apple_collision = (head_x + 7 >= curr_apple_x) && (head_x <= curr_apple_x + 7) &&
                         (head_y + 7 >= curr_apple_y) && (head_y <= curr_apple_y + 7);

always @(posedge clock_1hz or posedge reset) begin
    if (reset) begin
        apple_eaten <= 0;
        curr_apple_x <= 160;
        curr_apple_y <= 320;
        length <= 0;
        score <= 0;
        apple_count <= 0;
        velocity <= 1;
    end

    else if(score > high_score) 
        begin 
            high_score <= score;
        end

    else if (!game_won) begin
        if (apple_collision && !apple_eaten)
        begin
            apple_eaten <= 1;
            length <= length + 1;
            score <= score + velocity;
            apple_count <= apple_count+1;
            velocity <= 1 + apple_count/6;
        end
        
        else begin
            apple_eaten <= 0;
        end
      
        if (apple_eaten) begin
            curr_apple_x <= pos_x_rand;
            curr_apple_y <= pos_y_rand;
        end

        else if(velocity==3) begin //bird
            if (curr_apple_x < 10+margin) curr_apple_x <= 630-margin; 
            else curr_apple_x <= curr_apple_x - 1; //fly left 
        end
    end
end


// DISPLAY SCORE
always @(*) begin
   unit = score % 10; 
   tens = ((score % 100) - unit) / 10 ; 
   hundreds = ((score % 1000)- unit - tens*10 ) / 100;  
   thousands = ((score % 10000)- unit - tens*10 - hundreds*100) / 1000;
    
   h_unit = high_score % 10; 
   h_tens = ((high_score % 100) - h_unit) / 10 ; 
   h_hundreds = ((high_score % 1000)- h_unit - h_tens*10 ) / 100;  
   h_thousands = ((high_score % 10000)- h_unit - h_tens*10 - h_hundreds*100) / 1000;
end

wire [7:0]	SSD7, SSD6, SSD5, SSD4, SSD3, SSD2, SSD1, SSD0;		
assign SSD7 = h_thousands;
assign SSD6 = h_hundreds;
assign SSD5 = h_tens;
assign SSD4 = h_unit;
assign SSD3 = thousands;
assign SSD2 = hundreds;
assign SSD1 = tens;
assign SSD0 = unit;
	
reg [26:0] DIV_CLK = 0;
always @(posedge clock_100Mhz, posedge reset) 	
begin							
    if (reset)
        DIV_CLK <= 0;
    else
        DIV_CLK <= DIV_CLK + 1'b1;
end

wire [2:0] ssdscan_clk;
assign ssdscan_clk = DIV_CLK[20:18];
assign AN0	= ~(~(ssdscan_clk[2]) && ~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when sev_seg_clk = 000
assign AN1	= ~(~(ssdscan_clk[2]) && ~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when sev_seg_clk = 001
assign AN2	= ~(~(ssdscan_clk[2]) &&  (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when sev_seg_clk = 010
assign AN3	= ~(~(ssdscan_clk[2]) &&  (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when sev_seg_clk = 011
assign AN4	= ~( (ssdscan_clk[2]) && ~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when sev_seg_clk = 100
assign AN5	= ~( (ssdscan_clk[2]) && ~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when sev_seg_clk = 101
assign AN6	= ~( (ssdscan_clk[2]) &&  (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when sev_seg_clk = 110
assign AN7	= ~( (ssdscan_clk[2]) &&  (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when sev_seg_clk = 111

reg [3:0] SSD;
always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3, SSD4, SSD5, SSD6, SSD7)
begin: SSD_SCAN_OUT
    case (ssdscan_clk) 
            3'b000: SSD = SSD0;
            3'b001: SSD = SSD1;
            3'b010: SSD = SSD2;
            3'b011: SSD = SSD3;
            3'b100: SSD = SSD4;
            3'b101: SSD = SSD5;
            3'b110: SSD = SSD6;
            3'b111: SSD = SSD7;
    endcase 
end

// Hex-to-SSD conversion
reg [7:0] SSD_CATHODES;
always @ (SSD) 
begin : HEX_TO_SSD
    case (SSD)                                                       
        5'b00000 : SSD_CATHODES <= 7'b0000001; // 0
        5'b00001 : SSD_CATHODES <= 7'b1001111; // 1
        5'b00010 : SSD_CATHODES <= 7'b0010010; // 2
        5'b00011 : SSD_CATHODES <= 7'b0000110; // 3
        5'b00100 : SSD_CATHODES <= 7'b1001100; // 4        
        5'b00101 : SSD_CATHODES <= 7'b0100100; // 5
        5'b00110 : SSD_CATHODES <= 7'b0100000; // 6
        5'b00111 : SSD_CATHODES <= 7'b0001111; // 7
        5'b01000 : SSD_CATHODES <= 7'b0000000; // 8
        5'b01001 : SSD_CATHODES <= 7'b0000100; // 9
    endcase
end	

assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg} = {SSD_CATHODES};

endmodule
