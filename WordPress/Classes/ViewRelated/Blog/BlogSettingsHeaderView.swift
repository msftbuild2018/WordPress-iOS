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
                siteIconUrl = newValue
            }
        }
        get {
            return siteIconUrl
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
