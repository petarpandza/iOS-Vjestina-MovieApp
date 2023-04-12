import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieListViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var movieDetails = MovieUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 353, height: 150)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)

        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.delegate = self
        collectionView.dataSource = self

        
        for movie in movieDetails.allMovies{
            collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: movie.name)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
}

class MyCollectionViewCell: UICollectionViewCell {
    
    // Declare the UI elements that will be in the cell
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
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
    
        
        thumbnailImageView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 0)
        thumbnailImageView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 0)
        thumbnailImageView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: 0)
        thumbnailImageView.autoSetDimension(.width, toSize: 80)
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        titleLabel.autoPinEdge(.leading, to: .trailing, of: thumbnailImageView, withOffset: 8)
        titleLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        titleLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        titleLabel.autoSetDimension(.height, toSize: 20)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        subtitleLabel.autoPinEdge(.leading, to: .trailing, of: thumbnailImageView, withOffset: 8)
        subtitleLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 4)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ tableView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movieInfo = MovieUseCase()
        return movieInfo.allMovies.count
    }
    
    func collectionView(_ tableView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieDetails = MovieUseCase()
        let movie = movieDetails.allMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MyCollectionViewCell
        
        var movieName = movie.name
        movieName.append(" (")
        movieName.append(String(movieDetails.getDetails(id: movieDetails.allMovies[indexPath.row].id)!.year))
        movieName.append(")")
        cell.titleLabel.attributedText = NSMutableAttributedString().bold(movieName, fontSize: 16)
        
        cell.subtitleLabel.attributedText = NSMutableAttributedString().normal(movieDetails.allMovies[indexPath.row].summary, fontSize: 14)
        
        cell.thumbnailImageView.load(url: URL(string: movieDetails.allMovies[indexPath.row].imageUrl)!)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}




