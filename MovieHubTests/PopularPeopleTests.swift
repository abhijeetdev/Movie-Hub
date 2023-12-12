//
//  PopularPeopleTests.swift
//  MovieHubTests
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import XCTest
@testable import MovieHub

final class PopularPeopleTests: XCTestCase {
    
    func testPopularPeopleDecoding() throws {
        // Given
        let json = """
        {
            "page": 1,
            "total_pages": 5,
            "results": [
                {
                    "id": 123,
                    "profile_path": "/image.jpg",
                    "known_for": [
                        {
                            "title": "Movie Title",
                            "id": 456
                        }
                    ],
                    "name": "John Doe"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        let popularPeople = try Utils.jsonDecoder.decode(PopularPeopleResponse.self, from: json)
        
        // Then
        XCTAssertNotNil(popularPeople)
        XCTAssertEqual(popularPeople.page, 1)
        XCTAssertEqual(popularPeople.totalPages, 5)
        XCTAssertEqual(popularPeople.results.count, 1)
        
        let firstResult = popularPeople.results.first
        XCTAssertNotNil(firstResult)
        XCTAssertEqual(firstResult?.id, 123)
        XCTAssertEqual(firstResult?.profilePath, "/image.jpg")
        XCTAssertEqual(firstResult?.name, "John Doe")
        
        let knownFor = firstResult?.knownFor?.first
        XCTAssertNotNil(knownFor)
        XCTAssertEqual(knownFor?.title, "Movie Title")
        XCTAssertEqual(knownFor?.id, 456)
    }
    
    func testPeopleResultHashableConformance() {
        //Given
        let result1 = People(knownForDepartment: "Department", name: "Name", profilePath: "/path", id: 123, knownFor: [KnownFor(title: "Title", id: 456)])
        let result2 = People(knownForDepartment: "Department", name: "Name", profilePath: "/path", id: 123, knownFor: [KnownFor(title: "Title", id: 456)])
        
        //Then
        XCTAssertEqual(result1, result2)
        
        let set: Set<People> = [result1, result2]
        XCTAssertEqual(set.count, 1)
    }
    
    func testKnownForDecoding() throws {
        // Given
        let json = """
        {
            "title": "Movie Title",
            "id": 123
        }
        """.data(using: .utf8)!
        
        // When
        let knownFor = try Utils.jsonDecoder.decode(KnownFor.self, from: json)
        
        // Then
        XCTAssertNotNil(knownFor)
        XCTAssertEqual(knownFor.title, "Movie Title")
        XCTAssertEqual(knownFor.id, 123)
    }
}

