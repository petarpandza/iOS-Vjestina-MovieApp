import Foundation
import UIKit
import PureLayout

class MovieCategoriesListViewCell: UICollectionViewCell {

    
    private var thumbnailImageView: UIImageView!
    private var favoriteButton: UIButton!
    private var movie: Movie!
    
    private var userDefaults: UserDefaults!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        userDefaults = UserDefaults.standard

        createViews()
        customizeViews()
        defineLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        thumbnailImageView = UIImageView()
        favoriteButton = UIButton()
    }
    
    private func customizeViews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(favoriteButton)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        favoriteButton.backgroundColor = .darkGray
        favoriteButton.layer.cornerRadius = 15
        favoriteButton.layer.opacity = 0.8
        
        favoriteButton.addTarget(self, action: #selector(favoriteClicked(_:)), for: .touchUpInside)
        
        let favoriteImage = UIImage(systemName: "heart", withConfiguration: .none)
        let favoriteImageFilled = UIImage(systemName: "heart.fill", withConfiguration: .none)
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.setImage(favoriteImageFilled, for: .selected)

        contentView.layer.cornerRadius = 12
    }
    
    private func defineLayout() {
        thumbnailImageView.autoPinEdgesToSuperviewEdges()
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        favoriteButton.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 10)
        favoriteButton.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        favoriteButton.autoSetDimension(.width, toSize: 30)
        favoriteButton.autoSetDimension(.height, toSize: 30)
    }
    
    func setMovie(movie: Movie) {
        self.movie = movie
        loadImage(url: URL(string: movie.imageUrl)!)
        updateFavoriteButton()
    }
    
    private func loadImage(url: URL) {
        thumbnailImageView.load(url: url)
    }
    
    private func updateFavoriteButton() {
        let data = userDefaults.data(forKey: "favoriteMovies")
        guard let data else {
            favoriteButton.isSelected = false
            return
        }
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            if (movies.contains(movie)) {
                favoriteButton.isSelected = true
            } else {
                favoriteButton.isSelected = false
            }
        } catch {
            fatalError("movies decoding error")
        }
    }
    
    @objc func favoriteClicked(_ sender: UIButton) {
        
        let data = userDefaults.data(forKey: "favoriteMovies")
        if (!sender.isSelected) {
            guard let data else {
                do {
                    // No favorite movies, adding the first one
                    let newData = try JSONEncoder().encode([movie])
                    userDefaults.set(newData, forKey: "favoriteMovies")
                } catch {
                    fatalError("missing movie")
                }
                return
            }
            do {
                var movies = try JSONDecoder().decode([Movie].self, from: data)
                movies.removeAll {$0.id == movie.id}
                movies.append(movie)
                let newData = try JSONEncoder().encode(movies)
                userDefaults.set(newData, forKey: "favoriteMovies")
            } catch {
                fatalError("movie decoding/encoding error")
            }
        } else {
            guard let data else {
                // Tried removing a favorite movie, no favorite movies found
                fatalError("tried removing nonexisting favorite movie")
            }
            do {
                var movies = try JSONDecoder().decode([Movie].self, from: data)
                movies.removeAll {$0.id == movie.id} // Remove movie from array
                let newData = try JSONEncoder().encode(movies)
                userDefaults.set(newData, forKey: "favoriteMovies")
            } catch {
                fatalError("movie decoding/encoding error")
            }
        }
        
        sender.isSelected = !sender.isSelected
    }
}
