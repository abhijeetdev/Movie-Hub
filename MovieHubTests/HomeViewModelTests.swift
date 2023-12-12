//
//  MDHomeViewModelTests.swift
//  MovieHubTests
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import XCTest
@testable import MovieHub

// Mock MDServiceProtocol
class MockService: ServiceProtocol {
    var getCalled = false
    
    func GET<T>(request: MovieHub.Request, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        getCalled = true
        var originalMovies: T
        
        if T.self is MovieResponse.Type {
            originalMovies = MovieResponse(
                page: 1,
                totalResults: 100,
                totalPages: 5,
                results: [
                    Movie(
                        id: 1234, 
                        popularity: 123.45,
                        voteCount: 500,
                        video: false,
                        posterPath: "/example_poster_path",
                        adult: false,
                        backdropPath: "/example_backdrop_path",
                        originalTitle: "Original Title",
                        genreIds: [1, 2, 3],
                        title: "Title",
                        voteAverage: 8.5,
                        overview: "Example overview",
                        releaseDate: "2023-01-01",
                        runtime: nil,
                        genres: nil,
                        credits: nil, 
                        videos: nil
                    )
                ]
            ) as! T
        } else {
            originalMovies = PopularPeopleResponse(
                results: [
                    People(
                        knownForDepartment: "Department",
                        name: "Name",
                        profilePath: "/path",
                        id: 123,
                        knownFor: [
                            KnownFor(
                                title: "Title",
                                id: 456
                            )
                        ]
                    )
                ]
            ) as! T
        }
        completion(.success(originalMovies))
    }
}

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockService: MockService!
    
    override func setUp() {
        super.setUp()
        mockService = MockService()
        viewModel = HomeViewModel(mdService: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchData() {
        let expectation = expectation(description: "Fetch data expectation")
        
        viewModel.fetchData { result in
            switch result {
            case .success(let items):
                XCTAssertFalse(items.popularPeople.isEmpty)
                XCTAssertFalse(items.trendingMovies.isEmpty)
                XCTAssertFalse(items.upcomingMovies.isEmpty)
                XCTAssertFalse(items.nowPlayingMovies.isEmpty)
            case .failure(let error):
                XCTFail("Fetching data failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(mockService.getCalled, "GET method of MDService not called")
    }
}

