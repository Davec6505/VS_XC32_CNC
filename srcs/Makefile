
# Project directories expected in the project.
# These directories are created if they do not exist when "make build_dir" is run.
# The directories are used to store object files, binaries, source files, include files, and other files.
# The directories are created relative to the project root directory.
# The project root directory is expected to be one level above the srcs directory.
# The project root directory is expected to contain the srcs, objs, incs, bins, and other directories.
# The objs directory is used to store object files.
# The incs directory is used to store header files.
# The bins directory is used to store binaries.
# The other directory is used to store other files such as maps and XML files.
ROOT     := ..
OBJ_DIR  := $(ROOT)/objs
INC_DIR  := $(ROOT)/incs
BIN_DIR  := $(ROOT)/bins
SRC_DIR  := $(ROOT)/srcs
OUT_DIR  := $(ROOT)/other


# Source files and object files
# The source files are expected to be in the srcs directory & sub-directories.
# The source files are expected to have the .c extension.
# The object file list is created from the SRCS variable with the .o extension inplaceof the .c extension.
SRCS      := $(shell find $(SRC_DIR) -type f -name '*.c')
OBJS 	  := $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

#ASM  := $(foreach dir,$(DIR),$(wildcard $(dir)/*.S))
# The assembly files are expected to be in the srcs directory & sub-directories.
ASM       := $(shell find $(SRC_DIR) -type f -name '*.S')
ASMS  := $(ASM:$(SRC_DIR)/%.S=$(OBJ_DIR)/%.o)

# The assembly object files are created from the ASM variable with the .o extension inplace of the .S extension.
# The assembly object files are added to the OBJS variable.
# This allows the assembly files to be compiled and linked with the C source files.
# The assembly files are expected to be in the srcs directory & sub-directories.
# The assembly files are expected to have the .S extension.
# The assembly files are expected to be compiled with the same compiler as the C source files.
# The assembly files are expected to be compiled with the same flags as the C source files.
OBJS += $(ASMS)

# Compiler and flags
COMPILER  := c99
ifeq ($(COMPILER),c99)
CC := $(COMPILER_LOCATION)/xc32-gcc
MCU := -mprocessor=$(DEVICE)
STD := c99
FLAGS := -Werror -Wall -MP -MMD -MF
else
CC := $(COMPILER_LOCATION)/xc32
MCU := -mprocessor=$(DEVICE)
STD := c90
endif


# Assign all Include directories dynamically, first run "make build_dir" from terminal.
INCS := $(foreach d,$(shell find $(INC_DIR) -type d),-I$d)
INCS +=   -I$(DFP_INCLUDE)


#Direct the compiler outputs for .o files from .c or .cpp code
DIRECT_OBJ := $(CC)    -g -x c -c $(MCU)  -ffunction-sections -fdata-sections -O1 -fno-common \
			$(INCS)  $(FLAGS) -DXPRJ_default=default -mdfp=$(DFP_DIR)
			

# Direct compiler output for linker 
DIRECT_LINK := $(CC)  $(MCU) -nostartfiles -DXPRJ_default=default -mdfp=$(DFP_DIR) 	\
			-Wl,--defsym=__MPLAB_BUILD=1,--script="p32MZ1024EFH100.ld",--defsym=_min_heap_size=512,--gc-sections,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="$(OUT_DIR)/production.map",--memorysummary,$(OUT_DIR)/memoryfile.xml \




DIRECT_ASM :=   -c  -DXPRJ_default=default    -Wa,--defsym=__MPLAB_BUILD=1,-MD=$(OBJ_DIR)/startup/startup.o.asm.d,--gdwarf-2 -mdfp=$(DFP_DIR) -MMD -MF $(OBJ_DIR)/startup/startup.o.d

# Define the default target (which is built when make is invoked without any arguments)
$(BIN_DIR)/$(MODULE): $(OBJS)
	@echo "Building project for $(DEVICE)"
	@echo "Linking object files to create the final executable"
	$(DIRECT_LINK) -o $@ $^ 
	@echo "Build complete. Output is in $(BIN_DIR)"

# Compile all source files to object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling $< to $@"
	$(DIRECT_OBJ) -c $< -o $@
	@echo "Object file created: $@"

$(OBJ_DIR)/%.o: %.S
	@echo "Compiling assembly file $< to object file $@"
	$(CC) $(MCU) $(DIRECT_ASM) -o $@ $<
	@echo "Object file created: $@"



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
		$(OBJS)	          \
		$(OBJ_DIR)/startup/*
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
