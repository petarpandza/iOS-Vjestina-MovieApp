import Foundation
import UIKit
import MovieAppData

class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = MovieUseCase().popularMovies[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MovieCategoriesViewCell

        
        cell.loadImage(url: URL(string: MovieUseCase().popularMovies[indexPath.row].imageUrl)!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().popularMovies.count
    }
    
}

class FreeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = MovieUseCase().freeToWatchMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MovieCategoriesViewCell

        
        cell.loadImage(url: URL(string: MovieUseCase().freeToWatchMovies[indexPath.row].imageUrl)!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().freeToWatchMovies.count
    }
    
}

class TrendingCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = MovieUseCase().trendingMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movie.name, for: indexPath) as! MovieCategoriesViewCell

        
        cell.loadImage(url: URL(string: MovieUseCase().trendingMovies[indexPath.row].imageUrl)!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().trendingMovies.count
    }
    
}