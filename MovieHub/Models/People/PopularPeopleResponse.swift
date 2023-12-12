//
//  PopularPeople.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import Foundation

// MARK: - PopularPeople
struct PopularPeopleResponse: Codable {
    var page, totalPages: Int?
    var results: [People]
}

// MARK: - Result
struct People: Codable, Hashable {
    var knownForDepartment,name ,profilePath: String?
    var  id: Int?
    var knownFor: [KnownFor]?
}

// MARK: - KnownFor
struct KnownFor: Codable, Hashable {
    var title: String?
    var id: Int?

}
