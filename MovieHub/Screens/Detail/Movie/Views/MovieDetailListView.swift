//
//  MovieDetailListView.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//

import SwiftUI

struct MovieDetailListView: View {
    let movie: Movie
    @State private var selectedTrailer: MovieVideo? = nil
    let imageLoader = ImageProvider()
    
    var body: some View {
        List {
            MovieImageView(loader: imageLoader, imageURL: movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            HStack {
                Text(movie.genreText)
                Text(Strings.DASH)
                Text(movie.yearText)
                Text(movie.durationText)
            }
            
            if let overview = movie.overview {
                Text(overview)
            }
            
            HStack {
                Text(movie.ratingText)
                    .foregroundColor(.yellow)
                Text(movie.scoreText)
            }
            
            Divider()
            
            HStack(alignment: .top, spacing: 4 ) {
                if let cast = movie.cast, cast.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(Strings.STARTING).font(.headline)
                        ForEach(cast.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                
                if let crew = movie.crew, crew.count > 0 {
                    VStack(alignment: .leading, spacing: 4){
                        if let directors = movie.directors, directors.count > 0 {
                            Text(Strings.DIRECTOS).font(.headline)
                            ForEach(directors.prefix(2)) { director in
                                Text(director.name)
                            }
                        }
                        
                        
                        if let producers = movie.producers, producers.count > 0 {
                            Text(Strings.PRODUCERS).font(.headline)
                            ForEach(producers.prefix(2)) { producer in
                                Text(producer.name)
                            }
                        }
                        
                        if let screenWriters = movie.screenWriters, screenWriters.count > 0 {
                            Text(Strings.SCREEN_WRITES).font(.headline)
                            ForEach(screenWriters.prefix(2)) { screenWriter in
                                Text(screenWriter.name)
                            }
                        }
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Divider()
            
            if let trailer = movie.youtubeTrailers, trailer.count > 0 {
                Text(Strings.TRAILERS).font(.headline)
                ForEach(trailer) { trailer in
                    Button(action: {
                        selectedTrailer = trailer
                    }, label: {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemRed))
                        }
                    })
                }
            }
        }
        .sheet(item: $selectedTrailer) { trailer in
            SafariView(url:trailer.youtubeURL!)
        }
    }
}
