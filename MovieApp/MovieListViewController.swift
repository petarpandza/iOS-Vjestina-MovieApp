import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieListViewController: UIViewController {
    
    private var coordinator: MovieListCoordinator?
        
    

    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var movieDetails = MovieUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie List"
        
        createViews()
        customizeViews()
        defineViewLayout()
        

        for movie in movieDetails.allMovies{
            collectionView.register(MovieListViewCell.self, forCellWithReuseIdentifier: movie.name)
        }
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
    }
    
    private func customizeViews() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func defineViewLayout() {
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
    private func userDidSelect(movie: MovieModel) {
        coordinator?.showMovieDetails(for: movie)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
}



extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ tableView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().allMovies.count
    }
    
    func collectionView(_ tableView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = MovieUseCase().allMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MovieListViewCell
        
        
        cell.setMovie(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let movie = MovieUseCase().allMovies[indexPath.row]
        userDidSelect(movie: movie)
            
    }
}




