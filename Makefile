include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoDots10
NoDots10_FILES = Tweak.xm
NoDots10_EXTRA_FRAMEWORKS += Cephei cepheiprefs

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += nodots10
include $(THEOS_MAKE_PATH)/aggregate.mk
