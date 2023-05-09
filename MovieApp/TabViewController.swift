import UIKit
import MovieAppData

class TabViewController: UITabBarController {
    
    private var coordinator: MovieListCoordinator?
        
    func userDidSelect(movie: MovieModel) {
        coordinator?.showMovieDetails(for: movie)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieCategoriesListVC = MovieCategoriesListViewController()
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
