//
//  Movies.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import Foundation

// MARK: - Movies
struct MovieResponse: Decodable, Equatable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    let results: [Movie]
}
