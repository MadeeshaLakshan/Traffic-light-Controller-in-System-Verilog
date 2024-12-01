module controll_logic(
    input logic clk,timer_done,traffic_B,rstn,
    output logic red_light_A,amber_light_A,green_light_A,red_light_B,amber_light_B,green_light_B,amber_timer_en
);

enum logic [1:0] { F0, F1, F2, F3 }state, next_state ;

//next state 
always_comb begin
    case(state)

    F0: if(traffic_B) next_state = F1 ;
        else next_state = state ;

    F1: if(timer_done) next_state = F2 ;
        else next_state = state ;

    F2: if(!traffic_B) next_state = F3 ;
        else next_state = state ;

    F3: if(timer_done) next_state = F0 ;
        else next_state = state ;

    endcase
end

//state sequencer
always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) state <= F0 ;
    else state <= next_state ;
end

//output logic
always_comb begin
    if(state == F1) begin 
        red_light_A = 0; amber_light_A = 1; green_light_A = 0;
        red_light_B = 1; amber_light_B = 0; green_light_B = 0;
        amber_timer_en = 1;
    end

    else if(state == F2) begin 
        red_light_A = 1; amber_light_A = 0; green_light_A = 0;
        red_light_B = 0; amber_light_B = 0; green_light_B = 1;
        amber_timer_en = 0;
    end
    else if(state == F3) begin 
        red_light_A = 1; amber_light_A = 0; green_light_A = 0;
        red_light_B = 0; amber_light_B = 1; green_light_B = 0;
        amber_timer_en = 1;
    end
    else  begin 
        red_light_A = 0; amber_light_A = 0; green_light_A = 1;
        red_light_B = 1; amber_light_B = 0; green_light_B = 0;
        amber_timer_en = 0;
    end
 end
    
endmodule