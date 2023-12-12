//
//  MDHomeViewModel.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import Foundation

typealias FetchCompletion = (Result<(popularPeople: [ItemEnum], trendingMovies: [ItemEnum], upcomingMovies: [ItemEnum], nowPlayingMovies: [ItemEnum]), Error>) -> Void

protocol HomeViewModelProtocol {
    func fetchData(completion: @escaping FetchCompletion)
}

final class HomeViewModel: HomeViewModelProtocol {
    private let mdService: ServiceProtocol
    
    init(mdService: ServiceProtocol) {
        self.mdService = mdService
    }
    
    func fetchData(completion: @escaping FetchCompletion) {
        Task {
            do {
                let popularPeople = try await fetchPopularPeople()
                let trendingMovies = try await fetchMovies(for: .trending)
                let upcomingMovies = try await fetchMovies(for: .upcoming)
                let nowPlayingMovies = try await fetchMovies(for: .nowPlaying)
                
                completion(.success((popularPeople, trendingMovies, upcomingMovies, nowPlayingMovies)))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func fetchPopularPeople() async throws -> [ItemEnum] {
        return try await withCheckedThrowingContinuation { continuation in
            let request = Request(endpoint: URLs.People.popular, page: 1)
            mdService.GET(request: request) { (result: Result<PopularPeopleResponse, Error>) in
                switch result {
                case .success(let responseModel):
                    let results = responseModel.results
                    continuation.resume(returning: results.map(ItemEnum.person))
                case .failure(let error):
                    print(String(describing: error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func fetchMovies(for section: SectionLayout) async throws -> [ItemEnum] {
        return try await withCheckedThrowingContinuation { continuation in
            var request: Request
            
            switch section {
            case .trending:
                request = Request(endpoint: URLs.Movies.trending)
            case .upcoming:
                request = Request(endpoint: URLs.Movies.upcoming, page: 1)
            case .nowPlaying:
                request = Request(endpoint: URLs.Movies.nowPlaying, page: 1)
            default:
                continuation.resume(throwing: DataError.invalidSection)
                return
            }
            
            mdService.GET(request: request) { (result: Result<MovieResponse, Error>) in
                switch result {
                case .success(let responseModel):
                    let results = responseModel.results
                    //MARK: Because each movie is uniquely identified based on its id, the same movie may have received different responses.  NSDiffableDataSourceSnapshot demands that each item be distinct. To solve the problem, I converted the movie into a unique sectionwise shared item.
                    continuation.resume(returning: results.map { movie in
                        ItemEnum.movie(ShardedItem(shard: section, item: movie))
                    })
                case .failure(let error):
                    print(String(describing: error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

enum DataError: Error {
    case invalidSection
    
    var localizedDescription: String {
        switch self {
        case .invalidSection:
            return "Data requested for Invalid section"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
