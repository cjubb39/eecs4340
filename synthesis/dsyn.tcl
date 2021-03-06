##################################################################
# SPECIFY LIBRARIES
##################################################################
set SynopsysInstall [getenv "SYNOPSYS"]
set designDB /sim/synopsys/SAED_EDK90nm/Digital_Standard_Cell_Library/synopsys/models/saed90nm_typ.db
# set designDB /proj/arcade/synopsys/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_tt1p05v25c.db

# This parameter is used to specify the synthesis tool all the paths that it should search when looking for a synthesis technology library for reference during synthesis.
set search_path [list . [format "%s%s" $SynopsysInstall /dw/sim_ver]]
# The parameter specifies the file that contains all the logic cells that should used for mapping during synthesis. In other words, the tool during synthesis maps a design to the logic cells present in this library.
set target_library $designDB
# Implementation for standard operators, such as +, *
set synthetic_library [list dw_foundation.sldb]
# This parameter points to the library that contains information on the logic gates in the synthesis technology library. The tool uses this library solely for reference but does not use the cells present in it for mapping as in the case of target_library.
set link_library [concat [concat "*" $target_library] $synthetic_library]
# This parameter points to the library that contains the “visual” information on the logic cells in the synthesis technology library. All logic cells have a symbolic representation and information about the symbols is stored in this library.
set symbol_library [list generic.sdb]
set mw_ref_lib /sim/synopsys/SAED_EDK90nm/Digital_Standard_Cell_Library/process/astro/gds-as/saed90nm_dv
set astro_tf /sim/synopsys/SAED_EDK90nm/Technology_Kit/techfile/saed90nm_icc_1p9m.tf

define_design_lib WORK -path ./WORK

##################################################################
# COMPILATION PARAMETERS
##################################################################
set myFiles [glob rtl/*.sv]; # RTL source files
set fileFormat sverilog; # verilog or sverilog
set basename cam_cell; # Top-level module name

# Clock information
set CLK "clk"; # The name of your clock
set virtual 0; # 1 if virtual clock, 0 if real clock

# Timing information
set clkPeriodNS 2.5 ; # Desired clock period (in ns)
# Input delay tells DC how long after the clock before an input becomes valid.
set inDelayNS [expr $clkPeriodNS*.1]; # Delay from clock to inputs valid
set outDelayNS [expr $clkPeriodNS*.1]; # Delay from clock to output valid

# Driving and loading information
# We assume all inputs to the design are driven by a fanout 8 inverter
set inputDrive INVX8

##################################################################
# SYNTHESIS SETTINGS
##################################################################
# Controls whether a warning message is issued if a latch is inferred from a design.
set hdlin_check_no_latch true

# Compiler switches.
set useUltra 0 ; # 1 for compile_ultra, 0 for compile

# mapEffort, useUngroup are for non-ultra compile.
set mapEffort1 high; # First pass - low, medium, or high
set mapEffort2 high; # second pass - low, medium, or high
set useUngroup 0 ; # 0 if no flatten, 1 if flatten

# Control the writing of result files
set stage synth; # Name appended to output files

# The following control which output files you want. They should be set to 1 if you want the file, 0 if not
set writeV 1; # Compiled structural Verilog file
set writeDDC 1; # Compiled file in ddc format (XG-mode)
set writeSDF 1; # sdf file for back-annotated timing sim
set writeSDC 1; # sdc constraint file for place and route

set reportTiming 1; # Timing estimate
set reportArea 1; # Area estimate
set reportPower 1; # Power estimate
set reportQuality 1; # Quality of results report
set reportGating 1; # Report clock gating

set reportReference 1; #
set reportDesign 1; #
set reportCell 1; #
set reportCompileOptions 1; #
set reportConstraint 1; #

##################################################################
# READ DESIGN - the following shoudn't need modification
##################################################################
# Analyze and elaborate the files
analyze -format $fileFormat -lib WORK $myFiles
elaborate $basename -lib WORK -update
list_designs
current_design $basename

# The link command makes sure that all the required design parts are linked together.
link

# The uniquify command makes unique copies of replicated modules.
# uniquify

##################################################################
# SET OPERATING CONDITIONS
##################################################################
set_operating_conditions TYPICAL

# Define the load model for the wires
set_wire_load_model -name ForQA

# Set the driving cell for all inputs except the clock The clock has infinite drive by default. This is usually what you want for synthesis because you will use other tools (like SOC Encounter) to build the clock tree (or define it by hand).
if { $virtual == 0 } {
	set_driving_cell -lib_cell $inputDrive [all_inputs]
} else {
	set_driving_cell -lib_cell $inputDrive [remove_from_collection [all_inputs] $CLK]
}

# Set the load of the circuit outputs in terms of the load of the next cell that they will drive
set_load 13 [all_outputs]

##################################################################
# SET DESIGN CONSTRAINTS
##################################################################
# Now you can create clocks for the design and set other constraints
if { $virtual == 0 } {
	create_clock -period $clkPeriodNS $CLK
} else {
	create_clock -period $clkPeriodNS -name $CLK
}

# Sets input delay on pins or input ports relative to a clock signal.
if { $virtual == 0 } {
	set_input_delay $inDelayNS -clock $CLK [all_inputs] 
} else {
	set_input_delay $inDelayNS -clock $CLK [remove_from_collection [all_inputs] $CLK]
}
# Sets output delay on pins or output ports relative to a clock signal.
set_output_delay $outDelayNS -clock $CLK [all_outputs]

# Try to fix hold time issues
set_fix_hold $CLK

# Minimize area
set_max_area 0

# This command will fix the problem of having assign statements left in your structural file. But, it will insert pairs of inverters for feedthroughs!
set_fix_multiple_port_nets -all -buffer_constants

##################################################################
# COMPILE & OPTIMIZE THE DESIGN
##################################################################
# Now compile the design with given mapping effort and do a second compile with incremental mapping or use the compile_ultra meta-command
if { $useUltra == 1 } {
	compile_ultra
} else {
	if { $useUngroup == 1 } {
		compile -ungroup_all -map_effort $mapEffort1
		compile -incremental_mapping -map_effort $mapEffort2
	} else {
		compile -map_effort $mapEffort1
		compile -incremental_mapping -map_effort $mapEffort2
	}
}

set MW_LIB_NAME [format "%s%s" $basename "_LIB"]
create_mw_lib -technology $astro_tf -mw_reference_library $mw_ref_lib $MW_LIB_NAME
open_mw_lib $MW_LIB_NAME
check_library
report_lib saed90nm_typ > report/report_lib.rpt

##################################################################
# ANALYZE AND RESOLVE DESIGN PROBLEMS
##################################################################
check_library
report_lib saed90nm_typ > report/report_lib.rpt
report_synlib dw_foundation.sldb > report/report_synlib.rpt
check_design > report/${basename}.check_design.rpt

set filebase [format "%s%s" [format "%s%s" $basename "_"] $stage]

##################################################################
# Check for design errors
# Designer should examine log file, look for:
# - inferred latches not in syn.lib
# - fanout nets other than clk
##################################################################

if { $reportTiming == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".timing.rpt"]
	redirect $filename { report_timing -max_paths 10 -input -net -path full -delay max }
}

if { $reportArea == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".area.rpt"]
	redirect $filename { report_area }
}

if { $reportPower == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".power.rpt"]
	redirect $filename { report_power }
}

if { $reportQuality == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".quality.rpt"]
	redirect $filename { report_qor }
}

if { $reportGating == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".gating.rpt"]
	redirect $filename { report_clock_gating -hier -gating_elements }
}

if { $reportReference == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".reference.rpt"]
	redirect $filename { report_reference -nosplit -hierarchy }
}

if { $reportDesign == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".design.rpt"]
	redirect $filename { report_design }
}

if { $reportCompileOptions == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".compile_options.rpt"]
	redirect $filename { report_compile_options }
}

if { $reportConstraint == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".constraint.rpt"]
	redirect $filename { report_constraints -max_delay -all_viol -verb }
}

if { $reportCell == 1 } {
	set filename [format "%s%s%s" "report/" $filebase ".cell.rpt"]
	redirect $filename { report_cell }
}

##################################################################
# SAVE THE DESIGN DATABASE
##################################################################
# Structural (synthesized) file as verilog
if { $writeV == 1 } {
	set filename [format "%s%s" $filebase ".v"]
	write -format verilog -hierarchy -output $filename
}

# Write out the sdf file for back-annotated verilog sim
# This file can be large!
if { $writeSDF == 1 } {
	set filename [format "%s%s" $filebase ".sdf"]
	write_sdf -version 1.0 $filename
}

# This is the timing constraints file generated from the conditions above - used in the place and route program
if { $writeSDC == 1 } {
	set filename [format "%s%s" $filebase ".sdc"]
	write_sdc $filename
}

# Synopsys database format in case you want to read this synthesized result back in to synopsys later in XG mode (ddc format)
if { $writeDDC == 1 } {
	set filename [format "%s%s" $filebase ".ddc"]
	write -format ddc -hierarchy -o $filename
	set mw_filename [format "%s%s" $filebase "_DCT"]
	write_milkyway -overwrite -output $mw_filename
}

quit