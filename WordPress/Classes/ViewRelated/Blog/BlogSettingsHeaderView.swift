import Foundation
import WordPressShared

protocol BlogSettingsHeaderCallback {
    func onSiteIconEditRequested()
}

@objc class BlogSettingsHeaderView: UIView {
    let NO_ICON_STATUS_TEXT = "Add a Site Icon"
    let UPDATE_ICON_STATUS_TEXT = "Update Site Icon"
    let BlogSettingsHeaderHeight = 154;
    let BlogSettingsHeaderIconSize = 64.0;
    let BlogSettingsHeaderLabelHeight = 20.0;
    let BlogSettingsHeaderVerticalMargin = 20.0;
    let BlogSettingsHeaderVerticalSpacing = 10.0;
    let BlogSettingsHeaderMinimumPressDuration = 0.001;
    
    // callback
    optional var callback: BlogSettingsHeaderCallback
    
    // views
    var siteIconImageView: UIImageView = UIImageView()
    var statusTextLabel: UILabel = UILabel()
    
    // changing the site icon will automatically update the icon image view
    var siteIconUrl: String {
        set {
            if (newValue != siteIconUrl) {
                self.siteIconUrl = newValue
            }
        }
        get {
            return self.siteIconUrl
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup the site icon image view and add it to layout
        addSubview(siteIconImageView)
        
        // Setup the site icon status text view and add it to layout
        statusTextLabel = newLabelForStatusText()
        addSubview(statusTextLabel)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func handleIconLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        // Touch Down: Depress the site icon
        if (gestureReconizer.state == UIGestureRecognizerState.began) {
            siteIconImageView.depressSpringAnimation()
            return
        }
        
        // Touch Up: Normalize the site icon
        if (gestureReconizer.state == UIGestureRecognizerState.ended) {
            siteIconImageView.normalizeSpringAnimation()
            
            // make sure touch was in site icon boundary
            let touchInSiteIcon = gestureReconizer.location(in: siteIconImageView)
            if (callback != nil && siteIconImageView.bounds.contains(touchInSiteIcon)) {
                callback.onSiteIconEditRequested()
            }
        }
    }
    
    private func newImageViewForSiteIcon() -> UIImageView {
        let frame = CGRect(x: 0.0, y: 0.0, width: BlogSettingsHeaderIconSize, height: BlogSettingsHeaderIconSize)
        let imageView = UIImageView(frame: frame)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
        // allow site icon view to handle long presses
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector(("handleIconLongPress:")))
        gestureRecognizer.minimumPressDuration = BlogSettingsHeaderMinimumPressDuration
        imageView.addGestureRecognizer(gestureRecognizer)
        
        return imageView
    }
    
    private func newLabelForStatusText() -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.isOpaque = true
        label.textColor = WPStyleGuide.wordPressBlue()
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = NSTextAlignment.center
        label.text = NO_ICON_STATUS_TEXT
        WPStyleGuide.configureLabel(label, textStyle:UIFontTextStyle.callout)
        return label
    }
    
    private func configureConstraints() {
        // center the site icon horizontally
        addConstraint(NSLayoutConstraint(item: siteIconImageView,
                                         attribute: NSLayoutAttribute.centerX,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self,
                                         attribute: NSLayoutAttribute.centerX,
                                         multiplier: 1,
                                         constant: 0))
        
        // center the status text horizontally
        addConstraint(NSLayoutConstraint(item: statusTextLabel,
                                         attribute: NSLayoutAttribute.centerX,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self,
                                         attribute: NSLayoutAttribute.centerX,
                                         multiplier: 1,
                                         constant: 0))
    }
    
    private func updateSiteIcon(blog: Blog) {
    }
}
