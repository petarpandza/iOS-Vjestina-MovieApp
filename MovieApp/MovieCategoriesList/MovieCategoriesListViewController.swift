import Foundation
import UIKit
import PureLayout
import Combine

class MovieCategoriesListViewController: UIViewController {
    
    private var mainScrollView: UIScrollView!
    
    private var popularCollectionView: UICollectionView!
    private var freeCollectionView: UICollectionView!
    private var trendingCollectionView: UICollectionView!
    
    private var popularLayout: UICollectionViewFlowLayout!
    private var freeLayout: UICollectionViewFlowLayout!
    private var trendingLayout: UICollectionViewFlowLayout!
    
    
    private var viewModel: MovieCategoriesListViewModel!
    private var disposables = Set<AnyCancellable>()
    private var popularMovies: [Movie] = []
    private var freeToWatchMovies: [Movie] = []
    private var trendingMovies: [Movie] = []
    
    
    private var popularCollectionViewDataSource: PopularCollectionViewDataSource!
    private var freeCollectionViewDataSource: FreeCollectionViewDataSource!
    private var trendingCollectionViewDataSource: TrendingCollectionViewDataSource!
    
    private var whatsPopularLabel: UILabel!
    private var freeToWatchLabel: UILabel!
    private var trendingLabel: UILabel!
    
    var coordinator: MovieListCoordinator!
    
    init(viewModel: MovieCategoriesListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        customizeViews()
        defineViewLayout()
        registerCollectionViews()
        bindData()
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
        
        popularCollectionViewDataSource = PopularCollectionViewDataSource(movies: popularMovies)
        freeCollectionViewDataSource = FreeCollectionViewDataSource(movies: freeToWatchMovies)
        trendingCollectionViewDataSource = TrendingCollectionViewDataSource(movies: trendingMovies)
        
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
        
        mainScrollView.contentSize = CGSize(width: view.bounds.width, height: 0.9*view.bounds.height)
    }
    
    private func registerCollectionViews() {

        popularCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "popular")
        
        freeCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "free")
        
        trendingCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "trending")
        
    }
    
    private func bindData() {
        self.popularMovies = viewModel.popularMoviesPublished
        self.freeToWatchMovies = viewModel.freeMoviesPublished
        self.trendingMovies = viewModel.trendingMoviesPublished

        
        viewModel
            .$popularMoviesPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else { return }
                
                self.popularMovies = movies
                self.popularCollectionViewDataSource.updateData(movies: movies)
                self.popularCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$freeMoviesPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else { return }
                
                self.freeToWatchMovies = movies
                self.freeCollectionViewDataSource.updateData(movies: movies)
                self.freeCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$trendingMoviesPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else { return }
                
                self.trendingMovies = movies
                self.trendingCollectionViewDataSource.updateData(movies: movies)
                self.trendingCollectionView.reloadData()
            }
            .store(in: &disposables)
    }
    
    private func userDidSelect(movie: Movie) {
        coordinator.showMovieDetails(for: movie)
    }
    
}


extension MovieCategoriesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
            
        case 1:
            let movie = popularMovies[indexPath.row]
            userDidSelect(movie: movie)
        case 2:
            let movie = freeToWatchMovies[indexPath.row]
            userDidSelect(movie: movie)
        case 3:
            let movie = trendingMovies[indexPath.row]
            userDidSelect(movie: movie)
        default:
            print("error")
        }
    }
}
