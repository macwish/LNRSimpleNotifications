# Change Log

## 0.4.2
### Fixed
- Fixed notification width error on iPad in multi-window mode. __[Contributed by moshegutman]__

## 0.4.1
### Fixed
- Adds missing ```use_frameworks!``` declaration in Demo project Podfile.

## 0.4.0
### Changed
- __LNRNotificationManager__ and __LNRNotificationView__ now use parameter name __onTap__ to refer to the on tap callback for notofications rather than the poorly-named __callback__. In the interface this slightly modifies the parameters of the __LNRNotificationView__ ```init:title:body:icon:duration:onTap:position:notificationManager:``` and the __LNRNotificationManager__ ```showNotification:title:body:onTap:``` methods. 
- Demo app now uses __LNRSimpleNotifications__ Pod rather than direct inclusion of the project files.

### Fixed
- No long adds extra padding equal to status bar height when showing notifications from the top position when the status bar is hidden. __[Contributed by jkennington]__

## 0.3.0
### Changed
- __LNRSimpleNotifications__ class renamed __LNRNotificationManager__.
- __LNRSimpleNotificationView__ class renamed __LNRNotificationView__.
- __LNRSimpleNotifications/LNRNotificationManager__ is no longer a singleton - you can create multiple notification managers, each with a different theme, to display notifications. 
- Sample project updated to demonstrate the use of two notification managers with different themes.

## 0.2.3
### Fixed
- Icon vertical positioning is now properly centered. Thanks Chris Akring for submitting this fix!
- Title label width now respects presence of icon instead of overflowing off the right side of the screen. Thanks Markus Chemelar for submitting this fix!

## 0.2.2
### Fixed
- The background of Notifications displayed from the top of the screen has been extended all the way to the top of the screen, rather than leaving a 20px (@1x) gap for the status bar. 
 
## 0.2.1
### Changed
- Class __LNRSimpleNotifications__ now inherits from NSObject.

## 0.2.0
### Changed
- Updated to Swift 2.0. 

## 0.1.2
### Changed
- Left side Icon padding in notifications reduced from 2 * padding default to just the padding default. __[Contributed by pkurzok]__
-  LISNRSimpleNotifications now explicitly displays notifications using main thread. 
