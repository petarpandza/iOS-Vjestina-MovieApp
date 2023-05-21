import Foundation
import UIKit
import PureLayout

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
    
    private func userDidSelect(movie: Movie) {
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
