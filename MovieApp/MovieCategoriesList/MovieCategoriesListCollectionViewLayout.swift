import UIKit

class MovieCategoriesCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.itemSize = CGSize(width: 125, height: 170)
        self.scrollDirection = .horizontal
        self.minimumInteritemSpacing = 10
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
