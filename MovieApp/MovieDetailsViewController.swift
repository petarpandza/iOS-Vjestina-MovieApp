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
    private var movieLengthLabel: UILabel!
    private var favoriteButton: UIButton!
    private var overviewLabel: UILabel!
    private var summaryLabel: UILabel!
    private var crewView: UICollectionView!
    
    
    private var screenHeight: CGFloat!
    private var screenWidth: CGFloat!
    private var movieDetails: MovieDetailsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        movieDetails = MovieUseCase().getDetails(id: 111161)
        
        createViews()
        customizeViews()
        defineViewLayout()
        
    }
    
    
    private func createViews() {
        
        screenHeight = view.frame.height
        screenWidth = view.frame.width
        
        
        movieImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight*0.4))
        userScoreLabel = UILabel(frame: CGRect(x: screenWidth*0.06, y: screenHeight*0.16, width: screenWidth, height: 20))
        movieTitleLabel = UILabel()
        releaseDateLabel = UILabel()
        genreLabel = UILabel()
        favoriteButton = UIButton()
        overviewLabel = UILabel()
        summaryLabel = UILabel()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth*0.26, height: 40)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: screenWidth*0.06, bottom: 0, right: screenWidth*0.06)
        layout.minimumInteritemSpacing = 10
        crewView = UICollectionView(frame: .zero, collectionViewLayout: layout)
 
        
    }
    
    private func customizeViews() {
        
        movieImageView.load(url: URL(string: movieDetails.imageUrl)!)
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        view.addSubview(movieImageView)
        
        userScoreLabel.attributedText = NSMutableAttributedString().bold(String(format: "%.1f", arguments: [movieDetails.rating]), fontSize: 20).normal(" User Score", fontSize: 16)
        userScoreLabel.textColor = .white
        view.addSubview(userScoreLabel)
        
        movieTitleLabel.attributedText = NSMutableAttributedString().bold(movieDetails.name, fontSize: 30).normal(String(format: " (%d)", arguments: [movieDetails.year]), fontSize: 30)
        movieTitleLabel.textColor = .white
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(movieTitleLabel)
        
        releaseDateLabel.attributedText = NSMutableAttributedString().normal(movieDetails.releaseDate, fontSize: 15)
        releaseDateLabel.textColor = .white
        view.addSubview(releaseDateLabel)
        
        genreLabel.attributedText = NSMutableAttributedString().normal(categoriesToString(categories: movieDetails.categories), fontSize: 15).bold(lengthIntToString(length: movieDetails.duration), fontSize: 15)
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
        
        summaryLabel.attributedText = NSMutableAttributedString().normal(movieDetails.summary, fontSize: 18)
        summaryLabel.textColor = .black
        summaryLabel.lineBreakMode = .byWordWrapping
        summaryLabel.numberOfLines = 0
        view.addSubview(summaryLabel)
        
        //crewView.translatesAutoresizingMaskIntoConstraints = false
        crewView.delegate = self
        crewView.dataSource = self
        for crew in movieDetails.crewMembers {
            crewView.register(crewViewCell.self, forCellWithReuseIdentifier: crew.name)
        }
        view.addSubview(crewView)
        
    }
    
    private func defineViewLayout() {
        
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
        let movieDetails = MovieUseCase().getDetails(id: 111161)
        return movieDetails?.crewMembers.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieDetails = MovieUseCase().getDetails(id: 111161)
        let crewName = movieDetails?.crewMembers[indexPath.row].name
        let crewRole = movieDetails?.crewMembers[indexPath.row].role
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: crewName!, for: indexPath) as! crewViewCell
        cell.nameLabel.attributedText = NSMutableAttributedString().bold(crewName!, fontSize: 18)
        cell.roleLabel.attributedText = NSMutableAttributedString().normal(crewRole!, fontSize: 18)
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
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

class crewViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    var roleLabel: UILabel!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        
        roleLabel = UILabel()
        roleLabel.textColor = .black
        roleLabel.textAlignment = .left
        roleLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(roleLabel)
        
        nameLabel.autoPinEdge(.top, to: .top, of: contentView)
        nameLabel.autoPinEdge(.leading, to: .leading, of: contentView)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView)
        
        roleLabel.autoPinEdge(.top, to: .bottom, of: nameLabel)
        roleLabel.autoPinEdge(.leading, to: .leading, of: contentView)
        roleLabel.autoPinEdge(.trailing, to: .trailing, of: contentView)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
}
