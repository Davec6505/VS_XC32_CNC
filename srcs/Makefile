DEVICE := 32MZ1024EFH100

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
DFP_DIR := $(DFP_LOCATION)/$(DFP)
DFP_INCLUDE := $(DFP_DIR)/include


# Project directories expected in the project root
# These directories are created if they do not exist when "make build_dir" is run.
# The directories are used to store object files, binaries, source files, include files, and other files.
# The directories are created relative to the project root directory.
# The project root directory is expected to be one level above the srcs directory.
# The project root directory is expected to contain the srcs, objs, incs, bins, and other directories.
# The objs directory is used to store object files.
# The incs directory is used to store header files.
# The bins directory is used to store binaries.
# The other directory is used to store other files such as maps and XML files.
MODULE := main
ROOT      := ..
OBJ_DIR  := $(ROOT)/objs
INC_DIR  := $(ROOT)/incs
BIN_DIR  := $(ROOT)/bins
SRC_DIR  := $(ROOT)/srcs
OUT_DIR  := $(ROOT)/other

# Source files and object files
# The source files are expected to be in the srcs directory & sub-directories.
# The source files are expected to have the .c extension.
# The object files are created with the .o extension.
# The object files are created in the objs directory with the same subdirectory structure as the srcs directory.
# The object files are created with the same name as the source files, but with the .o extension.
SRCS      := $(shell find $(ROOT)/srcs -type f -name '*.c')
OBJS 	  := $(SRCS:$(ROOT)/srcs/%.c=$(OBJ_DIR)/%.o)


# Compiler and flags
COMPILER  := c99
ifeq ($(COMPILER),c99)
CC := $(COMPILER_LOCATION)/xc32-gcc
MCU := -mprocessor=$(DEVICE)
STD := c99
else
CC := $(COMPILER_LOCATION)/xc32
MCU := -mprocessor=$(DEVICE)
STD := c90
endif


# Assign all Include directories dynamically, first run "make build_dir" from terminal.
INCS := $(foreach d,$(shell find $(INC_DIR) -type d),-I$d)
INCS +=   -I/opt/microchip/mplabx/v6.25/packs/Microchip/PIC32MZ-EF_DFP/1.4.168/include


#Direct the compiler outputs for .o files from .c or .cpp code
DIRECT_OBJ := $(CC)    -g -x c -c $(MCU)  -ffunction-sections -fdata-sections -O1 -fno-common \
			$(INCS)  -Werror -Wall -MP -MMD -MF -DXPRJ_default=default -mdfp=$(DFP_DIR)
			

# Direct compiler output for linker 
DIRECT_LINK := $(CC)  $(MCU) -DXPRJ_default=default -mdfp="/opt/microchip/mplabx/v6.25/packs/Microchip/PIC32MZ-EF_DFP/1.4.168" 	\
			-Wl,--defsym=__MPLAB_BUILD=1,--script="p32MZ1024EFH100.ld",--defsym=_min_heap_size=512,--gc-sections,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="$(OUT_DIR)/production.map",--memorysummary,$(OUT_DIR)/memoryfile.xml \
			


# Define the default target (which is built when make is invoked without any arguments)
$(BIN_DIR)/all: $(OBJS)
	@echo "Building project for $(DEVICE)"
	@echo "Linking object files to create the final executable"
	$(DIRECT_LINK) -o $@ $^ 
	@echo "Build complete. Output is in $(BIN_DIR)"

# Compile all source files to object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling $< to $@"
	$(DIRECT_OBJ) -c $< -o $@
	@echo "Object file created: $@"


#	$(DIRECT_OBJ) -c $< -o $@ 


.PHONY: clean build_dir debug  help

# Create the build directories if they do not exist
# This target is used to create the necessary directories for the build process.
# It creates the OBJ_DIR, BIN_DIR, SRC_DIR, INC_DIR, and OUT_DIR
# It also creates subdirectories in OBJ_DIR and INC_DIR for each subdirectory in SRC_DIR
# This is useful for organizing the build output and include files.
# To run this target, use: make build_dir
build_dir: 
	@echo "Creating build base directories if they do not exist"
	mkdir -p $(OBJ_DIR) $(BIN_DIR) $(SRC_DIR) $(INC_DIR) $(OUT_DIR)
	@echo "Building OBJ_DIR and INC_DIR sub directories from SRC_DIR sub directories."
	for d in $(shell find $(SRC_DIR) -type d | sed 's|$(ROOT)/srcs/||'); do \
		if [ "$$d" != "" ]; then \
			mkdir -p $(OBJ_DIR)/$$d; \
			mkdir -p $(INC_DIR)/$$d; \
		fi \
	done

# Display the source files, object files, and include directories
debug:
	@echo $(SRCS)
	@echo $(OBJS)
	@echo $(INCS)


# For xc32 Compiler help with less use: make help less
# For xc32 Compiler help without less use: make help
help:
	@echo "Displaying help information for xc32-gcc"
ifeq ($(filter less,$(MAKECMDGOALS)),less)
	xc32-gcc --help | less
else
	xc32-gcc --help
endif




clean:
	@echo "Cleaning up object files and binaries"
	$(call clear_build_dir)
	@echo "Clean complete."


define clear_build_dir
	rm -r  $(BIN_DIR)/*   \
		$(OBJS)
endef



##################################################################################################
##                       Table 5-6. Kind-of-Output Control Options								##
##################################################################################################
# Option      |  Definition
# -----------------------------------------------------------------------------------------------
# -c          |  Stop compilation before the link step, producing an intermediate file.
# -E          |  Stop compilation after preprocessing, producing a preprocessed file.
# --help      |  Print a description of the command line options.
# -o file     |Place the output in a file with the specified name.
# -S          |  Stop compilation before the assembly step, producing an assembly file output.
# -specs=file |  Overrides the standard specs file.
# -v          |  Print the commands executed during each stage of compilation.
# --version   |  Show version information then quit.
# -x          |  Specify the language of a source file regardless of its file extension.
#################################################################################################
