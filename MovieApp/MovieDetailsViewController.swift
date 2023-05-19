import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieDetailsViewController: UIViewController {
    
    private var movieImageView: UIImageView!
    
    private var userScoreLabel: UILabel!
    private var movieTitleLabel: UILabel!
    private var releaseDateLabel: UILabel!
    private var genreLabel: UILabel!
    private var favoriteButton: UIButton!
    private var overviewLabel: UILabel!
    private var summaryLabel: UILabel!
    private var crewView: UICollectionView!
    
    
    private var screenHeight: CGFloat!
    private var screenWidth: CGFloat!
    private var movie: MovieModel!
    
    convenience init(movie: MovieModel!) {
        self.init()
        self.movie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Details"
        
        createViews()
        customizeViews()
        defineViewLayout()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateViews()
    }
    
    
    private func createViews() {
        
        screenHeight = view.frame.height
        screenWidth = view.frame.width
        
        
        movieImageView = UIImageView()
        userScoreLabel = UILabel()
        movieTitleLabel = UILabel()
        releaseDateLabel = UILabel()
        genreLabel = UILabel()
        favoriteButton = UIButton()
        overviewLabel = UILabel()
        summaryLabel = UILabel()
        
        let crewViewLayout = UICollectionViewFlowLayout()
        crewViewLayout.itemSize = CGSize(width: screenWidth*0.26, height: 40)
        crewViewLayout.scrollDirection = .vertical
        crewViewLayout.sectionInset = UIEdgeInsets(top: 0, left: screenWidth*0.06, bottom: 0, right: screenWidth*0.06)
        crewViewLayout.minimumInteritemSpacing = 10
        crewView = UICollectionView(frame: .zero, collectionViewLayout: crewViewLayout)
 
        
    }
    
    private func customizeViews() {
        
        view.backgroundColor = .white
        
        movieImageView.load(url: URL(string: movie.imageUrl)!)
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        view.addSubview(movieImageView)
        
        userScoreLabel.attributedText = NSMutableAttributedString().bold(String(format: "%.1f", arguments: [MovieUseCase().getDetails(id: movie.id)!.rating]), fontSize: 20).normal(" User Score", fontSize: 16)
        userScoreLabel.textColor = .white
        view.addSubview(userScoreLabel)
        
        movieTitleLabel.attributedText = NSMutableAttributedString().bold(movie.name, fontSize: 30).normal(String(format: " (%d)", arguments: [MovieUseCase().getDetails(id: movie.id)!.year]), fontSize: 30)
        movieTitleLabel.textColor = .white
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(movieTitleLabel)
        
        releaseDateLabel.attributedText = NSMutableAttributedString().normal(MovieUseCase().getDetails(id: movie.id)!.releaseDate, fontSize: 15)
        releaseDateLabel.textColor = .white
        view.addSubview(releaseDateLabel)
        
        genreLabel.attributedText = NSMutableAttributedString().normal(categoriesToString(categories: MovieUseCase().getDetails(id: movie.id)!.categories), fontSize: 15).bold(lengthIntToString(length: MovieUseCase().getDetails(id: movie.id)!.duration), fontSize: 15)
        genreLabel.textColor = .white
        view.addSubview(genreLabel)
        
        favoriteButton.backgroundColor = .gray
        favoriteButton.layer.cornerRadius = 17.5
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        let homeImage = UIImage(systemName: "star", withConfiguration: homeSymbolConfiguration)
        favoriteButton.setImage(homeImage, for: .normal)
        view.addSubview(favoriteButton)
        
        overviewLabel.attributedText = NSMutableAttributedString().bold("Overview", fontSize: 30)
        overviewLabel.textColor = .black
        view.addSubview(overviewLabel)
        
        summaryLabel.attributedText = NSMutableAttributedString().normal(movie.summary, fontSize: 18)
        summaryLabel.textColor = .black
        summaryLabel.lineBreakMode = .byWordWrapping
        summaryLabel.numberOfLines = 0
        view.addSubview(summaryLabel)
        
        crewView.alpha = 0
        crewView.delegate = self
        crewView.dataSource = self
        
        crewView.register(MovieDetailsCrewViewCell.self, forCellWithReuseIdentifier: "crew")
        
        view.addSubview(crewView)
        
        userScoreLabel.alpha = 0
        movieTitleLabel.alpha = 0
        releaseDateLabel.alpha = 0
        genreLabel.alpha = 0
        summaryLabel.alpha = 0
        
    }
    
    private func defineViewLayout() {
        
        movieImageView.autoSetDimension(.height, toSize: screenHeight*0.4)
        movieImageView.autoSetDimension(.width, toSize: screenWidth)
        movieImageView.autoPinEdge(toSuperviewSafeArea: .top)

        userScoreLabel.autoSetDimension(.height, toSize: 20)
        userScoreLabel.autoSetDimension(.width, toSize: screenWidth)
        userScoreLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: screenWidth*0.06)
        userScoreLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: screenHeight*0.16)
        
        movieTitleLabel.autoSetDimension(.width, toSize: screenWidth*0.88)
        movieTitleLabel.autoPinEdge(.leading, to: .leading, of: userScoreLabel)
        movieTitleLabel.autoPinEdge(.top, to: .bottom, of: userScoreLabel, withOffset: 15)
        
        releaseDateLabel.autoMatch(.width, to: .width, of: movieTitleLabel)
        releaseDateLabel.autoPinEdge(.leading, to: .leading, of: userScoreLabel)
        releaseDateLabel.autoPinEdge(.top, to: .bottom, of: movieTitleLabel, withOffset: 15)
        
        genreLabel.autoMatch(.width, to: .width, of: movieTitleLabel)
        genreLabel.autoPinEdge(.leading, to: .leading, of: userScoreLabel)
        genreLabel.autoPinEdge(.top, to: .bottom, of: releaseDateLabel, withOffset: 2)
        
        favoriteButton.autoPinEdge(.leading, to: .leading, of: userScoreLabel)
        favoriteButton.autoPinEdge(.top, to: .bottom, of: genreLabel, withOffset: 15)
        favoriteButton.autoSetDimensions(to: CGSize(width: 35, height: 35))
        
        overviewLabel.autoMatch(.width, to: .width, of: movieTitleLabel)
        overviewLabel.autoPinEdge(.leading, to: .leading, of: userScoreLabel)
        overviewLabel.autoPinEdge(.top, to: .bottom, of: movieImageView, withOffset: 30)
        
        summaryLabel.autoMatch(.width, to: .width, of: movieTitleLabel)
        summaryLabel.autoPinEdge(.leading, to: .leading, of: userScoreLabel)
        summaryLabel.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 20)
        
        crewView.autoPinEdge(.top, to: .bottom, of: summaryLabel, withOffset: 20)
        crewView.autoPinEdge(.leading, to: .leading, of: view)
        crewView.autoPinEdge(.trailing, to: .trailing, of: view)
        crewView.autoPinEdge(.bottom, to: .bottom, of: view)
        
        
        
    }
    
    private func animateViews() {

        userScoreLabel.alpha = 1
        movieTitleLabel.alpha = 1
        releaseDateLabel.alpha = 1
        genreLabel.alpha = 1
        summaryLabel.alpha = 1
        
        userScoreLabel.transform = userScoreLabel.transform.translatedBy(x: -screenWidth, y: 0)
        movieTitleLabel.transform = movieTitleLabel.transform.translatedBy(x: -screenWidth, y: 0)
        releaseDateLabel.transform = releaseDateLabel.transform.translatedBy(x: -screenWidth, y: 0)
        genreLabel.transform = genreLabel.transform.translatedBy(x: -screenWidth, y: 0)
        summaryLabel.transform = summaryLabel.transform.translatedBy(x: -screenWidth, y: 0)
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.userScoreLabel.transform = .identity
            self.movieTitleLabel.transform = .identity
            self.releaseDateLabel.transform = .identity
            self.genreLabel.transform = .identity
            self.summaryLabel.transform = .identity
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveEaseIn], animations: {
            self.crewView.alpha = 1
        })
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
}

private func categoriesToString(categories:[MovieCategoryModel]) -> String {
    var s = String()
    
    if (categories.isEmpty) {
        return String()
    }
    
    let length = s.count
    
    for i in 0...length {
        s.append(categories[i].category)
        if (i != length) {
            s.append(", ")
        }
    }

    return s
}

private func lengthIntToString(length: Int) -> String{
    let hours = length / 60
    let minutes = length % 60
    
    return String(format: " %dh %dm", arguments: [hours, minutes])
}

extension MovieDetailsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().getDetails(id: movie.id)?.crewMembers.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crew", for: indexPath) as? MovieDetailsCrewViewCell else {
                fatalError()
                }
        
        let crewMember = MovieUseCase().getDetails(id: movie.id)?.crewMembers[indexPath.row]
        
        cell.setCrew(crewMember: crewMember!)
        
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate {
}

extension MovieCategoryModel {
    var category: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .drama: return "Drama"
        case .fantasy: return "Fantasy"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .thriller: return "Thriller"
        case .western: return "Western"
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension NSMutableAttributedString {
    
    func bold(_ value:String, fontSize size: CGFloat) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String, fontSize size: CGFloat) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

