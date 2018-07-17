include $(THEOS)/makefiles/common.mk
ARCHS= arm64
TWEAK_NAME = darkmode
darkmode_FILES = Tweak.xm
darkmode_FRAMEWORKS = UIKit
export TARGET = iphone:clang:11.2:11.2
export SDKVERSION=11.2
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
