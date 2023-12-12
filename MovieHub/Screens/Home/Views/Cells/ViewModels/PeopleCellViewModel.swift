//
//  PeopleCellViewModel.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 12/12/2023.
//

import UIKit

final class PeopleCellViewModel {
    
    private let model: People
    private let loader: ImageLoader
       
    private var imageUrl: URL? {
        return URL(string: "\(URLs.ImageRequest.w185)/\(String(describing: model.profilePath!))")
    }
    
    init(model: People, loader: ImageLoader = ImageLoader.shared) {
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
