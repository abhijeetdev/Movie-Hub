//
//  MovieDetailViewModel.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    
    private let movieService: ServiceProtocol
    
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: Error?
    
    init(movieService: ServiceProtocol = Service.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = true
        let request = Request(endpoint: URLs.Movies.details(id: id))
        //print("Abhi", request.url?.absoluteString)
        movieService.GET(request: request) { (result: Result<Movie, Error>) in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.movie = movie
                }
            case .failure(let error):
                print(String(describing: error))
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = error
                }
            }
        }
    }
}
