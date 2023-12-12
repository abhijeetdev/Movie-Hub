//
//  MoviesViewController.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 08/12/2023.
//

import UIKit
import SwiftUI

final class HomeViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionLayout, ItemEnum>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionLayout, ItemEnum>
    
    //MARK: cells -
    var peopleCellRegistration: UICollectionView.CellRegistration<PeopleCell, ItemEnum>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!
    
    //MARK: properties -
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<SectionLayout, ItemEnum>! = nil
    var snapshot = Snapshot()
    
    var viewModel: HomeViewModelProtocol
    
    //MARK: ViewModel -
    init(viewModel: HomeViewModelProtocol = HomeViewModel(mdService: Service.shared)) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        title = Strings.APP_TITLE
        
        //setup collection view
        setupCollectionView()
        setupCellAndSupplementaryRegistrations()
        configureDataSource()
        
        //apply initial snapshot
        applyInitialSnapshot()
        
        //fetch data
        fetchDataAndUpdateUI()
    }
    
    //Mark: Methods -
    func fetchDataAndUpdateUI() {
        viewModel.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    
                    self?.snapshot.appendItems(items.popularPeople, toSection:.popularPeople)
                    self?.snapshot.appendItems(items.trendingMovies, toSection: .trending)
                    self?.snapshot.appendItems(items.upcomingMovies, toSection: .upcoming)
                    self?.snapshot.appendItems(items.nowPlayingMovies, toSection: .nowPlaying)
                    
                    self?.dataSource.apply(self!.snapshot, animatingDifferences: true)
                case .failure(let error):
                    // Handle error
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
    
    func applyInitialSnapshot() {
        snapshot.appendSections([.popularPeople])
        snapshot.appendSections([.trending])
        snapshot.appendSections([.upcoming])
        snapshot.appendSections([.nowPlaying])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func applySnapshot(_ popularPeople: [ItemEnum],
                       _ trendingMovies: [ItemEnum],
                       _ upcomingMovies: [ItemEnum],
                       _ nowPlayingMovies: [ItemEnum]) {
        
    }
}

//MARK: Preview -
struct ViewControllerRepresentable: UIViewControllerRepresentable {

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: HomeViewController())
    }
}

struct ViewController_Previews: PreviewProvider {

    static var previews: some SwiftUI.View {
        ViewControllerRepresentable()
            .edgesIgnoringSafeArea(.vertical)
//            .colorScheme(.dark)
//                   .environment(\.sizeCategory, ContentSizeCategory.accessibilityExtraExtraExtraLarge)
    }

}

