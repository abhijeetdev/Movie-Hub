//
//  MoviesViewController+UI.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import UIKit

extension HomeViewController {
    func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            return sectionIdentifier.layoutSection(with: layoutEnvironment)
        }
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
    
    func setupCellAndSupplementaryRegistrations() {
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: Key.ReusableIdentifiers.movieCell)
    
        peopleCellRegistration = .init(cellNib: PeopleCell.nib) { (cell, indexPath, item) in
            if case .person(let person) = item {
                cell.viewModel = PeopleCellViewModel(model: person)
            }
        }
        
        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader) { (header, _, indexPath) in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            header.titleLabel.text = section.title
        }
        
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }
}
