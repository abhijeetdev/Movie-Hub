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
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: PeopleCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            titleLabel.text = viewModel.name
            
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
    
//    func setup(item: People) {
//        textLabel.text = item.name
//        imageUrlString = item.profilePath
//    }
//    
//    var imageUrlString: String? {
//        didSet {
//            guard let urlsString = imageUrlString else {
//                return
//            }
//            let imageUrl = URL(string: "\(URLs.ImageRequest.w185)/\(urlsString)")
//            fetchImage(imageUrl: imageUrl) { [weak self] result in
//                switch result {
//                case .success(let image):
//                    DispatchQueue.main.async {
//                        self?.imageView.image = image
//                        self?.imageView.contentMode = .scaleToFill
//                    }
//                case .failure:
//                    break
//                }
//            }
//        }
//    }
//    
//    public func fetchImage(imageUrl: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
//        guard let imageUrl = imageUrl else {
//            completion(.failure(URLError(.badURL)))
//            return
//        }
//        
//        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
//    }
}

final class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
}
