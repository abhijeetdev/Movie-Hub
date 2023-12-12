//
//  Movie+Stub.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//

import Foundation

extension Movie {
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movies")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        return stubbedMovies[0]
    }
    
}

extension Bundle {
    
    func loadAndDecodeJSON<T: Decodable>(filename: String) throws -> T? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(T.self, from: data)
        return decodedModel
    }
}
