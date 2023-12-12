//
//  Urls.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import Foundation

enum URLs {
    private static let API_Key = "1689e46a26ad66d068502d0097d09c7d"
    private static let language = "language=en-US"
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    enum People {
        static let popular = baseURL + "person/popular?api_key=\(API_Key)&\(language)&page="
        static let detailBase = baseURL + "person/"
        static let detailEnd = "?api_key=\(API_Key)&\(language)"
        static let movieCreditsBase = "\(baseURL)person/"
        static let movieCreditsEnd = "/movie_credits?api_key=\(API_Key)&\(language)"
    }
    
    enum Movies {
        static let popular = baseURL + "movie/popular?api_key=\(API_Key)&\(language)&page="
        static let trending = baseURL + "trending/movie/week?api_key=\(API_Key)&\(language)"
        static let nowPlaying = baseURL + "movie/now_playing?api_key=\(API_Key)&\(language)&region=US&page="
        static let upcoming = baseURL + "movie/upcoming?api_key=\(API_Key)&\(language)&page="
        
        static func details(id: Int) -> String {
            return baseURL + "movie/\(id)?api_key=\(API_Key)&\(language)&append_to_response=videos,credits"
        }
    }
    
    enum TV {
        static let popular = "\(baseURL)tv/popular?api_key=\(API_Key)&\(language)&page="
    }
    
    enum Search {
        static let queryBase = baseURL + "search/person?api_key=\(API_Key)&\(language)&query="
        static let queryMiddle = "&page="
        static let queryEnd = "&include_adult=false"
    }
    
    enum Configuration {
        static let languages = "\(baseURL)configuration/languages?api_key=\(API_Key)"
    }
    
    enum Others {
        static let video = "https://www.themoviedb.org/video/play?key=P6AaSMfXHbA"
        static let movieImages = "/images?api_key=\(API_Key)&\(language)&include_image_language=en"
    }
    
    enum ImageRequest {
        static let w500 = "https://image.tmdb.org/t/p/w500"
        static let original = "https://image.tmdb.org/t/p/original"
        static let w1280 = "https://image.tmdb.org/t/p/w1280"
        static let w185 = "https://image.tmdb.org/t/p/w185"
    }
    
    static let youTube = "https://youtube.com/watch?v="
}
