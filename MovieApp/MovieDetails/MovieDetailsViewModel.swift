import Foundation

class MovieDetailsViewModel {
    
    @Published private(set) var movie: Movie
    @Published private(set) var movieDetails: MovieDetails?

    init(movie: Movie) {
        self.movie = movie
        self.movieDetails = MovieDetails(categories: [], crewMembers: [], duration: 0, id: 0, imageUrl: "", name: "", rating: 0, releaseDate: "", summary: "", year: 1)
        
        Task {
            let useCase = MovieUseCase()
            movieDetails = await useCase.getDetails(forId: movie.id)
        }
    }
    
    
}

