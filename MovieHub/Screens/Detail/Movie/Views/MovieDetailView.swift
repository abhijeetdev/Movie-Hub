//
//  MovieDetailView.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var viewModel = MovieDetailViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.movie != nil {
                MovieDetailListView(movie: viewModel.movie!)
            }
        }
        .navigationTitle(viewModel.movie?.title ?? "")
        .onAppear {
            viewModel.loadMovie(id: movieId)
        }
    }
}

#Preview {
    NavigationView {
        MovieDetailView(movieId: Movie.stubbedMovie.id)
    }
    
    //    MovieImageView(loader: ImageLoader(),
    //                   imageURL: URL(string: "https://image.tmdb.org/t/p/w154/dB6Krk806zeqd0YNp2ngQ9zXteH.jpg")!)
}
