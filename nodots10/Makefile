include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NoDots10
NoDots10_FILES = nodots10RootListController.m
NoDots10_INSTALL_PATH = /Library/PreferenceBundles
NoDots10_FRAMEWORKS = UIKit
NoDots10_PRIVATE_FRAMEWORKS = Preferences
NoDots10_EXTRA_FRAMEWORKS += Cephei cepheiprefs 

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoDots10.plist$(ECHO_END)
