//
//  MovieCellViewModel.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 12/12/2023.
//

import UIKit

final class MovieCellViewModel {
    
    private let model: Movie
    private let loader: ImageLoader
    
    var title: String {
        return model.title ?? ""
    }
   
    private var imageUrl: URL? {
        return URL(string: "\(URLs.ImageRequest.w185)/\(String(describing: model.posterPath!))")
    }
    
    init(model: Movie, loader: ImageLoader = ImageLoader.shared) {
        self.model = model
        self.loader = loader
    }
    
    public func fetchImage() async throws -> UIImage {
        guard let imageUrl = imageUrl else {
            throw URLError(.badURL)
        }

        return try await loader.loadImage(from: imageUrl)
    }
}
