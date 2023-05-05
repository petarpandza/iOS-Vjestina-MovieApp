import Foundation
import UIKit
import PureLayout
import MovieAppData

class MyCollectionViewCell: UICollectionViewCell {
    
    private var thumbnailImageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        customizeViews()
        defineViewLayout()

    }
    
    private func createViews() {
        thumbnailImageView = UIImageView()
        titleLabel = UILabel()
        subtitleLabel = UILabel()
    }
    
    private func customizeViews() {
        
        // New UIView needed to properly clip image because of rounded corners.
        let imageAndTextView = UIView()
        contentView.addSubview(imageAndTextView)
        imageAndTextView.frame = contentView.frame
        
        imageAndTextView.addSubview(thumbnailImageView)
        imageAndTextView.addSubview(titleLabel)
        imageAndTextView.addSubview(subtitleLabel)
        imageAndTextView.backgroundColor = .white
        imageAndTextView.layer.cornerRadius = 15
        imageAndTextView.layer.masksToBounds = true
        
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        titleLabel.adjustsFontSizeToFitWidth = true
        
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.numberOfLines = 5
        subtitleLabel.textColor = .gray

        contentView.layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        
    }
    
    private func defineViewLayout() {
            
            thumbnailImageView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 0)
            thumbnailImageView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 0)
            thumbnailImageView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: 0)
            thumbnailImageView.autoSetDimension(.width, toSize: 80)

            
            titleLabel.autoPinEdge(.leading, to: .trailing, of: thumbnailImageView, withOffset: 8)
            titleLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
            titleLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
            titleLabel.autoSetDimension(.height, toSize: 20)

            
            subtitleLabel.autoPinEdge(.leading, to: .trailing, of: thumbnailImageView, withOffset: 8)
            subtitleLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
            subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 4)
        
    }
    
    public func loadImage(url: URL) {
        thumbnailImageView.load(url: url)
    }
    
    public func setTitle(title: String) {
        titleLabel.attributedText = NSMutableAttributedString().bold(title, fontSize: 16)
    }
    
    public func setSubtitle(subtitle: String) {
        subtitleLabel.attributedText = NSMutableAttributedString().normal(subtitle, fontSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
