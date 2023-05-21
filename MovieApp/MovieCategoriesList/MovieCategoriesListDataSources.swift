import Foundation
import UIKit

class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func updateData(movies: [Movie]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popular", for: indexPath) as? MovieCategoriesListViewCell else {
            fatalError("Unable to dequeue popular cell")
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

class FreeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func updateData(movies: [Movie]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "free", for: indexPath) as? MovieCategoriesListViewCell else {
            fatalError("Unable to dequeue free cell")
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

class TrendingCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func updateData(movies: [Movie]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trending", for: indexPath) as? MovieCategoriesListViewCell else {
            fatalError("Unable to dequeue trending cell")
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
