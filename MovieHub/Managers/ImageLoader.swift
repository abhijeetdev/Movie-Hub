//
//  MDImageLoader.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import UIKit

protocol ImageLoaderProtocol {
    func makeCache() -> NSCache<NSString, UIImage>
    func makeImage(data: Data) -> UIImage?
    func makeUrlSession() -> URLSession
}

//MARK: Dependancy Injection
final class ImageLoaderFactory: ImageLoaderProtocol {
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
    private let handler: ImageLoaderProtocol
        
    init(handler: ImageLoaderProtocol = ImageLoaderFactory()) {
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
    
    func loadImage(from imageUrl: URL) async throws -> UIImage {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<UIImage, Error>) in
            downloadImage(imageUrl) { result in
                switch result {
                    case .success(let image):
                        continuation.resume(returning: image)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }
}
