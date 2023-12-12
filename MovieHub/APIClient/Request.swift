//
//  MDRequest.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import Foundation

final class Request {
    private var endpoint: String
    
    public var url: URL? {
        return URL(string: endpoint)
    }
        
    init(endpoint: String, page: Int? = nil) {
        var urlString = endpoint
        
        if let page = page {
            urlString += String(page)
        }
        
        self.endpoint = urlString
    }
}

