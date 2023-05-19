import Foundation
import UIKit
import PureLayout
import MovieAppData

class FavoritesViewController: UIViewController {
    
    var coordinator: MovieListCoordinator!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()

        createViews()
        customizeViews()
        defineViewLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Favorites"
    }
    
    private func userDidSelect(movie: MovieModel) {
        coordinator?.showMovieDetails(for: movie)
    }
    
    private func createViews() {
        
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
    }
    
    private func defineViewLayout() {
        
    }
}
