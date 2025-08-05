# Name of the project binary
MODULE    	:= VS_XC32_CNC

# Device configuration
# The device is expected to be a PIC32MZ family device.
DEVICE 		:= 32MZ1024EFH064

# Compiler location and DFP (Device Family Pack) location
# The compiler location is expected to be the path to the xc32-gcc compiler.
# The DFP location is expected to be the path to the Microchip Device Family Pack.
# The DFP is used to provide the necessary header files and libraries for the specific device.
# The DFP is expected to be installed in the MPLAB X IDE installation directory.
# The DFP is expected to be in the packs directory of the MPLAB X IDE installation directory.
# The DFP is expected to be in the format of Microchip/PIC32MZ-EF_DFP/1.4.168.
COMPILER_LOCATION := /opt/microchip/xc32/v4.60/bin
DFP_LOCATION := /opt/microchip/mplabx/v6.25/packs
DFP := Microchip/PIC32MZ-EF_DFP/1.4.168


BUILD=make
CLEAN=make clean
BUILD_DIR=make build_dir
#THIRDP_LIB_PATH=/usr/local/mylibs/

all:
	@echo "######  BUILDING   ########"
	+(cd srcs; $(BUILD) COMPILER_LOCATION=$(COMPILER_LOCATION) DFP_LOCATION=$(DFP_LOCATION) DFP=$(DFP) DEVICE=$(DEVICE) MODULE=$(MODULE))
	@echo "###### BIN TO HEX ########"
	+(cd bins;  xc32-bin2hex VS_XC32_CNC)
	@echo "######  BUILD COMPLETE   ########"

3rd-party-libs:
#	(cd src/3rd_party/libzmq; $(BUILD) install)

build_dir:
	@echo "#######BUILDING DIRECTORIES FOR OUTPUT BINARIES#######"
	(cd srcs; $(BUILD_DIR))

debug:
	@echo "#######DEBUGGING OUTPUTS#######"
	(cd srcs; $(BUILD) debug)


clean:
	@echo "#######BUILDING DIRECTORIES FOR OUTPUT BINARIES#######"
	(cd srcs; $(CLEAN))


install:
	(cd srcs; $(BUILD) install)


.PHONY: all 3rd-party-libs build_dir clean install