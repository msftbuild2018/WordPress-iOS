import Foundation
import WordPressShared

@objc class BlogSettingsHeaderView: UIView {
    let NO_ICON_STATUS_TEXT = "Add a Site Icon"
    let UPDATE_ICON_STATUS_TEXT = "Update Site Icon"
    
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
//        siteIconImageView = UIImageView(frame: CGRect(0, 0, MeHeaderViewGravatarSize, MeHeaderViewGravatarSize))
//        addSubview(siteIconImageView)
        
        // Setup the site icon status text view and add it to layout
        statusTextLabel = newLabelForStatusText()
        addSubview(statusTextLabel)
        
        configureConstraints()
    }
    
    private func newLabelForStatusText() -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.text = NO_ICON_STATUS_TEXT
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
