//POVRay-File created by 3d41.ulp v1.05
///home/charles/Mitutoyo-SPC-Interface/mitutoyo-spc-data-logger/mitutoyo-spc-data-logger.brd
//9/13/11 2:53 PM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 325;
#local cam_z = -122;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -5;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 38;
#local lgt1_pos_y = 57;
#local lgt1_pos_z = 28;
#local lgt1_intense = 0.777419;
#local lgt2_pos_x = -38;
#local lgt2_pos_y = 57;
#local lgt2_pos_z = 28;
#local lgt2_intense = 0.777419;
#local lgt3_pos_x = 38;
#local lgt3_pos_y = 57;
#local lgt3_pos_z = -19;
#local lgt3_intense = 0.777419;
#local lgt4_pos_x = -38;
#local lgt4_pos_y = 57;
#local lgt4_pos_z = -19;
#local lgt4_intense = 0.777419;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 101.600000;
#declare pcb_y_size = 53.340000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(704);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-50.800000,0,-26.670000>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro MITUTOYO_SPC_DATA_LOGGER(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,18
<0.000000,0.000000><99.060000,0.000000>
<99.060000,0.000000><99.060000,1.270000>
<99.060000,1.270000><101.600000,3.810000>
<101.600000,3.810000><101.600000,38.100000>
<101.600000,38.100000><99.060000,40.640000>
<99.060000,40.640000><99.060000,50.800000>
<99.060000,50.800000><96.520000,53.340000>
<96.520000,53.340000><0.000000,53.264000>
<0.000000,53.264000><0.000000,0.000000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_CH1) #declare global_pack_CH1=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<16.510000,0.000000,36.830000>}#end		//Shrouded Header 10Pin CH1  ML10
#ifndef(pack_CH2) #declare global_pack_CH2=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<30.480000,0.000000,36.830000>}#end		//Shrouded Header 10Pin CH2  ML10
#ifndef(pack_CH3) #declare global_pack_CH3=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<44.450000,0.000000,36.830000>}#end		//Shrouded Header 10Pin CH3  ML10
#ifndef(pack_CH4) #declare global_pack_CH4=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<58.420000,0.000000,36.830000>}#end		//Shrouded Header 10Pin CH4  ML10
#ifndef(pack_CH5) #declare global_pack_CH5=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<72.390000,0.000000,36.830000>}#end		//Shrouded Header 10Pin CH5  ML10
#ifndef(pack_CH6) #declare global_pack_CH6=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<86.360000,0.000000,36.830000>}#end		//Shrouded Header 10Pin CH6  ML10
#ifndef(pack_CHMOD) #declare global_pack_CHMOD=yes; object {SWITCH_B3F_10XX1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<59.690000,0.000000,11.430000>}#end		//Tactile Switch-Omron CHMOD  B3F-10XX
//Parts without Macro (e.g. SMD Solderjumper)				Test point CS TPSQTP09R
//Parts without Macro (e.g. SMD Solderjumper)				Test point MISO TPSQTP09R
//Parts without Macro (e.g. SMD Solderjumper)				Test point MOSI TPSQTP09R
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<20.574000,0.000000,24.638000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R1 10K 0805
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<34.544000,0.000000,24.638000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R2 10K 0805
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<48.514000,0.000000,24.638000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R3 10K 0805
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<62.484000,0.000000,24.638000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R4 10K 0805
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<23.622000,0.000000,38.227000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R5 10K 0805
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.144000,0.000000,31.242000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R6 10K 0805
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<37.592000,0.000000,38.354000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R7 10K 0805
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<23.622000,0.000000,35.433000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R8 10K 0805
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<51.562000,0.000000,35.306000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R9 10K 0805
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<37.592000,0.000000,35.306000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R10 10K 0805
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<65.532000,0.000000,38.100000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R11 10K 0805
#ifndef(pack_R12) #declare global_pack_R12=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<51.562000,0.000000,38.100000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R12 10K 0805
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<88.900000,0.000000,11.684000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R13 10K 0805
#ifndef(pack_R14) #declare global_pack_R14=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<4.064000,0.000000,31.242000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R14 10K 0805
#ifndef(pack_R15) #declare global_pack_R15=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<76.200000,0.000000,24.638000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R15 10K 0805
#ifndef(pack_R16) #declare global_pack_R16=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<21.082000,0.000000,15.240000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R16 10K 0805
#ifndef(pack_R17) #declare global_pack_R17=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<90.170000,0.000000,24.638000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R17 10K 0805
#ifndef(pack_R18) #declare global_pack_R18=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<79.248000,0.000000,39.624000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R18 10K 0805
#ifndef(pack_R19) #declare global_pack_R19=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<65.532000,0.000000,35.306000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R19 10K 0805
#ifndef(pack_R20) #declare global_pack_R20=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<79.248000,0.000000,34.036000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R20 10K 0805
#ifndef(pack_R21) #declare global_pack_R21=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<79.248000,0.000000,36.830000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R21 10K 0805
#ifndef(pack_R22) #declare global_pack_R22=yes; object {RES_SMD_CHIP_0805("102",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<9.144000,0.000000,40.640000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R22 1K 0805
#ifndef(pack_R23) #declare global_pack_R23=yes; object {RES_SMD_CHIP_0805("102",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<9.144000,0.000000,45.720000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R23 1K 0805
#ifndef(pack_R24) #declare global_pack_R24=yes; object {RES_SMD_CHIP_0805("102",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<9.144000,0.000000,50.800000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R24 1K 0805
#ifndef(pack_R25) #declare global_pack_R25=yes; object {RES_SMD_CHIP_0805("102",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<9.144000,0.000000,35.560000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R25 1K 0805
#ifndef(pack_R26) #declare global_pack_R26=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<66.294000,0.000000,11.684000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R26 10K 0805
#ifndef(pack_R30) #declare global_pack_R30=yes; object {RES_SMD_CHIP_0805("182",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<20.320000,0.000000,11.176000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R30 1.8K 0805
#ifndef(pack_R31) #declare global_pack_R31=yes; object {RES_SMD_CHIP_0805("182",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<23.368000,0.000000,11.176000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R31 1.8K 0805
#ifndef(pack_R32) #declare global_pack_R32=yes; object {RES_SMD_CHIP_0805("182",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<26.416000,0.000000,11.176000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R32 1.8K 0805
#ifndef(pack_R54) #declare global_pack_R54=yes; object {RES_SMD_CHIP_0805("332",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<20.320000,0.000000,4.318000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R54 3.3K 0805
#ifndef(pack_R55) #declare global_pack_R55=yes; object {RES_SMD_CHIP_0805("332",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<23.368000,0.000000,4.318000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R55 3.3K 0805
#ifndef(pack_R56) #declare global_pack_R56=yes; object {RES_SMD_CHIP_0805("332",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<26.416000,0.000000,4.318000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R56 3.3K 0805
#ifndef(pack_RESET) #declare global_pack_RESET=yes; object {SWITCH_B3F_10XX1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<39.370000,0.000000,11.430000>}#end		//Tactile Switch-Omron RESET  B3F-10XX
#ifndef(pack_SAMPLE) #declare global_pack_SAMPLE=yes; object {SWITCH_B3F_10XX1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<82.550000,0.000000,11.430000>}#end		//Tactile Switch-Omron SAMPLE  B3F-10XX
//Parts without Macro (e.g. SMD Solderjumper)				Test point SCK TPSQTP09R
#ifndef(pack_X1) #declare global_pack_X1=yes; object {CON_PHOENIX_508_MSTBV_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<6.350000,0.000000,24.130000>}#end		//Connector PHOENIX type MSTBV vertical 2 pins X1 MSTBV2 MSTBV2
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<15.240000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<15.240000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<15.240000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<15.240000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<15.240000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<29.210000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<31.750000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<29.210000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<31.750000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<29.210000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<31.750000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<29.210000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<31.750000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<29.210000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<31.750000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.180000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.180000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.180000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.180000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.180000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<57.150000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.690000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<57.150000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.690000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<57.150000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.690000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<57.150000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.690000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<57.150000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.690000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<71.120000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<73.660000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<71.120000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<73.660000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<71.120000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<73.660000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<71.120000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<73.660000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<71.120000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<73.660000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<85.090000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<87.630000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<85.090000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<87.630000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<85.090000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<87.630000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<85.090000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<87.630000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<85.090000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CH6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<87.630000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_CHMOD) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<56.438800,0,13.690600> texture{col_thl}}
#ifndef(global_pack_CHMOD) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<62.941200,0,13.690600> texture{col_thl}}
#ifndef(global_pack_CHMOD) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<56.438800,0,9.169400> texture{col_thl}}
#ifndef(global_pack_CHMOD) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<62.941200,0,9.169400> texture{col_thl}}
object{TOOLS_PCB_SMD(0.900000,0.900000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<6.858000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<5.310000,0.000000,50.800000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<2.310000,0.000000,50.800000>}
object{TOOLS_PCB_SMD(0.900000,0.900000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<1.524000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<5.310000,0.000000,35.560000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<2.310000,0.000000,35.560000>}
object{TOOLS_PCB_SMD(0.900000,0.900000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<15.240000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<5.870000,0.000000,6.240000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<6.270000,0.000000,7.340000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<5.870000,0.000000,8.440000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<5.470000,0.000000,9.540000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<5.870000,0.000000,10.640000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<5.470000,0.000000,11.740000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<5.870000,0.000000,12.840000>}
object{TOOLS_PCB_SMD(0.700000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<5.870000,0.000000,13.940000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<16.070000,0.000000,13.240000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<16.070000,0.000000,7.240000>}
object{TOOLS_PCB_SMD(1.400000,1.900000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<2.970000,0.000000,14.840000>}
object{TOOLS_PCB_SMD(1.400000,1.900000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<2.070000,0.000000,1.640000>}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<15.240000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<16.510000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<17.780000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<29.210000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<30.480000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<31.750000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<43.180000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<44.450000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<45.720000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<57.150000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<58.420000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<59.690000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<71.120000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<72.390000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<73.660000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<85.090000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<86.360000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_Q6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<87.630000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.574000,0.000000,23.738000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.574000,0.000000,25.538000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<34.544000,0.000000,23.738000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<34.544000,0.000000,25.538000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<48.514000,0.000000,23.738000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<48.514000,0.000000,25.538000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<62.484000,0.000000,23.738000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<62.484000,0.000000,25.538000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<22.722000,0.000000,38.227000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<24.522000,0.000000,38.227000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<8.244000,0.000000,31.242000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<10.044000,0.000000,31.242000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.692000,0.000000,38.354000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.492000,0.000000,38.354000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<22.722000,0.000000,35.433000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<24.522000,0.000000,35.433000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<50.662000,0.000000,35.306000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<52.462000,0.000000,35.306000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.692000,0.000000,35.306000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.492000,0.000000,35.306000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<66.432000,0.000000,38.100000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.632000,0.000000,38.100000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<50.662000,0.000000,38.100000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<52.462000,0.000000,38.100000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<88.900000,0.000000,12.584000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<88.900000,0.000000,10.784000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<3.164000,0.000000,31.242000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<4.964000,0.000000,31.242000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<76.200000,0.000000,23.738000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<76.200000,0.000000,25.538000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.182000,0.000000,15.240000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<21.982000,0.000000,15.240000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<90.170000,0.000000,23.738000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<90.170000,0.000000,25.538000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.348000,0.000000,39.624000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<80.148000,0.000000,39.624000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<66.432000,0.000000,35.306000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.632000,0.000000,35.306000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.348000,0.000000,34.036000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<80.148000,0.000000,34.036000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.348000,0.000000,36.830000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<80.148000,0.000000,36.830000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.044000,0.000000,40.640000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<8.244000,0.000000,40.640000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.044000,0.000000,45.720000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<8.244000,0.000000,45.720000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.044000,0.000000,50.800000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<8.244000,0.000000,50.800000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.044000,0.000000,35.560000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<8.244000,0.000000,35.560000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.294000,0.000000,12.584000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.294000,0.000000,10.784000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.320000,0.000000,10.276000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.320000,0.000000,12.076000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.368000,0.000000,10.276000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.368000,0.000000,12.076000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<26.416000,0.000000,10.276000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<26.416000,0.000000,12.076000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.320000,0.000000,3.418000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.320000,0.000000,5.218000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.368000,0.000000,3.418000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.368000,0.000000,5.218000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<26.416000,0.000000,3.418000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<26.416000,0.000000,5.218000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<5.310000,0.000000,45.720000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<2.310000,0.000000,45.720000>}
#ifndef(global_pack_RESET) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<36.118800,0,13.690600> texture{col_thl}}
#ifndef(global_pack_RESET) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<42.621200,0,13.690600> texture{col_thl}}
#ifndef(global_pack_RESET) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<36.118800,0,9.169400> texture{col_thl}}
#ifndef(global_pack_RESET) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<42.621200,0,9.169400> texture{col_thl}}
#ifndef(global_pack_SAMPLE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<79.298800,0,13.690600> texture{col_thl}}
#ifndef(global_pack_SAMPLE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.801200,0,13.690600> texture{col_thl}}
#ifndef(global_pack_SAMPLE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<79.298800,0,9.169400> texture{col_thl}}
#ifndef(global_pack_SAMPLE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.801200,0,9.169400> texture{col_thl}}
object{TOOLS_PCB_SMD(0.900000,0.900000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<10.160000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<5.310000,0.000000,40.640000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<2.310000,0.000000,40.640000>}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<35.560000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<38.100000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<50.800000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<53.340000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<55.880000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<58.420000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<66.040000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<68.580000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<73.660000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<76.200000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<78.740000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<81.280000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<83.820000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<86.360000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<88.900000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<91.440000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<24.130000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<58.420000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<55.880000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<53.340000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<50.800000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<48.260000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<45.720000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<41.910000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<34.290000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<31.750000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<68.580000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<71.120000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<73.660000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<76.200000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<78.740000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<81.280000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<83.820000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<86.360000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<26.670000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<40.640000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<33.020000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<45.720000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<6.350000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<6.350000,0,21.590000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<3.556000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<8.763000,0,12.446000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<29.972000,0,16.383000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<24.765000,0,10.668000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<10.160000,0,38.481000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<38.481000,0,39.751000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<65.532000,0,36.830000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<84.709000,0,44.323000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<13.716000,0,7.112000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<26.416000,0,7.112000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<23.368000,0,8.636000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<8.636000,0,10.668000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<18.923000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<21.717000,0,11.557000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.524000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.524000,0.000000,16.764000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,90.000000,0> translate<1.524000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.032000,0.000000,10.198000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.032000,0.000000,13.208000>}
box{<0,0,-0.127000><3.010000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.032000,0.000000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.032000,0.000000,10.198000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.070000,0.000000,10.160000>}
box{<0,0,-0.127000><0.053740,0.035000,0.127000> rotate<0,44.997030,0> translate<2.032000,0.000000,10.198000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.070000,0.000000,1.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.070000,0.000000,10.160000>}
box{<0,0,-0.127000><8.520000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.070000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.070000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.070000,0.000000,10.706000>}
box{<0,0,-0.127000><0.546000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.070000,0.000000,10.706000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,35.560000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.286000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,40.640000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.286000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,50.800000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.286000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.310000,0.000000,35.560000>}
box{<0,0,-0.127000><0.024000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.286000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.310000,0.000000,40.640000>}
box{<0,0,-0.127000><0.024000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.286000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.310000,0.000000,45.720000>}
box{<0,0,-0.127000><0.024000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.286000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.310000,0.000000,50.800000>}
box{<0,0,-0.127000><0.024000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.286000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.310000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.413000,0.000000,40.640000>}
box{<0,0,-0.127000><0.103000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.310000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.310000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.413000,0.000000,40.767000>}
box{<0,0,-0.127000><0.163518,0.035000,0.127000> rotate<0,-50.953768,0> translate<2.310000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.310000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.413000,0.000000,45.720000>}
box{<0,0,-0.127000><0.103000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.310000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.413000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.413000,0.000000,45.720000>}
box{<0,0,-0.127000><4.953000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.413000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.032000,0.000000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.970000,0.000000,14.146000>}
box{<0,0,-0.127000><1.326532,0.035000,0.127000> rotate<0,-44.997030,0> translate<2.032000,0.000000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.970000,0.000000,14.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.970000,0.000000,14.840000>}
box{<0,0,-0.127000><0.694000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.970000,0.000000,14.840000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.070000,0.000000,10.706000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.048000,0.000000,11.684000>}
box{<0,0,-0.127000><1.383101,0.035000,0.127000> rotate<0,-44.997030,0> translate<2.070000,0.000000,10.706000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.164000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.175000,0.000000,31.242000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<3.164000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.175000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.175000,0.000000,31.242000>}
box{<0,0,-0.127000><1.397000,0.035000,0.127000> rotate<0,90.000000,0> translate<3.175000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.556000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.556000,0.000000,8.636000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,90.000000,0> translate<3.556000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.524000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.064000,0.000000,16.764000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<1.524000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.556000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.572000,-1.535000,4.064000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<3.556000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.556000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.572000,0.000000,9.652000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<3.556000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.572000,0.000000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.358000,0.000000,9.652000>}
box{<0,0,-0.127000><0.786000,0.035000,0.127000> rotate<0,0.000000,0> translate<4.572000,0.000000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.048000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.414000,0.000000,11.684000>}
box{<0,0,-0.127000><2.366000,0.035000,0.127000> rotate<0,0.000000,0> translate<3.048000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.358000,0.000000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.470000,0.000000,9.540000>}
box{<0,0,-0.127000><0.158392,0.035000,0.127000> rotate<0,44.997030,0> translate<5.358000,0.000000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.414000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.470000,0.000000,11.740000>}
box{<0,0,-0.127000><0.079196,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.414000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.064000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.588000,0.000000,15.240000>}
box{<0,0,-0.127000><2.155261,0.035000,0.127000> rotate<0,44.997030,0> translate<4.064000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.870000,0.000000,10.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.898000,0.000000,10.668000>}
box{<0,0,-0.127000><0.039598,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.870000,0.000000,10.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.175000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,26.670000>}
box{<0,0,-0.127000><4.490128,0.035000,0.127000> rotate<0,44.997030,0> translate<3.175000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.604000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.858000,0.000000,16.510000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,-44.997030,0> translate<6.604000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.588000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.112000,0.000000,15.240000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.588000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.286000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.239000,0.000000,22.606000>}
box{<0,0,-0.127000><7.004600,0.035000,0.127000> rotate<0,44.997030,0> translate<2.286000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.239000,0.000000,22.606000>}
box{<0,0,-0.127000><1.350029,0.035000,0.127000> rotate<0,-48.810853,0> translate<6.350000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.604000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,16.256000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<6.604000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,22.860000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<6.350000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.870000,0.000000,12.840000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.760000,0.000000,12.840000>}
box{<0,0,-0.127000><1.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.870000,0.000000,12.840000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.760000,0.000000,12.840000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.064500,0.000000,13.144500>}
box{<0,0,-0.127000><0.430628,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.760000,0.000000,12.840000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.064500,0.000000,13.144500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.128000,0.000000,13.208000>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,-44.997030,0> translate<8.064500,0.000000,13.144500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.128000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.128000,0.000000,13.208000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,-90.000000,0> translate<8.128000,0.000000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.112000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.128000,0.000000,14.224000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<7.112000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.964000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.244000,0.000000,31.242000>}
box{<0,0,-0.127000><3.280000,0.035000,0.127000> rotate<0,0.000000,0> translate<4.964000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.310000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.244000,0.000000,35.560000>}
box{<0,0,-0.127000><2.934000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.310000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.310000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.244000,0.000000,40.640000>}
box{<0,0,-0.127000><2.934000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.310000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.310000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.244000,0.000000,45.720000>}
box{<0,0,-0.127000><2.934000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.310000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.310000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.244000,0.000000,50.800000>}
box{<0,0,-0.127000><2.934000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.310000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.244000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.255000,0.000000,31.242000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<8.244000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.898000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.636000,0.000000,10.668000>}
box{<0,0,-0.127000><2.738000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.898000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.064500,0.000000,13.144500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,0.000000,12.446000>}
box{<0,0,-0.127000><0.987828,0.035000,0.127000> rotate<0,44.997030,0> translate<8.064500,0.000000,13.144500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.255000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.271000,0.000000,30.226000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<8.255000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,16.510000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,90.000000,0> translate<10.160000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.044000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,31.242000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.044000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,34.036000>}
box{<0,0,-0.127000><2.794000,0.035000,0.127000> rotate<0,90.000000,0> translate<10.160000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.044000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,35.560000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.044000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,38.481000>}
box{<0,0,-0.127000><2.921000,0.035000,0.127000> rotate<0,90.000000,0> translate<10.160000,0.000000,38.481000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.270000,0.000000,7.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.440000,0.000000,7.340000>}
box{<0,0,-0.127000><4.170000,0.035000,0.127000> rotate<0,0.000000,0> translate<6.270000,0.000000,7.340000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.870000,0.000000,8.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.388000,0.000000,8.440000>}
box{<0,0,-0.127000><6.518000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.870000,0.000000,8.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.440000,0.000000,7.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,5.080000>}
box{<0,0,-0.127000><3.196123,0.035000,0.127000> rotate<0,44.997030,0> translate<10.440000,0.000000,7.340000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,39.370000>}
box{<0,0,-0.127000><13.970000,0.035000,0.127000> rotate<0,90.000000,0> translate<12.700000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.335000,-1.535000,19.685000>}
box{<0,0,-0.127000><9.878282,0.035000,0.127000> rotate<0,44.997030,0> translate<6.350000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.388000,0.000000,8.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,7.112000>}
box{<0,0,-0.127000><1.878076,0.035000,0.127000> rotate<0,44.997030,0> translate<12.388000,0.000000,8.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,15.494000>}
box{<0,0,-0.127000><3.302000,0.035000,0.127000> rotate<0,90.000000,0> translate<14.224000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.732000,0.000000,9.144000>}
box{<0,0,-0.127000><10.057887,0.035000,0.127000> rotate<0,44.997030,0> translate<7.620000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.732000,0.000000,10.160000>}
box{<0,0,-0.127000><6.465784,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,11.176000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<14.224000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,16.510000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<14.224000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,18.923000>}
box{<0,0,-0.127000><9.159861,0.035000,0.127000> rotate<0,-44.997030,0> translate<8.763000,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,22.860000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<7.620000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,22.860000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<12.700000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<15.240000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,39.116000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<10.160000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,39.370000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,90.000000,0> translate<15.240000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,41.910000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<12.700000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.044000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.621000,0.000000,40.640000>}
box{<0,0,-0.127000><5.577000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.044000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,40.640000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.240000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,-1.535000,21.463000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<15.240000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,-1.535000,34.544000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<15.240000,-1.535000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,-1.535000,34.544000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<16.637000,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.621000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,0.000000,41.656000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.621000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,0.000000,42.418000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,90.000000,0> translate<16.637000,0.000000,42.418000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.732000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.764000,0.000000,10.160000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,0.000000,0> translate<14.732000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.636000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.764000,-1.535000,10.668000>}
box{<0,0,-0.127000><8.128000,0.035000,0.127000> rotate<0,0.000000,0> translate<8.636000,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.764000,0.000000,11.176000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,0.000000,0> translate<15.240000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.732000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.272000,0.000000,9.144000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<14.732000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.764000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,12.192000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.764000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,12.700000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,90.000000,0> translate<17.780000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,24.765000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.510000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.907000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.780000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.907000,-1.535000,25.273000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<16.637000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.907000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.907000,-1.535000,25.273000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<17.907000,-1.535000,25.273000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.070000,0.000000,13.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.070000,0.000000,15.240000>}
box{<0,0,-0.127000><2.828427,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.070000,0.000000,13.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,-1.535000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.288000,-1.535000,21.463000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.637000,-1.535000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.070000,0.000000,1.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.542000,0.000000,1.640000>}
box{<0,0,-0.127000><16.472000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.070000,0.000000,1.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.764000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,-1.535000,8.636000>}
box{<0,0,-0.127000><2.873682,0.035000,0.127000> rotate<0,44.997030,0> translate<16.764000,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.764000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,12.192000>}
box{<0,0,-0.127000><2.873682,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.764000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,12.700000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,90.000000,0> translate<18.796000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,13.716000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.780000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,23.749000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<17.780000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.070000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.923000,0.000000,15.240000>}
box{<0,0,-0.127000><0.853000,0.035000,0.127000> rotate<0,0.000000,0> translate<18.070000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.044000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.177000,0.000000,45.720000>}
box{<0,0,-0.127000><9.133000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.044000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.304000,0.000000,13.208000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,-44.997030,0> translate<18.796000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.288000,-1.535000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.685000,-1.535000,22.860000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<18.288000,-1.535000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.272000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.748500,0.000000,11.620500>}
box{<0,0,-0.127000><3.502300,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.272000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.748500,0.000000,11.620500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.812000,0.000000,11.557000>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,44.997030,0> translate<19.748500,0.000000,11.620500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.182000,0.000000,5.080000>}
box{<0,0,-0.127000><7.482000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.700000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.923000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.182000,0.000000,15.240000>}
box{<0,0,-0.127000><1.259000,0.035000,0.127000> rotate<0,0.000000,0> translate<18.923000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.748500,0.000000,11.620500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.204000,0.000000,12.076000>}
box{<0,0,-0.127000><0.644174,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.748500,0.000000,11.620500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.542000,0.000000,1.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,3.418000>}
box{<0,0,-0.127000><2.514472,0.035000,0.127000> rotate<0,-44.997030,0> translate<18.542000,0.000000,1.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.182000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,5.218000>}
box{<0,0,-0.127000><0.195161,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.182000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,5.218000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,10.276000>}
box{<0,0,-0.127000><5.058000,0.035000,0.127000> rotate<0,90.000000,0> translate<20.320000,0.000000,10.276000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.204000,0.000000,12.076000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,12.076000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.204000,0.000000,12.076000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.574000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.574000,0.000000,23.738000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.574000,0.000000,23.738000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.574000,0.000000,23.749000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,0.000000,0> translate<18.796000,0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.574000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.574000,0.000000,25.538000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,90.000000,0> translate<20.574000,0.000000,25.538000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.828000,0.000000,41.910000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.780000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.082000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.082000,0.000000,16.002000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,90.000000,0> translate<21.082000,0.000000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.082000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.336000,0.000000,14.224000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,44.997030,0> translate<21.082000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,38.481000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.336000,-1.535000,49.657000>}
box{<0,0,-0.127000><15.805251,0.035000,0.127000> rotate<0,-44.997030,0> translate<10.160000,-1.535000,38.481000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.923000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,17.780000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<18.923000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.082000,0.000000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,16.510000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,-44.997030,0> translate<21.082000,0.000000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.574000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,24.511000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<20.574000,0.000000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,24.511000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<21.590000,0.000000,24.511000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.812000,0.000000,11.557000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717000,0.000000,11.557000>}
box{<0,0,-0.127000><1.905000,0.035000,0.127000> rotate<0,0.000000,0> translate<19.812000,0.000000,11.557000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.982000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,15.240000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,0.000000,0> translate<21.982000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,15.240000>}
box{<0,0,-0.127000><14.986000,0.035000,0.127000> rotate<0,-90.000000,0> translate<22.098000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.271000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,30.226000>}
box{<0,0,-0.127000><12.827000,0.035000,0.127000> rotate<0,0.000000,0> translate<9.271000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,31.369000>}
box{<0,0,-0.127000><1.143000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.098000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,34.925000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.098000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.336000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.606000,0.000000,14.224000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<21.336000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.606000,0.000000,35.433000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.098000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.044000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.606000,0.000000,50.800000>}
box{<0,0,-0.127000><12.562000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.044000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.606000,0.000000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.722000,0.000000,35.433000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.606000,0.000000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.722000,0.000000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.733000,0.000000,35.433000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.722000,0.000000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.722000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.733000,0.000000,38.227000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.722000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.733000,0.000000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.733000,0.000000,38.227000>}
box{<0,0,-0.127000><2.794000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.733000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.304000,0.000000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,13.208000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,0.000000,0> translate<19.304000,0.000000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.177000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.114000,0.000000,49.657000>}
box{<0,0,-0.127000><5.567759,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.177000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,3.418000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,3.418000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,0.000000,3.418000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,5.218000>}
box{<0,0,-0.127000><3.418000,0.035000,0.127000> rotate<0,-90.000000,0> translate<23.368000,0.000000,5.218000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,-1.535000,8.636000>}
box{<0,0,-0.127000><4.572000,0.035000,0.127000> rotate<0,0.000000,0> translate<18.796000,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,10.276000>}
box{<0,0,-0.127000><1.640000,0.035000,0.127000> rotate<0,90.000000,0> translate<23.368000,0.000000,10.276000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,12.076000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,12.065000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<23.368000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,12.076000>}
box{<0,0,-0.127000><0.624000,0.035000,0.127000> rotate<0,-90.000000,0> translate<23.368000,0.000000,12.076000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,12.700000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,44.997030,0> translate<22.860000,0.000000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637000,0.000000,42.418000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,49.149000>}
box{<0,0,-0.127000><9.519071,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.637000,0.000000,42.418000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717000,-1.535000,11.557000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.495000,-1.535000,9.779000>}
box{<0,0,-0.127000><2.514472,0.035000,0.127000> rotate<0,44.997030,0> translate<21.717000,-1.535000,11.557000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.606000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.749000,0.000000,51.943000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.606000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.828000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.511000,0.000000,38.227000>}
box{<0,0,-0.127000><5.208549,0.035000,0.127000> rotate<0,44.997030,0> translate<20.828000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.257000,0.000000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.522000,0.000000,38.227000>}
box{<0,0,-0.127000><0.464097,0.035000,0.127000> rotate<0,55.176276,0> translate<24.257000,0.000000,38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.511000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.522000,0.000000,38.227000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<24.511000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.765000,0.000000,10.668000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<23.368000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.765000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.765000,-1.535000,12.446000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,90.000000,0> translate<24.765000,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.495000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.146000,-1.535000,9.779000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,0.000000,0> translate<23.495000,-1.535000,9.779000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.522000,0.000000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.273000,0.000000,35.433000>}
box{<0,0,-0.127000><0.751000,0.035000,0.127000> rotate<0,0.000000,0> translate<24.522000,0.000000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.796000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,13.716000>}
box{<0,0,-0.127000><6.604000,0.035000,0.127000> rotate<0,0.000000,0> translate<18.796000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,38.100000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,90.000000,0> translate<25.400000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,40.640000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.510000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.146000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.781000,-1.535000,10.414000>}
box{<0,0,-0.127000><0.898026,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.146000,-1.535000,9.779000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.352500,0.000000,12.763500>}
box{<0,0,-0.127000><1.347038,0.035000,0.127000> rotate<0,44.997030,0> translate<25.400000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,3.418000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,3.418000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,0.000000,0> translate<23.368000,0.000000,3.418000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,5.218000>}
box{<0,0,-0.127000><1.894000,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.416000,0.000000,5.218000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,-1.535000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,-1.535000,7.112000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.716000,-1.535000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,10.276000>}
box{<0,0,-0.127000><3.164000,0.035000,0.127000> rotate<0,90.000000,0> translate<26.416000,0.000000,10.276000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,12.076000>}
box{<0,0,-0.127000><0.624000,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.416000,0.000000,12.076000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.352500,0.000000,12.763500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,12.700000>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,44.997030,0> translate<26.352500,0.000000,12.763500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.098000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,35.687000>}
box{<0,0,-0.127000><6.106574,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.098000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,3.418000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.554000,0.000000,3.556000>}
box{<0,0,-0.127000><0.195161,0.035000,0.127000> rotate<0,-44.997030,0> translate<26.416000,0.000000,3.418000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.606000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.813000,0.000000,19.431000>}
box{<0,0,-0.127000><7.363810,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.606000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.813000,0.000000,19.431000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.813000,0.000000,24.003000>}
box{<0,0,-0.127000><4.572000,0.035000,0.127000> rotate<0,90.000000,0> translate<27.813000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.554000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.448000,0.000000,3.556000>}
box{<0,0,-0.127000><1.894000,0.035000,0.127000> rotate<0,0.000000,0> translate<26.554000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.956000,-1.535000,41.656000>}
box{<0,0,-0.127000><5.028943,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.400000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.956000,-1.535000,41.656000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.956000,-1.535000,41.910000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,90.000000,0> translate<28.956000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.685000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,22.860000>}
box{<0,0,-0.127000><9.525000,0.035000,0.127000> rotate<0,0.000000,0> translate<19.685000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,22.860000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<25.400000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<29.210000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.273000,0.000000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,39.370000>}
box{<0,0,-0.127000><5.567759,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.273000,0.000000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.448000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.464000,0.000000,4.572000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<28.448000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.765000,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.591000,-1.535000,17.272000>}
box{<0,0,-0.127000><6.824995,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.765000,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.352500,0.000000,12.763500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.972000,0.000000,16.383000>}
box{<0,0,-0.127000><5.118746,0.035000,0.127000> rotate<0,-44.997030,0> translate<26.352500,0.000000,12.763500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.353000,0.000000,40.513000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.210000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.353000,-1.535000,43.053000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.210000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.607000,-1.535000,34.544000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<29.210000,-1.535000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.607000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.607000,-1.535000,34.544000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<30.607000,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.749000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.607000,0.000000,51.943000>}
box{<0,0,-0.127000><6.858000,0.035000,0.127000> rotate<0,0.000000,0> translate<23.749000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.257000,0.000000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.496000,0.000000,45.847000>}
box{<0,0,-0.127000><10.237492,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.257000,0.000000,38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,24.765000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<30.480000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,46.990000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.400000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.607000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,50.800000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<30.607000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.877000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<31.750000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.607000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.877000,-1.535000,25.273000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<30.607000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.877000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.877000,-1.535000,25.273000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<31.877000,-1.535000,25.273000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.353000,0.000000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.004000,0.000000,40.513000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,0.000000,0> translate<30.353000,0.000000,40.513000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.353000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.258000,-1.535000,43.053000>}
box{<0,0,-0.127000><1.905000,0.035000,0.127000> rotate<0,0.000000,0> translate<30.353000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,23.749000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<31.750000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.114000,0.000000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.147000,0.000000,49.657000>}
box{<0,0,-0.127000><10.033000,0.035000,0.127000> rotate<0,0.000000,0> translate<23.114000,0.000000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.258000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.401000,-1.535000,41.910000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<32.258000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.909000,-1.535000,39.751000>}
box{<0,0,-0.127000><3.053287,0.035000,0.127000> rotate<0,44.997030,0> translate<31.750000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,1.270000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<33.020000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.147000,0.000000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,50.800000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<33.147000,0.000000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.813000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.417000,0.000000,30.607000>}
box{<0,0,-0.127000><9.339466,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.813000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,23.738000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<34.544000,0.000000,23.738000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,23.749000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,25.538000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,25.654000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,90.000000,0> translate<34.544000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.572000,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.052000,-1.535000,4.064000>}
box{<0,0,-0.127000><30.480000,0.035000,0.127000> rotate<0,0.000000,0> translate<4.572000,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.368000,0.000000,49.149000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.179000,0.000000,49.149000>}
box{<0,0,-0.127000><11.811000,0.035000,0.127000> rotate<0,0.000000,0> translate<23.368000,0.000000,49.149000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,2.540000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,-90.000000,0> translate<35.560000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.052000,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,3.556000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,44.997030,0> translate<35.052000,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.118800,0.000000,13.690600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.195000,0.000000,13.716000>}
box{<0,0,-0.127000><0.080322,0.035000,0.127000> rotate<0,-18.433732,0> translate<36.118800,0.000000,13.690600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.195000,0.000000,15.875000>}
box{<0,0,-0.127000><9.878282,0.035000,0.127000> rotate<0,44.997030,0> translate<29.210000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.692000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,35.306000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<36.692000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,35.306000>}
box{<0,0,-0.127000><0.381000,0.035000,0.127000> rotate<0,-90.000000,0> translate<36.703000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.416000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,35.687000>}
box{<0,0,-0.127000><10.287000,0.035000,0.127000> rotate<0,0.000000,0> translate<26.416000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.692000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,35.687000>}
box{<0,0,-0.127000><0.381159,0.035000,0.127000> rotate<0,-88.340420,0> translate<36.692000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.692000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,38.354000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<36.692000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,38.354000>}
box{<0,0,-0.127000><2.667000,0.035000,0.127000> rotate<0,90.000000,0> translate<36.703000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.004000,0.000000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,45.339000>}
box{<0,0,-0.127000><6.824995,0.035000,0.127000> rotate<0,-44.997030,0> translate<32.004000,0.000000,40.513000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.179000,0.000000,49.149000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,50.800000>}
box{<0,0,-0.127000><2.334867,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.179000,0.000000,49.149000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.592000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.592000,0.000000,40.132000>}
box{<0,0,-0.127000><3.937000,0.035000,0.127000> rotate<0,90.000000,0> translate<37.592000,0.000000,40.132000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.703000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.719000,0.000000,34.290000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<36.703000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.336000,-1.535000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.227000,-1.535000,49.657000>}
box{<0,0,-0.127000><16.891000,0.035000,0.127000> rotate<0,0.000000,0> translate<21.336000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.195000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.354000,0.000000,13.716000>}
box{<0,0,-0.127000><2.159000,0.035000,0.127000> rotate<0,0.000000,0> translate<36.195000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.195000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.354000,0.000000,13.716000>}
box{<0,0,-0.127000><3.053287,0.035000,0.127000> rotate<0,44.997030,0> translate<36.195000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.592000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.481000,0.000000,35.306000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,44.997030,0> translate<37.592000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.481000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.481000,0.000000,38.354000>}
box{<0,0,-0.127000><1.397000,0.035000,0.127000> rotate<0,-90.000000,0> translate<38.481000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.909000,-1.535000,39.751000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.481000,-1.535000,39.751000>}
box{<0,0,-0.127000><4.572000,0.035000,0.127000> rotate<0,0.000000,0> translate<33.909000,-1.535000,39.751000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.481000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.492000,0.000000,35.306000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.481000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.481000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.492000,0.000000,38.354000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.481000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.719000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.116000,0.000000,34.290000>}
box{<0,0,-0.127000><1.397000,0.035000,0.127000> rotate<0,0.000000,0> translate<37.719000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.492000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.116000,0.000000,35.306000>}
box{<0,0,-0.127000><0.624000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.492000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.464000,0.000000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,4.572000>}
box{<0,0,-0.127000><9.906000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.464000,0.000000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.354000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,13.716000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.354000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,13.716000>}
box{<0,0,-0.127000><9.144000,0.035000,0.127000> rotate<0,90.000000,0> translate<39.370000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.227000,-1.535000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,50.800000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<38.227000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.624000,0.000000,4.572000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<39.370000,0.000000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.116000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.513000,0.000000,35.687000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.116000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,2.540000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,-90.000000,0> translate<40.640000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.624000,0.000000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,3.556000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<39.624000,0.000000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.591000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.291000,-1.535000,17.272000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.591000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.592000,0.000000,40.132000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.291000,0.000000,44.831000>}
box{<0,0,-0.127000><6.645390,0.035000,0.127000> rotate<0,-44.997030,0> translate<37.592000,0.000000,40.132000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.972000,-1.535000,16.383000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.418000,-1.535000,16.383000>}
box{<0,0,-0.127000><12.446000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.972000,-1.535000,16.383000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.545000,0.000000,13.716000>}
box{<0,0,-0.127000><3.175000,0.035000,0.127000> rotate<0,0.000000,0> translate<39.370000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.545000,-1.535000,17.780000>}
box{<0,0,-0.127000><21.082000,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.118800,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.621200,-1.535000,9.169400>}
box{<0,0,-0.127000><6.502400,0.035000,0.127000> rotate<0,0.000000,0> translate<36.118800,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.545000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.621200,0.000000,13.690600>}
box{<0,0,-0.127000><0.080322,0.035000,0.127000> rotate<0,18.433732,0> translate<42.545000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.621200,0.000000,13.690600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.672000,0.000000,13.716000>}
box{<0,0,-0.127000><0.056796,0.035000,0.127000> rotate<0,-26.563298,0> translate<42.621200,0.000000,13.690600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.481000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.053000,0.000000,44.323000>}
box{<0,0,-0.127000><6.465784,0.035000,0.127000> rotate<0,-44.997030,0> translate<38.481000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,0.000000,2.540000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.195000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,0.000000,22.860000>}
box{<0,0,-0.127000><9.878282,0.035000,0.127000> rotate<0,-44.997030,0> translate<36.195000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<43.180000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.116000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,0.000000,39.370000>}
box{<0,0,-0.127000><5.747364,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.116000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.401000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,41.910000>}
box{<0,0,-0.127000><9.779000,0.035000,0.127000> rotate<0,0.000000,0> translate<33.401000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.434000,0.000000,25.654000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<34.544000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.781000,-1.535000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.815000,-1.535000,10.414000>}
box{<0,0,-0.127000><18.034000,0.035000,0.127000> rotate<0,0.000000,0> translate<25.781000,-1.535000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.069000,-1.535000,41.910000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,0.000000,0> translate<43.180000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.577000,-1.535000,34.544000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<43.180000,-1.535000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.577000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.577000,-1.535000,34.544000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<44.577000,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.545000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.085000,-1.535000,15.240000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<42.545000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.069000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.212000,-1.535000,43.053000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<44.069000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,0.000000,24.765000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<44.450000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.847000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<45.720000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.577000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.847000,-1.535000,25.273000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<44.577000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.847000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.847000,-1.535000,25.273000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<45.847000,-1.535000,25.273000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.736000,0.000000,23.749000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<45.720000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,1.270000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<34.290000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.291000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.117000,-1.535000,12.446000>}
box{<0,0,-0.127000><6.824995,0.035000,0.127000> rotate<0,44.997030,0> translate<42.291000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.496000,0.000000,45.847000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.371000,0.000000,45.847000>}
box{<0,0,-0.127000><15.875000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.496000,0.000000,45.847000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.815000,-1.535000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.752000,-1.535000,6.477000>}
box{<0,0,-0.127000><5.567759,0.035000,0.127000> rotate<0,44.997030,0> translate<43.815000,-1.535000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.434000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.879000,0.000000,30.099000>}
box{<0,0,-0.127000><6.286179,0.035000,0.127000> rotate<0,-44.997030,0> translate<43.434000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,2.540000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<46.990000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.621200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,3.530600>}
box{<0,0,-0.127000><7.974467,0.035000,0.127000> rotate<0,44.997030,0> translate<42.621200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,3.530600>}
box{<0,0,-0.127000><0.990600,0.035000,0.127000> rotate<0,90.000000,0> translate<48.260000,-1.535000,3.530600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,23.738000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<48.514000,0.000000,23.738000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.736000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,23.749000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,0.000000,0> translate<46.736000,0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,25.538000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,25.654000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,90.000000,0> translate<48.514000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,41.910000>}
box{<0,0,-0.127000><2.794000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.720000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.662000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.179000>}
box{<0,0,-0.127000><0.127475,0.035000,0.127000> rotate<0,85.044115,0> translate<50.662000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.662000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.306000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.662000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.306000>}
box{<0,0,-0.127000><0.381000,0.035000,0.127000> rotate<0,-90.000000,0> translate<50.673000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.513000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.687000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.513000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.662000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.687000>}
box{<0,0,-0.127000><0.381159,0.035000,0.127000> rotate<0,-88.340420,0> translate<50.662000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.662000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,38.100000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.662000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,38.100000>}
box{<0,0,-0.127000><2.413000,0.035000,0.127000> rotate<0,90.000000,0> translate<50.673000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.418000,-1.535000,16.383000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,8.001000>}
box{<0,0,-0.127000><11.853938,0.035000,0.127000> rotate<0,44.997030,0> translate<42.418000,-1.535000,16.383000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.673000,0.000000,35.179000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.927000,0.000000,35.179000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.673000,0.000000,35.179000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.498500,0.000000,38.925500>}
box{<0,0,-0.127000><4.220720,0.035000,0.127000> rotate<0,44.997030,0> translate<48.514000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.498500,0.000000,38.925500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.562000,0.000000,38.862000>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,44.997030,0> translate<51.498500,0.000000,38.925500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.562000,0.000000,37.338000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.562000,0.000000,38.862000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,90.000000,0> translate<51.562000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,45.339000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.943000,0.000000,45.339000>}
box{<0,0,-0.127000><15.113000,0.035000,0.127000> rotate<0,0.000000,0> translate<36.830000,0.000000,45.339000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.371000,0.000000,45.847000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.324000,0.000000,50.800000>}
box{<0,0,-0.127000><7.004600,0.035000,0.127000> rotate<0,-44.997030,0> translate<47.371000,0.000000,45.847000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.562000,0.000000,37.338000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.451000,0.000000,36.449000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,44.997030,0> translate<51.562000,0.000000,37.338000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.451000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.451000,0.000000,36.449000>}
box{<0,0,-0.127000><1.143000,0.035000,0.127000> rotate<0,90.000000,0> translate<52.451000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.451000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.462000,0.000000,35.306000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<52.451000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.927000,0.000000,35.179000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.959000,0.000000,33.147000>}
box{<0,0,-0.127000><2.873682,0.035000,0.127000> rotate<0,44.997030,0> translate<50.927000,0.000000,35.179000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,46.990000>}
box{<0,0,-0.127000><21.590000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.324000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,0.000000,50.800000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<52.324000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.462000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,38.100000>}
box{<0,0,-0.127000><3.418000,0.035000,0.127000> rotate<0,0.000000,0> translate<52.462000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,49.530000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<53.340000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,50.800000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<55.880000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.212000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.007000,-1.535000,43.053000>}
box{<0,0,-0.127000><10.795000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.212000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.007000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.070500,-1.535000,42.989500>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,44.997030,0> translate<56.007000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.070500,-1.535000,42.989500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.134000,-1.535000,43.053000>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,-44.997030,0> translate<56.070500,-1.535000,42.989500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.498500,0.000000,38.925500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.134000,0.000000,43.561000>}
box{<0,0,-0.127000><6.555587,0.035000,0.127000> rotate<0,-44.997030,0> translate<51.498500,0.000000,38.925500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.672000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.388000,0.000000,13.716000>}
box{<0,0,-0.127000><13.716000,0.035000,0.127000> rotate<0,0.000000,0> translate<42.672000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.388000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.438800,0.000000,13.690600>}
box{<0,0,-0.127000><0.056796,0.035000,0.127000> rotate<0,26.563298,0> translate<56.388000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.438800,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.515000,0.000000,9.271000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,-53.126596,0> translate<56.438800,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.438800,0.000000,13.690600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.515000,0.000000,13.716000>}
box{<0,0,-0.127000><0.080322,0.035000,0.127000> rotate<0,-18.433732,0> translate<56.438800,0.000000,13.690600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.438800,0.000000,13.690600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,0.000000,13.716000>}
box{<0,0,-0.127000><0.711653,0.035000,0.127000> rotate<0,-2.045273,0> translate<56.438800,0.000000,13.690600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.515000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,0.000000,13.716000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,0.000000,0> translate<56.515000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,0.000000,22.860000>}
box{<0,0,-0.127000><9.144000,0.035000,0.127000> rotate<0,90.000000,0> translate<57.150000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<57.150000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,0.000000,39.370000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<55.880000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.070500,-1.535000,42.989500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,41.910000>}
box{<0,0,-0.127000><1.526644,0.035000,0.127000> rotate<0,44.997030,0> translate<56.070500,-1.535000,42.989500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.514000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.404000,0.000000,25.654000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<48.514000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.943000,0.000000,45.339000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.404000,0.000000,50.800000>}
box{<0,0,-0.127000><7.723020,0.035000,0.127000> rotate<0,-44.997030,0> translate<51.943000,0.000000,45.339000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.293000,0.000000,40.513000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<57.150000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.293000,0.000000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.293000,0.000000,42.164000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,90.000000,0> translate<58.293000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.404000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,0.000000,50.800000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<57.404000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.547000,-1.535000,34.544000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<57.150000,-1.535000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.547000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.547000,-1.535000,34.544000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<58.547000,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.291000,0.000000,44.831000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.055000,0.000000,44.831000>}
box{<0,0,-0.127000><16.764000,0.035000,0.127000> rotate<0,0.000000,0> translate<42.291000,0.000000,44.831000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.293000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.182000,0.000000,43.053000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,-44.997030,0> translate<58.293000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,0.000000,24.765000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<58.420000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.817000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<59.690000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.547000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.817000,-1.535000,25.273000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<58.547000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.817000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.817000,-1.535000,25.273000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<59.817000,-1.535000,25.273000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.134000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,-1.535000,43.053000>}
box{<0,0,-0.127000><4.064000,0.035000,0.127000> rotate<0,0.000000,0> translate<56.134000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.706000,0.000000,23.749000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<59.690000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.833000,-1.535000,40.767000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<59.690000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.404000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.087000,0.000000,29.337000>}
box{<0,0,-0.127000><5.208549,0.035000,0.127000> rotate<0,-44.997030,0> translate<57.404000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.341000,-1.535000,41.910000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<60.198000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.976000,0.000000,13.716000>}
box{<0,0,-0.127000><4.826000,0.035000,0.127000> rotate<0,0.000000,0> translate<57.150000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.484000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.484000,0.000000,23.738000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<62.484000,0.000000,23.738000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.706000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.484000,0.000000,23.749000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,0.000000,0> translate<60.706000,0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.484000,0.000000,25.538000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.484000,0.000000,25.654000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,90.000000,0> translate<62.484000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.515000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.865000,0.000000,9.271000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<56.515000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.976000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.865000,0.000000,13.716000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,0.000000,0> translate<61.976000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.865000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.941200,0.000000,9.169400>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,53.126596,0> translate<62.865000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.976000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.941200,0.000000,13.690600>}
box{<0,0,-0.127000><0.965534,0.035000,0.127000> rotate<0,1.507336,0> translate<61.976000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.865000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.941200,0.000000,13.690600>}
box{<0,0,-0.127000><0.080322,0.035000,0.127000> rotate<0,18.433732,0> translate<62.865000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.941200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.992000,0.000000,9.271000>}
box{<0,0,-0.127000><0.113592,0.035000,0.127000> rotate<0,-63.430762,0> translate<62.941200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,0.000000,38.100000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<59.690000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.053000,0.000000,44.323000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.627000,0.000000,44.323000>}
box{<0,0,-0.127000><20.574000,0.035000,0.127000> rotate<0,0.000000,0> translate<43.053000,0.000000,44.323000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.992000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.389000,0.000000,10.668000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<62.992000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.959000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.389000,0.000000,33.147000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,0.000000,0> translate<52.959000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.632000,0.000000,38.100000>}
box{<0,0,-0.127000><1.132000,0.035000,0.127000> rotate<0,0.000000,0> translate<63.500000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.632000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,0.000000,35.306000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.632000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,0.000000,35.941000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,90.000000,0> translate<64.643000,0.000000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.532000,0.000000,36.830000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.643000,0.000000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.055000,0.000000,44.831000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.167000,0.000000,51.943000>}
box{<0,0,-0.127000><10.057887,0.035000,0.127000> rotate<0,-44.997030,0> translate<59.055000,0.000000,44.831000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.389000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,10.668000>}
box{<0,0,-0.127000><1.905000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.389000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,10.784000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,90.000000,0> translate<66.294000,0.000000,10.784000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,12.573000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,12.584000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,90.000000,0> translate<66.294000,0.000000,12.584000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.389000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.179000>}
box{<0,0,-0.127000><2.873682,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.389000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.687000>}
box{<0,0,-0.127000><0.381000,0.035000,0.127000> rotate<0,90.000000,0> translate<66.421000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,38.100000>}
box{<0,0,-0.127000><2.413000,0.035000,0.127000> rotate<0,90.000000,0> translate<66.421000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.179000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.432000,0.000000,35.306000>}
box{<0,0,-0.127000><0.127475,0.035000,0.127000> rotate<0,-85.044115,0> translate<66.421000,0.000000,35.179000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.432000,0.000000,35.306000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.421000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.432000,0.000000,35.306000>}
box{<0,0,-0.127000><0.381159,0.035000,0.127000> rotate<0,88.340420,0> translate<66.421000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.432000,0.000000,38.100000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.421000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.134000,0.000000,43.561000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.945000,0.000000,43.561000>}
box{<0,0,-0.127000><11.811000,0.035000,0.127000> rotate<0,0.000000,0> translate<56.134000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.532000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,36.830000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,0.000000,0> translate<65.532000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.961000,0.000000,8.001000>}
box{<0,0,-0.127000><3.771708,0.035000,0.127000> rotate<0,44.997030,0> translate<66.294000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.977000,0.000000,39.878000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.977000,0.000000,38.862000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,-90.000000,0> translate<69.977000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.627000,0.000000,44.323000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.104000,0.000000,50.800000>}
box{<0,0,-0.127000><9.159861,0.035000,0.127000> rotate<0,-44.997030,0> translate<63.627000,0.000000,44.323000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.976000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.612000,0.000000,22.352000>}
box{<0,0,-0.127000><12.213148,0.035000,0.127000> rotate<0,-44.997030,0> translate<61.976000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.977000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.612000,0.000000,38.227000>}
box{<0,0,-0.127000><0.898026,0.035000,0.127000> rotate<0,44.997030,0> translate<69.977000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.977000,0.000000,39.878000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.866000,0.000000,40.767000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,-44.997030,0> translate<69.977000,0.000000,39.878000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.612000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,0.000000,22.860000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,-44.997030,0> translate<70.612000,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<71.120000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,39.370000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<68.580000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.341000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,41.910000>}
box{<0,0,-0.127000><9.779000,0.035000,0.127000> rotate<0,0.000000,0> translate<61.341000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.104000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,0.000000,50.800000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<70.104000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.484000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.374000,0.000000,25.654000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<62.484000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.882000,0.000000,39.370000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,0.000000,0> translate<71.120000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.263000,-1.535000,43.053000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<71.120000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,-1.535000,34.544000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<71.120000,-1.535000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,-1.535000,34.544000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<72.517000,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.866000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,0.000000,40.767000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,0.000000,0> translate<70.866000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.182000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,0.000000,43.053000>}
box{<0,0,-0.127000><13.335000,0.035000,0.127000> rotate<0,0.000000,0> translate<59.182000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.882000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,0.000000,40.513000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<71.882000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,0.000000,24.765000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.390000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.374000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,0.000000,27.940000>}
box{<0,0,-0.127000><3.232892,0.035000,0.127000> rotate<0,-44.997030,0> translate<71.374000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,0.000000,41.910000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.517000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.787000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<73.660000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.787000,-1.535000,25.273000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<72.517000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.787000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.787000,-1.535000,25.273000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.787000,-1.535000,25.273000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,0.000000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.914000,0.000000,40.513000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.025000,0.000000,40.513000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.612000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,0.000000,38.227000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,0.000000,0> translate<70.612000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.263000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,-1.535000,43.053000>}
box{<0,0,-0.127000><1.905000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.263000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,0.000000,23.749000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<73.660000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.945000,0.000000,43.561000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.184000,0.000000,50.800000>}
box{<0,0,-0.127000><10.237492,0.035000,0.127000> rotate<0,-44.997030,0> translate<67.945000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.311000,-1.535000,41.910000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<74.168000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,0.000000,23.738000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<76.200000,0.000000,23.738000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,0.000000,23.749000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.676000,0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,0.000000,25.538000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,0.000000,25.654000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,90.000000,0> translate<76.200000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.184000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,0.000000,50.800000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<75.184000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.581000,0.000000,40.640000>}
box{<0,0,-0.127000><3.412497,0.035000,0.127000> rotate<0,-44.997030,0> translate<74.168000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.167000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.581000,0.000000,51.943000>}
box{<0,0,-0.127000><10.414000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.167000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.581000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.724000,0.000000,50.800000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<76.581000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,12.573000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.978000,0.000000,12.573000>}
box{<0,0,-0.127000><11.684000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.294000,0.000000,12.573000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.978000,0.000000,12.573000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.105000,0.000000,12.446000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,44.997030,0> translate<77.978000,0.000000,12.573000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.348000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,34.036000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<78.348000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,34.036000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,-90.000000,0> translate<78.359000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,35.687000>}
box{<0,0,-0.127000><11.938000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.421000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.348000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,36.830000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<78.348000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,36.830000>}
box{<0,0,-0.127000><1.143000,0.035000,0.127000> rotate<0,90.000000,0> translate<78.359000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,38.354000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,90.000000,0> translate<78.359000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.348000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,39.624000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<78.348000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,39.624000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<78.359000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.724000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,0.000000,50.800000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<77.724000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.581000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.121000,0.000000,40.640000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<76.581000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.612000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.248000,0.000000,13.716000>}
box{<0,0,-0.127000><12.213148,0.035000,0.127000> rotate<0,44.997030,0> translate<70.612000,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.248000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.298800,0.000000,13.690600>}
box{<0,0,-0.127000><0.056796,0.035000,0.127000> rotate<0,26.563298,0> translate<79.248000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.298800,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.375000,0.000000,9.271000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,-53.126596,0> translate<79.298800,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.298800,0.000000,13.690600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.375000,0.000000,13.716000>}
box{<0,0,-0.127000><0.080322,0.035000,0.127000> rotate<0,-18.433732,0> translate<79.298800,0.000000,13.690600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.121000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.137000,0.000000,39.624000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<79.121000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.137000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.148000,0.000000,39.624000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,0.000000,0> translate<80.137000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.137000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.148000,0.000000,39.624000>}
box{<0,0,-0.127000><0.127475,0.035000,0.127000> rotate<0,85.044115,0> translate<80.137000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.517000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.264000,0.000000,50.800000>}
box{<0,0,-0.127000><10.955912,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.517000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.148000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.645000,0.000000,34.036000>}
box{<0,0,-0.127000><0.497000,0.035000,0.127000> rotate<0,0.000000,0> translate<80.148000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.772000,0.000000,38.354000>}
box{<0,0,-0.127000><2.413000,0.035000,0.127000> rotate<0,0.000000,0> translate<78.359000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.264000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.280000,0.000000,50.800000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<80.264000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.772000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.534000,0.000000,39.116000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,-44.997030,0> translate<80.772000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.534000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.534000,0.000000,40.005000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<81.534000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.148000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.550000,0.000000,36.830000>}
box{<0,0,-0.127000><2.402000,0.035000,0.127000> rotate<0,0.000000,0> translate<80.148000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.914000,0.000000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<83.820000,0.000000,50.419000>}
box{<0,0,-0.127000><14.009200,0.035000,0.127000> rotate<0,-44.997030,0> translate<73.914000,0.000000,40.513000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<83.820000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<83.820000,0.000000,50.800000>}
box{<0,0,-0.127000><0.381000,0.035000,0.127000> rotate<0,90.000000,0> translate<83.820000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.534000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.582000,0.000000,43.053000>}
box{<0,0,-0.127000><4.310523,0.035000,0.127000> rotate<0,-44.997030,0> translate<81.534000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.582000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.709000,0.000000,43.053000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,0.000000,0> translate<84.582000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.137000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.709000,0.000000,44.323000>}
box{<0,0,-0.127000><6.465784,0.035000,0.127000> rotate<0,-44.997030,0> translate<80.137000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.645000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.836000,0.000000,38.227000>}
box{<0,0,-0.127000><5.926969,0.035000,0.127000> rotate<0,-44.997030,0> translate<80.645000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.117000,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.963000,-1.535000,12.446000>}
box{<0,0,-0.127000><37.846000,0.035000,0.127000> rotate<0,0.000000,0> translate<47.117000,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.375000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,13.716000>}
box{<0,0,-0.127000><5.715000,0.035000,0.127000> rotate<0,0.000000,0> translate<79.375000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,22.860000>}
box{<0,0,-0.127000><9.144000,0.035000,0.127000> rotate<0,90.000000,0> translate<85.090000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<85.090000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.550000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,39.370000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<82.550000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,40.132000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,90.000000,0> translate<85.090000,0.000000,40.132000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.311000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,41.910000>}
box{<0,0,-0.127000><9.779000,0.035000,0.127000> rotate<0,0.000000,0> translate<75.311000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.217000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.217000,0.000000,51.181000>}
box{<0,0,-0.127000><6.096000,0.035000,0.127000> rotate<0,90.000000,0> translate<85.217000,0.000000,51.181000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.344000,0.000000,25.654000>}
box{<0,0,-0.127000><9.144000,0.035000,0.127000> rotate<0,0.000000,0> translate<76.200000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.836000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.598000,0.000000,38.227000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,0.000000,0> translate<84.836000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.709000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.598000,0.000000,43.942000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,-44.997030,0> translate<84.709000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.217000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.598000,0.000000,44.704000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,44.997030,0> translate<85.217000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.598000,0.000000,43.942000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.598000,0.000000,44.704000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,90.000000,0> translate<85.598000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.375000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.725000,0.000000,9.271000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<79.375000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.725000,0.000000,13.716000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,0.000000,0> translate<85.090000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.725000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.801200,0.000000,9.169400>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,53.126596,0> translate<85.725000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.801200,0.000000,13.690600>}
box{<0,0,-0.127000><0.711653,0.035000,0.127000> rotate<0,2.045273,0> translate<85.090000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.725000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.801200,0.000000,13.690600>}
box{<0,0,-0.127000><0.080322,0.035000,0.127000> rotate<0,18.433732,0> translate<85.725000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.801200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.852000,0.000000,9.271000>}
box{<0,0,-0.127000><0.113592,0.035000,0.127000> rotate<0,-63.430762,0> translate<85.801200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.217000,0.000000,51.181000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.979000,0.000000,51.943000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,-44.997030,0> translate<85.217000,0.000000,51.181000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,0.000000,40.132000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,0.000000,41.402000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<85.090000,0.000000,40.132000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,0.000000,41.402000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,0.000000,50.800000>}
box{<0,0,-0.127000><9.398000,0.035000,0.127000> rotate<0,90.000000,0> translate<86.360000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.344000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,0.000000,26.797000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<85.344000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,35.941000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,-1.535000,34.544000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<85.090000,-1.535000,35.941000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,-1.535000,34.544000>}
box{<0,0,-0.127000><8.001000,0.035000,0.127000> rotate<0,90.000000,0> translate<86.487000,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.598000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,0.000000,39.116000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,-44.997030,0> translate<85.598000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,0.000000,40.767000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,90.000000,0> translate<86.487000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.979000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.741000,0.000000,51.943000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,0.000000,0> translate<85.979000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.122000,-1.535000,8.001000>}
box{<0,0,-0.127000><36.322000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.800000,-1.535000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.963000,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.249000,-1.535000,10.160000>}
box{<0,0,-0.127000><3.232892,0.035000,0.127000> rotate<0,44.997030,0> translate<84.963000,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.852000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.249000,0.000000,10.668000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<85.852000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.630000,0.000000,24.765000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<86.360000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.630000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.630000,0.000000,41.783000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,-90.000000,0> translate<87.630000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.630000,0.000000,41.910000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<86.487000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.961000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.757000,0.000000,8.001000>}
box{<0,0,-0.127000><18.796000,0.035000,0.127000> rotate<0,0.000000,0> translate<68.961000,0.000000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.630000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.757000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<87.630000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.757000,-1.535000,25.273000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<86.487000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.757000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.757000,-1.535000,25.273000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<87.757000,-1.535000,25.273000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.122000,-1.535000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.884000,-1.535000,8.763000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,-44.997030,0> translate<87.122000,-1.535000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.741000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.884000,0.000000,50.800000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<86.741000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.833000,-1.535000,40.767000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.138000,-1.535000,40.767000>}
box{<0,0,-0.127000><27.305000,0.035000,0.127000> rotate<0,0.000000,0> translate<60.833000,-1.535000,40.767000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.630000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.646000,0.000000,23.749000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<87.630000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.105000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.773000,0.000000,12.446000>}
box{<0,0,-0.127000><10.668000,0.035000,0.127000> rotate<0,0.000000,0> translate<78.105000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.249000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,10.668000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,0.000000,0> translate<87.249000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,10.784000>}
box{<0,0,-0.127000><0.116000,0.035000,0.127000> rotate<0,90.000000,0> translate<88.900000,0.000000,10.784000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,10.784000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,10.795000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,90.000000,0> translate<88.900000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.773000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,12.573000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<88.773000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,12.584000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,12.573000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<88.900000,0.000000,12.573000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,12.584000>}
box{<0,0,-0.127000><6.720000,0.035000,0.127000> rotate<0,-90.000000,0> translate<88.900000,0.000000,12.584000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.335000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,-1.535000,19.685000>}
box{<0,0,-0.127000><75.565000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.335000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.138000,-1.535000,40.767000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<89.154000,-1.535000,41.783000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<88.138000,-1.535000,40.767000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<89.916000,0.000000,11.811000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<88.900000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<89.916000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<89.916000,0.000000,12.700000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<89.916000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<90.170000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<90.170000,0.000000,23.738000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<90.170000,0.000000,23.738000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.646000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<90.170000,0.000000,23.749000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,0.000000,0> translate<88.646000,0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<90.170000,0.000000,25.538000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<90.170000,0.000000,25.527000>}
box{<0,0,-0.127000><0.011000,0.035000,0.127000> rotate<0,-90.000000,0> translate<90.170000,0.000000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.417000,0.000000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<92.583000,0.000000,30.607000>}
box{<0,0,-0.127000><58.166000,0.035000,0.127000> rotate<0,0.000000,0> translate<34.417000,0.000000,30.607000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.218000,-1.535000,24.003000>}
box{<0,0,-0.127000><6.106574,0.035000,0.127000> rotate<0,-44.997030,0> translate<88.900000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.757000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.599000,0.000000,13.843000>}
box{<0,0,-0.127000><8.261836,0.035000,0.127000> rotate<0,-44.997030,0> translate<87.757000,0.000000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.879000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.599000,0.000000,30.099000>}
box{<0,0,-0.127000><45.720000,0.035000,0.127000> rotate<0,0.000000,0> translate<47.879000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<88.900000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.853000,0.000000,24.257000>}
box{<0,0,-0.127000><7.004600,0.035000,0.127000> rotate<0,-44.997030,0> translate<88.900000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<90.170000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.853000,0.000000,25.527000>}
box{<0,0,-0.127000><3.683000,0.035000,0.127000> rotate<0,0.000000,0> translate<90.170000,0.000000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<92.583000,0.000000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.853000,0.000000,31.877000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<92.583000,0.000000,30.607000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.249000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,-1.535000,10.160000>}
box{<0,0,-0.127000><6.731000,0.035000,0.127000> rotate<0,0.000000,0> translate<87.249000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,-1.535000,12.700000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,-90.000000,0> translate<93.980000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.085000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,-1.535000,15.240000>}
box{<0,0,-0.127000><48.895000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.085000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<89.916000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,16.764000>}
box{<0,0,-0.127000><5.747364,0.035000,0.127000> rotate<0,-44.997030,0> translate<89.916000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,17.780000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<93.980000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.853000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,25.400000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,44.997030,0> translate<93.853000,0.000000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,27.940000>}
box{<0,0,-0.127000><20.320000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.660000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.599000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,30.480000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,-44.997030,0> translate<93.599000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.884000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,50.800000>}
box{<0,0,-0.127000><6.096000,0.035000,0.127000> rotate<0,0.000000,0> translate<87.884000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.884000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.107000,-1.535000,8.763000>}
box{<0,0,-0.127000><6.223000,0.035000,0.127000> rotate<0,0.000000,0> translate<87.884000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.599000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.107000,0.000000,13.843000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,0.000000,0> translate<93.599000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.218000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.107000,-1.535000,24.003000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,0.000000,0> translate<93.218000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.361000,-1.535000,18.923000>}
box{<0,0,-0.127000><79.121000,0.035000,0.127000> rotate<0,0.000000,0> translate<15.240000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<87.630000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.361000,0.000000,41.783000>}
box{<0,0,-0.127000><6.731000,0.035000,0.127000> rotate<0,0.000000,0> translate<87.630000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.709000,-1.535000,44.323000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.361000,-1.535000,44.323000>}
box{<0,0,-0.127000><9.652000,0.035000,0.127000> rotate<0,0.000000,0> translate<84.709000,-1.535000,44.323000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.107000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,9.779000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<94.107000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,10.287000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,90.000000,0> translate<95.123000,-1.535000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,14.859000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<93.980000,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.107000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,0.000000,14.859000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<94.107000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,14.859000>}
box{<0,0,-0.127000><3.302000,0.035000,0.127000> rotate<0,-90.000000,0> translate<95.123000,-1.535000,14.859000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,0.000000,17.907000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,90.000000,0> translate<95.123000,0.000000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.361000,-1.535000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,18.161000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,44.997030,0> translate<94.361000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.487000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.377000,0.000000,26.797000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<86.487000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.087000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.377000,0.000000,29.337000>}
box{<0,0,-0.127000><34.290000,0.035000,0.127000> rotate<0,0.000000,0> translate<61.087000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.853000,0.000000,31.877000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.377000,0.000000,31.877000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,0.000000,0> translate<93.853000,0.000000,31.877000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.107000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.504000,-1.535000,25.400000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<94.107000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.361000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.504000,0.000000,40.640000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<94.361000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<94.361000,-1.535000,44.323000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.504000,-1.535000,43.180000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<94.361000,-1.535000,44.323000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,-1.535000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,11.684000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<95.123000,-1.535000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,12.700000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<96.520000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,15.240000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<96.520000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.123000,0.000000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,19.304000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<95.123000,0.000000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,20.320000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<96.520000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.504000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,25.400000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<95.504000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.377000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,27.940000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<95.377000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.377000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,30.480000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<95.377000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.377000,0.000000,31.877000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,33.020000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<95.377000,0.000000,31.877000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.504000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,40.640000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<95.504000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<95.504000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,43.180000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<95.504000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,48.260000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<96.520000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.980000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,50.800000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<93.980000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<89.154000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.647000,-1.535000,41.783000>}
box{<0,0,-0.127000><7.493000,0.035000,0.127000> rotate<0,0.000000,0> translate<89.154000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.752000,-1.535000,6.477000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.901000,-1.535000,6.477000>}
box{<0,0,-0.127000><49.149000,0.035000,0.127000> rotate<0,0.000000,0> translate<47.752000,-1.535000,6.477000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<93.853000,0.000000,24.257000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.901000,0.000000,24.257000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,0.000000,0> translate<93.853000,0.000000,24.257000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.901000,-1.535000,6.477000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,7.239000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,-44.997030,0> translate<96.901000,-1.535000,6.477000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,13.081000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<96.520000,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,7.239000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,13.081000>}
box{<0,0,-0.127000><5.842000,0.035000,0.127000> rotate<0,90.000000,0> translate<97.663000,-1.535000,13.081000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.901000,0.000000,24.257000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,0.000000,25.019000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,-44.997030,0> translate<96.901000,0.000000,24.257000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,0.000000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,0.000000,25.019000>}
box{<0,0,-0.127000><24.638000,0.035000,0.127000> rotate<0,-90.000000,0> translate<97.663000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.647000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,42.799000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<96.647000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,46.101000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<96.520000,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,42.799000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,-1.535000,46.101000>}
box{<0,0,-0.127000><3.302000,0.035000,0.127000> rotate<0,90.000000,0> translate<97.663000,-1.535000,46.101000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<96.520000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<97.663000,0.000000,49.657000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,44.997030,0> translate<96.520000,0.000000,50.800000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,0.000000,0.000000>}
box{<0,0,-0.203200><101.600000,0.035000,0.203200> rotate<0,0.000000,0> translate<0.000000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,-1.535000,0.000000>}
box{<0,0,-0.203200><101.600000,0.035000,0.203200> rotate<0,0.000000,0> translate<0.000000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,0.000000,0.000000>}
box{<0,0,-0.203200><53.340000,0.035000,0.203200> rotate<0,-90.000000,0> translate<0.000000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,0.000000>}
box{<0,0,-0.203200><53.340000,0.035000,0.203200> rotate<0,-90.000000,0> translate<0.000000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,0.000000,53.340000>}
box{<0,0,-0.203200><101.600000,0.035000,0.203200> rotate<0,0.000000,0> translate<0.000000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,-1.535000,53.340000>}
box{<0,0,-0.203200><101.600000,0.035000,0.203200> rotate<0,0.000000,0> translate<0.000000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,0.000000,53.340000>}
box{<0,0,-0.203200><53.340000,0.035000,0.203200> rotate<0,90.000000,0> translate<101.600000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,-1.535000,53.340000>}
box{<0,0,-0.203200><53.340000,0.035000,0.203200> rotate<0,90.000000,0> translate<101.600000,-1.535000,53.340000> }
texture{col_pol}
}
#end
union{
cylinder{<15.240000,0.038000,41.910000><15.240000,-1.538000,41.910000>0.457200}
cylinder{<17.780000,0.038000,41.910000><17.780000,-1.538000,41.910000>0.457200}
cylinder{<15.240000,0.038000,39.370000><15.240000,-1.538000,39.370000>0.457200}
cylinder{<17.780000,0.038000,39.370000><17.780000,-1.538000,39.370000>0.457200}
cylinder{<15.240000,0.038000,36.830000><15.240000,-1.538000,36.830000>0.457200}
cylinder{<17.780000,0.038000,36.830000><17.780000,-1.538000,36.830000>0.457200}
cylinder{<15.240000,0.038000,34.290000><15.240000,-1.538000,34.290000>0.457200}
cylinder{<17.780000,0.038000,34.290000><17.780000,-1.538000,34.290000>0.457200}
cylinder{<15.240000,0.038000,31.750000><15.240000,-1.538000,31.750000>0.457200}
cylinder{<17.780000,0.038000,31.750000><17.780000,-1.538000,31.750000>0.457200}
cylinder{<29.210000,0.038000,41.910000><29.210000,-1.538000,41.910000>0.457200}
cylinder{<31.750000,0.038000,41.910000><31.750000,-1.538000,41.910000>0.457200}
cylinder{<29.210000,0.038000,39.370000><29.210000,-1.538000,39.370000>0.457200}
cylinder{<31.750000,0.038000,39.370000><31.750000,-1.538000,39.370000>0.457200}
cylinder{<29.210000,0.038000,36.830000><29.210000,-1.538000,36.830000>0.457200}
cylinder{<31.750000,0.038000,36.830000><31.750000,-1.538000,36.830000>0.457200}
cylinder{<29.210000,0.038000,34.290000><29.210000,-1.538000,34.290000>0.457200}
cylinder{<31.750000,0.038000,34.290000><31.750000,-1.538000,34.290000>0.457200}
cylinder{<29.210000,0.038000,31.750000><29.210000,-1.538000,31.750000>0.457200}
cylinder{<31.750000,0.038000,31.750000><31.750000,-1.538000,31.750000>0.457200}
cylinder{<43.180000,0.038000,41.910000><43.180000,-1.538000,41.910000>0.457200}
cylinder{<45.720000,0.038000,41.910000><45.720000,-1.538000,41.910000>0.457200}
cylinder{<43.180000,0.038000,39.370000><43.180000,-1.538000,39.370000>0.457200}
cylinder{<45.720000,0.038000,39.370000><45.720000,-1.538000,39.370000>0.457200}
cylinder{<43.180000,0.038000,36.830000><43.180000,-1.538000,36.830000>0.457200}
cylinder{<45.720000,0.038000,36.830000><45.720000,-1.538000,36.830000>0.457200}
cylinder{<43.180000,0.038000,34.290000><43.180000,-1.538000,34.290000>0.457200}
cylinder{<45.720000,0.038000,34.290000><45.720000,-1.538000,34.290000>0.457200}
cylinder{<43.180000,0.038000,31.750000><43.180000,-1.538000,31.750000>0.457200}
cylinder{<45.720000,0.038000,31.750000><45.720000,-1.538000,31.750000>0.457200}
cylinder{<57.150000,0.038000,41.910000><57.150000,-1.538000,41.910000>0.457200}
cylinder{<59.690000,0.038000,41.910000><59.690000,-1.538000,41.910000>0.457200}
cylinder{<57.150000,0.038000,39.370000><57.150000,-1.538000,39.370000>0.457200}
cylinder{<59.690000,0.038000,39.370000><59.690000,-1.538000,39.370000>0.457200}
cylinder{<57.150000,0.038000,36.830000><57.150000,-1.538000,36.830000>0.457200}
cylinder{<59.690000,0.038000,36.830000><59.690000,-1.538000,36.830000>0.457200}
cylinder{<57.150000,0.038000,34.290000><57.150000,-1.538000,34.290000>0.457200}
cylinder{<59.690000,0.038000,34.290000><59.690000,-1.538000,34.290000>0.457200}
cylinder{<57.150000,0.038000,31.750000><57.150000,-1.538000,31.750000>0.457200}
cylinder{<59.690000,0.038000,31.750000><59.690000,-1.538000,31.750000>0.457200}
cylinder{<71.120000,0.038000,41.910000><71.120000,-1.538000,41.910000>0.457200}
cylinder{<73.660000,0.038000,41.910000><73.660000,-1.538000,41.910000>0.457200}
cylinder{<71.120000,0.038000,39.370000><71.120000,-1.538000,39.370000>0.457200}
cylinder{<73.660000,0.038000,39.370000><73.660000,-1.538000,39.370000>0.457200}
cylinder{<71.120000,0.038000,36.830000><71.120000,-1.538000,36.830000>0.457200}
cylinder{<73.660000,0.038000,36.830000><73.660000,-1.538000,36.830000>0.457200}
cylinder{<71.120000,0.038000,34.290000><71.120000,-1.538000,34.290000>0.457200}
cylinder{<73.660000,0.038000,34.290000><73.660000,-1.538000,34.290000>0.457200}
cylinder{<71.120000,0.038000,31.750000><71.120000,-1.538000,31.750000>0.457200}
cylinder{<73.660000,0.038000,31.750000><73.660000,-1.538000,31.750000>0.457200}
cylinder{<85.090000,0.038000,41.910000><85.090000,-1.538000,41.910000>0.457200}
cylinder{<87.630000,0.038000,41.910000><87.630000,-1.538000,41.910000>0.457200}
cylinder{<85.090000,0.038000,39.370000><85.090000,-1.538000,39.370000>0.457200}
cylinder{<87.630000,0.038000,39.370000><87.630000,-1.538000,39.370000>0.457200}
cylinder{<85.090000,0.038000,36.830000><85.090000,-1.538000,36.830000>0.457200}
cylinder{<87.630000,0.038000,36.830000><87.630000,-1.538000,36.830000>0.457200}
cylinder{<85.090000,0.038000,34.290000><85.090000,-1.538000,34.290000>0.457200}
cylinder{<87.630000,0.038000,34.290000><87.630000,-1.538000,34.290000>0.457200}
cylinder{<85.090000,0.038000,31.750000><85.090000,-1.538000,31.750000>0.457200}
cylinder{<87.630000,0.038000,31.750000><87.630000,-1.538000,31.750000>0.457200}
cylinder{<56.438800,0.038000,13.690600><56.438800,-1.538000,13.690600>0.508000}
cylinder{<62.941200,0.038000,13.690600><62.941200,-1.538000,13.690600>0.508000}
cylinder{<56.438800,0.038000,9.169400><56.438800,-1.538000,9.169400>0.508000}
cylinder{<62.941200,0.038000,9.169400><62.941200,-1.538000,9.169400>0.508000}
cylinder{<15.240000,0.038000,22.860000><15.240000,-1.538000,22.860000>0.406400}
cylinder{<16.510000,0.038000,24.765000><16.510000,-1.538000,24.765000>0.406400}
cylinder{<17.780000,0.038000,22.860000><17.780000,-1.538000,22.860000>0.406400}
cylinder{<29.210000,0.038000,22.860000><29.210000,-1.538000,22.860000>0.406400}
cylinder{<30.480000,0.038000,24.765000><30.480000,-1.538000,24.765000>0.406400}
cylinder{<31.750000,0.038000,22.860000><31.750000,-1.538000,22.860000>0.406400}
cylinder{<43.180000,0.038000,22.860000><43.180000,-1.538000,22.860000>0.406400}
cylinder{<44.450000,0.038000,24.765000><44.450000,-1.538000,24.765000>0.406400}
cylinder{<45.720000,0.038000,22.860000><45.720000,-1.538000,22.860000>0.406400}
cylinder{<57.150000,0.038000,22.860000><57.150000,-1.538000,22.860000>0.406400}
cylinder{<58.420000,0.038000,24.765000><58.420000,-1.538000,24.765000>0.406400}
cylinder{<59.690000,0.038000,22.860000><59.690000,-1.538000,22.860000>0.406400}
cylinder{<71.120000,0.038000,22.860000><71.120000,-1.538000,22.860000>0.406400}
cylinder{<72.390000,0.038000,24.765000><72.390000,-1.538000,24.765000>0.406400}
cylinder{<73.660000,0.038000,22.860000><73.660000,-1.538000,22.860000>0.406400}
cylinder{<85.090000,0.038000,22.860000><85.090000,-1.538000,22.860000>0.406400}
cylinder{<86.360000,0.038000,24.765000><86.360000,-1.538000,24.765000>0.406400}
cylinder{<87.630000,0.038000,22.860000><87.630000,-1.538000,22.860000>0.406400}
cylinder{<36.118800,0.038000,13.690600><36.118800,-1.538000,13.690600>0.508000}
cylinder{<42.621200,0.038000,13.690600><42.621200,-1.538000,13.690600>0.508000}
cylinder{<36.118800,0.038000,9.169400><36.118800,-1.538000,9.169400>0.508000}
cylinder{<42.621200,0.038000,9.169400><42.621200,-1.538000,9.169400>0.508000}
cylinder{<79.298800,0.038000,13.690600><79.298800,-1.538000,13.690600>0.508000}
cylinder{<85.801200,0.038000,13.690600><85.801200,-1.538000,13.690600>0.508000}
cylinder{<79.298800,0.038000,9.169400><79.298800,-1.538000,9.169400>0.508000}
cylinder{<85.801200,0.038000,9.169400><85.801200,-1.538000,9.169400>0.508000}
cylinder{<35.560000,0.038000,2.540000><35.560000,-1.538000,2.540000>0.400000}
cylinder{<93.980000,0.038000,50.800000><93.980000,-1.538000,50.800000>0.400000}
cylinder{<96.520000,0.038000,50.800000><96.520000,-1.538000,50.800000>0.400000}
cylinder{<38.100000,0.038000,2.540000><38.100000,-1.538000,2.540000>0.400000}
cylinder{<50.800000,0.038000,2.540000><50.800000,-1.538000,2.540000>0.400000}
cylinder{<53.340000,0.038000,2.540000><53.340000,-1.538000,2.540000>0.400000}
cylinder{<55.880000,0.038000,2.540000><55.880000,-1.538000,2.540000>0.400000}
cylinder{<58.420000,0.038000,2.540000><58.420000,-1.538000,2.540000>0.400000}
cylinder{<60.960000,0.038000,2.540000><60.960000,-1.538000,2.540000>0.400000}
cylinder{<63.500000,0.038000,2.540000><63.500000,-1.538000,2.540000>0.400000}
cylinder{<66.040000,0.038000,2.540000><66.040000,-1.538000,2.540000>0.400000}
cylinder{<68.580000,0.038000,2.540000><68.580000,-1.538000,2.540000>0.400000}
cylinder{<73.660000,0.038000,2.540000><73.660000,-1.538000,2.540000>0.400000}
cylinder{<76.200000,0.038000,2.540000><76.200000,-1.538000,2.540000>0.400000}
cylinder{<78.740000,0.038000,2.540000><78.740000,-1.538000,2.540000>0.400000}
cylinder{<81.280000,0.038000,2.540000><81.280000,-1.538000,2.540000>0.400000}
cylinder{<83.820000,0.038000,2.540000><83.820000,-1.538000,2.540000>0.400000}
cylinder{<86.360000,0.038000,2.540000><86.360000,-1.538000,2.540000>0.400000}
cylinder{<88.900000,0.038000,2.540000><88.900000,-1.538000,2.540000>0.400000}
cylinder{<91.440000,0.038000,2.540000><91.440000,-1.538000,2.540000>0.400000}
cylinder{<24.130000,0.038000,50.800000><24.130000,-1.538000,50.800000>0.400000}
cylinder{<63.500000,0.038000,50.800000><63.500000,-1.538000,50.800000>0.400000}
cylinder{<60.960000,0.038000,50.800000><60.960000,-1.538000,50.800000>0.400000}
cylinder{<58.420000,0.038000,50.800000><58.420000,-1.538000,50.800000>0.400000}
cylinder{<55.880000,0.038000,50.800000><55.880000,-1.538000,50.800000>0.400000}
cylinder{<53.340000,0.038000,50.800000><53.340000,-1.538000,50.800000>0.400000}
cylinder{<50.800000,0.038000,50.800000><50.800000,-1.538000,50.800000>0.400000}
cylinder{<48.260000,0.038000,50.800000><48.260000,-1.538000,50.800000>0.400000}
cylinder{<45.720000,0.038000,50.800000><45.720000,-1.538000,50.800000>0.400000}
cylinder{<41.910000,0.038000,50.800000><41.910000,-1.538000,50.800000>0.400000}
cylinder{<39.370000,0.038000,50.800000><39.370000,-1.538000,50.800000>0.400000}
cylinder{<36.830000,0.038000,50.800000><36.830000,-1.538000,50.800000>0.400000}
cylinder{<34.290000,0.038000,50.800000><34.290000,-1.538000,50.800000>0.400000}
cylinder{<31.750000,0.038000,50.800000><31.750000,-1.538000,50.800000>0.400000}
cylinder{<29.210000,0.038000,50.800000><29.210000,-1.538000,50.800000>0.400000}
cylinder{<68.580000,0.038000,50.800000><68.580000,-1.538000,50.800000>0.400000}
cylinder{<71.120000,0.038000,50.800000><71.120000,-1.538000,50.800000>0.400000}
cylinder{<73.660000,0.038000,50.800000><73.660000,-1.538000,50.800000>0.400000}
cylinder{<76.200000,0.038000,50.800000><76.200000,-1.538000,50.800000>0.400000}
cylinder{<78.740000,0.038000,50.800000><78.740000,-1.538000,50.800000>0.400000}
cylinder{<81.280000,0.038000,50.800000><81.280000,-1.538000,50.800000>0.400000}
cylinder{<83.820000,0.038000,50.800000><83.820000,-1.538000,50.800000>0.400000}
cylinder{<86.360000,0.038000,50.800000><86.360000,-1.538000,50.800000>0.400000}
cylinder{<93.980000,0.038000,48.260000><93.980000,-1.538000,48.260000>0.400000}
cylinder{<96.520000,0.038000,48.260000><96.520000,-1.538000,48.260000>0.400000}
cylinder{<93.980000,0.038000,45.720000><93.980000,-1.538000,45.720000>0.400000}
cylinder{<96.520000,0.038000,45.720000><96.520000,-1.538000,45.720000>0.400000}
cylinder{<93.980000,0.038000,43.180000><93.980000,-1.538000,43.180000>0.400000}
cylinder{<96.520000,0.038000,43.180000><96.520000,-1.538000,43.180000>0.400000}
cylinder{<93.980000,0.038000,40.640000><93.980000,-1.538000,40.640000>0.400000}
cylinder{<96.520000,0.038000,40.640000><96.520000,-1.538000,40.640000>0.400000}
cylinder{<93.980000,0.038000,38.100000><93.980000,-1.538000,38.100000>0.400000}
cylinder{<96.520000,0.038000,38.100000><96.520000,-1.538000,38.100000>0.400000}
cylinder{<93.980000,0.038000,35.560000><93.980000,-1.538000,35.560000>0.400000}
cylinder{<96.520000,0.038000,35.560000><96.520000,-1.538000,35.560000>0.400000}
cylinder{<93.980000,0.038000,33.020000><93.980000,-1.538000,33.020000>0.400000}
cylinder{<96.520000,0.038000,33.020000><96.520000,-1.538000,33.020000>0.400000}
cylinder{<93.980000,0.038000,30.480000><93.980000,-1.538000,30.480000>0.400000}
cylinder{<96.520000,0.038000,30.480000><96.520000,-1.538000,30.480000>0.400000}
cylinder{<93.980000,0.038000,27.940000><93.980000,-1.538000,27.940000>0.400000}
cylinder{<96.520000,0.038000,27.940000><96.520000,-1.538000,27.940000>0.400000}
cylinder{<93.980000,0.038000,25.400000><93.980000,-1.538000,25.400000>0.400000}
cylinder{<96.520000,0.038000,25.400000><96.520000,-1.538000,25.400000>0.400000}
cylinder{<93.980000,0.038000,22.860000><93.980000,-1.538000,22.860000>0.400000}
cylinder{<96.520000,0.038000,22.860000><96.520000,-1.538000,22.860000>0.400000}
cylinder{<93.980000,0.038000,20.320000><93.980000,-1.538000,20.320000>0.400000}
cylinder{<96.520000,0.038000,20.320000><96.520000,-1.538000,20.320000>0.400000}
cylinder{<93.980000,0.038000,17.780000><93.980000,-1.538000,17.780000>0.400000}
cylinder{<96.520000,0.038000,17.780000><96.520000,-1.538000,17.780000>0.400000}
cylinder{<93.980000,0.038000,15.240000><93.980000,-1.538000,15.240000>0.400000}
cylinder{<96.520000,0.038000,15.240000><96.520000,-1.538000,15.240000>0.400000}
cylinder{<93.980000,0.038000,12.700000><93.980000,-1.538000,12.700000>0.400000}
cylinder{<96.520000,0.038000,12.700000><96.520000,-1.538000,12.700000>0.400000}
cylinder{<93.980000,0.038000,10.160000><93.980000,-1.538000,10.160000>0.400000}
cylinder{<96.520000,0.038000,10.160000><96.520000,-1.538000,10.160000>0.400000}
cylinder{<26.670000,0.038000,50.800000><26.670000,-1.538000,50.800000>0.400000}
cylinder{<93.980000,0.038000,7.620000><93.980000,-1.538000,7.620000>0.400000}
cylinder{<96.520000,0.038000,7.620000><96.520000,-1.538000,7.620000>0.400000}
cylinder{<40.640000,0.038000,2.540000><40.640000,-1.538000,2.540000>0.400000}
cylinder{<43.180000,0.038000,2.540000><43.180000,-1.538000,2.540000>0.400000}
cylinder{<33.020000,0.038000,2.540000><33.020000,-1.538000,2.540000>0.400000}
cylinder{<45.720000,0.038000,2.540000><45.720000,-1.538000,2.540000>0.400000}
cylinder{<6.350000,0.038000,26.670000><6.350000,-1.538000,26.670000>0.698500}
cylinder{<6.350000,0.038000,21.590000><6.350000,-1.538000,21.590000>0.698500}
//Holes(fast)/Vias
cylinder{<3.556000,0.038000,5.080000><3.556000,-1.538000,5.080000>0.300000 }
cylinder{<8.763000,0.038000,12.446000><8.763000,-1.538000,12.446000>0.304800 }
cylinder{<29.972000,0.038000,16.383000><29.972000,-1.538000,16.383000>0.304800 }
cylinder{<24.765000,0.038000,10.668000><24.765000,-1.538000,10.668000>0.304800 }
cylinder{<10.160000,0.038000,38.481000><10.160000,-1.538000,38.481000>0.304800 }
cylinder{<38.481000,0.038000,39.751000><38.481000,-1.538000,39.751000>0.304800 }
cylinder{<65.532000,0.038000,36.830000><65.532000,-1.538000,36.830000>0.304800 }
cylinder{<84.709000,0.038000,44.323000><84.709000,-1.538000,44.323000>0.304800 }
cylinder{<13.716000,0.038000,7.112000><13.716000,-1.538000,7.112000>0.300000 }
cylinder{<26.416000,0.038000,7.112000><26.416000,-1.538000,7.112000>0.300000 }
cylinder{<23.368000,0.038000,8.636000><23.368000,-1.538000,8.636000>0.300000 }
cylinder{<8.636000,0.038000,10.668000><8.636000,-1.538000,10.668000>0.300000 }
cylinder{<18.923000,0.038000,15.240000><18.923000,-1.538000,15.240000>0.304800 }
cylinder{<21.717000,0.038000,11.557000><21.717000,-1.538000,11.557000>0.304800 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.946800,0.000000,15.290800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.946800,0.000000,16.460100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<56.946800,0.000000,16.460100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.946800,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.336500,0.000000,16.070300>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,45.004380,0> translate<56.946800,0.000000,16.460100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.336500,0.000000,16.070300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.726300,0.000000,16.460100>}
box{<0,0,-0.050800><0.551260,0.036000,0.050800> rotate<0,-44.997030,0> translate<57.336500,0.000000,16.070300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.726300,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.726300,0.000000,15.290800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<57.726300,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.700700,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.310900,0.000000,16.460100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<58.310900,0.000000,16.460100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.310900,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.116100,0.000000,16.265200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<58.116100,0.000000,16.265200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.116100,0.000000,16.265200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.116100,0.000000,15.485600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,-90.000000,0> translate<58.116100,0.000000,15.485600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.116100,0.000000,15.485600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.310900,0.000000,15.290800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<58.116100,0.000000,15.485600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.310900,0.000000,15.290800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.700700,0.000000,15.290800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<58.310900,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.700700,0.000000,15.290800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.895600,0.000000,15.485600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<58.700700,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.895600,0.000000,15.485600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.895600,0.000000,16.265200>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<58.895600,0.000000,16.265200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.895600,0.000000,16.265200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.700700,0.000000,16.460100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<58.700700,0.000000,16.460100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.285400,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.285400,0.000000,15.290800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<59.285400,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.285400,0.000000,15.290800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.870000,0.000000,15.290800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<59.285400,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.870000,0.000000,15.290800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.064900,0.000000,15.485600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<59.870000,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.064900,0.000000,15.485600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.064900,0.000000,16.265200>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<60.064900,0.000000,16.265200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.064900,0.000000,16.265200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.870000,0.000000,16.460100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<59.870000,0.000000,16.460100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.870000,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.285400,0.000000,16.460100>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<59.285400,0.000000,16.460100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.234200,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.454700,0.000000,16.460100>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<60.454700,0.000000,16.460100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.454700,0.000000,16.460100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.454700,0.000000,15.290800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<60.454700,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.454700,0.000000,15.290800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.234200,0.000000,15.290800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<60.454700,0.000000,15.290800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.454700,0.000000,15.875400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.844400,0.000000,15.875400>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<60.454700,0.000000,15.875400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,22.537700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,22.732600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<1.533200,0.000000,22.537700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,22.732600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,23.122400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<1.728100,0.000000,23.122400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,23.122400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,23.317200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<1.533200,0.000000,23.317200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,23.317200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,23.317200>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,0.000000,0> translate<0.753600,0.000000,23.317200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,23.317200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,23.122400>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<0.558800,0.000000,23.122400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,23.122400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,22.732600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<0.558800,0.000000,22.732600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,22.732600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,22.537700>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<0.558800,0.000000,22.732600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,22.537700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,22.537700>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<0.753600,0.000000,22.537700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,22.537700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,22.927500>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<1.143400,0.000000,22.927500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,22.147900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,22.147900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<0.558800,0.000000,22.147900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,22.147900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,21.368400>}
box{<0,0,-0.050800><1.405305,0.036000,0.050800> rotate<0,-33.686713,0> translate<0.558800,0.000000,21.368400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,21.368400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,21.368400>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<0.558800,0.000000,21.368400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,20.978600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,20.978600>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<0.558800,0.000000,20.978600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,20.978600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,20.394000>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<0.558800,0.000000,20.394000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,20.394000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,20.199100>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<0.558800,0.000000,20.394000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,20.199100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,20.199100>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,0.000000,0> translate<0.753600,0.000000,20.199100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,20.199100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,20.394000>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<1.533200,0.000000,20.199100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,20.394000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,20.978600>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,90.000000,0> translate<1.728100,0.000000,20.978600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,29.277500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,29.277500>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<0.558800,0.000000,29.277500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,29.667200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,28.887700>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<1.728100,0.000000,28.887700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,28.497900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,28.497900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<0.558800,0.000000,28.497900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,28.497900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,27.913300>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<1.728100,0.000000,27.913300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,27.913300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,27.718400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<1.533200,0.000000,27.718400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,27.718400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,27.718400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<1.143400,0.000000,27.718400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,27.718400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.948500,0.000000,27.913300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<0.948500,0.000000,27.913300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.948500,0.000000,27.913300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.948500,0.000000,28.497900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,90.000000,0> translate<0.948500,0.000000,28.497900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.948500,0.000000,28.108200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,27.718400>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<0.558800,0.000000,27.718400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,27.328600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,26.938900>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,-90.000000,0> translate<0.558800,0.000000,26.938900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,27.133800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,27.133800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<0.558800,0.000000,27.133800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,27.328600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,26.938900>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,-90.000000,0> translate<1.728100,0.000000,26.938900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,25.769600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,25.964500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<1.533200,0.000000,25.769600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,25.964500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,26.354300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<1.728100,0.000000,26.354300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.728100,0.000000,26.354300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,26.549100>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<1.533200,0.000000,26.549100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.533200,0.000000,26.549100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,26.549100>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,0.000000,0> translate<0.753600,0.000000,26.549100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,26.549100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,26.354300>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<0.558800,0.000000,26.354300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,26.354300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,25.964500>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<0.558800,0.000000,25.964500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.558800,0.000000,25.964500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,25.769600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<0.558800,0.000000,25.964500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<0.753600,0.000000,25.769600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,25.769600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<0.753600,0.000000,25.769600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,25.769600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.143400,0.000000,26.159400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<1.143400,0.000000,26.159400> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.479700,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.810300,0.000000,19.796400>}
box{<0,0,-0.088900><0.748457,0.036000,0.088900> rotate<0,-26.570145,0> translate<35.810300,0.000000,19.796400> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.810300,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.140900,0.000000,19.127000>}
box{<0,0,-0.088900><0.946675,0.036000,0.088900> rotate<0,-44.997030,0> translate<35.140900,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.140900,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.140900,0.000000,18.457600>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<35.140900,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.140900,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.475600,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<35.140900,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.475600,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.145000,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<35.475600,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.145000,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.479700,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<36.145000,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.479700,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.479700,0.000000,18.792300>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,90.000000,0> translate<36.479700,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.479700,0.000000,18.792300>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.145000,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<36.145000,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<36.145000,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<35.140900,0.000000,19.127000>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<35.140900,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<38.491000,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.486900,0.000000,19.461700>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<37.486900,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.486900,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.152200,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<37.152200,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.152200,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.152200,0.000000,18.457600>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<37.152200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.152200,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.486900,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<37.152200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<37.486900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<38.491000,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<37.486900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<39.163500,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<39.163500,0.000000,18.122900>}
box{<0,0,-0.088900><2.008300,0.036000,0.088900> rotate<0,-90.000000,0> translate<39.163500,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<39.163500,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<39.498200,0.000000,19.461700>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<39.163500,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<39.498200,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<40.167600,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<39.498200,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<40.167600,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<40.502300,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<40.167600,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<40.502300,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<40.502300,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,-90.000000,0> translate<40.502300,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<43.186100,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<43.186100,0.000000,20.131200>}
box{<0,0,-0.088900><2.008300,0.036000,0.088900> rotate<0,90.000000,0> translate<43.186100,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<43.186100,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<43.855500,0.000000,19.461700>}
box{<0,0,-0.088900><0.946745,0.036000,0.088900> rotate<0,45.001309,0> translate<43.186100,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<43.855500,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<44.524900,0.000000,20.131200>}
box{<0,0,-0.088900><0.946745,0.036000,0.088900> rotate<0,-45.001309,0> translate<43.855500,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<44.524900,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<44.524900,0.000000,18.122900>}
box{<0,0,-0.088900><2.008300,0.036000,0.088900> rotate<0,-90.000000,0> translate<44.524900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.197400,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.532100,0.000000,19.461700>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,0.000000,0> translate<45.197400,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.532100,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.532100,0.000000,18.122900>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,-90.000000,0> translate<45.532100,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.197400,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.866800,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<45.197400,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.532100,0.000000,20.465900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<45.532100,0.000000,20.131200>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,-90.000000,0> translate<45.532100,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<46.873000,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<46.873000,0.000000,18.457600>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,-90.000000,0> translate<46.873000,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<46.873000,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<47.207700,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<46.873000,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<46.538300,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<47.207700,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<46.538300,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<47.879200,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<47.879200,0.000000,18.457600>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,-90.000000,0> translate<47.879200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<47.879200,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<48.213900,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<47.879200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<48.213900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<49.218000,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<48.213900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<49.218000,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<49.218000,0.000000,19.461700>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,90.000000,0> translate<49.218000,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<50.225200,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<50.225200,0.000000,18.457600>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,-90.000000,0> translate<50.225200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<50.225200,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<50.559900,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<50.225200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<49.890500,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<50.559900,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<49.890500,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.566100,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.235500,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<51.566100,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.235500,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.570200,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<52.235500,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.570200,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.570200,0.000000,19.127000>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,90.000000,0> translate<52.570200,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.570200,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.235500,0.000000,19.461700>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<52.235500,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<52.235500,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.566100,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<51.566100,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.566100,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.231400,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<51.231400,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.231400,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.231400,0.000000,18.457600>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<51.231400,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.231400,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<51.566100,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<51.231400,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<53.242700,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<53.242700,0.000000,18.457600>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,-90.000000,0> translate<53.242700,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<53.242700,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<53.577400,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<53.242700,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<53.577400,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<54.581500,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<53.577400,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<54.581500,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<54.581500,0.000000,17.788200>}
box{<0,0,-0.088900><1.673500,0.036000,0.088900> rotate<0,-90.000000,0> translate<54.581500,0.000000,17.788200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<54.581500,0.000000,17.788200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<54.246800,0.000000,17.453500>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<54.246800,0.000000,17.453500> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<54.246800,0.000000,17.453500>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<53.912100,0.000000,17.453500>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,0.000000,0> translate<53.912100,0.000000,17.453500> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.588700,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.258100,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<55.588700,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.258100,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.592800,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<56.258100,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.592800,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.592800,0.000000,19.127000>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,90.000000,0> translate<56.592800,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.592800,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.258100,0.000000,19.461700>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<56.258100,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<56.258100,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.588700,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<55.588700,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.588700,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.254000,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<55.254000,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.254000,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.254000,0.000000,18.457600>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<55.254000,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.254000,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<55.588700,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<55.254000,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.615400,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.280700,0.000000,20.131200>}
box{<0,0,-0.088900><0.473408,0.036000,0.088900> rotate<0,45.005588,0> translate<60.280700,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.280700,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.611300,0.000000,20.131200>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<59.611300,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.611300,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.276600,0.000000,19.796400>}
box{<0,0,-0.088900><0.473408,0.036000,0.088900> rotate<0,-45.005588,0> translate<59.276600,0.000000,19.796400> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.276600,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.276600,0.000000,19.461700>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,-90.000000,0> translate<59.276600,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.276600,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.611300,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<59.276600,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.611300,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.280700,0.000000,19.127000>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<59.611300,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.280700,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.615400,0.000000,18.792300>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<60.280700,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.615400,0.000000,18.792300>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.615400,0.000000,18.457600>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,-90.000000,0> translate<60.615400,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.615400,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.280700,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<60.280700,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<60.280700,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.611300,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<59.611300,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.611300,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<59.276600,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<59.276600,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<61.287900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<61.287900,0.000000,20.131200>}
box{<0,0,-0.088900><2.008300,0.036000,0.088900> rotate<0,90.000000,0> translate<61.287900,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<61.287900,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.292000,0.000000,20.131200>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<61.287900,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.292000,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.626700,0.000000,19.796400>}
box{<0,0,-0.088900><0.473408,0.036000,0.088900> rotate<0,45.005588,0> translate<62.292000,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.626700,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.626700,0.000000,19.127000>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<62.626700,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.626700,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.292000,0.000000,18.792300>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<62.292000,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<62.292000,0.000000,18.792300>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<61.287900,0.000000,18.792300>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<61.287900,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<64.638000,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<64.303300,0.000000,20.131200>}
box{<0,0,-0.088900><0.473408,0.036000,0.088900> rotate<0,45.005588,0> translate<64.303300,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<64.303300,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.633900,0.000000,20.131200>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<63.633900,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.633900,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.299200,0.000000,19.796400>}
box{<0,0,-0.088900><0.473408,0.036000,0.088900> rotate<0,-45.005588,0> translate<63.299200,0.000000,19.796400> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.299200,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.299200,0.000000,18.457600>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,-90.000000,0> translate<63.299200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.299200,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.633900,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<63.299200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<63.633900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<64.303300,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<63.633900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<64.303300,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<64.638000,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<64.303300,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<67.321800,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<67.321800,0.000000,18.122900>}
box{<0,0,-0.088900><2.008300,0.036000,0.088900> rotate<0,-90.000000,0> translate<67.321800,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<67.321800,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.325900,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<67.321800,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.325900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.660600,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<68.325900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.660600,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.660600,0.000000,19.796400>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,90.000000,0> translate<68.660600,0.000000,19.796400> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.660600,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.325900,0.000000,20.131200>}
box{<0,0,-0.088900><0.473408,0.036000,0.088900> rotate<0,45.005588,0> translate<68.325900,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<68.325900,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<67.321800,0.000000,20.131200>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<67.321800,0.000000,20.131200> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<69.667800,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<70.337200,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<69.667800,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<70.337200,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<70.671900,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<70.337200,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<70.671900,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<70.671900,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,-90.000000,0> translate<70.671900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<70.671900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<69.667800,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<69.667800,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<69.667800,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<69.333100,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<69.333100,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<69.333100,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<69.667800,0.000000,18.792300>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<69.333100,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<69.667800,0.000000,18.792300>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<70.671900,0.000000,18.792300>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<69.667800,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<71.679100,0.000000,19.796400>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<71.679100,0.000000,18.457600>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,-90.000000,0> translate<71.679100,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<71.679100,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<72.013800,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<71.679100,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<71.344400,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<72.013800,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<71.344400,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<73.020000,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<73.689400,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<73.020000,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<73.689400,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<74.024100,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<73.689400,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<74.024100,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<74.024100,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,-90.000000,0> translate<74.024100,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<74.024100,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<73.020000,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<73.020000,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<73.020000,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<72.685300,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<72.685300,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<72.685300,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<73.020000,0.000000,18.792300>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<72.685300,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<73.020000,0.000000,18.792300>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<74.024100,0.000000,18.792300>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<73.020000,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<76.707900,0.000000,20.131200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<76.707900,0.000000,18.122900>}
box{<0,0,-0.088900><2.008300,0.036000,0.088900> rotate<0,-90.000000,0> translate<76.707900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<76.707900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<78.046700,0.000000,18.122900>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,0.000000,0> translate<76.707900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.053900,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.723300,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<79.053900,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.723300,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.058000,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<79.723300,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.058000,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.058000,0.000000,19.127000>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,90.000000,0> translate<80.058000,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.058000,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.723300,0.000000,19.461700>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<79.723300,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.723300,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.053900,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<79.053900,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.053900,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<78.719200,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<78.719200,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<78.719200,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<78.719200,0.000000,18.457600>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<78.719200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<78.719200,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<79.053900,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<78.719200,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<81.399900,0.000000,17.453500>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<81.734600,0.000000,17.453500>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,0.000000,0> translate<81.399900,0.000000,17.453500> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<81.734600,0.000000,17.453500>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.069300,0.000000,17.788200>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<81.734600,0.000000,17.453500> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.069300,0.000000,17.788200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.069300,0.000000,19.461700>}
box{<0,0,-0.088900><1.673500,0.036000,0.088900> rotate<0,90.000000,0> translate<82.069300,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.069300,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<81.065200,0.000000,19.461700>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<81.065200,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<81.065200,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.730500,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<80.730500,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.730500,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.730500,0.000000,18.457600>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<80.730500,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<80.730500,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<81.065200,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<80.730500,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<81.065200,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.069300,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<81.065200,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<83.411200,0.000000,17.453500>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<83.745900,0.000000,17.453500>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,0.000000,0> translate<83.411200,0.000000,17.453500> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<83.745900,0.000000,17.453500>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.080600,0.000000,17.788200>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<83.745900,0.000000,17.453500> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.080600,0.000000,17.788200>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.080600,0.000000,19.461700>}
box{<0,0,-0.088900><1.673500,0.036000,0.088900> rotate<0,90.000000,0> translate<84.080600,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.080600,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<83.076500,0.000000,19.461700>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<83.076500,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<83.076500,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.741800,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<82.741800,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.741800,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.741800,0.000000,18.457600>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,-90.000000,0> translate<82.741800,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<82.741800,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<83.076500,0.000000,18.122900>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<82.741800,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<83.076500,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.080600,0.000000,18.122900>}
box{<0,0,-0.088900><1.004100,0.036000,0.088900> rotate<0,0.000000,0> translate<83.076500,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<85.757200,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<85.087800,0.000000,18.122900>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<85.087800,0.000000,18.122900> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<85.087800,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.753100,0.000000,18.457600>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<84.753100,0.000000,18.457600> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.753100,0.000000,18.457600>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.753100,0.000000,19.127000>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,90.000000,0> translate<84.753100,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.753100,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<85.087800,0.000000,19.461700>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,-44.997030,0> translate<84.753100,0.000000,19.127000> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<85.087800,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<85.757200,0.000000,19.461700>}
box{<0,0,-0.088900><0.669400,0.036000,0.088900> rotate<0,0.000000,0> translate<85.087800,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<85.757200,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<86.091900,0.000000,19.127000>}
box{<0,0,-0.088900><0.473337,0.036000,0.088900> rotate<0,44.997030,0> translate<85.757200,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<86.091900,0.000000,19.127000>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<86.091900,0.000000,18.792300>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,-90.000000,0> translate<86.091900,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<86.091900,0.000000,18.792300>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<84.753100,0.000000,18.792300>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,0.000000,0> translate<84.753100,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<86.764400,0.000000,18.122900>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<86.764400,0.000000,19.461700>}
box{<0,0,-0.088900><1.338800,0.036000,0.088900> rotate<0,90.000000,0> translate<86.764400,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<86.764400,0.000000,18.792300>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<87.433800,0.000000,19.461700>}
box{<0,0,-0.088900><0.946675,0.036000,0.088900> rotate<0,-44.997030,0> translate<86.764400,0.000000,18.792300> }
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<87.433800,0.000000,19.461700>}
cylinder{<0,0,0><0,0.036000,0>0.088900 translate<87.768500,0.000000,19.461700>}
box{<0,0,-0.088900><0.334700,0.036000,0.088900> rotate<0,0.000000,0> translate<87.433800,0.000000,19.461700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,7.150100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,7.150100>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,7.150100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,7.150100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,7.620400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,7.620400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,7.620400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,7.777100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.881200,0.000000,7.777100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,7.777100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,7.777100>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<99.254100,0.000000,7.777100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,7.777100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,7.620400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<99.097300,0.000000,7.620400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,7.620400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,7.150100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.097300,0.000000,7.150100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,8.555900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,8.242300>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,8.242300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,8.242300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,8.085600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,8.085600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,8.085600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,8.085600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,8.085600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,8.085600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,8.242300>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,8.242300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,8.242300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,8.555900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,8.555900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,8.555900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,8.712600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,8.555900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,8.712600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,8.712600>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,8.712600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,8.712600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,8.085600>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.724400,0.000000,8.085600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,9.021100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,9.491400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,9.491400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,9.491400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,9.648100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.881200,0.000000,9.648100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,9.648100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,9.491400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<99.724400,0.000000,9.491400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,9.491400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,9.177800>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.724400,0.000000,9.177800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,9.177800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,9.021100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<99.567600,0.000000,9.021100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,9.021100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,9.177800>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,9.177800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,9.177800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,9.648100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,9.648100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,9.956600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,10.113300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,10.113300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,10.113300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,10.113300>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,10.113300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,9.956600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,10.270100>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,10.270100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<98.940600,0.000000,10.113300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,10.113300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<98.940600,0.000000,10.113300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.351400,0.000000,10.893700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.351400,0.000000,11.050500>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,90.000000,0> translate<100.351400,0.000000,11.050500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.351400,0.000000,11.050500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.194600,0.000000,11.207200>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<100.194600,0.000000,11.207200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.194600,0.000000,11.207200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,11.207200>}
box{<0,0,-0.038100><0.783700,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,11.207200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,11.207200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,10.736900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.410900,0.000000,10.736900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,10.736900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,10.580200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,10.736900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,10.580200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,10.580200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,10.580200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,10.580200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,10.736900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,10.580200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,10.736900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,11.207200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,11.207200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,11.515700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,11.515700>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,11.515700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,11.515700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,11.986000>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,11.986000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,11.986000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,12.142700>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,11.986000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,12.142700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,12.142700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,12.142700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,13.386700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,13.386700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,13.386700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,13.386700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,13.857000>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.097300,0.000000,13.857000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,13.857000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,14.013700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<99.097300,0.000000,13.857000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,14.013700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,14.013700>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.254100,0.000000,14.013700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,14.013700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,13.857000>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,14.013700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,13.857000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,14.013700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<99.567600,0.000000,13.857000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,14.013700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,14.013700>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.724400,0.000000,14.013700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,14.013700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,13.857000>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.881200,0.000000,14.013700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,13.857000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,13.386700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,13.386700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,13.386700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,13.857000>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.567600,0.000000,13.857000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,14.322200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,14.322200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,14.322200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,14.322200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,14.478900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,14.322200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,14.478900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,14.949200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,14.949200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,14.949200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.194600,0.000000,14.949200>}
box{<0,0,-0.038100><0.783700,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,14.949200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.194600,0.000000,14.949200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.351400,0.000000,14.792500>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<100.194600,0.000000,14.949200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.351400,0.000000,14.792500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.351400,0.000000,14.635700>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.351400,0.000000,14.635700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,15.257700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,15.414400>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,15.414400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,15.414400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,15.414400>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,15.414400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,15.414400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,15.257700>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.567600,0.000000,15.257700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,15.257700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,15.257700>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,15.257700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,15.257700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,15.414400>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,90.000000,0> translate<99.881200,0.000000,15.414400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,15.414400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,15.414400>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<99.881200,0.000000,15.414400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,15.414400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,15.257700>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,15.257700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,15.257700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,15.257700>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<99.881200,0.000000,15.257700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,16.660900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,17.287900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<99.097300,0.000000,17.287900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,17.287900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,17.287900>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,17.287900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,17.287900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,16.660900>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,44.992462,0> translate<99.254100,0.000000,17.287900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,16.660900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,16.660900>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<99.881200,0.000000,16.660900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,16.660900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,17.287900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,17.287900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,17.753100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,18.066700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,18.066700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,18.066700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,18.223400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,18.066700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,18.223400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,18.223400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,18.223400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,18.223400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,17.753100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,17.753100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,17.753100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,17.596400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,17.596400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,17.596400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,17.753100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<99.724400,0.000000,17.753100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,17.753100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,18.223400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.724400,0.000000,18.223400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,19.158900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,18.688600>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.410900,0.000000,18.688600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,18.688600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,18.531900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,18.688600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,18.531900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,18.531900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,18.531900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,18.531900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,18.688600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,18.531900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,18.688600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,19.158900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,19.158900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,19.467400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,19.467400>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,19.467400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,19.467400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,19.624100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,19.624100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,19.624100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,19.937700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,19.937700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,19.937700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,20.094400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,19.937700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,20.094400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,20.094400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,20.094400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,21.338400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,21.338400>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,21.338400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,21.338400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,21.965400>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<99.567600,0.000000,21.965400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,21.965400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,21.965400>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,21.965400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,22.430600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,22.744200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,22.744200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,22.744200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,22.900900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.881200,0.000000,22.900900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,22.900900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,22.900900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,22.900900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,22.900900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,22.744200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,22.744200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,22.744200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,22.430600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.410900,0.000000,22.430600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,22.430600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,22.273900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,22.430600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,22.273900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,22.273900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,22.273900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,22.273900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,22.430600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,22.273900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,23.679700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,23.366100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,23.366100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,23.366100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,23.209400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,23.209400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,23.209400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,23.209400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,23.209400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,23.209400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,23.366100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,23.366100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,23.366100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,23.679700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,23.679700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,23.679700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,23.836400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,23.679700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,23.836400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,23.836400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,23.836400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,23.836400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,23.209400>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.724400,0.000000,23.209400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,24.144900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,24.144900>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,24.144900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,24.615200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,24.144900>}
box{<0,0,-0.038100><0.565212,0.036000,0.038100> rotate<0,-56.309028,0> translate<99.724400,0.000000,24.144900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,24.144900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,24.615200>}
box{<0,0,-0.038100><0.565212,0.036000,0.038100> rotate<0,56.309028,0> translate<99.410900,0.000000,24.615200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,25.394700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,25.081100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,25.081100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,25.081100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,24.924400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,24.924400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,24.924400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,24.924400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,24.924400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,24.924400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,25.081100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,25.081100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,25.081100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,25.394700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,25.394700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,25.394700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,25.551400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,25.394700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,25.551400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,25.551400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,25.551400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,25.551400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,24.924400>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.724400,0.000000,24.924400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,25.859900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,25.859900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,25.859900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,25.859900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,26.330200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,26.330200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,26.330200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,26.486900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,26.330200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,26.486900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,26.486900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,26.486900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,27.730900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,28.357900>}
box{<0,0,-0.038100><1.130424,0.036000,0.038100> rotate<0,33.685033,0> translate<99.097300,0.000000,28.357900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,29.601900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,29.601900>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,29.601900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,29.601900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,29.915400>}
box{<0,0,-0.038100><0.443427,0.036000,0.038100> rotate<0,-44.987894,0> translate<99.097300,0.000000,29.601900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,29.915400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,30.228900>}
box{<0,0,-0.038100><0.443427,0.036000,0.038100> rotate<0,44.987894,0> translate<99.097300,0.000000,30.228900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,30.228900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,30.228900>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,30.228900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,30.694100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,31.007700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,31.007700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,31.007700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,31.164400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,31.007700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,31.164400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,31.164400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,31.164400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,31.164400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,30.694100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,30.694100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,30.694100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,30.537400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,30.537400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,30.537400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,30.694100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<99.724400,0.000000,30.694100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,30.694100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,31.164400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.724400,0.000000,31.164400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,31.472900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,31.472900>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,31.472900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,31.943200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,31.472900>}
box{<0,0,-0.038100><0.565212,0.036000,0.038100> rotate<0,-56.309028,0> translate<99.724400,0.000000,31.472900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,31.472900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,31.943200>}
box{<0,0,-0.038100><0.565212,0.036000,0.038100> rotate<0,56.309028,0> translate<99.410900,0.000000,31.943200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,32.722700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,32.409100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,32.409100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,32.409100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,32.252400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,32.252400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,32.252400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,32.252400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,32.252400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,32.252400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,32.409100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,32.409100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,32.409100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,32.722700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,32.722700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,32.722700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,32.879400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,32.722700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,32.879400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,32.879400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,32.879400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,32.879400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,32.252400>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.724400,0.000000,32.252400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,33.187900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,33.187900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<99.410900,0.000000,33.187900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,33.187900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,33.501400>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,33.501400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,33.501400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,33.658200>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,33.658200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,33.967400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,33.967400>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.097300,0.000000,33.967400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,33.967400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,34.437700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.097300,0.000000,34.437700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.097300,0.000000,34.437700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,34.594400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<99.097300,0.000000,34.437700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,34.594400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,34.594400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.254100,0.000000,34.594400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,34.594400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,34.437700>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,34.594400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,34.437700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,34.594400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<99.567600,0.000000,34.437700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.724400,0.000000,34.594400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,34.594400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<99.724400,0.000000,34.594400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,34.594400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,34.437700>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.881200,0.000000,34.594400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,34.437700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,33.967400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<100.037900,0.000000,33.967400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,33.967400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,34.437700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<99.567600,0.000000,34.437700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,35.059600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,35.373200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<100.037900,0.000000,35.373200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,35.373200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,35.529900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.881200,0.000000,35.529900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,35.529900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,35.529900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,35.529900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,35.529900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,35.373200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.410900,0.000000,35.373200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,35.373200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,35.059600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<99.410900,0.000000,35.059600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,35.059600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,34.902900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<99.410900,0.000000,35.059600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.567600,0.000000,34.902900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,34.902900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<99.567600,0.000000,34.902900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,34.902900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,35.059600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<99.881200,0.000000,34.902900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.254100,0.000000,35.995100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,35.995100>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<99.254100,0.000000,35.995100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.881200,0.000000,35.995100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<100.037900,0.000000,36.151900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<99.881200,0.000000,35.995100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,35.838400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<99.410900,0.000000,36.151900>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,90.000000,0> translate<99.410900,0.000000,36.151900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<88.684100,0.000000,4.610100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<88.684100,0.000000,5.550700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,90.000000,0> translate<88.684100,0.000000,5.550700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<88.684100,0.000000,5.550700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.154400,0.000000,5.550700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<88.684100,0.000000,5.550700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.154400,0.000000,5.550700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.311100,0.000000,5.393900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<89.154400,0.000000,5.550700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.311100,0.000000,5.393900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.311100,0.000000,5.080400>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,-90.000000,0> translate<89.311100,0.000000,5.080400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.311100,0.000000,5.080400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.154400,0.000000,4.923600>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<89.154400,0.000000,4.923600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.154400,0.000000,4.923600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<88.684100,0.000000,4.923600>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<88.684100,0.000000,4.923600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<88.997600,0.000000,4.923600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.311100,0.000000,4.610100>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,44.997030,0> translate<88.997600,0.000000,4.923600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.089900,0.000000,4.610100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.776300,0.000000,4.610100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<89.776300,0.000000,4.610100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.776300,0.000000,4.610100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.619600,0.000000,4.766800>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<89.619600,0.000000,4.766800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.619600,0.000000,4.766800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.619600,0.000000,5.080400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<89.619600,0.000000,5.080400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.619600,0.000000,5.080400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.776300,0.000000,5.237100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<89.619600,0.000000,5.080400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.776300,0.000000,5.237100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.089900,0.000000,5.237100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<89.776300,0.000000,5.237100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.089900,0.000000,5.237100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.246600,0.000000,5.080400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<90.089900,0.000000,5.237100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.246600,0.000000,5.080400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.246600,0.000000,4.923600>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<90.246600,0.000000,4.923600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.246600,0.000000,4.923600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<89.619600,0.000000,4.923600>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<89.619600,0.000000,4.923600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.555100,0.000000,5.237100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.868600,0.000000,4.610100>}
box{<0,0,-0.038100><0.701007,0.036000,0.038100> rotate<0,63.430762,0> translate<90.555100,0.000000,5.237100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<90.868600,0.000000,4.610100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<91.182100,0.000000,5.237100>}
box{<0,0,-0.038100><0.701007,0.036000,0.038100> rotate<0,-63.430762,0> translate<90.868600,0.000000,4.610100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.426100,0.000000,4.610100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.426100,0.000000,5.550700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,90.000000,0> translate<92.426100,0.000000,5.550700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.426100,0.000000,5.550700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.896400,0.000000,5.550700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<92.426100,0.000000,5.550700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.896400,0.000000,5.550700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,5.393900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<92.896400,0.000000,5.550700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,5.393900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,5.237100>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<93.053100,0.000000,5.237100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,5.237100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.896400,0.000000,5.080400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<92.896400,0.000000,5.080400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.896400,0.000000,5.080400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,4.923600>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<92.896400,0.000000,5.080400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,4.923600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,4.766800>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<93.053100,0.000000,4.766800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<93.053100,0.000000,4.766800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.896400,0.000000,4.610100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<92.896400,0.000000,4.610100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.896400,0.000000,4.610100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.426100,0.000000,4.610100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<92.426100,0.000000,4.610100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.426100,0.000000,5.080400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<92.896400,0.000000,5.080400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<92.426100,0.000000,5.080400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.620200,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.620200,0.000000,4.648200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.620200,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.620200,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433600,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<34.620200,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.704800,0.000000,4.919300>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<35.433600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.704800,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.704800,0.000000,6.004000>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,90.000000,0> translate<35.704800,0.000000,6.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.704800,0.000000,6.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433600,0.000000,6.275100>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<35.433600,0.000000,6.275100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433600,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.620200,0.000000,6.275100>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<34.620200,0.000000,6.275100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.528400,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.070700,0.000000,4.648200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<36.528400,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.070700,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.341900,0.000000,4.919300>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<37.070700,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.341900,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.341900,0.000000,5.461600>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,90.000000,0> translate<37.341900,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.341900,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.070700,0.000000,5.732800>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<37.070700,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.070700,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.528400,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<36.528400,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.528400,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.257300,0.000000,5.461600>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<36.257300,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.257300,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.257300,0.000000,4.919300>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.257300,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.257300,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.528400,0.000000,4.648200>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<36.257300,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.979000,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.165500,0.000000,5.732800>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<38.165500,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.165500,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.894400,0.000000,5.461600>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<37.894400,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.894400,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.894400,0.000000,4.919300>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.894400,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.894400,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.165500,0.000000,4.648200>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<37.894400,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.165500,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.979000,0.000000,4.648200>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<38.165500,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.531500,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.531500,0.000000,4.919300>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.531500,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.531500,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.802600,0.000000,4.648200>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<39.531500,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.802600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.616100,0.000000,4.648200>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<39.802600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.616100,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.616100,0.000000,5.732800>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<40.616100,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.168600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.168600,0.000000,5.732800>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<41.168600,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.168600,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.439700,0.000000,5.732800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<41.168600,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.439700,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.710900,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<41.439700,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.710900,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.710900,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.710900,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.710900,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.982000,0.000000,5.732800>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<41.710900,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.982000,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.253200,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<41.982000,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.253200,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.253200,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.253200,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.619100,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.076800,0.000000,4.648200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<43.076800,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.076800,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.805700,0.000000,4.919300>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<42.805700,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.805700,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.805700,0.000000,5.461600>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,90.000000,0> translate<42.805700,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.805700,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.076800,0.000000,5.732800>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<42.805700,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.076800,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.619100,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<43.076800,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.619100,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.890300,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<43.619100,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.890300,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.890300,0.000000,5.190500>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.890300,0.000000,5.190500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.890300,0.000000,5.190500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.805700,0.000000,5.190500>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<42.805700,0.000000,5.190500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.442800,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.442800,0.000000,5.732800>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<44.442800,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.442800,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.256200,0.000000,5.732800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<44.442800,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.256200,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.527400,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<45.256200,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.527400,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.527400,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.527400,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.351000,0.000000,6.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.351000,0.000000,4.919300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.351000,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.351000,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.622200,0.000000,4.648200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<46.351000,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.079900,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.622200,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<46.079900,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.442400,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.984700,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<47.442400,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.984700,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.255900,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<47.984700,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.255900,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.255900,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.255900,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.255900,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.442400,0.000000,4.648200>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<47.442400,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.442400,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.171300,0.000000,4.919300>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<47.171300,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.171300,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.442400,0.000000,5.190500>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<47.171300,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.442400,0.000000,5.190500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.255900,0.000000,5.190500>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<47.442400,0.000000,5.190500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.079500,0.000000,6.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.079500,0.000000,4.919300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.079500,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.079500,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.350700,0.000000,4.648200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<49.079500,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.808400,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.350700,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<48.808400,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.899800,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.170900,0.000000,5.732800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<49.899800,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.170900,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.170900,0.000000,4.648200>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.170900,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.899800,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.442100,0.000000,4.648200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<49.899800,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.170900,0.000000,6.546300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.170900,0.000000,6.275100>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.170900,0.000000,6.275100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262300,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.804600,0.000000,4.648200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<51.262300,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.804600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.075800,0.000000,4.919300>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<51.804600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.075800,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.075800,0.000000,5.461600>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,90.000000,0> translate<52.075800,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.075800,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.804600,0.000000,5.732800>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<51.804600,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.804600,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262300,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<51.262300,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262300,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.991200,0.000000,5.461600>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<50.991200,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.991200,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.991200,0.000000,4.919300>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.991200,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.991200,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262300,0.000000,4.648200>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<50.991200,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.628300,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.628300,0.000000,5.732800>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<52.628300,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.628300,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.441700,0.000000,5.732800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<52.628300,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.441700,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.712900,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<53.441700,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.712900,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.712900,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.712900,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,5.732800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<54.265400,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,5.461600>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.536500,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,5.461600>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<54.265400,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,5.732800>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,90.000000,0> translate<54.265400,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,4.919300>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<54.265400,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,4.648200>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.536500,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.536500,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,4.648200>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<54.265400,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.265400,0.000000,4.919300>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,90.000000,0> translate<54.265400,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.721000,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.721000,0.000000,4.648200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.721000,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.721000,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.992100,0.000000,5.732800>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<56.721000,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.992100,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.534400,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<56.992100,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.534400,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.805600,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<57.534400,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.805600,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.805600,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.805600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.629200,0.000000,6.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.629200,0.000000,4.919300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.629200,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.629200,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.900400,0.000000,4.648200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<58.629200,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.358100,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.900400,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<58.358100,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.720600,0.000000,6.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.720600,0.000000,4.919300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.720600,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.720600,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.991800,0.000000,4.648200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<59.720600,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.449500,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.991800,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<59.449500,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540900,0.000000,4.105900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540900,0.000000,5.732800>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<60.540900,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540900,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.354300,0.000000,5.732800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<60.540900,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.354300,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.625500,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<61.354300,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.625500,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.625500,0.000000,4.919300>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.625500,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.625500,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.354300,0.000000,4.648200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<61.354300,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.354300,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540900,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<60.540900,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,5.732800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<62.178000,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,5.461600>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.449100,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,5.461600>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<62.178000,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,5.732800>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,90.000000,0> translate<62.178000,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,4.919300>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<62.178000,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,4.648200>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.449100,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.449100,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,4.648200>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<62.178000,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.178000,0.000000,4.919300>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,90.000000,0> translate<62.178000,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.996500,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.081100,0.000000,6.275100>}
box{<0,0,-0.076200><1.955290,0.036000,0.076200> rotate<0,-56.306216,0> translate<62.996500,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.633600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.718200,0.000000,6.275100>}
box{<0,0,-0.076200><1.955290,0.036000,0.076200> rotate<0,-56.306216,0> translate<64.633600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.270700,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.270700,0.000000,4.648200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.270700,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.270700,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.084100,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<66.270700,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.084100,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.355300,0.000000,4.919300>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<67.084100,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.355300,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.355300,0.000000,5.461600>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,90.000000,0> translate<67.355300,0.000000,5.461600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.355300,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.084100,0.000000,5.732800>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<67.084100,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.084100,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.270700,0.000000,5.732800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<66.270700,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.907800,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.178900,0.000000,5.732800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<67.907800,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.178900,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.178900,0.000000,4.648200>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.178900,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.907800,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.450100,0.000000,4.648200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<67.907800,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.178900,0.000000,6.546300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.178900,0.000000,6.275100>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.178900,0.000000,6.275100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.270300,0.000000,6.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.270300,0.000000,4.919300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.270300,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.270300,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.541500,0.000000,4.648200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<69.270300,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.999200,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.541500,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<68.999200,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.090600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.090600,0.000000,4.919300>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,90.000000,0> translate<70.090600,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.090600,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.361700,0.000000,4.919300>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<70.090600,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.361700,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.361700,0.000000,4.648200>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.361700,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.361700,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.090600,0.000000,4.648200>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<70.090600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.909100,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.180200,0.000000,6.275100>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<70.909100,0.000000,6.275100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.180200,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.180200,0.000000,4.648200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.180200,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.909100,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.451400,0.000000,4.648200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<70.909100,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.000500,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.000500,0.000000,4.919300>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.000500,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.000500,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.271600,0.000000,4.648200>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<72.000500,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.271600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.085100,0.000000,4.648200>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<72.271600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.085100,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.085100,0.000000,4.377100>}
box{<0,0,-0.076200><1.355700,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.085100,0.000000,4.377100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.085100,0.000000,4.377100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.813900,0.000000,4.105900>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.813900,0.000000,4.105900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.813900,0.000000,4.105900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.542800,0.000000,4.105900>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<72.542800,0.000000,4.105900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.637600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.722200,0.000000,6.275100>}
box{<0,0,-0.076200><1.955290,0.036000,0.076200> rotate<0,-56.306216,0> translate<73.637600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.274700,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.274700,0.000000,5.732800>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<75.274700,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.274700,0.000000,5.190500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.817000,0.000000,5.732800>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<75.274700,0.000000,5.190500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.817000,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.088100,0.000000,5.732800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<75.817000,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.910000,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.452300,0.000000,5.732800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<76.910000,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.452300,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.723500,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<77.452300,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.723500,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.723500,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.723500,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.723500,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.910000,0.000000,4.648200>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<76.910000,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.910000,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.638900,0.000000,4.919300>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<76.638900,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.638900,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.910000,0.000000,5.190500>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<76.638900,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.910000,0.000000,5.190500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.723500,0.000000,5.190500>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<76.910000,0.000000,5.190500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.276000,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.276000,0.000000,4.648200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.276000,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.276000,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.360600,0.000000,4.648200>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<78.276000,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.913100,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.997700,0.000000,4.648200>}
box{<0,0,-0.076200><1.533856,0.036000,0.076200> rotate<0,44.997030,0> translate<79.913100,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.913100,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.997700,0.000000,5.732800>}
box{<0,0,-0.076200><1.533856,0.036000,0.076200> rotate<0,-44.997030,0> translate<79.913100,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.550200,0.000000,4.105900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.550200,0.000000,5.732800>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<81.550200,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.550200,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.363600,0.000000,5.732800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<81.550200,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.363600,0.000000,5.732800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.634800,0.000000,5.461600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<82.363600,0.000000,5.732800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.634800,0.000000,5.461600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.634800,0.000000,4.919300>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.634800,0.000000,4.919300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.634800,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.363600,0.000000,4.648200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<82.363600,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.363600,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.550200,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<81.550200,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.187300,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.187300,0.000000,4.648200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.187300,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.187300,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.000700,0.000000,4.648200>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<83.187300,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.000700,0.000000,4.648200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.271900,0.000000,4.919300>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<84.000700,0.000000,4.648200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.271900,0.000000,4.919300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.271900,0.000000,6.004000>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,90.000000,0> translate<84.271900,0.000000,6.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.271900,0.000000,6.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.000700,0.000000,6.275100>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<84.000700,0.000000,6.275100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.000700,0.000000,6.275100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.187300,0.000000,6.275100>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<83.187300,0.000000,6.275100> }
//CH1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.685000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.685000,0.000000,27.940000>}
box{<0,0,-0.063500><17.780000,0.036000,0.063500> rotate<0,-90.000000,0> translate<19.685000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.685000,0.000000,27.940000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.335000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.685000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,45.720000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.335000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<20.955000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,31.369000>}
box{<0,0,-0.063500><4.699000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.065000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,26.670000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.065000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,46.990000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.065000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,32.258000>}
box{<0,0,-0.063500><4.318000,0.036000,0.063500> rotate<0,90.000000,0> translate<13.335000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<14.097000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<14.097000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<14.097000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<14.097000,0.000000,38.862000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.335000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,45.720000>}
box{<0,0,-0.063500><6.858000,0.036000,0.063500> rotate<0,90.000000,0> translate<13.335000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,38.862000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.081000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<14.097000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,34.798000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.335000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,34.798000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.081000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,27.940000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<20.955000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,29.210000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<21.209000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,29.210000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<20.955000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,26.670000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<20.955000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,37.465000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<21.209000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,36.195000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<20.955000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,29.210000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<20.955000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,37.465000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<20.955000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<21.209000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,45.720000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<20.955000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.209000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,44.450000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<20.955000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.955000,0.000000,37.465000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<20.955000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,34.798000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.065000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.065000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,33.782000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.081000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,90.000000,0> translate<13.335000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,32.258000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.081000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.335000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<13.335000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,34.290000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,36.867464,0> translate<12.065000,0.000000,34.671000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,31.369000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,-36.867464,0> translate<12.065000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.573000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,34.798000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,90.000000,0> translate<13.081000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.065000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,27.686000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<13.081000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.939000,0.000000,27.686000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<13.081000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.939000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.939000,0.000000,45.974000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,90.000000,0> translate<19.939000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.939000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,45.974000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<13.081000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.081000,0.000000,38.862000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,-90.000000,0> translate<13.081000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,38.862000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.065000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,33.782000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.573000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,34.290000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.573000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.081000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.573000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.573000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.573000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,41.275000>}
box{<0,0,-0.063500><2.413000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.065000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.192000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,41.275000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.065000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.192000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.192000,0.000000,42.545000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.192000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.192000,0.000000,42.545000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.065000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.065000,0.000000,46.990000>}
box{<0,0,-0.063500><4.445000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.065000,0.000000,46.990000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<17.780000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<17.780000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<17.780000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<17.780000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<17.780000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<15.240000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<15.240000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<15.240000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<15.240000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<15.240000,0.000000,34.290000>}
//CH2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.655000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.655000,0.000000,27.940000>}
box{<0,0,-0.063500><17.780000,0.036000,0.063500> rotate<0,-90.000000,0> translate<33.655000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.655000,0.000000,27.940000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.305000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.655000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,45.720000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.305000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<34.925000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,31.369000>}
box{<0,0,-0.063500><4.699000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.035000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,26.670000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.035000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,46.990000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.035000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,32.258000>}
box{<0,0,-0.063500><4.318000,0.036000,0.063500> rotate<0,90.000000,0> translate<27.305000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.067000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.067000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<28.067000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.067000,0.000000,38.862000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.305000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,45.720000>}
box{<0,0,-0.063500><6.858000,0.036000,0.063500> rotate<0,90.000000,0> translate<27.305000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,38.862000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.051000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.067000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,34.798000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.305000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,34.798000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.051000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,27.940000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<34.925000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,29.210000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<35.179000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,29.210000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<34.925000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,26.670000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<34.925000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,37.465000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<35.179000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,36.195000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<34.925000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,29.210000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<34.925000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,37.465000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<34.925000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<35.179000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,45.720000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<34.925000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.179000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,44.450000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<34.925000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.925000,0.000000,37.465000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<34.925000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,34.798000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.035000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.035000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,33.782000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.051000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,90.000000,0> translate<27.305000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,32.258000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<27.051000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<27.305000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,34.290000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,36.867464,0> translate<26.035000,0.000000,34.671000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,31.369000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,-36.867464,0> translate<26.035000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.543000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,34.798000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,90.000000,0> translate<27.051000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.035000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,27.686000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<27.051000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.909000,0.000000,27.686000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<27.051000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.909000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.909000,0.000000,45.974000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.909000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.909000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,45.974000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<27.051000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.051000,0.000000,38.862000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,-90.000000,0> translate<27.051000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,38.862000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.035000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,33.782000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.543000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,34.290000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.543000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.051000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.543000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.543000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.543000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,41.275000>}
box{<0,0,-0.063500><2.413000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.035000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.162000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,41.275000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.035000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.162000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.162000,0.000000,42.545000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.162000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.162000,0.000000,42.545000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<26.035000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.035000,0.000000,46.990000>}
box{<0,0,-0.063500><4.445000,0.036000,0.063500> rotate<0,90.000000,0> translate<26.035000,0.000000,46.990000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<31.750000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<31.750000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<31.750000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<31.750000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<31.750000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<29.210000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<29.210000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<29.210000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<29.210000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<29.210000,0.000000,34.290000>}
//CH3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.625000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.625000,0.000000,27.940000>}
box{<0,0,-0.063500><17.780000,0.036000,0.063500> rotate<0,-90.000000,0> translate<47.625000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.625000,0.000000,27.940000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.275000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.625000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,45.720000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.275000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<48.895000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,31.369000>}
box{<0,0,-0.063500><4.699000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.005000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,26.670000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.005000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,46.990000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.005000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,32.258000>}
box{<0,0,-0.063500><4.318000,0.036000,0.063500> rotate<0,90.000000,0> translate<41.275000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.037000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.037000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<42.037000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.037000,0.000000,38.862000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.275000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,45.720000>}
box{<0,0,-0.063500><6.858000,0.036000,0.063500> rotate<0,90.000000,0> translate<41.275000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,38.862000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.021000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.037000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,34.798000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.275000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,34.798000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.021000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,27.940000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<48.895000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,29.210000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<49.149000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,29.210000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<48.895000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,26.670000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<48.895000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,37.465000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<49.149000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,36.195000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<48.895000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,29.210000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<48.895000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,37.465000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<48.895000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<49.149000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,45.720000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<48.895000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<49.149000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,44.450000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<48.895000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.895000,0.000000,37.465000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<48.895000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,34.798000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.005000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.005000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,33.782000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.021000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,90.000000,0> translate<41.275000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,32.258000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<41.021000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.275000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<41.275000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,34.290000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,36.867464,0> translate<40.005000,0.000000,34.671000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,31.369000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,-36.867464,0> translate<40.005000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.513000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,34.798000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,90.000000,0> translate<41.021000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.005000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,27.686000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<41.021000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<47.879000,0.000000,27.686000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<41.021000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<47.879000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<47.879000,0.000000,45.974000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,90.000000,0> translate<47.879000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<47.879000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,45.974000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<41.021000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.021000,0.000000,38.862000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,-90.000000,0> translate<41.021000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,38.862000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.005000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,33.782000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.513000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,34.290000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.513000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.021000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.513000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.513000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.513000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,41.275000>}
box{<0,0,-0.063500><2.413000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.005000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,41.275000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.005000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,42.545000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.132000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,42.545000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.005000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.005000,0.000000,46.990000>}
box{<0,0,-0.063500><4.445000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.005000,0.000000,46.990000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<45.720000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<45.720000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<45.720000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<45.720000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<45.720000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<43.180000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<43.180000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<43.180000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<43.180000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<43.180000,0.000000,34.290000>}
//CH4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<61.595000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<61.595000,0.000000,27.940000>}
box{<0,0,-0.063500><17.780000,0.036000,0.063500> rotate<0,-90.000000,0> translate<61.595000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<61.595000,0.000000,27.940000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<55.245000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<61.595000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,45.720000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<55.245000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<62.865000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,31.369000>}
box{<0,0,-0.063500><4.699000,0.036000,0.063500> rotate<0,90.000000,0> translate<53.975000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,26.670000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<53.975000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,46.990000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<53.975000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,32.258000>}
box{<0,0,-0.063500><4.318000,0.036000,0.063500> rotate<0,90.000000,0> translate<55.245000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<56.007000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<56.007000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<56.007000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<56.007000,0.000000,38.862000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<55.245000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,45.720000>}
box{<0,0,-0.063500><6.858000,0.036000,0.063500> rotate<0,90.000000,0> translate<55.245000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,38.862000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<54.991000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<56.007000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,34.798000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<55.245000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,34.798000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<54.991000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,27.940000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<62.865000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,29.210000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<63.119000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,29.210000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<62.865000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,26.670000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<62.865000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,37.465000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<63.119000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,36.195000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<62.865000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,29.210000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<62.865000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,37.465000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<62.865000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<63.119000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,45.720000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<62.865000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<63.119000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,44.450000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<62.865000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<62.865000,0.000000,37.465000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<62.865000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,34.798000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<53.975000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<53.975000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,33.782000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<54.991000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,90.000000,0> translate<55.245000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,32.258000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<54.991000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<55.245000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<55.245000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,34.290000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,36.867464,0> translate<53.975000,0.000000,34.671000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,31.369000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,-36.867464,0> translate<53.975000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<54.483000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,34.798000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,90.000000,0> translate<54.991000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<53.975000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,27.686000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<54.991000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.849000,0.000000,27.686000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<54.991000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.849000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.849000,0.000000,45.974000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,90.000000,0> translate<61.849000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.849000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,45.974000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<54.991000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<54.991000,0.000000,38.862000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,-90.000000,0> translate<54.991000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,38.862000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<53.975000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,33.782000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<54.483000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,34.290000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<54.483000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.991000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<54.483000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.483000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<54.483000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,41.275000>}
box{<0,0,-0.063500><2.413000,0.036000,0.063500> rotate<0,90.000000,0> translate<53.975000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.102000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,41.275000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<53.975000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.102000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.102000,0.000000,42.545000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<54.102000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<54.102000,0.000000,42.545000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<53.975000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<53.975000,0.000000,46.990000>}
box{<0,0,-0.063500><4.445000,0.036000,0.063500> rotate<0,90.000000,0> translate<53.975000,0.000000,46.990000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<59.690000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<59.690000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<59.690000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<59.690000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<59.690000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<57.150000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<57.150000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<57.150000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<57.150000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<57.150000,0.000000,34.290000>}
//CH5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.565000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.565000,0.000000,27.940000>}
box{<0,0,-0.063500><17.780000,0.036000,0.063500> rotate<0,-90.000000,0> translate<75.565000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.565000,0.000000,27.940000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<69.215000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.565000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,45.720000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<69.215000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<76.835000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,31.369000>}
box{<0,0,-0.063500><4.699000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.945000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,26.670000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.945000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,46.990000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.945000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,32.258000>}
box{<0,0,-0.063500><4.318000,0.036000,0.063500> rotate<0,90.000000,0> translate<69.215000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.977000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.977000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<69.977000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.977000,0.000000,38.862000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<69.215000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,45.720000>}
box{<0,0,-0.063500><6.858000,0.036000,0.063500> rotate<0,90.000000,0> translate<69.215000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,38.862000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.961000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.977000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,34.798000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<69.215000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,34.798000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.961000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,27.940000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<76.835000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,29.210000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<77.089000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,29.210000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<76.835000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,26.670000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<76.835000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,37.465000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<77.089000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,36.195000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<76.835000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,29.210000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<76.835000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,37.465000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<76.835000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<77.089000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,45.720000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<76.835000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.089000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,44.450000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<76.835000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.835000,0.000000,37.465000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<76.835000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,34.798000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.945000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.945000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,33.782000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.961000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,90.000000,0> translate<69.215000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,32.258000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.961000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.215000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<69.215000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,34.290000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,36.867464,0> translate<67.945000,0.000000,34.671000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,31.369000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,-36.867464,0> translate<67.945000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<68.453000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,34.798000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.961000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.945000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,27.686000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<68.961000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.819000,0.000000,27.686000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<68.961000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.819000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.819000,0.000000,45.974000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,90.000000,0> translate<75.819000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.819000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,45.974000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<68.961000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.961000,0.000000,38.862000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,-90.000000,0> translate<68.961000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,38.862000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.945000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,33.782000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.453000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,34.290000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<68.453000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.961000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.453000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.453000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<68.453000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,41.275000>}
box{<0,0,-0.063500><2.413000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.945000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.072000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,41.275000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.945000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.072000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.072000,0.000000,42.545000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<68.072000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.072000,0.000000,42.545000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.945000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.945000,0.000000,46.990000>}
box{<0,0,-0.063500><4.445000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.945000,0.000000,46.990000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<73.660000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<73.660000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<73.660000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<73.660000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<73.660000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<71.120000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<71.120000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<71.120000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<71.120000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<71.120000,0.000000,34.290000>}
//CH6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<89.535000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<89.535000,0.000000,27.940000>}
box{<0,0,-0.063500><17.780000,0.036000,0.063500> rotate<0,-90.000000,0> translate<89.535000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<89.535000,0.000000,27.940000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<83.185000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<89.535000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,45.720000>}
box{<0,0,-0.063500><6.350000,0.036000,0.063500> rotate<0,0.000000,0> translate<83.185000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<90.805000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,31.369000>}
box{<0,0,-0.063500><4.699000,0.036000,0.063500> rotate<0,90.000000,0> translate<81.915000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,26.670000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<81.915000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,46.990000>}
box{<0,0,-0.063500><8.890000,0.036000,0.063500> rotate<0,0.000000,0> translate<81.915000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,32.258000>}
box{<0,0,-0.063500><4.318000,0.036000,0.063500> rotate<0,90.000000,0> translate<83.185000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.947000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.947000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<83.947000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.947000,0.000000,38.862000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<83.185000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,45.720000>}
box{<0,0,-0.063500><6.858000,0.036000,0.063500> rotate<0,90.000000,0> translate<83.185000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,38.862000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<82.931000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.947000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,34.798000>}
box{<0,0,-0.063500><0.762000,0.036000,0.063500> rotate<0,0.000000,0> translate<83.185000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,34.798000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<82.931000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,27.940000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<90.805000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,29.210000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<91.059000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,29.210000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<90.805000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,26.670000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<90.805000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,37.465000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<91.059000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,36.195000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<90.805000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,29.210000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<90.805000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,37.465000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<90.805000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,45.720000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<91.059000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,45.720000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<90.805000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<91.059000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,44.450000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<90.805000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.805000,0.000000,37.465000>}
box{<0,0,-0.063500><6.985000,0.036000,0.063500> rotate<0,-90.000000,0> translate<90.805000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,34.798000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<81.915000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,38.862000>}
box{<0,0,-0.063500><4.064000,0.036000,0.063500> rotate<0,90.000000,0> translate<81.915000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,33.782000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<82.931000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,90.000000,0> translate<83.185000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,32.258000>}
box{<0,0,-0.063500><0.254000,0.036000,0.063500> rotate<0,0.000000,0> translate<82.931000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<83.185000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<83.185000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,34.290000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,36.867464,0> translate<81.915000,0.000000,34.671000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,31.369000>}
box{<0,0,-0.063500><0.635000,0.036000,0.063500> rotate<0,-36.867464,0> translate<81.915000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<82.423000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,34.798000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,90.000000,0> translate<82.931000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,34.798000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,34.798000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<81.915000,0.000000,34.798000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,27.686000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<82.931000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<89.789000,0.000000,27.686000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<82.931000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<89.789000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<89.789000,0.000000,45.974000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,90.000000,0> translate<89.789000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<89.789000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,45.974000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<82.931000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<82.931000,0.000000,38.862000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,-90.000000,0> translate<82.931000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,38.862000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<81.915000,0.000000,38.862000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,33.782000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<82.423000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,33.782000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,34.290000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<82.423000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.931000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,32.258000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<82.423000,0.000000,32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.423000,0.000000,33.782000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<82.423000,0.000000,33.782000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,38.862000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,41.275000>}
box{<0,0,-0.063500><2.413000,0.036000,0.063500> rotate<0,90.000000,0> translate<81.915000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.042000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,41.275000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<81.915000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.042000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.042000,0.000000,42.545000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<82.042000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<82.042000,0.000000,42.545000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<81.915000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.915000,0.000000,46.990000>}
box{<0,0,-0.063500><4.445000,0.036000,0.063500> rotate<0,90.000000,0> translate<81.915000,0.000000,46.990000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<87.630000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<87.630000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<87.630000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<87.630000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<87.630000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<85.090000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<85.090000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<85.090000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<85.090000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<85.090000,0.000000,34.290000>}
//CHMOD silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.992000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.738000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.992000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.992000,0.000000,12.192000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.992000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.992000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.738000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,13.970000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.738000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.388000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.388000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.388000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.388000,0.000000,10.668000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.388000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.388000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.388000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,14.478000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<62.230000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.230000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.738000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,13.970000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<56.642000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,12.446000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.642000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<56.642000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.642000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,-90.000000,0> translate<58.420000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.960000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<58.420000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.960000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.960000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,90.000000,0> translate<60.960000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.960000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<58.420000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,14.224000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<58.420000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.960000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,14.224000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<58.420000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.960000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.960000,0.000000,14.478000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<60.960000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.833000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,8.636000>}
box{<0,0,-0.025400><2.413000,0.036000,0.025400> rotate<0,0.000000,0> translate<58.420000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.833000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.833000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<60.833000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.420000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<58.420000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.849000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,8.382000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.531000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.849000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.960000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.960000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.960000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,14.478000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.531000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.833000,0.000000,8.382000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.833000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,8.382000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.833000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.738000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.738000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.642000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.642000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.960000,0.000000,9.271000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.960000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,13.716000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.277000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.277000,0.000000,11.938000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.277000,0.000000,11.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.277000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.277000,0.000000,10.160000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.277000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.277000,0.000000,11.938000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,11.049000>}
box{<0,0,-0.076200><0.924574,0.036000,0.076200> rotate<0,74.049717,0> translate<57.277000,0.000000,11.938000> }
difference{
cylinder{<59.690000,0,11.430000><59.690000,0.036000,11.430000>1.854200 translate<0,0.000000,0>}
cylinder{<59.690000,-0.1,11.430000><59.690000,0.135000,11.430000>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<57.531000,0,9.271000><57.531000,0.036000,9.271000>0.584200 translate<0,0.000000,0>}
cylinder{<57.531000,-0.1,9.271000><57.531000,0.135000,9.271000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<61.849000,0,9.398000><61.849000,0.036000,9.398000>0.584200 translate<0,0.000000,0>}
cylinder{<61.849000,-0.1,9.398000><61.849000,0.135000,9.398000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<61.849000,0,13.589000><61.849000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<61.849000,-0.1,13.589000><61.849000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<57.531000,0,13.589000><57.531000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<57.531000,-0.1,13.589000><57.531000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<59.690000,0,11.430000><59.690000,0.036000,11.430000>0.660400 translate<0,0.000000,0>}
cylinder{<59.690000,-0.1,11.430000><59.690000,0.135000,11.430000>0.609600 translate<0,0.000000,0>}}
difference{
cylinder{<59.690000,0,11.430000><59.690000,0.036000,11.430000>0.330200 translate<0,0.000000,0>}
cylinder{<59.690000,-0.1,11.430000><59.690000,0.135000,11.430000>0.177800 translate<0,0.000000,0>}}
//CS silk screen
//ERROR silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,49.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,49.800000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,49.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,49.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,51.800000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<6.210000,0.000000,51.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,51.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,51.800000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,51.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,49.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,49.800000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,49.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,49.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,51.800000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.410000,0.000000,51.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,51.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,51.800000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,51.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,50.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,50.800000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,51.500000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,51.500000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,50.200000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,44.997030,0> translate<3.510000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,50.200000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,51.400000>}
box{<0,0,-0.101600><1.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<4.110000,0.000000,51.400000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,51.400000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,50.800000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.510000,0.000000,50.800000> }
//LOGO2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<95.656400,0.000000,2.184400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<95.148400,0.000000,1.041400>}
box{<0,0,-0.127000><1.250805,0.036000,0.127000> rotate<0,-66.033153,0> translate<95.148400,0.000000,1.041400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<95.148400,0.000000,1.041400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.894400,0.000000,1.193800>}
box{<0,0,-0.127000><0.296212,0.036000,0.127000> rotate<0,30.961713,0> translate<94.894400,0.000000,1.193800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.894400,0.000000,1.193800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.284800,0.000000,0.762000>}
box{<0,0,-0.127000><0.747036,0.036000,0.127000> rotate<0,-35.308883,0> translate<94.284800,0.000000,0.762000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.284800,0.000000,0.762000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.827600,0.000000,1.244600>}
box{<0,0,-0.127000><0.664782,0.036000,0.127000> rotate<0,46.545086,0> translate<93.827600,0.000000,1.244600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.827600,0.000000,1.244600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.234000,0.000000,1.854200>}
box{<0,0,-0.127000><0.732648,0.036000,0.127000> rotate<0,-56.306216,0> translate<93.827600,0.000000,1.244600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.980000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.218000,0.000000,2.667000>}
box{<0,0,-0.127000><0.772511,0.036000,0.127000> rotate<0,9.461698,0> translate<93.218000,0.000000,2.667000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.218000,0.000000,2.667000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.218000,0.000000,3.327400>}
box{<0,0,-0.127000><0.660400,0.036000,0.127000> rotate<0,90.000000,0> translate<93.218000,0.000000,3.327400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.218000,0.000000,3.327400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.980000,0.000000,3.479800>}
box{<0,0,-0.127000><0.777091,0.036000,0.127000> rotate<0,-11.309186,0> translate<93.218000,0.000000,3.327400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.259400,0.000000,4.114800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.802200,0.000000,4.775200>}
box{<0,0,-0.127000><0.803219,0.036000,0.127000> rotate<0,55.301197,0> translate<93.802200,0.000000,4.775200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.802200,0.000000,4.775200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.284800,0.000000,5.232400>}
box{<0,0,-0.127000><0.664782,0.036000,0.127000> rotate<0,-43.448975,0> translate<93.802200,0.000000,4.775200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.284800,0.000000,5.232400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<94.945200,0.000000,4.775200>}
box{<0,0,-0.127000><0.803219,0.036000,0.127000> rotate<0,34.692864,0> translate<94.284800,0.000000,5.232400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<95.580200,0.000000,5.029200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<95.707200,0.000000,5.842000>}
box{<0,0,-0.127000><0.822662,0.036000,0.127000> rotate<0,-81.113987,0> translate<95.580200,0.000000,5.029200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<95.707200,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<96.393000,0.000000,5.842000>}
box{<0,0,-0.127000><0.685800,0.036000,0.127000> rotate<0,0.000000,0> translate<95.707200,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<96.393000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<96.520000,0.000000,5.029200>}
box{<0,0,-0.127000><0.822662,0.036000,0.127000> rotate<0,81.113987,0> translate<96.393000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.155000,0.000000,4.775200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.815400,0.000000,5.232400>}
box{<0,0,-0.127000><0.803219,0.036000,0.127000> rotate<0,-34.692864,0> translate<97.155000,0.000000,4.775200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.815400,0.000000,5.232400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.298000,0.000000,4.775200>}
box{<0,0,-0.127000><0.664782,0.036000,0.127000> rotate<0,43.448975,0> translate<97.815400,0.000000,5.232400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.298000,0.000000,4.775200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.840800,0.000000,4.114800>}
box{<0,0,-0.127000><0.803219,0.036000,0.127000> rotate<0,-55.301197,0> translate<97.840800,0.000000,4.114800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.120200,0.000000,3.479800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.882200,0.000000,3.327400>}
box{<0,0,-0.127000><0.777091,0.036000,0.127000> rotate<0,11.309186,0> translate<98.120200,0.000000,3.479800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.882200,0.000000,3.327400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.882200,0.000000,2.667000>}
box{<0,0,-0.127000><0.660400,0.036000,0.127000> rotate<0,-90.000000,0> translate<98.882200,0.000000,2.667000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.882200,0.000000,2.667000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.120200,0.000000,2.540000>}
box{<0,0,-0.127000><0.772511,0.036000,0.127000> rotate<0,-9.461698,0> translate<98.120200,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.866200,0.000000,1.854200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.298000,0.000000,1.244600>}
box{<0,0,-0.127000><0.747036,0.036000,0.127000> rotate<0,54.685177,0> translate<97.866200,0.000000,1.854200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<98.298000,0.000000,1.244600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.815400,0.000000,0.762000>}
box{<0,0,-0.127000><0.682499,0.036000,0.127000> rotate<0,-44.997030,0> translate<97.815400,0.000000,0.762000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.815400,0.000000,0.762000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.205800,0.000000,1.193800>}
box{<0,0,-0.127000><0.747036,0.036000,0.127000> rotate<0,35.308883,0> translate<97.205800,0.000000,1.193800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<97.205800,0.000000,1.193800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<96.951800,0.000000,1.041400>}
box{<0,0,-0.127000><0.296212,0.036000,0.127000> rotate<0,-30.961713,0> translate<96.951800,0.000000,1.041400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<96.951800,0.000000,1.041400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<96.469200,0.000000,2.184400>}
box{<0,0,-0.127000><1.240706,0.036000,0.127000> rotate<0,67.105019,0> translate<96.469200,0.000000,2.184400> }
object{ARC(0.931500,0.254000,295.866357,604.133643,0.036000) translate<96.062800,0.000000,3.048000>}
object{ARC(2.114000,0.254000,191.326942,211.000942,0.036000) translate<96.054500,0.000000,2.951200>}
object{ARC(2.116300,0.254000,147.666890,166.038612,0.036000) translate<96.049700,0.000000,2.969300>}
object{ARC(2.114200,0.254000,103.186364,121.018598,0.036000) translate<96.043500,0.000000,2.972400>}
object{ARC(2.123700,0.254000,58.681828,77.131160,0.036000) translate<96.060500,0.000000,2.965200>}
object{ARC(2.058000,0.254000,14.267851,33.571154,0.036000) translate<96.123200,0.000000,2.972700>}
object{ARC(2.052700,0.254000,329.142995,349.487684,0.036000) translate<96.104300,0.000000,2.905700>}
//MISO silk screen
//MODE silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,34.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,34.560000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,34.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,34.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,36.560000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<6.210000,0.000000,36.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,36.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,36.560000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,36.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,34.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,34.560000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,34.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,34.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,36.560000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.410000,0.000000,36.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,36.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,36.560000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,36.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,34.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,35.560000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,36.260000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,36.260000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,34.960000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,44.997030,0> translate<3.510000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,34.960000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,36.160000>}
box{<0,0,-0.101600><1.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<4.110000,0.000000,36.160000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,36.160000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,35.560000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.510000,0.000000,35.560000> }
//MOSI silk screen
//MP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<1.370000,0.000000,2.240000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<1.370000,0.000000,1.240000>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<1.370000,0.000000,1.240000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<1.370000,0.000000,1.240000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<16.470000,0.000000,1.240000>}
box{<0,0,-0.063500><15.100000,0.036000,0.063500> rotate<0,0.000000,0> translate<1.370000,0.000000,1.240000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<16.470000,0.000000,1.240000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<16.470000,0.000000,15.240000>}
box{<0,0,-0.063500><14.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<16.470000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<16.470000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.070000,0.000000,15.240000>}
box{<0,0,-0.063500><14.400000,0.036000,0.063500> rotate<0,0.000000,0> translate<2.070000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.070000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.070000,0.000000,14.240000>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<2.070000,0.000000,14.240000> }
object{ARC(0.806200,0.127000,7.125016,97.125016,0.036000) translate<2.170000,0.000000,13.440000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.970000,0.000000,13.540000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.970000,0.000000,3.840000>}
box{<0,0,-0.063500><9.700000,0.036000,0.063500> rotate<0,-90.000000,0> translate<2.970000,0.000000,3.840000> }
object{ARC(1.600000,0.127000,270.000000,360.000000,0.036000) translate<1.370000,0.000000,3.840000>}
object{ARC(1.200000,0.127000,90.000000,180.000000,0.036000) translate<1.810000,0.000000,13.640000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.610000,0.000000,13.640000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.610000,0.000000,4.440000>}
box{<0,0,-0.063500><9.200000,0.036000,0.063500> rotate<0,-90.000000,0> translate<0.610000,0.000000,4.440000> }
object{ARC(1.204200,0.127000,175.236358,265.236358,0.036000) translate<1.810000,0.000000,4.340000>}
//Q1 silk screen
object{ARC(2.667000,0.203200,107.146796,218.245791,0.036000) translate<16.510000,0.000000,22.860000>}
object{ARC(2.666900,0.203200,321.752879,432.852571,0.036000) translate<16.510000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.415500,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.604500,0.000000,21.209000>}
box{<0,0,-0.101600><4.189000,0.036000,0.101600> rotate<0,0.000000,0> translate<14.415500,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.855100,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.256300,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<13.855100,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.223700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.796300,0.000000,22.606000>}
box{<0,0,-0.101600><0.572600,0.036000,0.101600> rotate<0,0.000000,0> translate<16.223700,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.763700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.164900,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<18.763700,0.000000,22.606000> }
//Q2 silk screen
object{ARC(2.667000,0.203200,107.146796,218.245791,0.036000) translate<30.480000,0.000000,22.860000>}
object{ARC(2.666900,0.203200,321.752879,432.852571,0.036000) translate<30.480000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.385500,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.574500,0.000000,21.209000>}
box{<0,0,-0.101600><4.189000,0.036000,0.101600> rotate<0,0.000000,0> translate<28.385500,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.825100,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.226300,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<27.825100,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.193700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.766300,0.000000,22.606000>}
box{<0,0,-0.101600><0.572600,0.036000,0.101600> rotate<0,0.000000,0> translate<30.193700,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.733700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.134900,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<32.733700,0.000000,22.606000> }
//Q3 silk screen
object{ARC(2.667000,0.203200,107.146796,218.245791,0.036000) translate<44.450000,0.000000,22.860000>}
object{ARC(2.666900,0.203200,321.752879,432.852571,0.036000) translate<44.450000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.355500,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.544500,0.000000,21.209000>}
box{<0,0,-0.101600><4.189000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.355500,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.795100,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.196300,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<41.795100,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.163700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.736300,0.000000,22.606000>}
box{<0,0,-0.101600><0.572600,0.036000,0.101600> rotate<0,0.000000,0> translate<44.163700,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.703700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.104900,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<46.703700,0.000000,22.606000> }
//Q4 silk screen
object{ARC(2.667000,0.203200,107.146796,218.245791,0.036000) translate<58.420000,0.000000,22.860000>}
object{ARC(2.666900,0.203200,321.752879,432.852571,0.036000) translate<58.420000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.325500,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.514500,0.000000,21.209000>}
box{<0,0,-0.101600><4.189000,0.036000,0.101600> rotate<0,0.000000,0> translate<56.325500,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.765100,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.166300,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<55.765100,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.133700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.706300,0.000000,22.606000>}
box{<0,0,-0.101600><0.572600,0.036000,0.101600> rotate<0,0.000000,0> translate<58.133700,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.673700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<61.074900,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<60.673700,0.000000,22.606000> }
//Q5 silk screen
object{ARC(2.667000,0.203200,107.146796,218.245791,0.036000) translate<72.390000,0.000000,22.860000>}
object{ARC(2.666900,0.203200,321.752879,432.852571,0.036000) translate<72.390000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.295500,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<74.484500,0.000000,21.209000>}
box{<0,0,-0.101600><4.189000,0.036000,0.101600> rotate<0,0.000000,0> translate<70.295500,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.735100,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.136300,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<69.735100,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<72.103700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<72.676300,0.000000,22.606000>}
box{<0,0,-0.101600><0.572600,0.036000,0.101600> rotate<0,0.000000,0> translate<72.103700,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<74.643700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<75.044900,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<74.643700,0.000000,22.606000> }
//Q6 silk screen
object{ARC(2.667000,0.203200,107.146796,218.245791,0.036000) translate<86.360000,0.000000,22.860000>}
object{ARC(2.666900,0.203200,321.752879,432.852571,0.036000) translate<86.360000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<84.265500,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<88.454500,0.000000,21.209000>}
box{<0,0,-0.101600><4.189000,0.036000,0.101600> rotate<0,0.000000,0> translate<84.265500,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<83.705100,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<84.106300,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<83.705100,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<86.073700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<86.646300,0.000000,22.606000>}
box{<0,0,-0.101600><0.572600,0.036000,0.101600> rotate<0,0.000000,0> translate<86.073700,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<88.613700,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<89.014900,0.000000,22.606000>}
box{<0,0,-0.101600><0.401200,0.036000,0.101600> rotate<0,0.000000,0> translate<88.613700,0.000000,22.606000> }
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.974000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.974000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.974000,0.000000,24.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.174000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.174000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.174000,0.000000,24.938000> }
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.944000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.944000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.944000,0.000000,24.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.144000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.144000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.144000,0.000000,24.938000> }
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.914000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.914000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.914000,0.000000,24.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.114000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.114000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.114000,0.000000,24.938000> }
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.884000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.884000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.884000,0.000000,24.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.084000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.084000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.084000,0.000000,24.938000> }
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.322000,0.000000,38.827000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.922000,0.000000,38.827000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.322000,0.000000,38.827000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.322000,0.000000,37.627000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.922000,0.000000,37.627000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.322000,0.000000,37.627000> }
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,31.842000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,31.842000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,31.842000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,30.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,30.642000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,30.642000> }
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.292000,0.000000,38.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.892000,0.000000,38.954000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.292000,0.000000,38.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.292000,0.000000,37.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.892000,0.000000,37.754000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.292000,0.000000,37.754000> }
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.322000,0.000000,36.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.922000,0.000000,36.033000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.322000,0.000000,36.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.322000,0.000000,34.833000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.922000,0.000000,34.833000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.322000,0.000000,34.833000> }
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262000,0.000000,35.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.862000,0.000000,35.906000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.262000,0.000000,35.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262000,0.000000,34.706000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.862000,0.000000,34.706000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.262000,0.000000,34.706000> }
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.292000,0.000000,35.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.892000,0.000000,35.906000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.292000,0.000000,35.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.292000,0.000000,34.706000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.892000,0.000000,34.706000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.292000,0.000000,34.706000> }
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.832000,0.000000,37.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.232000,0.000000,37.500000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.232000,0.000000,37.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.832000,0.000000,38.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.232000,0.000000,38.700000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.232000,0.000000,38.700000> }
//R12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262000,0.000000,38.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.862000,0.000000,38.700000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.262000,0.000000,38.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.262000,0.000000,37.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.862000,0.000000,37.500000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.262000,0.000000,37.500000> }
//R13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.500000,0.000000,11.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.500000,0.000000,11.384000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,-90.000000,0> translate<89.500000,0.000000,11.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.300000,0.000000,11.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.300000,0.000000,11.384000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,-90.000000,0> translate<88.300000,0.000000,11.384000> }
//R14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.764000,0.000000,31.842000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.364000,0.000000,31.842000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.764000,0.000000,31.842000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.764000,0.000000,30.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.364000,0.000000,30.642000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.764000,0.000000,30.642000> }
//R15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.600000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.600000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<75.600000,0.000000,24.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.800000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.800000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.800000,0.000000,24.938000> }
//R16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.782000,0.000000,15.840000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.382000,0.000000,15.840000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.782000,0.000000,15.840000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.782000,0.000000,14.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.382000,0.000000,14.640000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.782000,0.000000,14.640000> }
//R17 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.570000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.570000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<89.570000,0.000000,24.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.770000,0.000000,24.338000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.770000,0.000000,24.938000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<90.770000,0.000000,24.938000> }
//R18 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.948000,0.000000,40.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.548000,0.000000,40.224000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.948000,0.000000,40.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.948000,0.000000,39.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.548000,0.000000,39.024000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.948000,0.000000,39.024000> }
//R19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.832000,0.000000,34.706000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.232000,0.000000,34.706000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.232000,0.000000,34.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.832000,0.000000,35.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.232000,0.000000,35.906000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.232000,0.000000,35.906000> }
//R20 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.948000,0.000000,34.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.548000,0.000000,34.636000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.948000,0.000000,34.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.948000,0.000000,33.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.548000,0.000000,33.436000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.948000,0.000000,33.436000> }
//R21 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.948000,0.000000,37.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.548000,0.000000,37.430000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.948000,0.000000,37.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.948000,0.000000,36.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.548000,0.000000,36.230000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.948000,0.000000,36.230000> }
//R22 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,40.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,40.040000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,40.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,41.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,41.240000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,41.240000> }
//R23 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,45.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,45.120000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,45.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,46.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,46.320000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,46.320000> }
//R24 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,50.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,50.200000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,50.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,51.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,51.400000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,51.400000> }
//R25 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,34.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,34.960000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,34.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.444000,0.000000,36.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.844000,0.000000,36.160000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.844000,0.000000,36.160000> }
//R26 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.894000,0.000000,11.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.894000,0.000000,11.384000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.894000,0.000000,11.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.694000,0.000000,11.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.694000,0.000000,11.384000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.694000,0.000000,11.384000> }
//R30 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.720000,0.000000,10.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.720000,0.000000,11.476000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.720000,0.000000,11.476000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,10.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,11.476000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.920000,0.000000,11.476000> }
//R31 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.768000,0.000000,10.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.768000,0.000000,11.476000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.768000,0.000000,11.476000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.968000,0.000000,10.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.968000,0.000000,11.476000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.968000,0.000000,11.476000> }
//R32 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.816000,0.000000,10.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.816000,0.000000,11.476000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.816000,0.000000,11.476000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,10.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,11.476000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.016000,0.000000,11.476000> }
//R54 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.720000,0.000000,4.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.720000,0.000000,4.618000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.720000,0.000000,4.618000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,4.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,4.618000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.920000,0.000000,4.618000> }
//R55 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.768000,0.000000,4.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.768000,0.000000,4.618000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.768000,0.000000,4.618000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.968000,0.000000,4.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.968000,0.000000,4.618000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.968000,0.000000,4.618000> }
//R56 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.816000,0.000000,4.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.816000,0.000000,4.618000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.816000,0.000000,4.618000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,4.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,4.618000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.016000,0.000000,4.618000> }
//READ silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,44.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,44.720000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,44.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,44.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,46.720000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<6.210000,0.000000,46.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,46.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,46.720000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,46.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,44.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,44.720000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,44.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,44.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,46.720000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.410000,0.000000,46.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,46.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,46.720000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,46.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,45.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,45.720000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,46.420000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,46.420000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,45.120000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,44.997030,0> translate<3.510000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,45.120000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,46.320000>}
box{<0,0,-0.101600><1.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<4.110000,0.000000,46.320000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,46.320000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,45.720000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.510000,0.000000,45.720000> }
//RESET silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.418000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,12.192000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.672000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.418000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,13.970000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.418000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.068000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,10.668000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.068000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.068000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,14.478000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.418000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,13.970000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.322000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,12.446000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.322000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<36.322000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.322000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,-90.000000,0> translate<38.100000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.640000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.100000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.640000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.640000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,90.000000,0> translate<40.640000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.640000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.100000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,14.224000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<38.100000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.640000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,14.224000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.100000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.640000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.640000,0.000000,14.478000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<40.640000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.513000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,8.636000>}
box{<0,0,-0.025400><2.413000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.100000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.513000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.513000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<40.513000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.100000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<38.100000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.529000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.211000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.830000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.211000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,8.382000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.211000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.211000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.830000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.529000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,14.478000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.211000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.211000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,8.382000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,8.382000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.513000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.418000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.418000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.322000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.322000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,9.271000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,13.716000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,11.938000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.957000,0.000000,11.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,10.160000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.957000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,11.938000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.211000,0.000000,11.049000>}
box{<0,0,-0.076200><0.924574,0.036000,0.076200> rotate<0,74.049717,0> translate<36.957000,0.000000,11.938000> }
difference{
cylinder{<39.370000,0,11.430000><39.370000,0.036000,11.430000>1.854200 translate<0,0.000000,0>}
cylinder{<39.370000,-0.1,11.430000><39.370000,0.135000,11.430000>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<37.211000,0,9.271000><37.211000,0.036000,9.271000>0.584200 translate<0,0.000000,0>}
cylinder{<37.211000,-0.1,9.271000><37.211000,0.135000,9.271000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<41.529000,0,9.398000><41.529000,0.036000,9.398000>0.584200 translate<0,0.000000,0>}
cylinder{<41.529000,-0.1,9.398000><41.529000,0.135000,9.398000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<41.529000,0,13.589000><41.529000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<41.529000,-0.1,13.589000><41.529000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<37.211000,0,13.589000><37.211000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<37.211000,-0.1,13.589000><37.211000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<39.370000,0,11.430000><39.370000,0.036000,11.430000>0.660400 translate<0,0.000000,0>}
cylinder{<39.370000,-0.1,11.430000><39.370000,0.135000,11.430000>0.609600 translate<0,0.000000,0>}}
difference{
cylinder{<39.370000,0,11.430000><39.370000,0.036000,11.430000>0.330200 translate<0,0.000000,0>}
cylinder{<39.370000,-0.1,11.430000><39.370000,0.135000,11.430000>0.177800 translate<0,0.000000,0>}}
//SAMPLE silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.852000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.598000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.852000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.852000,0.000000,12.192000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.852000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.852000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.598000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,13.970000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.598000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.248000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.248000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.248000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.248000,0.000000,10.668000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.248000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.248000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.248000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.090000,0.000000,14.478000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<85.090000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.090000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<85.090000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.598000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.010000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,13.970000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<79.502000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,12.446000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.502000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.010000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<79.502000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,-90.000000,0> translate<81.280000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.820000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<81.280000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.820000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.820000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,90.000000,0> translate<83.820000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.820000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<81.280000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,14.224000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<81.280000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.820000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,14.224000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<81.280000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.820000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.820000,0.000000,14.478000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<83.820000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.693000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,8.636000>}
box{<0,0,-0.025400><2.413000,0.036000,0.025400> rotate<0,0.000000,0> translate<81.280000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.693000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<83.693000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<83.693000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<81.280000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<81.280000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.090000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.709000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.709000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.010000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.391000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.010000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.391000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,8.382000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.391000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.010000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.391000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.010000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.090000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.709000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.709000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.709000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.820000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.820000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.820000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,14.478000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.280000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.391000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.391000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,8.382000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.280000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.709000,0.000000,8.382000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.693000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<85.598000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.598000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.598000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.502000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.820000,0.000000,9.271000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.280000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.820000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,13.716000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.280000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,11.938000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<80.137000,0.000000,11.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,10.160000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<80.137000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,11.938000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.391000,0.000000,11.049000>}
box{<0,0,-0.076200><0.924574,0.036000,0.076200> rotate<0,74.049717,0> translate<80.137000,0.000000,11.938000> }
difference{
cylinder{<82.550000,0,11.430000><82.550000,0.036000,11.430000>1.854200 translate<0,0.000000,0>}
cylinder{<82.550000,-0.1,11.430000><82.550000,0.135000,11.430000>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<80.391000,0,9.271000><80.391000,0.036000,9.271000>0.584200 translate<0,0.000000,0>}
cylinder{<80.391000,-0.1,9.271000><80.391000,0.135000,9.271000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<84.709000,0,9.398000><84.709000,0.036000,9.398000>0.584200 translate<0,0.000000,0>}
cylinder{<84.709000,-0.1,9.398000><84.709000,0.135000,9.398000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<84.709000,0,13.589000><84.709000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<84.709000,-0.1,13.589000><84.709000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<80.391000,0,13.589000><80.391000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<80.391000,-0.1,13.589000><80.391000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<82.550000,0,11.430000><82.550000,0.036000,11.430000>0.660400 translate<0,0.000000,0>}
cylinder{<82.550000,-0.1,11.430000><82.550000,0.135000,11.430000>0.609600 translate<0,0.000000,0>}}
difference{
cylinder{<82.550000,0,11.430000><82.550000,0.036000,11.430000>0.330200 translate<0,0.000000,0>}
cylinder{<82.550000,-0.1,11.430000><82.550000,0.135000,11.430000>0.177800 translate<0,0.000000,0>}}
//SCK silk screen
//STATUS silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,39.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,39.640000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,39.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,39.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,41.640000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<6.210000,0.000000,41.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.210000,0.000000,41.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.810000,0.000000,41.640000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.810000,0.000000,41.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,39.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,39.640000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,39.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,39.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,41.640000>}
box{<0,0,-0.101600><2.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.410000,0.000000,41.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.410000,0.000000,41.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.810000,0.000000,41.640000>}
box{<0,0,-0.101600><1.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.410000,0.000000,41.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,39.940000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,40.640000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,41.340000>}
box{<0,0,-0.101600><0.700000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.510000,0.000000,41.340000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,40.040000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,44.997030,0> translate<3.510000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,40.040000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,41.240000>}
box{<0,0,-0.101600><1.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<4.110000,0.000000,41.240000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.110000,0.000000,41.240000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.510000,0.000000,40.640000>}
box{<0,0,-0.101600><0.848528,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.510000,0.000000,40.640000> }
//U$1 silk screen
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.715000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.985000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,26.035000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.715000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,26.035000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<5.715000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,18.415000>}
box{<0,0,-0.076200><11.430000,0.036000,0.076200> rotate<0,-90.000000,0> translate<2.540000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,18.415000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.540000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,18.415000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,29.845000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,29.845000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.540000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,29.210000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,29.210000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.050000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.050000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.715000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.985000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,20.955000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.715000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,20.955000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<5.715000,0.000000,22.225000> }
object{ARC(2.667000,0.152400,126.869898,180.000000,0.036000) translate<5.461000,0.000000,26.670000>}
object{ARC(2.667000,0.152400,180.000000,233.130102,0.036000) translate<5.461000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,24.511000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,23.749000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,23.749000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,28.778200>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,28.778200> }
object{ARC(2.667000,0.152400,126.869898,180.000000,0.036000) translate<5.461000,0.000000,21.590000>}
object{ARC(2.667000,0.152400,180.000000,233.130102,0.036000) translate<5.461000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.481800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.050000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.178000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,26.162000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,26.162000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,26.162000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.098000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,21.082000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.050000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,27.178000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.162000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,26.162000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.162000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,22.098000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.082000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,18.415000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,22.098000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.082000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,27.432000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.414000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,25.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,22.352000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.414000,0.000000,22.352000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,22.098000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<10.414000,0.000000,22.352000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,22.352000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,22.352000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.098000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.144000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,25.908000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,25.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,29.210000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,20.828000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-26.563298,0> translate<10.414000,0.000000,20.828000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,20.828000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,18.415000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.414000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,20.828000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,20.828000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,20.828000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,20.828000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,21.082000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<9.144000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,20.828000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,19.050000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,26.162000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.162000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,26.162000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,27.178000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,27.432000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,25.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,25.908000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,25.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.162000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,25.908000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-26.563298,0> translate<10.414000,0.000000,25.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,27.178000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<10.414000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.178000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.144000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,25.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,26.162000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<9.144000,0.000000,26.162000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  MITUTOYO_SPC_DATA_LOGGER(-50.800000,0,-26.670000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//ERROR		LED-1206
//LOGO2	OSHW_LOGO_10MILX0200-NT	OSHW_10X200_NOTEXT
//MODE		LED-1206
//MP1	DNP	MICROSD
//Q1	PN2222A	TO-92
//Q2	PN2222A	TO-92
//Q3	PN2222A	TO-92
//Q4	PN2222A	TO-92
//Q5	PN2222A	TO-92
//Q6	PN2222A	TO-92
//READ		LED-1206
//STATUS		LED-1206
//U$1	ARDUINO-MEGA	ARDUINO-MEGA
