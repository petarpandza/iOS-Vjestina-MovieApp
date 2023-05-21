import Foundation

class MovieListViewModel {
    
    @Published private(set) var allMoviesPublished: [Movie] = []
    @Published private(set) var allMovieDetailsPublished: [MovieDetails] = []
    
    private let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
        
        Task {
            allMoviesPublished = await movieUseCase.allMovies()
            allMovieDetailsPublished = await movieUseCase.allMovieDetails()
        }
    }
    
    
}

