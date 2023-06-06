import Foundation
import UIKit

class MovieCategoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var movies: [Movie]
    private let type: String
    
    init(movies: [Movie], type: String) {
        self.movies = movies
        self.type = type
    }
    
    func updateData(movies: [Movie]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type, for: indexPath) as? MovieCategoriesListViewCell else {
            fatalError("Unable to dequeue " + type + " cell")
        }

        guard !movies.isEmpty else {
            return cell
        }
        
        let movie = movies[indexPath.row]
        
        cell.setMovie(movie: movie)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
}
