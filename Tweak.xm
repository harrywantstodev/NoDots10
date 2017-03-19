#import <UIKit/UIPageControl.h>

#define plist @"/var/mobile/Library/Preferences/com.harrywantstodev.NoDots10.plist"

static BOOL SBisEnabled;
static BOOL CCisEnabled;
static BOOL LSisEnabled;
static BOOL WidgetisEnabled;
static BOOL BetaisEnabled;
static BOOL NewisEnabled;
static BOOL NCisEnabled;

%hook SBNotificationCenterViewController
//Notification Center
-(void)_loadPageControl
{
	if (NCisEnabled == YES) {

	} else {
		%orig;
	}
//	return NCisEnabled ? nil : %orig;
}
%end

%hook SBLeafIcon
//Beta Dot
-(bool) isBeta
{
	return BetaisEnabled ? NO : %orig;
}
-(BOOL)isRecentlyUpdated
//Blue Update Dot
{
	return NewisEnabled ? NO : %orig;
}
%end
//Widget
%hook WGWidgetListEditViewController
-(BOOL)_isNewItem:(id)arg1
{
	return WidgetisEnabled ? NO : %orig;
}
%end
//SpringBoard and folders
%hook SBIconListPageControl
- (id)initWithFrame:(CGRect)frame
{
	return SBisEnabled ? nil : %orig;
}
%end

//Control Center Pages
%hook CCUIControlCenterPageControl
- (id)initWithFrame:(CGRect)frame
{
	return CCisEnabled ? nil : %orig;
}
%end

//Lockscreen
%hook SBDashBoardPageControl
- (id)initWithFrame:(CGRect)frame
{
	return LSisEnabled ? nil : %orig;
}
//Needed for 10.2
- (id)_indicatorViewEnabled:(_Bool)arg1 index:(long long)arg2
{
	return LSisEnabled ? %orig(NO, arg2) : %orig;
}
%end

static void loadPreferences() {
    CFPreferencesAppSynchronize(CFSTR("com.harrywantstodev.nodots10"));
    NSNumber *tempVal;

    tempVal = (NSNumber *)CFPreferencesCopyAppValue(CFSTR("LSisEnabled"), CFSTR("com.harrywantstodev.nodots10"));
    LSisEnabled = !tempVal ? YES : [tempVal boolValue];

		tempVal = (NSNumber *)CFPreferencesCopyAppValue(CFSTR("NCisEnabled"), CFSTR("com.harrywantstodev.nodots10"));
		NCisEnabled = !tempVal ? YES : [tempVal boolValue];

		tempVal = (NSNumber *)CFPreferencesCopyAppValue(CFSTR("CCisEnabled"), CFSTR("com.harrywantstodev.nodots10"));
		CCisEnabled = !tempVal ? YES : [tempVal boolValue];

		tempVal = (NSNumber *)CFPreferencesCopyAppValue(CFSTR("WidgetisEnabled"), CFSTR("com.harrywantstodev.nodots10"));
		WidgetisEnabled = !tempVal ? YES : [tempVal boolValue];

		tempVal = (NSNumber *)CFPreferencesCopyAppValue(CFSTR("BetaisEnabled"), CFSTR("com.harrywantstodev.nodots10"));
		BetaisEnabled = !tempVal ? YES : [tempVal boolValue];

		tempVal = (NSNumber *)CFPreferencesCopyAppValue(CFSTR("SBisEnabled"), CFSTR("com.harrywantstodev.nodots10"));
		SBisEnabled = !tempVal ? YES : [tempVal boolValue];

		tempVal = (NSNumber *)CFPreferencesCopyAppValue(CFSTR("NewisEnabled"), CFSTR("com.harrywantstodev.nodots10"));
		NewisEnabled = !tempVal ? YES : [tempVal boolValue];

		[tempVal release];
}

%ctor {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        (CFNotificationCallback)loadPreferences,
        CFSTR("com.harrywantstodev.nodots10/settingschanged"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately);
    loadPreferences();
  }
