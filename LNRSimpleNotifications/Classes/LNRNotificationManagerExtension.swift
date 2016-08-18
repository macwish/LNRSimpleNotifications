//
//  LNRNotificationManagerExtension
//
//  LNRSimpleNotifications: Modifications of TSMessages Copyright (c) 2015 LISNR, inc.
//  TSMessages: Copyright (c) 2014 Toursprung, Felix Krause <krausefx@gmail.com>
//

import UIKit
import AudioToolbox

public extension LNRNotificationManager {
    
    public func show(title: String, body: String?, onTap: LNRNotificationOperationCompletionBlock?) {
        self.showNotification(title, body: body, onTap: onTap)
    }
        
    public func dismissActive(completion: LNRNotificationOperationCompletionBlock?) -> Bool {
        return self.dismissActiveNotification(completion)
    }
    
    public func dismiss(notification: LNRNotificationView, dismissAnimationCompletion:LNRNotificationOperationCompletionBlock?) -> Bool {
        return self.dismissNotification(notification, dismissAnimationCompletion: dismissAnimationCompletion)
    }
    
    public var isActive: Bool {
        return self.isNotificationActive
    }
    
    public var active: LNRNotificationView? {
        get {
            return self.activeNotification
        }
        set {
            self.activeNotification = newValue
        }
    }
    
    // MARK: Notification Styling
    
    public var backgroundColor: UIColor {
        get {
            return self.notificationsBackgroundColor
        }
        set {
            self.notificationsBackgroundColor = newValue
        }
    }
    
    public var titleTextColor: UIColor {
        get {
            return self.notificationsTitleTextColor
        }
        set {
            self.notificationsTitleTextColor = newValue
        }
    }
    
    public var bodyTextColor: UIColor {
        get {
            return self.notificationsBodyTextColor
        }
        set {
            self.notificationsBodyTextColor = newValue
        }
    }
    
    public var titleFont: UIFont {
        get {
            return self.notificationsTitleFont
        }
        set {
            self.notificationsTitleFont = newValue
        }
    }
    
    public var bodyFont: UIFont {
        get {
            return self.notificationsBodyFont
        }
        set {
            self.notificationsBodyFont = newValue
        }
    }
    
    public var seperatorColor: UIColor {
        get {
            return self.notificationsSeperatorColor
        }
        set {
            self.notificationsSeperatorColor = newValue
        }
    }
    
    public var icon: UIImage? {
        get {
            return self.notificationsIcon
        }
        set {
            self.notificationsIcon = newValue
        }
    }
    
    public var defaultDuration: NSTimeInterval {
        get {
            return self.notificationsDefaultDuration
        }
        set {
            self.notificationsDefaultDuration = newValue
        }
    }
    
    public var position: LNRNotificationPosition {
        get {
            return self.notificationsPosition
        }
        set {
            self.notificationsPosition = newValue
        }
    }
    
    public var sound: SystemSoundID? {
        get {
            return self.notificationSound
        }
        set {
            self.notificationSound = newValue
        }
    }
    
    // MARK: Internal
    
    private func display(notification: LNRNotificationView) {
        self.display(notification)
    }
    
}