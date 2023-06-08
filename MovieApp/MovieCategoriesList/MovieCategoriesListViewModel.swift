import Foundation

class MovieCategoriesListViewModel {
    
    @Published private(set) var streamingPublished:[Movie] = []
    @Published private(set) var onTvPublished:[Movie] = []
    @Published private(set) var forRentPublished:[Movie] = []
    @Published private(set) var inTheatersPublished:[Movie] = []
    @Published private(set) var moviesPublished:[Movie] = []
    @Published private(set) var tvShowsPublished:[Movie] = []
    @Published private(set) var todayPublished:[Movie] = []
    @Published private(set) var thisWeekPublished:[Movie] = []

    private let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
        
        Task {
            streamingPublished = await movieUseCase.streamingMovies()
            moviesPublished = await movieUseCase.freeMovies()
            todayPublished = await movieUseCase.todayMovies()
            onTvPublished = await movieUseCase.onTvMovies()
            forRentPublished = await movieUseCase.forRentMovies()
            inTheatersPublished = await movieUseCase.inTheatersMovies()
            tvShowsPublished = await movieUseCase.freeTvShows()
            thisWeekPublished = await movieUseCase.thisWeekMovies()
        }
    }
    
    
}
