`timescale 1ns / 1ps
module vga_controller(
    input clk, rst,               
    input [999:0] x_input, y_input, // 640x480 resolution
    input [9:0] x_apple, y_apple,
    input [9:0] length, margin,
    input signed [10:0] last_vel_x, last_vel_y,
    input [3:0] velocity,
    input[19:0] score, high_score,
    input game_won,

    output reg hSync, vSync,       
    output reg [3:0] vgaR, vgaG, vgaB,   
    output reg [9:0] h_counter, v_counter
);

    reg pulse, clk25;
	
	initial begin
		clk25 = 0;
		pulse = 0;
	end
	
	always @(posedge clk)
		pulse = ~pulse;
	always @(posedge pulse)
		clk25 = ~clk25;


    // VGA 640x480 @ 60Hz timing constants
    parameter H_VISIBLE_AREA = 640;
    parameter H_FRONT_PORCH = 16;
    parameter H_SYNC_PULSE = 96;
    parameter H_TOTAL = 800;

    parameter V_VISIBLE_AREA = 480;
    parameter V_FRONT_PORCH = 10;
    parameter V_SYNC_PULSE = 2;
    parameter V_TOTAL = 525;
    
    reg [999:0] value_x, value_y;
    reg body_matched = 0;
    integer i;


    // for sprite
    wire [11:0] headColor, leafColor, gemColor, birdColor, winColor; 

    reg [3:0] head_col, head_row, head_width, head_height;
    reg [3:0] offset_x, offset_y ;

    head_rom hd(
	.clk(clk),
    .col(head_col),
    .row(head_row),
	.color_data(headColor)
	);

    leaf_rom ld(
	.clk(clk),
    .col(h_counter-x_apple),
    .row(v_counter-y_apple),
	.color_data(leafColor)
	);

    gem_rom gm(
	.clk(clk),
    .col(h_counter-x_apple),
    .row(v_counter-y_apple),
	.color_data(gemColor)
	);

    bird_rom bd(
	.clk(clk),
    .col(h_counter-x_apple),
    .row(v_counter-y_apple),
	.color_data(birdColor)
	);

    // start screen at x=215 and y=186
    win_screen_rom wsd(
	.clk(clk),
    .col(h_counter-215),
    .row(v_counter-186),
	.color_data(winColor)
	);


    // set direction of sprite
    always @(*) begin
        if (last_vel_x == 1) begin
            // Moving right: normal
            head_col = h_counter - value_x[9:0];
            head_row = v_counter - value_y[9:0];
            head_width = 7;
            head_height = 11;
            offset_x = 0;
            offset_y = 3;
        end 
        else if (last_vel_x == -1) begin
            // Moving left: flip horizontally
            head_col = 7 - (h_counter - value_x[9:0]);
            head_row = v_counter - value_y[9:0];
            head_width = 7;
            head_height = 11;
            offset_x = 0;
            offset_y = 3;
        end 
        else if (last_vel_y == 1) begin
            // Moving down: rotate +90 degrees
            head_col = (v_counter - value_y[9:0]);
            head_row = 11 - (h_counter - value_x[9:0]);
            head_width = 11;
            head_height = 7;
            offset_x = 3;
            offset_y = 0;
        end 
        else if (last_vel_y == -1) begin
            // Moving up: rotate -90 degrees
            head_col = 7 - (v_counter - value_y[9:0]);
            head_row = (h_counter - value_x[9:0]);
            head_width = 11;
            head_height = 7;
            offset_x = 3;
            offset_y = 0;
        end 
        else begin
            // Default (not moving)
            head_col = h_counter - value_x[9:0];
            head_row = v_counter - value_y[9:0];
            head_width = 7;
            head_height = 11;
        end
    end


    // VGA Horizontal and Vertical Counters
    always @(posedge clk25 or posedge rst) begin
        if (rst) begin
            h_counter <= 0;
            v_counter <= 0;
        end else begin
            // Horizontal counter (pixels per line)
            if (h_counter == H_TOTAL - 1) begin
                h_counter <= 0;
                // Vertical counter (lines per frame)
                if (v_counter == V_TOTAL - 1) begin
                    v_counter <= 0;
                end else begin
                    v_counter <= v_counter + 1;
                end
            end else begin
                h_counter <= h_counter + 1;
            end
        end
    end

    // Generate Horizontal and Vertical Sync signals
    always @(posedge clk25 or posedge rst) begin
        if (rst) begin
            hSync <= 1;
            vSync <= 1;
        end else begin
            // Horizontal sync
            if (h_counter >= H_VISIBLE_AREA + H_FRONT_PORCH && h_counter < H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE)
                hSync <= 0;
            else
                hSync <= 1;

            // Vertical sync
            if (v_counter >= V_VISIBLE_AREA + V_FRONT_PORCH && v_counter < V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE)
                vSync <= 0;
            else
                vSync <= 1;
        end
    end
    

    // Generate RGB values based on x and y input coordinates
    always @(posedge clk25 or posedge rst) begin

        if (rst) begin
            vgaR <= 0;
            vgaG <= 0;
            vgaB <= 0;

        end else if(game_won) begin
            if (h_counter >= 215 && h_counter < (215 + 210) &&
                v_counter >= 186 && v_counter < (186 + 108) ) begin
                vgaR = winColor[11:8];
                vgaG = winColor[7:4];
                vgaB = winColor[3:0];
            end
            else begin
                // Set background color (black)
                vgaR = 0;
                vgaG = 0;
                vgaB = 0;
            end
             
        
        end else begin
            if (h_counter < H_VISIBLE_AREA && v_counter < V_VISIBLE_AREA) begin
                value_x = x_input[999:0]; 
                value_y = y_input[999:0];
                
                // sprite head
                if ((h_counter >= value_x[9:0] && h_counter <= value_x[9:0] + head_width) &&
                (v_counter >= value_y[9:0] && v_counter <= value_y[9:0] + head_height)) 
                begin
                    if (headColor!=12'b011111111111)
                    begin
                        vgaR = headColor[11:8];
                        vgaG = headColor[7:4];
                        vgaB = headColor[3:0];
                    end
                    else
                    begin
                        vgaR = 4'b0000;
                        vgaG = 4'b0000;
                        vgaB = 4'b0000;
                    end
                end

                else begin
                    body_matched = 0;

                    for (i = 1; i <= 20; i = i + 1) begin
                        if (i<=length) begin
                            if( (value_x[i*10 +:10] != 0 || value_y[i*10 +:10] != 0) && (h_counter >= (value_x[i*10 +: 10] + offset_x) && h_counter <= (value_x[i*10 +: 10] + 5 + offset_x) ) &&
                            (v_counter >= (value_y[i*10 +: 10] + offset_y) && v_counter <= (value_y[i*10 +: 10] + 5 + offset_y)) )  begin
                                vgaR = 4'b1111; // set body to red
                                vgaG = 4'b0000;
                                vgaB = 4'b0000;
                                body_matched = 1;
                            end
                        end
                    end

                    if (!body_matched) begin
                        if (
                        // Vertical walls (left/right)
                        ((h_counter>=margin && h_counter<=10+margin) || 
                        (h_counter>=630-margin && h_counter<=640-margin)) &&
                        (v_counter>=margin && v_counter<=480-margin)
                        ||
                        // Horizontal walls (top/bottom)
                        ((v_counter>=margin && v_counter<=10+margin) ||
                        (v_counter>=470-margin && v_counter<=480-margin)) && 
                        (h_counter>=margin && h_counter<=630-margin)
                        )
                        begin  //gold
                            vgaR = 4'b1111;
                            vgaG = 4'b1101;
                            vgaB = 4'b0000;
                        end
                        
                        else if ( (velocity == 1) //leaf
                        && (h_counter <= x_apple+7 && h_counter >= x_apple && v_counter <= y_apple+7 && v_counter >= y_apple) )
                            begin    
                                if (leafColor!=12'b011111111111)
                                begin
                                    vgaR = leafColor[11:8];
                                    vgaG = leafColor[7:4];
                                    vgaB = leafColor[3:0];
                                end
                                else
                                begin
                                    vgaR = 4'b0000;
                                    vgaG = 4'b0000;
                                    vgaB = 4'b0000;
                                end
                            end

                        else if ( (velocity == 2) //gem
                        && (h_counter <= x_apple+7 && h_counter >= x_apple && v_counter <= y_apple+7 && v_counter >= y_apple) )
                            begin    
                                if (gemColor!=12'b011111111111)
                                begin
                                    vgaR = gemColor[11:8];
                                    vgaG = gemColor[7:4];
                                    vgaB = gemColor[3:0];
                                end
                                else
                                begin
                                    vgaR = 4'b0000;
                                    vgaG = 4'b0000;
                                    vgaB = 4'b0000;
                                end
                            end
                            
                        else if ( (velocity == 3) //bird
                        && (h_counter <= x_apple+12 && h_counter >= x_apple && v_counter <= y_apple+7 && v_counter >= y_apple) )
                            begin    
                                if (birdColor!=12'b011111111111)
                                begin
                                    vgaR = birdColor[11:8];
                                    vgaG = birdColor[7:4];
                                    vgaB = birdColor[3:0];
                                end
                                else
                                begin
                                    vgaR = 4'b0000;
                                    vgaG = 4'b0000;
                                    vgaB = 4'b0000;
                                end
                            end

                        else begin
                            // Set background color (black)
                            vgaR = 0;
                            vgaG = 0;
                            vgaB = 0;
                        end
                    end 
                end 
            
            end else begin
                // Blanking (set all colors to 0 during blanking periods)
                vgaR = 0;
                vgaG = 0;
                vgaB = 0;
            end
  
      end
  end
  
   
endmodule
