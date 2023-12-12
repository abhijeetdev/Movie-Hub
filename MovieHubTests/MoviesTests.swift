//
//  MoviesTests.swift
//  MovieHubTests
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import XCTest
@testable import MovieHub

final class MoviesTests: XCTestCase {
    
    func testMoviesDecoding() {
        // Given
        let json = """
        {
            "page": 1,
            "total_results": 100,
            "total_pages": 5,
            "results": [
                {
                    "popularity": 123.45,
                    "vote_count": 500,
                    "video": false,
                    "poster_path": "/example_poster_path",
                    "id": 1234,
                    "adult": false,
                    "backdrop_path": "/example_backdrop_path",
                    "original_title": "Original Title",
                    "genre_ids": [1, 2, 3],
                    "title": "Title",
                    "vote_average": 8.5,
                    "overview": "Example overview",
                    "release_date": "2023-01-01"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        do {
            let movies = try Utils.jsonDecoder.decode(MovieResponse.self, from: json)
            
            // Then
            XCTAssertNotNil(movies)
            XCTAssertEqual(movies.page, 1)
            XCTAssertEqual(movies.totalResults, 100)
            XCTAssertEqual(movies.totalPages, 5)
            
            XCTAssertEqual(movies.results.count, 1)
            let movieResult = movies.results[0]
            XCTAssertNotNil(movieResult)
            XCTAssertEqual(movieResult.popularity, 123.45)
            XCTAssertEqual(movieResult.voteCount, 500)
            XCTAssertEqual(movieResult.video, false)
            XCTAssertEqual(movieResult.posterPath, "/example_poster_path")
            XCTAssertEqual(movieResult.id, 1234)
            XCTAssertEqual(movieResult.adult, false)
            XCTAssertEqual(movieResult.backdropPath, "/example_backdrop_path")
            XCTAssertEqual(movieResult.originalTitle, "Original Title")
            XCTAssertEqual(movieResult.genreIds, [1, 2, 3])
            XCTAssertEqual(movieResult.title, "Title")
            XCTAssertEqual(movieResult.voteAverage, 8.5)
            XCTAssertEqual(movieResult.overview, "Example overview")
            XCTAssertEqual(movieResult.releaseDate, "2023-01-01")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testNilValuesDecoding() {
        // Given
        let json = """
    {
        "page": 1,
        "total_results": null,
        "total_pages": 5,
        "results": [
            {
                "popularity": 123.45,
                "vote_count": 500,
                "video": false,
                "poster_path": "/example_poster_path",
                "id": 1234,
                "adult": false,
                "backdrop_path": null,
                "original_title": "Original Title",
                "genre_ids": [1, 2, 3],
                "title": "Title",
                "vote_average": 8.5,
                "overview": "Example overview",
                "release_date": "2023-01-01"
            }
        ]
    }
    """.data(using: .utf8)!
        
        // When
        do {
            let movies = try Utils.jsonDecoder.decode(MovieResponse.self, from: json)
            
            // Then
            XCTAssertNotNil(movies)
            XCTAssertEqual(movies.totalResults, nil)
            
            let movieResult = movies.results[0]
            XCTAssertNotNil(movieResult)
            XCTAssertEqual(movieResult.backdropPath, nil)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
