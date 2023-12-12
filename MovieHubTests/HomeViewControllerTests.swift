//
//  HomeViewControllerTests.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//

import XCTest
@testable import MovieHub

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    
    override func setUp() {
        super.setUp()
        
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // Mock ViewModel to simulate success and failure scenarios
    class MockHomeViewModelSuccess: HomeViewModelProtocol {
        func fetchData(completion: @escaping MovieHub.FetchCompletion) {
            completion(.success((popularPeople: [ItemEnum.movie(ShardedItem(shard: SectionLayout.popularPeople, item: Movie.stubbedMovie))], trendingMovies: [ItemEnum.movie(ShardedItem(shard: SectionLayout.popularPeople, item: Movie.stubbedMovie))], upcomingMovies: [ItemEnum.movie(ShardedItem(shard: SectionLayout.popularPeople, item: Movie.stubbedMovie))], nowPlayingMovies: [ItemEnum.movie(ShardedItem(shard: SectionLayout.popularPeople, item: Movie.stubbedMovie))])))
        }
    }

    // Test fetchDataAndUpdateUI() method when data is successfully fetched
    func testFetchDataAndUpdateUI_Success() {
        // Given
        sut = HomeViewController(viewModel: MockHomeViewModelSuccess())
        sut.loadViewIfNeeded()
        
        // When
        sut.fetchDataAndUpdateUI()
        
        XCTAssertEqual(sut.dataSource.numberOfSections(in: sut.collectionView), 4)
    }
}

