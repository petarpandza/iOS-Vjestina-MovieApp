import Foundation
import UIKit

protocol MovieListCoordinatorProtocol {
    
    func showMovieDetails(for movie: Movie)
    
}

class MovieListCoordinator: MovieListCoordinatorProtocol {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showMovieDetails(for movie: Movie) {
        let movieDetailsVC = MovieDetailsViewController(movie: movie)
        navigationController.pushViewController(movieDetailsVC, animated: true)
        
    }
}
