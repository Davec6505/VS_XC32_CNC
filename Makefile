
BUILD=make
CLEAN=make clean
BUILD_DIR=make build_dir
#THIRDP_LIB_PATH=/usr/local/mylibs/

all:
	@echo "###### BUILDING  ########"
	+(cd srcs; $(BUILD))
	+(cd bins;  xc32-bin2hex VS_XC32_CNC)

3rd-party-libs:
#	(cd src/3rd_party/libzmq; $(BUILD) install)

build_dir:
	@echo "#######BUILDING DIRECTORIES FOR OUTPUT BINARIES#######"
	(cd srcs; $(BUILD_DIR))


clean:
	@echo "#######BUILDING DIRECTORIES FOR OUTPUT BINARIES#######"
	(cd srcs; $(CLEAN))


install:
	(cd srcs; $(BUILD) install)


.PHONY: all 3rd-party-libs build_dir clean install