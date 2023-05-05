import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieCategoriesViewCell: UICollectionViewCell {
    
    private var thumbnailImageView: UIImageView!
    private var favoriteButton: UIButton!
    
    override init (frame: CGRect) {
        super.init(frame: frame)

        createViews()
        customizeViews()
        defineLayout()

    }
    
    private func createViews() {
        thumbnailImageView = UIImageView()
        favoriteButton = UIButton()
    }
    
    private func customizeViews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(favoriteButton)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        favoriteButton.backgroundColor = .darkGray
        favoriteButton.layer.cornerRadius = 15
        favoriteButton.layer.opacity = 0.8
        
        
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        let homeImage = UIImage(systemName: "heart", withConfiguration: homeSymbolConfiguration)
        favoriteButton.setImage(homeImage, for: .normal)

        contentView.layer.cornerRadius = 12
    }
    
    private func defineLayout() {
        thumbnailImageView.autoPinEdgesToSuperviewEdges()
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        favoriteButton.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 10)
        favoriteButton.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        favoriteButton.autoSetDimension(.width, toSize: 30)
        favoriteButton.autoSetDimension(.height, toSize: 30)
    }
    
    public func loadImage(url: URL) {
        thumbnailImageView.load(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
