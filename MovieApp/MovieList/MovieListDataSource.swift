import Foundation
import UIKit

class MovieListDataSource: NSObject, UICollectionViewDataSource {
    
    private var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func updateData(movies: [Movie]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieListCell", for: indexPath) as? MovieListViewCell else {
            fatalError("Unable to dequeue movie list cell")
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
