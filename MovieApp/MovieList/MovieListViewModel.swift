import Foundation

class MovieListViewModel {
    
    @Published private(set) var allMoviesPublished: [Movie] = []
    
    private let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
        
        Task {
            allMoviesPublished = await movieUseCase.allMovies()
        }
    }
    
    
}

