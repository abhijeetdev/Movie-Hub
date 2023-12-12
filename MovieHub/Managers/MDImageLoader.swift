//
//  MDImageLoader.swift
//  MovieDB
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import UIKit

protocol MDImageLoaderProtocol {
    func makeCache() -> NSCache<NSString, UIImage>
    func makeImage(data: Data) -> UIImage?
    func makeUrlSession() -> URLSession
}

//MARK: Dependancy Injection
class MDImageLoaderHandler: MDImageLoaderProtocol {
    func makeCache() -> NSCache<NSString, UIImage> {
        return NSCache<NSString, UIImage>()
    }
    
    func makeImage(data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func makeUrlSession() -> URLSession {
        return URLSession.shared
    }
}

final class ImageLoader {
    
    public static let shared = ImageLoader()
        
    private let session: URLSession
    private var imageDataCache: NSCache<NSString, UIImage>
    private let handler: MDImageLoaderProtocol
        
    init(handler: MDImageLoaderProtocol = MDImageLoaderHandler()) {
        self.handler = handler
        
        self.session = handler.makeUrlSession()
        imageDataCache = handler.makeCache()
    }

    public func downloadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let image = imageDataCache.object(forKey: key) {
            completion(.success(image))
            return
        }

        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = self?.handler.makeImage(data: data) else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            self?.imageDataCache.setObject(image, forKey: key)
            completion(.success(image))
        }
        task.resume()
    }
}

protocol ImageProviderProtocol {
    func makeImageLoader() -> ImageLoader
}

class ImageProviderFactory: ImageProviderProtocol {
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
