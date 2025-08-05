
BUILD=make
CLEAN=make clean
BUILD_DIR=make build_dir
#THIRDP_LIB_PATH=/usr/local/mylibs/

all:
	@echo "######  BUILDING   ########"
	+(cd srcs; $(BUILD))
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