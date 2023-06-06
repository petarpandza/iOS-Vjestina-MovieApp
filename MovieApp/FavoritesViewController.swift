import Foundation
import UIKit
import PureLayout

class FavoritesViewController: UIViewController {
    
    var coordinator: MovieListCoordinator!
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    
    private var userDefaults: UserDefaults!
    
    init() {
        userDefaults = UserDefaults.standard
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Favorites"
        collectionView.reloadData()
    }
    
    private func createViews() {
        layout = UICollectionViewFlowLayout()
        let collectionViewWidth = view.frame.width
        let cellWidth = (collectionViewWidth / 3) - 10
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth*1.35)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func defineViewLayout() {
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
    private func registerCollectionViews() {
        collectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "favorite")
    }
    
    private func userDidSelect(movie: Movie) {
        coordinator.showMovieDetails(for: movie)
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = userDefaults.data(forKey: "favoriteMovies")
        guard let data else {
            fatalError("unknown favorite movie pressed")
        }
        
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            userDidSelect(movie: movies[indexPath.row])
        } catch {
            fatalError("unknown favorite movie pressed")
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = userDefaults.data(forKey: "favoriteMovies")
        guard let data else {
            return 0
        }
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            return movies.count
        } catch {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favorite", for: indexPath) as? MovieCategoriesListViewCell else {
            fatalError("Unable to dequeue favorite cell")
        }

        let data = userDefaults.data(forKey: "favoriteMovies")
        
        guard let data else {
            return cell
        }

        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            cell.setMovie(movie: movies[indexPath.row])
        } catch {
            fatalError("favorite cell decode error")
        }
        
        return cell
    }
    
    
}
