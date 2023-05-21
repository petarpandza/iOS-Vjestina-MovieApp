import UIKit

class TabViewController: UITabBarController {
    
    private var coordinator: MovieListCoordinator!
    private var viewModel: MovieCategoriesListViewModel!
    
    init(viewModel: MovieCategoriesListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func userDidSelect(movie: Movie) {
        coordinator.showMovieDetails(for: movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieCategoriesListVC = MovieCategoriesListViewController(viewModel: viewModel)
        movieCategoriesListVC.coordinator = coordinator
        movieCategoriesListVC.tabBarItem = UITabBarItem(title: "Movie List", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.coordinator = coordinator
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        self.viewControllers = [movieCategoriesListVC, favoritesVC]
    }
    
    public func setCoordinator(coordinator: MovieListCoordinator) {
        self.coordinator = coordinator
        let movieCategoriesListVC = viewControllers![0] as? MovieCategoriesListViewController
        movieCategoriesListVC?.coordinator = coordinator
        
        let favoritesVC = viewControllers![1] as? FavoritesViewController
        favoritesVC?.coordinator = coordinator
    }
    
    
}

