import Foundation
import UIKit
import MovieAppData

class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popular", for: indexPath) as? MovieCategoriesListViewCell else {
                fatalError()
                }
        
        let movie = MovieUseCase().popularMovies[indexPath.row]
        
        cell.setMovie(movie: movie)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().popularMovies.count
    }
    
}

class FreeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "free", for: indexPath) as? MovieCategoriesListViewCell else {
                fatalError()
                }
        
        let movie = MovieUseCase().freeToWatchMovies[indexPath.row]
        
        cell.setMovie(movie: movie)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().freeToWatchMovies.count
    }
    
}

class TrendingCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trending", for: indexPath) as? MovieCategoriesListViewCell else {
                fatalError()
                }

        let movie = MovieUseCase().trendingMovies[indexPath.row]
        
        cell.setMovie(movie: movie)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().trendingMovies.count
    }
    
}
