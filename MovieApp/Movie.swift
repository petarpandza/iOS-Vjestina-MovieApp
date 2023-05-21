public struct Movie: Decodable, Hashable {

    public let id: Int
    public let name: String
    public let summary: String
    public let imageUrl: String

}

public struct MovieDetails: Decodable, Equatable, Hashable {
    
    public let categories: [MovieCategory]
    public let crewMembers: [MovieCrewMember]
    public let duration: Int
    public let id: Int
    public let imageUrl: String
    public let name: String
    public let rating: Double
    public let releaseDate: String
    public let summary: String
    public let year: Int
    
}

public struct MovieCrewMember: Decodable, Equatable, Hashable {

    public let name: String
    public let role: String

}

public enum MovieCategory: String, Decodable, Equatable, Hashable {

    case action = "ACTION"
    case adventure = "ADVENTURE"
    case comedy = "COMEDY"
    case crime = "CRIME"
    case drama = "DRAMA"
    case fantasy = "FANTASY"
    case romance = "ROMANCE"
    case scienceFiction = "SCIENCE_FICTION"
    case thriller = "THRILLER"
    case western = "WESTERN"

}
