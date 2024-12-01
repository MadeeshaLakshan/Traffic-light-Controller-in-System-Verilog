module top_module_7seg(
    input logic clk ,traffic_B,rstn,
    output logic red_light_A,amber_light_A,green_light_A,
    output logic red_light_B,amber_light_B,green_light_B,
    output logic [6:0]sev_segment[2:0]
);

logic [7:0]sec_counter_val;
logic [3:0]mili_sec_counter_val;
logic [3:0]tens,ones,decimels;
logic amber_timer_done,amber_timer_enable;

assign tens = sec_counter_val/10;
assign ones = sec_counter_val%10;
assign decimels = mili_sec_counter_val;

controll_logic controll_logic(
    .clk(clk),
    .timer_done(amber_timer_done),
    .traffic_B(traffic_B),
    .rstn(rstn),
    .red_light_A(red_light_A),
    .amber_light_A(amber_light_A),
    .green_light_A(green_light_A),
    .red_light_B(red_light_B),
    .amber_light_B(amber_light_B),
    .green_light_B(green_light_B),
    .amber_timer_en(amber_timer_enable)
);

amber_timer amber_timer(
    .clk(clk),
    .enable(amber_timer_enable),
    .timer_done(amber_timer_done),
    .sec_counter_val(sec_counter_val),
    .mili_sec_counter_val(mili_sec_counter_val)
);

Sev_segment_decorder ten(.number(tens), .sev_segment(sev_segment[2]));
Sev_segment_decorder one(.number(ones), .sev_segment(sev_segment[1]));
Sev_segment_decorder decimel(.number(decimels), .sev_segment(sev_segment[0]));

endmodule