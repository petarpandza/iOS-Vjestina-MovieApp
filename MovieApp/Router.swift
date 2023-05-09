import Foundation
import UIKit
import MovieAppData

protocol MovieListCoordinatorProtocol {
    
    func showMovieDetails(for movie: MovieModel)
    
}

class MovieListCoordinator: MovieListCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showMovieDetails(for movie: MovieModel) {
        let movieDetailsVC = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(movieDetailsVC, animated: true)
        
    }
}
