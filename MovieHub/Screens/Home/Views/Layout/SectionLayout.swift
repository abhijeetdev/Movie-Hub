//
//  SectionLayout.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//
import UIKit

enum SectionLayout: Int, Hashable {
    case popularPeople = 0
    case trending = 1
    case nowPlaying = 2
    case upcoming = 3
    
    var title: String {
        switch self {
       
        case .popularPeople:
            return "Popular People"
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        }
    }
}
extension SectionLayout {
    func layoutSection(with layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {
        case .popularPeople:
            return popularPeopleSection()
            
        default:
            return trendingSection()
        }
    }
    
    fileprivate func popularPeopleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .estimated(1)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(16)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        section.supplementariesFollowContentInsets = false
        section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
        return section
    }
    
    fileprivate func trendingSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .fractionalWidth(0.7)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.supplementariesFollowContentInsets = false
        section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
        return section
    }
    
    fileprivate func nowPlayingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),heightDimension: .estimated(1)), subitems: Array(repeating: group, count: 3))
        containerGroup.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.supplementariesFollowContentInsets = false
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
        return section
    }
    
    fileprivate func upcomingSection(_ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.headerMode = .supplementary
        let list = NSCollectionLayoutSection.list(using: listConfiguration, layoutEnvironment: layoutEnvironment)
        return list
    }
    
    fileprivate func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
    NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    
    }
    
    fileprivate func supplementaryFooterSeparatorItem() -> NSCollectionLayoutBoundarySupplementaryItem {
    NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
    
    }
}
 

