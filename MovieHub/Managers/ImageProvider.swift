//
//  ImageProvider.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//
import UIKit

protocol ImageProviderProtocol {
    func makeImageLoader() -> ImageLoader
}

final class ImageProviderFactory: ImageProviderProtocol {
    func makeImageLoader() -> ImageLoader {
        return ImageLoader.shared
    }
}

class ImageProvider: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let loader: ImageLoader
    
    init(loader: ImageProviderProtocol = ImageProviderFactory()) {
        self.loader = loader.makeImageLoader()
    }
    
    func loadImage(with url: URL) {
        isLoading = true
        loader.downloadImage(url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.image = image
                }
            case .failure(let error):
                self?.error = error
                self?.isLoading = false
                print(error.localizedDescription)
            }
        }
    }
}
