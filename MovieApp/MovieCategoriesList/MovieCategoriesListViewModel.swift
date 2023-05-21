import Foundation

class MovieCategoriesListViewModel {
    
    @Published private(set) var popularMoviesPublished: [Movie] = []
    @Published private(set) var freeMoviesPublished: [Movie] = []
    @Published private(set) var trendingMoviesPublished: [Movie] = []
    
    private let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
        
        Task {
            popularMoviesPublished = await movieUseCase.popularMovies()
            freeMoviesPublished = await movieUseCase.freeToWatchMovies()
            trendingMoviesPublished = await movieUseCase.trendingMovies()
        }
    }
    
    
}
