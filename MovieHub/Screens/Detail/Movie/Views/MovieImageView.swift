//
//  MovieImageView.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 11/12/2023.
//

import SwiftUI

struct MovieImageView: View {
    @ObservedObject var loader: ImageProvider
    
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.loader.image != nil {
                Image(uiImage: self.loader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.loader.loadImage(with: self.imageURL)
        }
    }
}
