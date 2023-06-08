import Foundation
import UIKit
import PureLayout
import Combine

class MovieCategoriesListViewController: UIViewController {
    
    private var mainScrollView: UIScrollView!
    
    private var streamingCollectionView: UICollectionView!
    private var onTvCollectionView: UICollectionView!
    private var forRentCollectionView: UICollectionView!
    private var inTheatersCollectionView: UICollectionView!
    private var moviesCollectionView: UICollectionView!
    private var tvShowsCollectionView: UICollectionView!
    private var todayCollectionView: UICollectionView!
    private var thisWeekCollectionView: UICollectionView!
    
    private var streamingLayout: UICollectionViewFlowLayout!
    private var onTvLayout: UICollectionViewFlowLayout!
    private var forRentLayout: UICollectionViewFlowLayout!
    private var inTheatersLayout: UICollectionViewFlowLayout!
    private var moviesLayout: UICollectionViewFlowLayout!
    private var tvShowsLayout: UICollectionViewFlowLayout!
    private var todayLayout: UICollectionViewFlowLayout!
    private var thisWeekLayout: UICollectionViewFlowLayout!
    
    private var whatsPopularLabel: UILabel!
    private var freeToWatchLabel: UILabel!
    private var trendingLabel: UILabel!

    private var streamingLabel: UIButton!
    private var onTvLabel: UIButton!
    private var forRentLabel: UIButton!
    private var inTheatersLabel: UIButton!
    private var moviesLabel: UIButton!
    private var tvShowsLabel: UIButton!
    private var todayLabel: UIButton!
    private var thisWeekLabel: UIButton!
    
    private var popularSelected: UIButton!
    private var freeToWatchSelected: UIButton!
    private var trendingSelected: UIButton!
    
    private var viewModel: MovieCategoriesListViewModel!
    private var disposables = Set<AnyCancellable>()
    private var streaming:[Movie] = []
    private var onTv:[Movie] = []
    private var forRent:[Movie] = []
    private var inTheaters:[Movie] = []
    private var movies:[Movie] = []
    private var tvShows:[Movie] = []
    private var today:[Movie] = []
    private var thisWeek:[Movie] = []
    
    private var streamingDataSource: MovieCategoriesCollectionViewDataSource!
    private var onTvDataSource: MovieCategoriesCollectionViewDataSource!
    private var forRentDataSource: MovieCategoriesCollectionViewDataSource!
    private var inTheatersDataSource: MovieCategoriesCollectionViewDataSource!
    private var moviesDataSource: MovieCategoriesCollectionViewDataSource!
    private var tvShowsDataSource: MovieCategoriesCollectionViewDataSource!
    private var todayDataSource: MovieCategoriesCollectionViewDataSource!
    private var thisWeekDataSource: MovieCategoriesCollectionViewDataSource!
    
    var coordinator: MovieListCoordinator!
    
    private var userDefaults: UserDefaults!
    
    init(viewModel: MovieCategoriesListViewModel) {
        self.viewModel = viewModel
        // TODO: Maybe isn't needed
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
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Movie List"
    }
    
    private func createViews() {
        mainScrollView = UIScrollView()
        
        streamingLayout = MovieCategoriesCollectionViewLayout()
        onTvLayout = MovieCategoriesCollectionViewLayout()
        forRentLayout = MovieCategoriesCollectionViewLayout()
        inTheatersLayout = MovieCategoriesCollectionViewLayout()
        moviesLayout = MovieCategoriesCollectionViewLayout()
        tvShowsLayout = MovieCategoriesCollectionViewLayout()
        todayLayout = MovieCategoriesCollectionViewLayout()
        thisWeekLayout = MovieCategoriesCollectionViewLayout()
        
        streamingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: streamingLayout)
        onTvCollectionView = UICollectionView(frame: .zero, collectionViewLayout: onTvLayout)
        forRentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: forRentLayout)
        inTheatersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: inTheatersLayout)
        moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: moviesLayout)
        tvShowsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: tvShowsLayout)
        todayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: todayLayout)
        thisWeekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: thisWeekLayout)
        
        streamingDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "streaming")
        onTvDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "ontv")
        forRentDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "forrent")
        inTheatersDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "intheaters")
        moviesDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "movies")
        tvShowsDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "tvshows")
        todayDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "today")
        thisWeekDataSource = MovieCategoriesCollectionViewDataSource(movies: [], type: "thisweek")
        
        whatsPopularLabel = UILabel()
        freeToWatchLabel = UILabel()
        trendingLabel = UILabel()
        
        streamingLabel = UIButton()
        onTvLabel = UIButton()
        forRentLabel = UIButton()
        inTheatersLabel = UIButton()
        moviesLabel = UIButton()
        tvShowsLabel = UIButton()
        todayLabel = UIButton()
        thisWeekLabel = UIButton()
        
        mainScrollView.addSubview(streamingCollectionView)
        mainScrollView.addSubview(onTvCollectionView)
        mainScrollView.addSubview(forRentCollectionView)
        mainScrollView.addSubview(inTheatersCollectionView)
        mainScrollView.addSubview(moviesCollectionView)
        mainScrollView.addSubview(tvShowsCollectionView)
        mainScrollView.addSubview(todayCollectionView)
        mainScrollView.addSubview(thisWeekCollectionView)
        
        mainScrollView.addSubview(whatsPopularLabel)
        mainScrollView.addSubview(freeToWatchLabel)
        mainScrollView.addSubview(trendingLabel)
        
        mainScrollView.addSubview(streamingLabel)
        mainScrollView.addSubview(onTvLabel)
        mainScrollView.addSubview(forRentLabel)
        mainScrollView.addSubview(inTheatersLabel)
        mainScrollView.addSubview(moviesLabel)
        mainScrollView.addSubview(tvShowsLabel)
        mainScrollView.addSubview(todayLabel)
        mainScrollView.addSubview(thisWeekLabel)
        
        view.addSubview(mainScrollView)
    }
    
    private func customizeViews() {
        
        view.backgroundColor = .white
        onTvCollectionView.isHidden = true
        forRentCollectionView.isHidden = true
        inTheatersCollectionView.isHidden = true
        tvShowsCollectionView.isHidden = true
        thisWeekCollectionView.isHidden = true
        
        whatsPopularLabel.attributedText = NSMutableAttributedString().bold("What's popular", fontSize: 20)
        freeToWatchLabel.attributedText = NSMutableAttributedString().bold("Free to Watch", fontSize: 20)
        trendingLabel.attributedText = NSMutableAttributedString().bold("Trending", fontSize: 20)
        
        streamingLabel.setTitleColor(.black, for: .selected)
        streamingLabel.setTitleColor(.gray, for: .normal)
        onTvLabel.setTitleColor(.black, for: .selected)
        onTvLabel.setTitleColor(.gray, for: .normal)
        forRentLabel.setTitleColor(.black, for: .selected)
        forRentLabel.setTitleColor(.gray, for: .normal)
        inTheatersLabel.setTitleColor(.black, for: .selected)
        inTheatersLabel.setTitleColor(.gray, for: .normal)
        moviesLabel.setTitleColor(.black, for: .selected)
        moviesLabel.setTitleColor(.gray, for: .normal)
        tvShowsLabel.setTitleColor(.black, for: .selected)
        tvShowsLabel.setTitleColor(.gray, for: .normal)
        todayLabel.setTitleColor(.black, for: .selected)
        todayLabel.setTitleColor(.gray, for: .normal)
        thisWeekLabel.setTitleColor(.black, for: .selected)
        thisWeekLabel.setTitleColor(.gray, for: .normal)
        
        streamingLabel.setAttributedTitle(NSMutableAttributedString().underlined("Streaming", fontSize: 18), for: .selected)
        streamingLabel.setAttributedTitle(NSMutableAttributedString().normal("Streaming", fontSize: 18), for: .normal)
        onTvLabel.setAttributedTitle(NSMutableAttributedString().underlined("On TV", fontSize: 18), for: .selected)
        onTvLabel.setAttributedTitle(NSMutableAttributedString().normal("On TV", fontSize: 18), for: .normal)
        forRentLabel.setAttributedTitle(NSMutableAttributedString().underlined("For Rent", fontSize: 18), for: .selected)
        forRentLabel.setAttributedTitle(NSMutableAttributedString().normal("For Rent", fontSize: 18), for: .normal)
        inTheatersLabel.setAttributedTitle(NSMutableAttributedString().underlined("In Theaters", fontSize: 18), for: .selected)
        inTheatersLabel.setAttributedTitle(NSMutableAttributedString().normal("In Theaters", fontSize: 18), for: .normal)
        moviesLabel.setAttributedTitle(NSMutableAttributedString().underlined("Movies", fontSize: 18), for: .selected)
        moviesLabel.setAttributedTitle(NSMutableAttributedString().normal("Movies", fontSize: 18), for: .normal)
        tvShowsLabel.setAttributedTitle(NSMutableAttributedString().underlined("TV", fontSize: 18), for: .selected)
        tvShowsLabel.setAttributedTitle(NSMutableAttributedString().normal("TV", fontSize: 18), for: .normal)
        todayLabel.setAttributedTitle(NSMutableAttributedString().underlined("Today", fontSize: 18), for: .selected)
        todayLabel.setAttributedTitle(NSMutableAttributedString().normal("Today", fontSize: 18), for: .normal)
        thisWeekLabel.setAttributedTitle(NSMutableAttributedString().underlined("This Week", fontSize: 18), for: .selected)
        thisWeekLabel.setAttributedTitle(NSMutableAttributedString().normal("This Week", fontSize: 18), for: .normal)
        
        streamingLabel.addTarget(self, action: #selector(popularSelected(_:)), for: .touchUpInside)
        onTvLabel.addTarget(self, action: #selector(popularSelected(_:)), for: .touchUpInside)
        forRentLabel.addTarget(self, action: #selector(popularSelected(_:)), for: .touchUpInside)
        inTheatersLabel.addTarget(self, action: #selector(popularSelected(_:)), for: .touchUpInside)
        
        moviesLabel.addTarget(self, action: #selector(freeToWatchSelected(_:)), for: .touchUpInside)
        tvShowsLabel.addTarget(self, action: #selector(freeToWatchSelected(_:)), for: .touchUpInside)
        
        todayLabel.addTarget(self, action: #selector(trendingSelected(_:)), for: .touchUpInside)
        thisWeekLabel.addTarget(self, action: #selector(trendingSelected(_:)), for: .touchUpInside)
        
        streamingLabel.isSelected = true
        moviesLabel.isSelected = true
        todayLabel.isSelected = true
        
        popularSelected = streamingLabel
        freeToWatchSelected = moviesLabel
        trendingSelected = todayLabel
        
        streamingLabel.tag = 11
        onTvLabel.tag = 12
        forRentLabel.tag = 13
        inTheatersLabel.tag = 14
        moviesLabel.tag = 21
        tvShowsLabel.tag = 22
        todayLabel.tag = 31
        thisWeekLabel.tag = 32
        
        
        streamingCollectionView.delegate = self
        streamingCollectionView.dataSource = streamingDataSource
        streamingCollectionView.tag = 11
        
        onTvCollectionView.delegate = self
        onTvCollectionView.dataSource = onTvDataSource
        onTvCollectionView.tag = 12
        
        forRentCollectionView.delegate = self
        forRentCollectionView.dataSource = forRentDataSource
        forRentCollectionView.tag = 13
        
        inTheatersCollectionView.delegate = self
        inTheatersCollectionView.dataSource = inTheatersDataSource
        inTheatersCollectionView.tag = 14
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = moviesDataSource
        moviesCollectionView.tag = 21
        
        tvShowsCollectionView.delegate = self
        tvShowsCollectionView.dataSource = tvShowsDataSource
        tvShowsCollectionView.tag = 22
        
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = todayDataSource
        todayCollectionView.tag = 31
        
        thisWeekCollectionView.delegate = self
        thisWeekCollectionView.dataSource = thisWeekDataSource
        thisWeekCollectionView.tag = 32
        
    }
    
    private func defineViewLayout() {
        
        mainScrollView.autoPinEdgesToSuperviewSafeArea()
        
        whatsPopularLabel.autoSetDimension(.width, toSize: 363)
        whatsPopularLabel.autoSetDimension(.height, toSize: 25)
        whatsPopularLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        whatsPopularLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        
        streamingLabel.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel)
        streamingLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        
        onTvLabel.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel)
        onTvLabel.autoPinEdge(.leading, to: .trailing, of: streamingLabel, withOffset: 20)
        
        forRentLabel.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel)
        forRentLabel.autoPinEdge(.leading, to: .trailing, of: onTvLabel, withOffset: 20)
        
        inTheatersLabel.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel)
        inTheatersLabel.autoPinEdge(.leading, to: .trailing, of: forRentLabel, withOffset: 20)
        
        streamingCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        streamingCollectionView.autoPinEdge(.top, to: .bottom, of: streamingLabel, withOffset: -15)
        streamingCollectionView.autoSetDimension(.height, toSize: 220)
        streamingCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        onTvCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        onTvCollectionView.autoPinEdge(.top, to: .bottom, of: streamingLabel, withOffset: -15)
        onTvCollectionView.autoSetDimension(.height, toSize: 220)
        onTvCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        forRentCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        forRentCollectionView.autoPinEdge(.top, to: .bottom, of: streamingLabel, withOffset: -15)
        forRentCollectionView.autoSetDimension(.height, toSize: 220)
        forRentCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        inTheatersCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        inTheatersCollectionView.autoPinEdge(.top, to: .bottom, of: streamingLabel, withOffset: -15)
        inTheatersCollectionView.autoSetDimension(.height, toSize: 220)
        inTheatersCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        freeToWatchLabel.autoMatch(.width, to: .width, of: whatsPopularLabel)
        freeToWatchLabel.autoMatch(.height, to: .height, of: whatsPopularLabel)
        freeToWatchLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        freeToWatchLabel.autoPinEdge(.top, to: .bottom, of: streamingCollectionView, withOffset: 25)
        
        moviesLabel.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel)
        moviesLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        
        tvShowsLabel.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel)
        tvShowsLabel.autoPinEdge(.leading, to: .trailing, of: moviesLabel, withOffset: 20)
        
        moviesCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        moviesCollectionView.autoPinEdge(.top, to: .bottom, of: moviesLabel, withOffset: -15)
        moviesCollectionView.autoSetDimension(.height, toSize: 220)
        moviesCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        tvShowsCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        tvShowsCollectionView.autoPinEdge(.top, to: .bottom, of: moviesLabel, withOffset: -15)
        tvShowsCollectionView.autoSetDimension(.height, toSize: 220)
        tvShowsCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        trendingLabel.autoMatch(.width, to: .width, of: whatsPopularLabel)
        trendingLabel.autoMatch(.height, to: .height, of: whatsPopularLabel)
        trendingLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        trendingLabel.autoPinEdge(.top, to: .bottom, of: moviesCollectionView, withOffset: 25)
        
        todayLabel.autoPinEdge(.top, to: .bottom, of: trendingLabel)
        todayLabel.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel)
        
        thisWeekLabel.autoPinEdge(.top, to: .bottom, of: trendingLabel)
        thisWeekLabel.autoPinEdge(.leading, to: .trailing, of: todayLabel, withOffset: 20)
        
        todayCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        todayCollectionView.autoPinEdge(.top, to: .bottom, of: todayLabel, withOffset: -15)
        todayCollectionView.autoSetDimension(.height, toSize: 220)
        todayCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        thisWeekCollectionView.autoPinEdge(.leading, to: .leading, of: whatsPopularLabel, withOffset: 0)
        thisWeekCollectionView.autoPinEdge(.top, to: .bottom, of: todayLabel, withOffset: -15)
        thisWeekCollectionView.autoSetDimension(.height, toSize: 220)
        thisWeekCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)

        mainScrollView.contentSize = CGSize(width: view.frame.width, height: 880)
    }
    
    private func registerCollectionViews() {
        
        streamingCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "streaming")
        onTvCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "ontv")
        forRentCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "forrent")
        inTheatersCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "intheaters")
        moviesCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "movies")
        tvShowsCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "tvshows")
        todayCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "today")
        thisWeekCollectionView.register(MovieCategoriesListViewCell.self, forCellWithReuseIdentifier: "thisweek")
        
    }
    
    private func bindData() {
        
        self.streaming = viewModel.streamingPublished
        self.movies = viewModel.moviesPublished
        self.today = viewModel.todayPublished
        
        self.onTv = viewModel.onTvPublished
        self.forRent = viewModel.forRentPublished
        self.inTheaters = viewModel.inTheatersPublished
        self.tvShows = viewModel.tvShowsPublished
        self.thisWeek = viewModel.thisWeekPublished
        
        
        viewModel
            .$streamingPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.streaming = movies
                self.streamingDataSource.updateData(movies: movies)
                self.streamingCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$moviesPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.movies = movies
                self.moviesDataSource.updateData(movies: movies)
                self.moviesCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$todayPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.today = movies
                self.todayDataSource.updateData(movies: movies)
                self.todayCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$onTvPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.onTv = movies
                self.onTvDataSource.updateData(movies: movies)
                self.onTvCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$forRentPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.forRent = movies
                self.forRentDataSource.updateData(movies: movies)
                self.forRentCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$inTheatersPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.inTheaters = movies
                self.inTheatersDataSource.updateData(movies: movies)
                self.inTheatersCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$tvShowsPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.tvShows = movies
                self.tvShowsDataSource.updateData(movies: movies)
                self.tvShowsCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        viewModel
            .$thisWeekPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else {return}
                
                self.thisWeek = movies
                self.thisWeekDataSource.updateData(movies: movies)
                self.thisWeekCollectionView.reloadData()
            }
            .store(in: &disposables)
        
        
    }
    
    @objc func popularSelected(_ sender: UIButton) {
        guard sender != popularSelected else {
            return
        }
        
        popularSelected.isSelected = false
        popularSelected = sender
        
        streamingLabel.setTitleColor(.black, for: .selected)
        streamingLabel.setTitleColor(.gray, for: .normal)
        onTvLabel.setTitleColor(.black, for: .selected)
        onTvLabel.setTitleColor(.gray, for: .normal)
        forRentLabel.setTitleColor(.black, for: .selected)
        forRentLabel.setTitleColor(.gray, for: .normal)
        inTheatersLabel.setTitleColor(.black, for: .selected)
        inTheatersLabel.setTitleColor(.gray, for: .normal)
        
        streamingCollectionView.isHidden = true
        onTvCollectionView.isHidden = true
        forRentCollectionView.isHidden = true
        inTheatersCollectionView.isHidden = true
        
        switch sender.tag {
        case 11:
            streamingCollectionView.isHidden = false
        case 12:
            onTvCollectionView.isHidden = false
        case 13:
            forRentCollectionView.isHidden = false
        case 14:
            inTheatersCollectionView.isHidden = false
        default:
            fatalError("Button pressed, unknown tag")
        }
        
        sender.isSelected = true
    }
    
    @objc func freeToWatchSelected(_ sender: UIButton) {
        guard sender != freeToWatchSelected else {
            return
        }
        
        freeToWatchSelected.isSelected = false
        freeToWatchSelected = sender
        
        moviesLabel.setTitleColor(.black, for: .selected)
        moviesLabel.setTitleColor(.gray, for: .normal)
        tvShowsLabel.setTitleColor(.black, for: .selected)
        tvShowsLabel.setTitleColor(.gray, for: .normal)
        
        moviesCollectionView.isHidden = true
        tvShowsCollectionView.isHidden = true
        
        switch sender.tag {
        case 21:
            moviesCollectionView.isHidden = false
        case 22:
            tvShowsCollectionView.isHidden = false
        default:
            fatalError("Button pressed, unknown tag")
        }
        
        sender.isSelected = true
    }
    
    @objc func trendingSelected(_ sender: UIButton) {
        guard sender != trendingSelected else {
            return
        }
        
        trendingSelected.isSelected = false
        trendingSelected = sender
        
        todayLabel.setTitleColor(.black, for: .selected)
        todayLabel.setTitleColor(.gray, for: .normal)
        thisWeekLabel.setTitleColor(.black, for: .selected)
        thisWeekLabel.setTitleColor(.gray, for: .normal)
        
        todayCollectionView.isHidden = true
        thisWeekCollectionView.isHidden = true

        
        switch sender.tag {
        case 31:
            todayCollectionView.isHidden = false
        case 32:
            thisWeekCollectionView.isHidden = false
        default:
            fatalError("Button pressed, unknown tag")
        }
        
        sender.isSelected = true
    }
    
    private func userDidSelect(movie: Movie) {
        coordinator.showMovieDetails(for: movie)
    }
    
}


extension MovieCategoriesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
            
        case 11:
            let movie = streaming[indexPath.row]
            userDidSelect(movie: movie)
        case 12:
            let movie = onTv[indexPath.row]
            userDidSelect(movie: movie)
        case 13:
            let movie = forRent[indexPath.row]
            userDidSelect(movie: movie)
        case 14:
            let movie = inTheaters[indexPath.row]
            userDidSelect(movie: movie)
        case 21:
            let movie = movies[indexPath.row]
            userDidSelect(movie: movie)
        case 22:
            let movie = tvShows[indexPath.row]
            userDidSelect(movie: movie)
        case 31:
            let movie = today[indexPath.row]
            userDidSelect(movie: movie)
        case 32:
            let movie = thisWeek[indexPath.row]
            userDidSelect(movie: movie)
        default:
            fatalError("Clicked cell detection error")
        }
    }
}
