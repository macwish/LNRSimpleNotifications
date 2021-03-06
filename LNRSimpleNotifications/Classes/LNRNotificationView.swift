//
//  LNRSimpleNotifications
//
//  LNRSimpleNotifications: Modifications of TSMessages Copyright (c) 2015 LISNR, inc.
//  TSMessages: Copyright (c) 2014 Toursprung, Felix Krause <krausefx@gmail.com>
//

import UIKit

let kLNRNotificationViewMinimumPadding: CGFloat = 15.0
let kStatusBarHeight: CGFloat = 20.0
let kBodyLabelTopPadding: CGFloat = 5.0

public class LNRNotificationView: UIView, UIGestureRecognizerDelegate {
    
    //MARK: Public
    
    /**
     *  The title of this notification
     */
    public var title: String
    
    /**
     *  The body of this notification
     */
    public var body: String?
    
    /**
     *  The duration of the displayed notification. If it is 0.0 duration will default to the default notification display time
     */
    public var duration: NSTimeInterval
    
    /**
     *  The position of the notification (top or bottom)
     */
    public var position: LNRNotificationPosition = LNRNotificationPosition.Top
    
    /**
     *  Set to YES by the Notification manager while the notification view is onscreen
     */
    public var isDisplayed: Bool = false
    
    /** Inits the notification view. Do not call this from outside this library.
     *  @param title The title of the notification view
     *  @param body The body of the notification view (optional)
     *  @param image A custom icon image (optional)
     *  @param duration The duration this notification should be displayed (optional)
     *  @param onTap The block that should be executed, when the user tapped on the notification
     *  @param position The position of the notification on the screen
     *  @param dismissingEnabled Should this notification be dismissed when the user taps/swipes it?
     */
    
    init(title: String, body: String?, icon: UIImage?, duration: NSTimeInterval, onTap: LNRNotificationOperationCompletionBlock?, position:LNRNotificationPosition, notificationManager: LNRNotificationManager) {
        
        self.title = title
        self.duration = duration
        self.position = position
        self.notificationManager = notificationManager
        
        if let body = body {
            self.body = body
        }
        
        if let onTap = onTap {
            self.onTap = onTap
        }
        
        let notificationWidth: CGFloat = (UIApplication.sharedApplication().keyWindow?.bounds.width)!
        let padding: CGFloat = kLNRNotificationViewMinimumPadding
        
        super.init(frame: CGRect.zero)
        
        // Set background color
        self.backgroundColor = notificationManager.notificationsBackgroundColor
        
        // Set up Title label
        self.titleLabel.text = self.title
        self.titleLabel.textColor = notificationManager.notificationsTitleTextColor
        self.titleLabel.font = notificationManager.notificationsTitleFont
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.addSubview(self.titleLabel)
        
        if let bodyText = self.body {
            if bodyText.characters.count > 0 {
                self.bodyLabel.text = bodyText
                self.bodyLabel.textColor = notificationManager.notificationsBodyTextColor
                self.bodyLabel.font = notificationManager.notificationsBodyFont
                self.bodyLabel.backgroundColor = UIColor.clearColor()
                self.bodyLabel.numberOfLines = 0
                self.bodyLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                self.addSubview(self.bodyLabel)
            }
        }
        
        if let icon = icon {
            self.iconImageView.image = icon
            self.iconImageView.frame = CGRect(x: padding, y: padding, width: icon.size.width, height: icon.size.height)
            self.addSubview(self.iconImageView)
        }
        
        self.seperator.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: notificationWidth, height: (1.0)) //Set seperator position at the top of the notification view. If notification position is Top we'll update it when we layout subviews.
        self.seperator.backgroundColor = notificationManager.notificationsSeperatorColor
        self.seperator.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.addSubview(self.seperator)
        
        let notificationHeight:CGFloat = self.notificationViewHeightAfterLayoutOutSubviews(padding, notificationWidth: notificationWidth)
        var topPosition:CGFloat = -notificationHeight;
        
        if self.position == LNRNotificationPosition.Bottom {
            topPosition = UIScreen.mainScreen().bounds.size.height
        }
        
        self.frame = CGRectMake(CGFloat(0.0), topPosition, notificationWidth, notificationHeight)
        
        if self.position == LNRNotificationPosition.Top {
            self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        } else {
            self.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleBottomMargin]
        }
        
        if self.onTap != nil {
            let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LNRNotificationView.handleTap(_:)))
            self.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    /**
     * Required initializer 'init(coder:)' must be imlemented by subclasses of UIView
     */
    required public init?(coder decoder: NSCoder) {
        self.title = ""
        self.duration = 0
        super.init(coder: decoder)
    }
    
    /**
     *  Dismisses this notification if this notification is currently displayed.
     *  @param completion A block called after the completion of the dismiss animation. This block is only called if the notification was displayed on screen at the time dismissWithCompletion: was called.
     *  @return true if notification was displayed at the time dismissWithCompletion: was called, false if notification was not displayed.
     */
    public func dismissWithCompletion(completion: LNRNotificationOperationCompletionBlock) -> Bool {
        return notificationManager.dismissNotification(self, dismissAnimationCompletion: completion)
    }
    
    //MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.notificationViewHeightAfterLayoutOutSubviews(kLNRNotificationViewMinimumPadding, notificationWidth: (UIApplication.sharedApplication().keyWindow?.bounds.width)!)
    }
    
    func notificationViewHeightAfterLayoutOutSubviews(padding: CGFloat, notificationWidth: CGFloat) -> CGFloat {
        
        let iconMargin = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 10)
        var height: CGFloat = 0.0
        
        var textLabelsXPosition: CGFloat = 2.0 * padding
        let statusBarVisible = !UIApplication.sharedApplication().statusBarHidden
        let topPadding = self.position == LNRNotificationPosition.Top && statusBarVisible ? kStatusBarHeight + padding : padding
        
        if let image = self.iconImageView.image {
            self.iconImageView.frame.origin.x += iconMargin.left
            textLabelsXPosition += image.size.width + iconMargin.right
        }
        
        self.titleLabel.frame = CGRect(x: textLabelsXPosition, y: topPadding, width: notificationWidth - textLabelsXPosition - padding, height: CGFloat(0.0))
        self.titleLabel.sizeToFit()
        
        if self.body != nil && (self.body!).characters.count > 0 {
            self.bodyLabel.frame = CGRectMake(textLabelsXPosition, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + kBodyLabelTopPadding, notificationWidth - padding - textLabelsXPosition, 0.0)
            self.bodyLabel.sizeToFit()
            height = self.bodyLabel.frame.origin.y + self.bodyLabel.frame.size.height
        } else {
            //Only title label set
            height = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height
        }
        
        height += padding
        
        let yPosition = self.position == LNRNotificationPosition.Top && statusBarVisible ?
            round((kStatusBarHeight+height) / 2.0) : round((height) / 2.0)
        self.iconImageView.center = CGPoint(x: self.iconImageView.center.x, y: yPosition)
        
        if self.position == LNRNotificationPosition.Top {
            var seperatorFrame: CGRect = self.seperator.frame
            seperatorFrame.origin.y = height
            self.seperator.frame = seperatorFrame
        }
        
        height += self.seperator.frame.size.height
        
        self.frame = CGRect(x: CGFloat(0.0), y: self.frame.origin.y, width: self.frame.size.width, height: height)
        
        return height
    }
    
    //MARK: Private
    
    private var onTap: LNRNotificationOperationCompletionBlock?
    private let titleLabel: UILabel = UILabel()
    private let bodyLabel: UILabel = UILabel()
    private let iconImageView: UIImageView = UIImageView()
    private let seperator: UIView = UIView()
    private var notificationManager: LNRNotificationManager!
    
    //MARK: Tap Recognition
    
    func handleTap(tapGestureRecognizer: UITapGestureRecognizer) {
        if tapGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if self.onTap != nil {
                self.onTap!()
            }
        }
    }
    
}
