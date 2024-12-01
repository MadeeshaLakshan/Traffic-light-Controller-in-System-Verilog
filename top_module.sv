module top_module(
    input logic clk ,traffic_B,rstn,
    output logic red_light_A,amber_light_A,green_light_A,
    output logic red_light_B,amber_light_B,green_light_B,
    output logic [7:0]sec_counter_val,
    output logic [3:0]mili_sec_counter_val
);

logic amber_timer_done,amber_timer_enable;
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
endmodule