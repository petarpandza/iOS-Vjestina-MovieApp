import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieCategoriesListViewController: UIViewController {
    
    var mainScrollView: UIScrollView!
    
    private var popularCollectionView: UICollectionView!
    private var freeCollectionView: UICollectionView!
    private var trendingCollectionView: UICollectionView!
    
    private var popularLayout: UICollectionViewFlowLayout!
    private var freeLayout: UICollectionViewFlowLayout!
    private var trendingLayout: UICollectionViewFlowLayout!
    
    private var movieDetails = MovieUseCase()
    
    private var popularCollectionViewDataSource: PopularCollectionViewDataSource!
    private var freeCollectionViewDataSource: FreeCollectionViewDataSource!
    private var trendingCollectionViewDataSource: TrendingCollectionViewDataSource!
    
    private var whatsPopularLabel: UILabel!
    private var freeToWatchLabel: UILabel!
    private var trendingLabel: UILabel!
    
    var coordinator: MovieListCoordinator!
        
    func userDidSelect(movie: MovieModel) {
        coordinator.showMovieDetails(for: movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        customizeViews()
        defineViewLayout()
        registerCollectionViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Movie List"
    }
    
    private func createViews() {
        
        mainScrollView = UIScrollView()
        
        
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
        
        mainScrollView.addSubview(popularCollectionView)
        mainScrollView.addSubview(freeCollectionView)
        mainScrollView.addSubview(trendingCollectionView)
        
        mainScrollView.addSubview(whatsPopularLabel)
        mainScrollView.addSubview(freeToWatchLabel)
        mainScrollView.addSubview(trendingLabel)
        
        view.addSubview(mainScrollView)
    }
    
    private func customizeViews() {
        
        view.backgroundColor = .white
        
        
        whatsPopularLabel.attributedText = NSMutableAttributedString().bold("What's popular", fontSize: 20)
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = popularCollectionViewDataSource
        popularCollectionView.tag = 1
        
        freeToWatchLabel.attributedText = NSMutableAttributedString().bold("Free to Watch", fontSize: 20)
        
        freeCollectionView.delegate = self
        freeCollectionView.dataSource = freeCollectionViewDataSource
        freeCollectionView.tag = 2
        
        trendingLabel.attributedText = NSMutableAttributedString().bold("Trending", fontSize: 20)
        
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = trendingCollectionViewDataSource
        trendingCollectionView.tag = 3
        
        
    }
    
    private func defineViewLayout() {
        
        mainScrollView.autoPinEdgesToSuperviewSafeArea()
        
        whatsPopularLabel.autoSetDimension(.width, toSize: 363)
        whatsPopularLabel.autoSetDimension(.height, toSize: 25)
        whatsPopularLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        whatsPopularLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        
        popularCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        popularCollectionView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: -15)
        popularCollectionView.autoSetDimension(.height, toSize: 220)
        popularCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        freeToWatchLabel.autoMatch(.width, to: .width, of: whatsPopularLabel)
        freeToWatchLabel.autoMatch(.height, to: .height, of: whatsPopularLabel)
        freeToWatchLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        freeToWatchLabel.autoPinEdge(.top, to: .bottom, of: popularCollectionView, withOffset: 25)
        
        freeCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        freeCollectionView.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel, withOffset: -15)
        freeCollectionView.autoSetDimension(.height, toSize: 220)
        freeCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        trendingLabel.autoMatch(.width, to: .width, of: whatsPopularLabel)
        trendingLabel.autoMatch(.height, to: .height, of: whatsPopularLabel)
        trendingLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        trendingLabel.autoPinEdge(.top, to: .bottom, of: freeCollectionView, withOffset: 25)
        
        trendingCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        trendingCollectionView.autoPinEdge(.top, to: .bottom, of: trendingLabel, withOffset: -15)
        trendingCollectionView.autoSetDimension(.height, toSize: 220)
        trendingCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        // TODO
        mainScrollView.contentSize = CGSize(width: view.bounds.width, height: trendingCollectionView.frame.maxY + 20)
        
    }
    
    private func registerCollectionViews() {

        for popularMovie in movieDetails.popularMovies{
            popularCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: popularMovie.name)
        }
 
        
        for freeMovie in movieDetails.freeToWatchMovies{
            freeCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: freeMovie.name)
        }
        
        for trendingMovie in movieDetails.trendingMovies{
            trendingCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: trendingMovie.name)
        }
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
}


extension MovieCategoriesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
            
        case 1:
            let movie = MovieUseCase().popularMovies[indexPath.row]
            userDidSelect(movie: movie)
        case 2:
            let movie = MovieUseCase().freeToWatchMovies[indexPath.row]
            userDidSelect(movie: movie)
        case 3:
            let movie = MovieUseCase().trendingMovies[indexPath.row]
            userDidSelect(movie: movie)
        default:
            print("error")
        }
    }
}
