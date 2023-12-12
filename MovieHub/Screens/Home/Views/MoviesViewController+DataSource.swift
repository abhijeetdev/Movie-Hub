//
//  MoviesViewController+DataSource.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import UIKit

extension HomeViewController {
     func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionLayout, ItemEnum>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: ItemEnum) -> UICollectionViewCell? in
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            switch section {
                case .popularPeople:
                    return collectionView.dequeueConfiguredReusableCell(using: self.peopleCellRegistration, for: indexPath, item: item)
                    
                default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Key.ReusableIdentifiers.movieCell, for: indexPath) as! MovieCell
                    if case .movie(let moviesResult) = item {
                        cell.viewModel = MovieCellViewModel(model: moviesResult.item)
                    }
                    return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }
    }
    
    
}
