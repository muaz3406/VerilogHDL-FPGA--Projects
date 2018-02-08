-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "01/14/2018 02:55:56"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	project IS
    PORT (
	calling_status : IN std_logic_vector(1 DOWNTO 0);
	door : BUFFER std_logic;
	enable : IN std_logic;
	reset : IN std_logic;
	floor_status : BUFFER std_logic_vector(1 DOWNTO 0);
	clk : IN std_logic;
	a0 : BUFFER std_logic;
	a1 : BUFFER std_logic;
	a2 : BUFFER std_logic;
	a3 : BUFFER std_logic;
	a4 : BUFFER std_logic;
	a5 : BUFFER std_logic;
	a6 : BUFFER std_logic
	);
END project;

-- Design Ports Information
-- door	=>  Location: PIN_G19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- enable	=>  Location: PIN_Y24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_AA22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- floor_status[0]	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- floor_status[1]	=>  Location: PIN_H15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a0	=>  Location: PIN_G18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a1	=>  Location: PIN_F22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a2	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a3	=>  Location: PIN_L26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a4	=>  Location: PIN_L25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a5	=>  Location: PIN_J22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a6	=>  Location: PIN_H22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- calling_status[0]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- calling_status[1]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_M23,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF project IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_calling_status : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_door : std_logic;
SIGNAL ww_enable : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_floor_status : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_clk : std_logic;
SIGNAL ww_a0 : std_logic;
SIGNAL ww_a1 : std_logic;
SIGNAL ww_a2 : std_logic;
SIGNAL ww_a3 : std_logic;
SIGNAL ww_a4 : std_logic;
SIGNAL ww_a5 : std_logic;
SIGNAL ww_a6 : std_logic;
SIGNAL \enable~input_o\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \door~output_o\ : std_logic;
SIGNAL \floor_status[0]~output_o\ : std_logic;
SIGNAL \floor_status[1]~output_o\ : std_logic;
SIGNAL \a0~output_o\ : std_logic;
SIGNAL \a1~output_o\ : std_logic;
SIGNAL \a2~output_o\ : std_logic;
SIGNAL \a3~output_o\ : std_logic;
SIGNAL \a4~output_o\ : std_logic;
SIGNAL \a5~output_o\ : std_logic;
SIGNAL \a6~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \calling_status[0]~input_o\ : std_logic;
SIGNAL \calling_status[1]~input_o\ : std_logic;
SIGNAL \compare|LessThan0~0_combout\ : std_logic;
SIGNAL \startup~q\ : std_logic;
SIGNAL \updown|cd~1_combout\ : std_logic;
SIGNAL \compare|LessThan1~0_combout\ : std_logic;
SIGNAL \startdown~q\ : std_logic;
SIGNAL \updown|cd~0_combout\ : std_logic;
SIGNAL \compare|Equal0~0_combout\ : std_logic;
SIGNAL \startequal~q\ : std_logic;
SIGNAL \comb_17|a~0_combout\ : std_logic;
SIGNAL \comb_17|c~combout\ : std_logic;
SIGNAL \comb_17|f~0_combout\ : std_logic;
SIGNAL \updown|cd\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \ALT_INV_clk~input_o\ : std_logic;
SIGNAL \updown|ALT_INV_cd\ : std_logic_vector(1 DOWNTO 1);
SIGNAL \ALT_INV_startequal~q\ : std_logic;

BEGIN

ww_calling_status <= calling_status;
door <= ww_door;
ww_enable <= enable;
ww_reset <= reset;
floor_status <= ww_floor_status;
ww_clk <= clk;
a0 <= ww_a0;
a1 <= ww_a1;
a2 <= ww_a2;
a3 <= ww_a3;
a4 <= ww_a4;
a5 <= ww_a5;
a6 <= ww_a6;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_clk~input_o\ <= NOT \clk~input_o\;
\updown|ALT_INV_cd\(1) <= NOT \updown|cd\(1);
\ALT_INV_startequal~q\ <= NOT \startequal~q\;

-- Location: IOOBUF_X69_Y73_N16
\door~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \startequal~q\,
	devoe => ww_devoe,
	o => \door~output_o\);

-- Location: IOOBUF_X67_Y73_N2
\floor_status[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \updown|cd\(0),
	devoe => ww_devoe,
	o => \floor_status[0]~output_o\);

-- Location: IOOBUF_X60_Y73_N16
\floor_status[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \updown|cd\(1),
	devoe => ww_devoe,
	o => \floor_status[1]~output_o\);

-- Location: IOOBUF_X69_Y73_N23
\a0~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \comb_17|a~0_combout\,
	devoe => ww_devoe,
	o => \a0~output_o\);

-- Location: IOOBUF_X107_Y73_N23
\a1~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \a1~output_o\);

-- Location: IOOBUF_X67_Y73_N23
\a2~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \comb_17|c~combout\,
	devoe => ww_devoe,
	o => \a2~output_o\);

-- Location: IOOBUF_X115_Y50_N2
\a3~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \comb_17|a~0_combout\,
	devoe => ww_devoe,
	o => \a3~output_o\);

-- Location: IOOBUF_X115_Y54_N16
\a4~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \updown|cd\(0),
	devoe => ww_devoe,
	o => \a4~output_o\);

-- Location: IOOBUF_X115_Y67_N16
\a5~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \comb_17|f~0_combout\,
	devoe => ww_devoe,
	o => \a5~output_o\);

-- Location: IOOBUF_X115_Y69_N2
\a6~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \updown|ALT_INV_cd\(1),
	devoe => ww_devoe,
	o => \a6~output_o\);

-- Location: IOIBUF_X115_Y40_N8
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: IOIBUF_X115_Y17_N1
\calling_status[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_calling_status(0),
	o => \calling_status[0]~input_o\);

-- Location: IOIBUF_X115_Y14_N1
\calling_status[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_calling_status(1),
	o => \calling_status[1]~input_o\);

-- Location: LCCOMB_X114_Y40_N24
\compare|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \compare|LessThan0~0_combout\ = (\calling_status[1]~input_o\ & (((\calling_status[0]~input_o\ & !\updown|cd\(0))) # (!\updown|cd\(1)))) # (!\calling_status[1]~input_o\ & (\calling_status[0]~input_o\ & (!\updown|cd\(0) & !\updown|cd\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100011001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \calling_status[0]~input_o\,
	datab => \calling_status[1]~input_o\,
	datac => \updown|cd\(0),
	datad => \updown|cd\(1),
	combout => \compare|LessThan0~0_combout\);

-- Location: FF_X114_Y40_N25
startup : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \compare|LessThan0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \startup~q\);

-- Location: LCCOMB_X114_Y40_N16
\updown|cd~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \updown|cd~1_combout\ = \updown|cd\(1) $ (((\startdown~q\ & ((!\updown|cd\(0)))) # (!\startdown~q\ & (\startup~q\ & \updown|cd\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011010001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \startdown~q\,
	datab => \startup~q\,
	datac => \updown|cd\(1),
	datad => \updown|cd\(0),
	combout => \updown|cd~1_combout\);

-- Location: FF_X114_Y40_N17
\updown|cd[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ALT_INV_clk~input_o\,
	d => \updown|cd~1_combout\,
	ena => \ALT_INV_startequal~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \updown|cd\(1));

-- Location: LCCOMB_X114_Y40_N26
\compare|LessThan1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \compare|LessThan1~0_combout\ = (\calling_status[1]~input_o\ & (!\calling_status[0]~input_o\ & (\updown|cd\(0) & \updown|cd\(1)))) # (!\calling_status[1]~input_o\ & ((\updown|cd\(1)) # ((!\calling_status[0]~input_o\ & \updown|cd\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \calling_status[0]~input_o\,
	datab => \calling_status[1]~input_o\,
	datac => \updown|cd\(0),
	datad => \updown|cd\(1),
	combout => \compare|LessThan1~0_combout\);

-- Location: FF_X114_Y40_N27
startdown : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \compare|LessThan1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \startdown~q\);

-- Location: LCCOMB_X114_Y40_N30
\updown|cd~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \updown|cd~0_combout\ = \updown|cd\(0) $ (((\startdown~q\) # (\startup~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \startdown~q\,
	datac => \updown|cd\(0),
	datad => \startup~q\,
	combout => \updown|cd~0_combout\);

-- Location: FF_X114_Y40_N31
\updown|cd[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ALT_INV_clk~input_o\,
	d => \updown|cd~0_combout\,
	ena => \ALT_INV_startequal~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \updown|cd\(0));

-- Location: LCCOMB_X114_Y40_N20
\compare|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \compare|Equal0~0_combout\ = (\calling_status[0]~input_o\ & (\updown|cd\(0) & (\calling_status[1]~input_o\ $ (!\updown|cd\(1))))) # (!\calling_status[0]~input_o\ & (!\updown|cd\(0) & (\calling_status[1]~input_o\ $ (!\updown|cd\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010000100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \calling_status[0]~input_o\,
	datab => \calling_status[1]~input_o\,
	datac => \updown|cd\(0),
	datad => \updown|cd\(1),
	combout => \compare|Equal0~0_combout\);

-- Location: FF_X114_Y40_N21
startequal : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \compare|Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \startequal~q\);

-- Location: LCCOMB_X114_Y67_N24
\comb_17|a~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \comb_17|a~0_combout\ = (\updown|cd\(0) & !\updown|cd\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \updown|cd\(0),
	datad => \updown|cd\(1),
	combout => \comb_17|a~0_combout\);

-- Location: LCCOMB_X68_Y72_N0
\comb_17|c\ : cycloneive_lcell_comb
-- Equation(s):
-- \comb_17|c~combout\ = (!\updown|cd\(0) & \updown|cd\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \updown|cd\(0),
	datac => \updown|cd\(1),
	combout => \comb_17|c~combout\);

-- Location: LCCOMB_X114_Y67_N22
\comb_17|f~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \comb_17|f~0_combout\ = (\updown|cd\(0)) # (\updown|cd\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \updown|cd\(0),
	datad => \updown|cd\(1),
	combout => \comb_17|f~0_combout\);

-- Location: IOIBUF_X115_Y13_N1
\enable~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_enable,
	o => \enable~input_o\);

-- Location: IOIBUF_X115_Y6_N15
\reset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

ww_door <= \door~output_o\;

ww_floor_status(0) <= \floor_status[0]~output_o\;

ww_floor_status(1) <= \floor_status[1]~output_o\;

ww_a0 <= \a0~output_o\;

ww_a1 <= \a1~output_o\;

ww_a2 <= \a2~output_o\;

ww_a3 <= \a3~output_o\;

ww_a4 <= \a4~output_o\;

ww_a5 <= \a5~output_o\;

ww_a6 <= \a6~output_o\;
END structure;


