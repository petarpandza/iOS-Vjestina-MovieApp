import Foundation
import Combine

protocol MovieUseCaseProtocol {

    func popularMovies() async -> [Movie]
    func freeToWatchMovies() async -> [Movie]
    func trendingMovies() async -> [Movie]
    func allMovies() async -> [Movie]
    func getDetails(forId id :Int) async -> MovieDetails
    func allMovieDetails() async -> [MovieDetails]

}

class MovieUseCase: MovieUseCaseProtocol {
    
    func getDetails(forId id: Int) async -> MovieDetails {
        do {
            return try await fetchDetails(forId: id)
        } catch {
            fatalError("movie details fetch")
        }
    }
    
    func popularMovies() async -> [Movie] {
        do {
            let response1 = try await fetchMovie(forCriteria: "popular?criteria=FOR_RENT")
            let response2 = try await fetchMovie(forCriteria: "popular?criteria=IN_THEATERS")
            let response3 = try await fetchMovie(forCriteria: "popular?criteria=ON_TV")
            let response4 = try await fetchMovie(forCriteria: "popular?criteria=STREAMING")
            
            var responses = Set<Movie>()
            responses.formUnion(response1)
            responses.formUnion(response2)
            responses.formUnion(response3)
            responses.formUnion(response4)
            
            return Array(responses)
        } catch {
            fatalError("popular movies fetch")
        }
    }
    
    func freeToWatchMovies() async -> [Movie] {
        do {
            let response1 = try await fetchMovie(forCriteria: "free-to-watch?criteria=MOVIE")
            let response2 = try await fetchMovie(forCriteria: "free-to-watch?criteria=TV_SHOW")
            
            var responses = Set<Movie>()
            responses.formUnion(response1)
            responses.formUnion(response2)
            
            return Array(responses)
        } catch {
            fatalError("free movies fetch")
        }
    }
    
    func trendingMovies() async -> [Movie] {
        do {
            let response1 = try await fetchMovie(forCriteria: "trending?criteria=THIS_WEEK")
            let response2 = try await fetchMovie(forCriteria: "trending?criteria=TODAY")
            
            var responses = Set<Movie>()
            responses.formUnion(response1)
            responses.formUnion(response2)
            
            return Array(responses)
        } catch {
            fatalError("trending movies fetch")
        }
    }

    func allMovies() async -> [Movie] {
        do {
            let response1 = try await fetchMovie(forCriteria: "popular?criteria=FOR_RENT")
            let response2 = try await fetchMovie(forCriteria: "popular?criteria=IN_THEATERS")
            let response3 = try await fetchMovie(forCriteria: "popular?criteria=ON_TV")
            let response4 = try await fetchMovie(forCriteria: "popular?criteria=STREAMING")
            
            let response5 = try await fetchMovie(forCriteria: "free-to-watch?criteria=MOVIE")
            let response6 = try await fetchMovie(forCriteria: "free-to-watch?criteria=TV_SHOW")
            
            let response7 = try await fetchMovie(forCriteria: "trending?criteria=THIS_WEEK")
            let response8 = try await fetchMovie(forCriteria: "trending?criteria=TODAY")
            
            var responses = Set<Movie>()
            responses.formUnion(response1)
            responses.formUnion(response2)
            responses.formUnion(response3)
            responses.formUnion(response4)
            responses.formUnion(response5)
            responses.formUnion(response6)
            responses.formUnion(response7)
            responses.formUnion(response8)
            
            return Array(responses)
        } catch {
            fatalError("popular movies fetch")
        }
    }
    
    func allMovieDetails() async -> [MovieDetails] {
        var set: [MovieDetails] = []
        
        let allMovies = await allMovies()
        
        for movie in allMovies {
            do {
                try set.append(await fetchDetails(forId: movie.id))
            } catch {
                fatalError("all movie details fetch")
            }
        }
        
        return set
    }
    
    private func fetchMovie(forCriteria criteria:String) async throws -> [Movie] {
        
        guard let url = URL(string: "https://five-ios-api.herokuapp.com/api/v1/movie/" + criteria) else {
            print("Invalid URL")
            return []
        }
        
        var request = URLRequest(url: url)
        
        let token = "Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        let responseData = try decoder.decode([Movie].self, from: data)
        
        return responseData
    }
    
    private func fetchDetails(forId id: Int) async throws -> MovieDetails {
        
        guard let url = URL(string: "https://five-ios-api.herokuapp.com/api/v1/movie/" + String(id) + "/details") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        
        let token = "Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        let responseData = try decoder.decode(MovieDetails.self, from: data)
        
        return responseData
    }

}
