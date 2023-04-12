import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieCategoriesViewController: UIViewController {
    
    var mainView: UIScrollView!
    
    var popularCollectionView: UICollectionView!
    var freeCollectionView: UICollectionView!
    var trendingCollectionView: UICollectionView!
    
    var popularLayout: UICollectionViewFlowLayout!
    var freeLayout: UICollectionViewFlowLayout!
    var trendingLayout: UICollectionViewFlowLayout!
    
    var movieDetails = MovieUseCase()
    
    var popularCollectionViewDataSource: PopularCollectionViewDataSource!
    var freeCollectionViewDataSource: FreeCollectionViewDataSource!
    var trendingCollectionViewDataSource: TrendingCollectionViewDataSource!
    
    var whatsPopularLabel: UILabel!
    var freeToWatchLabel: UILabel!
    var trendingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        createViews()
        customizeViews()
        registerCollectionViews()
        
    }
    
    private func createViews() {
        
        mainView = UIScrollView()
        
        
        popularLayout = UICollectionViewFlowLayout()
        freeLayout = UICollectionViewFlowLayout()
        trendingLayout = UICollectionViewFlowLayout()
        
        popularLayout.itemSize = CGSize(width: 125, height: 170)
        popularLayout.scrollDirection = .horizontal
        popularLayout.minimumInteritemSpacing = 10
        popularLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        freeLayout.itemSize = CGSize(width: 125, height: 170)
        freeLayout.scrollDirection = .horizontal
        freeLayout.minimumInteritemSpacing = 10
        freeLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        trendingLayout.itemSize = CGSize(width: 125, height: 170)
        trendingLayout.scrollDirection = .horizontal
        trendingLayout.minimumInteritemSpacing = 10
        trendingLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: popularLayout)
        freeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: freeLayout)
        trendingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: trendingLayout)
        
        popularCollectionViewDataSource = PopularCollectionViewDataSource()
        freeCollectionViewDataSource = FreeCollectionViewDataSource()
        trendingCollectionViewDataSource = TrendingCollectionViewDataSource()
        
        whatsPopularLabel = UILabel()
        freeToWatchLabel = UILabel()
        trendingLabel = UILabel()
        
        mainView.addSubview(popularCollectionView)
        mainView.addSubview(freeCollectionView)
        mainView.addSubview(trendingCollectionView)
        
        mainView.addSubview(whatsPopularLabel)
        mainView.addSubview(freeToWatchLabel)
        mainView.addSubview(trendingLabel)
        
        view.addSubview(mainView)
    }
    
    private func customizeViews() {
        
        mainView.autoPinEdgesToSuperviewSafeArea()
        mainView.maximumZoomScale = 1
        
        whatsPopularLabel.frame = CGRect(x: 20, y: 30, width: 363, height: 25)
        whatsPopularLabel.attributedText = NSMutableAttributedString().bold("What's popular", fontSize: 20)
        
        popularCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        popularCollectionView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: -15)
        popularCollectionView.autoSetDimension(.height, toSize: 220)
        popularCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = popularCollectionViewDataSource
        
        freeToWatchLabel.autoMatch(.width, to: .width, of: whatsPopularLabel)
        freeToWatchLabel.autoMatch(.height, to: .height, of: whatsPopularLabel)
        freeToWatchLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        freeToWatchLabel.autoPinEdge(.top, to: .bottom, of: popularCollectionView, withOffset: 25)
        freeToWatchLabel.attributedText = NSMutableAttributedString().bold("Free to Watch", fontSize: 20)
        
        freeCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        freeCollectionView.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel, withOffset: -15)
        freeCollectionView.autoSetDimension(.height, toSize: 220)
        freeCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        freeCollectionView.delegate = self
        freeCollectionView.dataSource = freeCollectionViewDataSource
        
        trendingLabel.autoMatch(.width, to: .width, of: whatsPopularLabel)
        trendingLabel.autoMatch(.height, to: .height, of: whatsPopularLabel)
        trendingLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        trendingLabel.autoPinEdge(.top, to: .bottom, of: freeCollectionView, withOffset: 25)
        trendingLabel.attributedText = NSMutableAttributedString().bold("Trending", fontSize: 20)
        
        trendingCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        trendingCollectionView.autoPinEdge(.top, to: .bottom, of: trendingLabel, withOffset: -15)
        trendingCollectionView.autoSetDimension(.height, toSize: 220)
        trendingCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = trendingCollectionViewDataSource
        
    }
    
    private func registerCollectionViews() {

        for popularMovie in movieDetails.popularMovies{
            popularCollectionView.register(MovieCategoriesViewCell.self, forCellWithReuseIdentifier: popularMovie.name)
        }
 
        
        for freeMovie in movieDetails.freeToWatchMovies{
            freeCollectionView.register(MovieCategoriesViewCell.self, forCellWithReuseIdentifier: freeMovie.name)
        }
        
        for trendingMovie in movieDetails.trendingMovies{
            trendingCollectionView.register(MovieCategoriesViewCell.self, forCellWithReuseIdentifier: trendingMovie.name)
        }
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
}


class MovieCategoriesViewCell: UICollectionViewCell {
    
    let thumbnailImageView = UIImageView()
    let favoriteButton = UIButton()
    
    override init (frame: CGRect) {
        super.init(frame: frame)

        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(favoriteButton)
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    
        thumbnailImageView.autoPinEdgesToSuperviewEdges()
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        favoriteButton.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 10)
        favoriteButton.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        favoriteButton.autoSetDimension(.width, toSize: 30)
        favoriteButton.autoSetDimension(.height, toSize: 30)
        favoriteButton.backgroundColor = .darkGray
        favoriteButton.layer.cornerRadius = 15
        favoriteButton.layer.opacity = 0.8
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        let homeImage = UIImage(systemName: "heart", withConfiguration: homeSymbolConfiguration)
        favoriteButton.setImage(homeImage, for: .normal)

        contentView.layer.cornerRadius = 12

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCategoriesViewController: UICollectionViewDelegate {

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}

class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieDetails = MovieUseCase()
        let movie = movieDetails.popularMovies[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MovieCategoriesViewCell

        
        cell.thumbnailImageView.load(url: URL(string: movieDetails.popularMovies[indexPath.row].imageUrl)!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movieInfo = MovieUseCase()
        return movieInfo.popularMovies.count
    }
    
}

class FreeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieDetails = MovieUseCase()
        let movie = movieDetails.freeToWatchMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MovieCategoriesViewCell

        
        cell.thumbnailImageView.load(url: URL(string: movieDetails.freeToWatchMovies[indexPath.row].imageUrl)!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movieInfo = MovieUseCase()
        return movieInfo.freeToWatchMovies.count
    }
    
}

class TrendingCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieDetails = MovieUseCase()
        let movie = movieDetails.trendingMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MovieCategoriesViewCell

        
        cell.thumbnailImageView.load(url: URL(string: movieDetails.trendingMovies[indexPath.row].imageUrl)!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movieInfo = MovieUseCase()
        return movieInfo.trendingMovies.count
    }
    
}
