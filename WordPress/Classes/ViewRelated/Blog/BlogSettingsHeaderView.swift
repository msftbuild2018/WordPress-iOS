import Foundation
import WordPressShared

@objc class BlogSettingsHeaderView: UIView {
    let NO_ICON_STATUS_TEXT = "Add a Site Icon"
    let UPDATE_ICON_STATUS_TEXT = "Update Site Icon"
    
    let siteIconImageView = UIImageView()
    let statusTextLabel = UILabel()
    
    // changing the site icon will automatically update the icon image view
    var siteIconUrl: String {
        set {
            if (newValue != siteIconUrl) {
                siteIconUrl = newValue
                updateSiteIcon(url: siteIconUrl)
            }
        }
        get {
            return siteIconUrl
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        statusTextLabel.text = NO_ICON_STATUS_TEXT
        addSubview(statusTextLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func updateSiteIcon(blog: Blog) {
        let siteIconPicker = SiteIconPickerPresenter(blog: blog)
        siteIconPicker.onCompletion = ((media: Media?, error: Error?) -> Void) {
            if (error) {
                // show error message
            } else if (media) {
            } else {
            }
        }
        // TODO
        // if null/empty string
            // set default image
        // else
            // start picker presenter
            // on success
    }
}
