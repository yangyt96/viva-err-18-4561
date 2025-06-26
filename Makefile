
########################################################
# Vivado
########################################################

project:
	vivado -mode batch -source ./script/main.tcl

gui:
	vivado ./workspace/emu/emu.xpr


########################################################
# Clean up
########################################################

clean:
	- rm -r .Xil
	- rm -r workspace
	- rm *.jou
	- rm *.log
	- rm *.str


