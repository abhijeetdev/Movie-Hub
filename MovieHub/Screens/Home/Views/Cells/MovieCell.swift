//
//  PictureCell.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import Foundation

import UIKit

final class MovieCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    var viewModel: MovieCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            titleLabel.text = viewModel.title
            
            Task {
                do {
                    let image = try await viewModel.fetchImage()
                    imageView.image = image
                    imageView.contentMode = .scaleToFill
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        titleLabel.backgroundColor = .red
        
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
                titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor)
            ]
        )
        
    }
}
