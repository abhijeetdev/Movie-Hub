//
//  AvatarCell.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import UIKit

final class PeopleCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: Key.NibNames.peopleCell, bundle: nil)
    }
    
    @IBOutlet weak var imageView: RoundedImageView!
    
    var viewModel: PeopleCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
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
}

final class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
}
