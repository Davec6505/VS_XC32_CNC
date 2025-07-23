DEVICE := PIC32MZ2048EFH100

DFP_DIR = 

MODULE := main
ROOT      := ..
OBJ_DIR  := $(ROOT)/objs
INC_DIR  := $(ROOT)/incs
BIN_DIR  := $(ROOT)/bins
SRC_DIR  := $(ROOT)/srcs

SRCS      := $(shell echo $(shell find $(ROOT)/srcs -type f -name *.c) | sed 's/\.c$$/\/.c/g')
SRC 	  := $(shell echo $(SRCS) | sed 's/main\/.c$$/%.c/g')
OBJ 	  := $(shell echo $(SRCS:%.c=$(ROOT)/objs/%.o) | sed 's/\/..\/srcs//g' | sed 's/\/.o$$/.o/g')
OBJS 	  := $(shell echo $(SRCS:%.c=$(ROOT)/objs/%.o) | sed 's/\/..\/srcs//g' | sed 's/main\/.o/%.o/g')
SRCS	  := $(shell echo $(SRCS) | sed 's/\/\.c$$/.c/g')

COMPILER  := c99
ifeq ($(COMPILER),c99)
CC := xc32-gcc
MCU := -mcpu=$(DEVICE)
STD := c99
else
CC := xc32
MCU := --CHIP=$(DEVICE)
STD := c90
endif

#Direct the compiler outputs for pcode
DIRECT_OBJ := "/opt/microchip/xc32/v4.60/bin/xc32-gcc"    -g -x c -c -mprocessor=32MZ1024EFH100  -ffunction-sections -fdata-sections -O1 -fno-common \
			-I"../incs"  -Werror -Wall -MP -MMD -MF -DXPRJ_default=default -mdfp="/opt/microchip/mplabx/v6.25/packs/Microchip/PIC32MZ-EF_DFP/1.4.168"  

# Direct compiler output for linker 
#DIRECT_LINK := "/opt/microchip/xc32/v4.60/bin/xc32-gcc"   -mprocessor=32MZ1024EFH100  -o dist/default/production/NewFolder.production.elf  \
				build/default/production/_ext/1360937237/main.o build/default/production/_ext/1171490990/initialization.o build/default/production/_ext/1171490990/interrupts.o \
				build/default/production/_ext/1171490990/exceptions.o build/default/production/_ext/163028504/xc32_monitor.o build/default/production/_ext/60165520/plib_clk.o  \
				build/default/production/_ext/1865254177/plib_gpio.o build/default/production/_ext/1865200349/plib_evic.o build/default/production/_ext/1865638794/plib_tmr1.o  \         
#				-DXPRJ_default=default      -Wl,--defsym=__MPLAB_BUILD=1,--script="../src/config/default/p32MZ1024EFH100.ld",--defsym=_min_heap_size=512,--gc-sections,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="dist/default/production/NewFolder.production.map",--memorysummary,dist/default/production/memoryfile.xml -mdfp="/opt/microchip/mplabx/v6.25/packs/Microchip/PIC32MZ-EF_DFP/1.4.168" \
				"/opt/microchip/xc32/v4.60/bin"/xc32-bin2hex dist/default/production/NewFolder.production.elf 

DIRECT_LINK := "/opt/microchip/xc32/v4.60/bin/xc32-gcc"   -mprocessor=32MZ2048EFH100 -DXPRJ_default=default -mdfp="/opt/microchip/mplabx/v6.25/packs/Microchip/PIC32MZ-EF_DFP/1.4.168" 	\
			-Wl,--defsym=__MPLAB_BUILD=1,--script="p32MZ1024EFH100.ld",--defsym=_min_heap_size=512,--gc-sections,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="$(OBJ_DIR)/production.map",--memorysummary,$(OBJ_DIR)/memoryfile.xml \
			

INC := -I$(INC_DIR) -I /opt/microchip/mplabx/v6.25/packs/Microchip/PIC32MZ-EF_DFP/1.4.168/include



$(BIN_DIR)/all: $(OBJ)
	@echo "Building project for $(DEVICE)"
	@echo "Linking object files to create the final executable"
	$(DIRECT_LINK) -o $@ $^ 
	@echo "Build complete. Output is in $(BIN_DIR)"

$(OBJ): $(SRCS)
	@echo "Compiling $<	to $@"
	$(DIRECT_OBJ) -c $< -o $@ 


.PHONY: clean  build_dir debug

build_dir:


debug:
	@echo $(SRCS)
	@echo $(SRC)
	@echo $(OBJS)
	@echo $(OBJ)


clean:
	$(call clear_build_dir)
	@echo "Clean complete."


define clear_build_dir
	@echo "Cleaning up object files and binaries"
	rm -r  $(BIN_DIR)/*   \
		  $(OBJ_DIR)/*.o $(OBJ_DIR)/*.xml $(OBJ_DIR)/*.map\
		  $(SRC_DIR)/*.elf $(SRC_DIR)/*.hex 
endef
