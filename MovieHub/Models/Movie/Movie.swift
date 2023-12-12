//
//  Movie.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    
    let adult: Bool?
    let backdropPath: String?
    let originalTitle: String?
    let genreIds: [Int]?
    let title: String?
    let voteAverage: Double
    let overview, releaseDate: String?
    let runtime: Int?
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: "\(URLs.ImageRequest.w500)\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "\(URLs.ImageRequest.w500)\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? Strings.NA
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return Strings.NA
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return Strings.NA
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return Strings.NA
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? Strings.NA
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == Strings.DIRECTOR }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == Strings.PRODUCER }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == Strings.STORY }
    }
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
}

extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MovieGenre: Codable {
    
    let name: String
}

struct MovieCredit: Codable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Codable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Codable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieVideoResponse: Codable {
    let results: [MovieVideo]
}

struct MovieVideo: Codable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == Strings.YOUTUBE else {
            return nil
        }
        return URL(string: "\(URLs.youTube)\(key)")
    }
}
