`timescale 1ns / 1ps
module position_controller(
    input clock, reset,
    input BtnL, BtnR, BtnU, BtnD,
    input [9:0] x_apple, y_apple,
    input [9:0] length, margin,
    input [3:0] velocity,

    output [999:0] pos_x, pos_y,  
    output reg signed [10:0] last_vel_x , last_vel_y
);

parameter [10:0] monitor_width_pixels = 640;
parameter [10:0] monitor_height_pixels = 480;

reg signed [10:0] vel_x, vel_y;
reg signed [10:0] pos_x_temp, pos_y_temp;
reg [989:0] pos_x_body,pos_y_body;

assign pos_x = {pos_x_body[989:0],pos_x_temp[9:0]};
assign pos_y = {pos_y_body[989:0],pos_y_temp[9:0]};

integer i;
reg [3:0] move_counter;
reg collision;

reg [989:0] temp_1s = ~(990'b0);


always @(*) begin
    vel_x = last_vel_x;
    vel_y = last_vel_y;

    if (BtnR==1) begin // right
      if(last_vel_x != -1)  begin
        vel_x = 1;
        vel_y = 0; end
    end 
    else if (BtnL==1) begin // left
      if(last_vel_x != 1)  begin
        vel_x = -1;
        vel_y = 0; end
    end 
    else if (BtnD==1) begin // down
       if(last_vel_y != -1)  begin
        vel_x = 0;
        vel_y = 1; end 
    end 
    else if (BtnU==1) begin // up
        if(last_vel_y != 1)  begin
        vel_x = 0;
        vel_y = -1; end
    end 
end


always @(posedge clock or posedge reset) begin
    if (reset == 1) begin
        pos_x_temp = 320;
        pos_y_temp = 120;
        move_counter = 0;

        last_vel_x = 0;
        last_vel_y = 0;
        pos_x_body = 990'b0;
        pos_y_body = 990'b0;
    end 
   
   else begin
        collision = 0;
        
        // Move dragon
        if (move_counter >= 7) begin 
            move_counter = 0;

            // Shift body 
            pos_x_body = pos_x_body << 10;
            pos_y_body = pos_y_body << 10;

            // New head position
            pos_x_body[9:0] = pos_x_temp[9:0];
            pos_y_body[9:0] = pos_y_temp[9:0];

            // Mask off extra bits
            pos_x_body[989:0] = pos_x_body[989:0] & ~(temp_1s << (length * 10));
            pos_y_body[989:0] = pos_y_body[989:0] & ~(temp_1s << (length * 10));
        end


        // Check wall collisions
        if ( 
            ( ((pos_x_temp >= margin && pos_x_temp <= 10 + margin) || 
            (pos_x_temp >= 630 - margin && pos_x_temp <= 640 - margin)) &&
            (pos_y_temp >= margin && pos_y_temp <= 480 - margin) )
            ||
            ( ((pos_y_temp >= margin && pos_y_temp <= 10 + margin) || 
            (pos_y_temp >= 470 - margin && pos_y_temp <= 480 - margin)) &&
            (pos_x_temp >= 10 + margin && pos_x_temp <= 630 - margin) )
        ) 
        begin
            collision = 1;
        end

        // Check self collisions
        for (i = 1; i <= 20; i = i + 1) begin
            if (i<=length) begin
               if ( (pos_x_temp == pos_x_body[i*10 +:10]) && 
                    (pos_y_temp == pos_y_body[i*10 +:10]) ) 
                begin
                    collision = 1;
                end
            end
        end

        // If no collision, update head position
        if (!collision) begin
            pos_x_temp = pos_x_temp + vel_x * velocity;
            pos_y_temp = pos_y_temp + vel_y * velocity;
            move_counter = move_counter + velocity;
        end         
                 

        if( BtnL==1 || BtnD==1 || BtnR==1 || BtnU==1)
           begin
            last_vel_x = vel_x;
            last_vel_y = vel_y;
          end

        if (pos_x_temp < 1) begin
            pos_x_temp = monitor_width_pixels - 1;  
        end
        else if (pos_x_temp >= monitor_width_pixels -1) begin
            pos_x_temp = 1;  
        end
        else if (pos_y_temp < 0) begin
            pos_y_temp = monitor_height_pixels - 1;  
        end
        else if (pos_y_temp >= monitor_height_pixels) begin
            pos_y_temp = 0;  
        end
    end 
    
end
    

endmodule
