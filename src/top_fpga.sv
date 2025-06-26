

module top_fpga (
    //--------------------------------------
    // LOC
    //--------------------------------------
    input  wire        LOC_REFCLK_P,
    input  wire        LOC_REFCLK_N,
    //--------------------------------------
    // MMI64
    //--------------------------------------
    input  wire [15:0] MMI64_H2F,
    output wire [15:0] MMI64_F2H,
    input  wire        MMI64_H2F_CLK,
    input  wire        MMI64_DEBUG_ENABLE_I,
    input  wire        MMI64_GT_RESET_I,
    input  wire        MMI64_PINMUX_RESET_I,
    output wire        MMI64_F2H_CLK,
    output wire        MMI64_PINMUX_READY_O,
    //--------------------------------------
    // LED
    //--------------------------------------
    output wire        LED_BLUE,
    output wire        LED_YELLOW,
    output wire        LED_RED,
    output wire        LED_GREEN,
    //--------------------------------------
    // DDR4_SODIMM2
    //--------------------------------------
    inout  wire [71:0] DDR4_SODIMM2_DQ,
    inout  wire [ 8:0] DDR4_SODIMM2_DQS_T,
    inout  wire [ 8:0] DDR4_SODIMM2_DQS_C,
    output wire [ 1:0] DDR4_SODIMM2_CK_T,
    output wire [ 1:0] DDR4_SODIMM2_CK_C,
    inout  wire [ 8:0] DDR4_SODIMM2_DM_DBI_N,
    output wire [16:0] DDR4_SODIMM2_ADR,
    output wire [ 1:0] DDR4_SODIMM2_BA,
    output wire [ 1:0] DDR4_SODIMM2_CKE,
    output wire [ 1:0] DDR4_SODIMM2_ODT,
    output wire [ 1:0] DDR4_SODIMM2_CS_N,
    output wire [ 1:0] DDR4_SODIMM2_BG,
    input  wire        DDR4_SODIMM2_CLK_P,
    input  wire        DDR4_SODIMM2_CLK_N,
    output wire        DDR4_SODIMM2_RESET_N,
    output wire        DDR4_SODIMM2_ACT_N,
    input  wire        DDR4_SODIMM2_ALERT_N,
    //--------------------------------------
    // DDR4_SODIMM1
    //--------------------------------------
    inout  wire [71:0] DDR4_SODIMM1_DQ,
    inout  wire [ 8:0] DDR4_SODIMM1_DQS_T,
    inout  wire [ 8:0] DDR4_SODIMM1_DQS_C,
    output wire [ 1:0] DDR4_SODIMM1_CK_T,
    output wire [ 1:0] DDR4_SODIMM1_CK_C,
    inout  wire [ 8:0] DDR4_SODIMM1_DM_DBI_N,
    output wire [16:0] DDR4_SODIMM1_ADR,
    output wire [ 1:0] DDR4_SODIMM1_BA,
    output wire [ 1:0] DDR4_SODIMM1_CKE,
    output wire [ 1:0] DDR4_SODIMM1_ODT,
    output wire [ 1:0] DDR4_SODIMM1_CS_N,
    output wire [ 1:0] DDR4_SODIMM1_BG,
    input  wire        DDR4_SODIMM1_CLK_P,
    input  wire        DDR4_SODIMM1_CLK_N,
    output wire        DDR4_SODIMM1_RESET_N,
    output wire        DDR4_SODIMM1_ACT_N,
    input  wire        DDR4_SODIMM1_ALERT_N,
    //--------------------------------------
    // r0_m0_fa2_tk2v0_eb1 : EB-V0-MULTI-IO-R1
    //--------------------------------------
    output wire        R0_M0_FA2_TK2V0_EB1_LED_BLUE,
    output wire        R0_M0_FA2_TK2V0_EB1_LED_YELLOW,
    output wire        R0_M0_FA2_TK2V0_EB1_LED_RED,
    output wire        R0_M0_FA2_TK2V0_EB1_LED_GREEN,
    inout  wire [ 7:0] R0_M0_FA2_TK2V0_EB1_GPIO1_IO,
    inout  wire [ 7:0] R0_M0_FA2_TK2V0_EB1_GPIO2_IO,
    input  wire        R0_M0_FA2_TK2V0_EB1_BUTTON_1,
    input  wire        R0_M0_FA2_TK2V0_EB1_BUTTON_2,
    input  wire        R0_M0_FA2_TK2V0_EB1_BUTTON_3,
    output wire        R0_M0_FA2_TK2V0_EB1_UART_A_TXD,
    input  wire        R0_M0_FA2_TK2V0_EB1_UART_A_RXD,
    output wire        R0_M0_FA2_TK2V0_EB1_UART_B_TXD,
    input  wire        R0_M0_FA2_TK2V0_EB1_UART_B_RXD,
    output wire        R0_M0_FA2_TK2V0_EB1_SPI_SCLK,
    output wire        R0_M0_FA2_TK2V0_EB1_SPI_NWP,
    output wire        R0_M0_FA2_TK2V0_EB1_SPI_NCS,
    output wire        R0_M0_FA2_TK2V0_EB1_SPI_MOSI,
    output wire        R0_M0_FA2_TK2V0_EB1_SPI_HOLD,
    input  wire        R0_M0_FA2_TK2V0_EB1_SPI_MISO,
    //--------------------------------------
    // r0_m0_fa2_tj3v0_eb1 : EB-FM-CS-XCVP-R3           
    //--------------------------------------
    output wire        R0_M0_FA2_TJ3V0_EB1_LED_YELLOW,
    output wire        R0_M0_FA2_TJ3V0_EB1_LED_RED,
    output wire        R0_M0_FA2_TJ3V0_EB1_LED_GREEN
);

  //------------------------------------------------
  // PROFPGA
  //------------------------------------------------
  logic mmcm_locked;
  logic clk_mmcm_out1, clk_mmcm_out2, clk_mmcm_out3, clk_mmcm_out4;
  logic clk_100MHz;

  //------------------------------------------------
  // CIPS
  //------------------------------------------------
  cips U_CIPS (
      .CH0_DDR4_0_0_act_n  (DDR4_SODIMM1_ACT_N),
      .CH0_DDR4_0_0_adr    (DDR4_SODIMM1_ADR),
      .CH0_DDR4_0_0_ba     (DDR4_SODIMM1_BA),
      .CH0_DDR4_0_0_bg     (DDR4_SODIMM1_BG),
      .CH0_DDR4_0_0_ck_c   (DDR4_SODIMM1_CK_C),
      .CH0_DDR4_0_0_ck_t   (DDR4_SODIMM1_CK_T),
      .CH0_DDR4_0_0_cke    (DDR4_SODIMM1_CKE),
      .CH0_DDR4_0_0_cs_n   (DDR4_SODIMM1_CS_N),
      .CH0_DDR4_0_0_dm_n   (DDR4_SODIMM1_DM_DBI_N),
      .CH0_DDR4_0_0_dq     (DDR4_SODIMM1_DQ),
      .CH0_DDR4_0_0_dqs_c  (DDR4_SODIMM1_DQS_C),
      .CH0_DDR4_0_0_dqs_t  (DDR4_SODIMM1_DQS_T),
      .CH0_DDR4_0_0_odt    (DDR4_SODIMM1_ODT),
      .CH0_DDR4_0_0_reset_n(DDR4_SODIMM1_RESET_N),

      .CH0_DDR4_1_0_act_n  (DDR4_SODIMM2_ACT_N),
      .CH0_DDR4_1_0_adr    (DDR4_SODIMM2_ADR),
      .CH0_DDR4_1_0_ba     (DDR4_SODIMM2_BA),
      .CH0_DDR4_1_0_bg     (DDR4_SODIMM2_BG),
      .CH0_DDR4_1_0_ck_c   (DDR4_SODIMM2_CK_C),
      .CH0_DDR4_1_0_ck_t   (DDR4_SODIMM2_CK_T),
      .CH0_DDR4_1_0_cke    (DDR4_SODIMM2_CKE),
      .CH0_DDR4_1_0_cs_n   (DDR4_SODIMM2_CS_N),
      .CH0_DDR4_1_0_dm_n   (DDR4_SODIMM2_DM_DBI_N),
      .CH0_DDR4_1_0_dq     (DDR4_SODIMM2_DQ),
      .CH0_DDR4_1_0_dqs_c  (DDR4_SODIMM2_DQS_C),
      .CH0_DDR4_1_0_dqs_t  (DDR4_SODIMM2_DQS_T),
      .CH0_DDR4_1_0_odt    (DDR4_SODIMM2_ODT),
      .CH0_DDR4_1_0_reset_n(DDR4_SODIMM2_RESET_N),

      .sys_clk0_0_clk_n(DDR4_SODIMM1_CLK_N),
      .sys_clk0_0_clk_p(DDR4_SODIMM1_CLK_P),

      .sys_clk1_0_clk_n(DDR4_SODIMM2_CLK_N),
      .sys_clk1_0_clk_p(DDR4_SODIMM2_CLK_P),

      .clk_5MHz(clk_mmcm_out1)
  );


endmodule
