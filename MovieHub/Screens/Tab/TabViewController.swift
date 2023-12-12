//
//  MDTabViewController.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 08/12/2023.
//

import UIKit

final class TabViewController: UITabBarController {
    
    // MARK:  Properties -
    private var movieViewController: UIViewController!
    private var searchViewController: UIViewController!
    
    private let moviesController: MoviesViewControllable
    private let searchController: SearchViewControllable
    
    // MARK: MAIN -
    init(moviesController: MoviesViewControllable = MDMoviesViewControllable(),
         searchController: SearchViewControllable = MDSearchViewControllable()) {
        self.moviesController = moviesController
        self.searchController = searchController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: FUNCTIONS -
    private func setUpViews() {
        self.movieViewController = self.moviesController.makeMoviesViewController()
        self.searchViewController = self.searchController.makeSearchViewController()
        
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .lightGray
        
        setViewControllers([movieViewController, searchViewController], animated: false)
        
    }
}

protocol MoviesViewControllable {
    func makeMoviesViewController() -> UIViewController
}

protocol SearchViewControllable {
    func makeSearchViewController() -> UIViewController
}

final class MDMoviesViewControllable: MoviesViewControllable {
    func makeMoviesViewController() -> UIViewController {
        let movieVC = HomeViewController()
        let movieViewController = UINavigationController(rootViewController: movieVC)
        movieViewController.tabBarItem = UITabBarItem(title: Strings.TAB_ONE_TITLE, image: UIImage(systemName: "tv"), tag: 1)
        return movieViewController
    }
}

final class MDSearchViewControllable: SearchViewControllable {
    func makeSearchViewController() -> UIViewController {
        let searchVC = SearchViewController()
        let searchViewController = UINavigationController(rootViewController: searchVC)
        searchViewController.tabBarItem = UITabBarItem(title: Strings.TAB_TWO_TITLE, image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return searchViewController
    }
}
