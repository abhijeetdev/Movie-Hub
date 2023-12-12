//
//  MoviesViewController+Delegate.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import UIKit
import SwiftUI

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .movie(let movie):
            let albumDetailVC = UIHostingController(rootView: MovieDetailView(movieId: movie.item.id))
            navigationController?.pushViewController(albumDetailVC, animated: true)
        case .person(_):
            break
        }
    }
}
