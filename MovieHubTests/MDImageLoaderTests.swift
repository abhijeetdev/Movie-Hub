//
//  MDImageLoaderTests.swift
//  MovieDBTests
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import XCTest
@testable import MovieDB

final class MockImageLoaderHandler: ImageLoaderProtocol {
    var image: UIImage?
    
    func makeImage(data: Data) -> UIImage? {
        return image
    }
    
    func makeUrlSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: sessionConfiguration)
    }
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func makeCache() -> NSCache<NSString, UIImage> {
        return imageCache
    }
}

final class ImageLoaderTests: XCTestCase {
    
    var imageLoader: ImageLoader!
    var handler: MockImageLoaderHandler!
    
    override func setUp() {
        super.setUp()
        handler = MockImageLoaderHandler()
        imageLoader = ImageLoader(handler: handler)
    }
    
    override func tearDown() {
        handler = nil
        imageLoader = nil
        
        URLProtocolMock.mockURLs.removeAll()
        super.tearDown()
    }
    
    func testDownloadImageWithDataInCache() {
        let url = URL(string: "https://example.com/image.png")!
        let expectedData = UIImage()
        handler.imageCache.setObject(expectedData, forKey: url.absoluteString as NSString)
        
        let expectation = XCTestExpectation(description: "Download image with data in cache")
        
        imageLoader.downloadImage(url) { result in
            switch result {
            case .success(let image):
                XCTAssertEqual(image, expectedData, "Downloaded data should match the data in cache")
            case .failure:
                XCTFail("Download should succeed when data is in cache")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDownloadImageWithoutDataInCache() {
        
        // Given:
        let urlMock = URL(string: "https://example.com/image.png")!
        let response = HTTPURLResponse(url: urlMock, statusCode: 200, httpVersion: nil, headerFields: nil)
        let error: Error? = nil
        let mockImage = UIImage()
        let mockData = mockImage.pngData()

        URLProtocolMock.mockURLs = [
            urlMock: (error, mockData, response),
        ]
        
        handler.image = mockImage
        
        let expectation = XCTestExpectation(description: "Download image without data in cache")
        
        //When:
        imageLoader.downloadImage(urlMock) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image, "Downloaded data should not be nil")
                XCTAssertEqual(image, mockImage, "Downloaded data should match the mockData")
            case .failure(let error):
                XCTFail("Download should succeed when data is not in cache. Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDownloadImageWithNetworkFailure() {
        // Given:
        let urlMock = URL(string: "https://invalidurl")! // Invalid URL
        let response: HTTPURLResponse? = nil
        let error = URLError(URLError.badURL)
        let mockData: Data? = nil

        URLProtocolMock.mockURLs = [
            urlMock: (error, mockData, response),
        ]
        
        let expectation = XCTestExpectation(description: "Download image with network failure")
        
        //When
        imageLoader.downloadImage(urlMock) { result in
            switch result {
            case .success:
                XCTFail("Download should fail with a network error for an invalid URL")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, URLError.badURL.rawValue, "Expected URLError.badURL for an invalid URL")
            }
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 5.0)
    }
}
