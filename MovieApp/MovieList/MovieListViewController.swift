import Foundation
import UIKit
import PureLayout
import Combine

class MovieListViewController: UIViewController {
    
    private var coordinator: MovieListCoordinator!
    
    private var viewModel: MovieListViewModel!
    private var disposables = Set<AnyCancellable>()
    private var allMovies: [Movie] = []
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var dataSource: MovieListDataSource!
    
    init(viewModel: MovieListViewModel) {
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
    
    public func setCoordinator(coordinator: MovieListCoordinator) {
        self.coordinator = coordinator
    }
    
    private func createViews() {
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 353, height: 150)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        dataSource = MovieListDataSource(movies: allMovies)
    }
    
    private func customizeViews() {
        title = "Movie List"
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
    }
    
    private func defineViewLayout() {
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
    private func bindData() {
        self.allMovies = viewModel.allMoviesPublished
        
        viewModel
            .$allMoviesPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else { return }
                
                self.allMovies = movies
                self.dataSource.updateData(movies: movies)
                self.collectionView.reloadData()
            }
            .store(in: &disposables)
   
    }
    
    private func registerCollectionViews() {
        
        collectionView.register(MovieListViewCell.self, forCellWithReuseIdentifier: "movieListCell")
        
    }
    
    private func userDidSelect(movie: Movie) {
        coordinator.showMovieDetails(for: movie)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
}

extension MovieListViewController:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = allMovies[indexPath.row]
        userDidSelect(movie: movie)
        
    }
}
