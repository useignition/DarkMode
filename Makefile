include $(THEOS)/makefiles/common.mk

TWEAK_NAME = darkmode
darkmode_FILES = Tweak.xm
darkmode_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
