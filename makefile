# main makefile

# #####################################################
# includes
# #
include config.mak

# #####################################################
# make projects
# #
ifeq ($(IS_CONFIG), yes)

# include prefix
include prefix.mak

# make all
all : .null
	$(MAKE) -C $(SRC_DIR)

# make install
install : .null
	-$(RMDIR) $(BIN_DIR)
	-$(MKDIR) $(BIN_DIR)
	-$(RMDIR) $(BIN_DIR)$(_)inc
	-$(RMDIR) $(BIN_DIR)$(_)lib
	-$(RMDIR) $(BIN_DIR)$(_)obj
	-$(MKDIR) $(BIN_DIR)$(_)inc
	-$(MKDIR) $(BIN_DIR)$(_)lib
	-$(MKDIR) $(BIN_DIR)$(_)obj
	$(MAKE) -C $(SRC_DIR)
	$(MAKE) -C $(SRC_DIR) install

# make clean
clean : .null
	$(MAKE) -C $(SRC_DIR) clean

.null :

else

# #####################################################
# no-config
# #
all :
	@echo "please make config..."

endif

# #####################################################
# config
# #

# default args
ifeq ($(PLAT),)
PLAT := linux_x86
endif

ifeq ($(DEBUG),)
DEBUG := n
endif

ifeq ($(PRO_DIR),)
PRO_DIR 	:= ${shell pwd}
endif

ifeq ($(PRO_NAME),)
PRO_NAME 	:= ${shell basename ${shell pwd}}
endif

# is debug?
ifeq ($(DEBUG),y)
IS_DEBUG = 1
else
IS_DEBUG = 0
endif

config :
	# generate config.h
	-cp ${shell pwd}$(_)plat$(_)$(PLAT)$(_)config.h ${shell pwd}$(_)src$(_)config.h

	# append config.h
	@echo "// config" 									>> ${shell pwd}$(_)src$(_)config.h
	@echo "#ifndef $(PRO_NAME)_AUTO_CONFIG_H" 			>> ${shell pwd}$(_)src$(_)config.h
	@echo "#define $(PRO_NAME)_AUTO_CONFIG_H" 			>> ${shell pwd}$(_)src$(_)config.h
	@echo "#define $(PRO_NAME)_CONFIG_DEBUG $(IS_DEBUG)">> ${shell pwd}$(_)src$(_)config.h
	@echo "#endif" 										>> ${shell pwd}$(_)src$(_)config.h

	# generate config.mak
	@echo "# config"                      				> config.mak
	@echo "IS_CONFIG = yes" 							>> config.mak
	@echo ""                              				>> config.mak
	@echo "# architecture"                				>> config.mak
	@echo "PLAT =" $(PLAT) 								>> config.mak
	@echo ""                              				>> config.mak
	@echo "# root"                						>> config.mak
	@echo "PRO_DIR =" $(PRO_DIR) 						>> config.mak
	@echo "PRO_NAME =" $(PRO_NAME) 						>> config.mak
	@echo "DEBUG =" $(DEBUG) 							>> config.mak
	@echo ""                              				>> config.mak
	@echo "# export"									>> config.mak
	@echo "export PLAT"					 				>> config.mak
	@echo "export PRO_DIR" 		 						>> config.mak
	@echo "export PRO_NAME" 		 					>> config.mak
	@echo "export DEBUG" 			 					>> config.mak


