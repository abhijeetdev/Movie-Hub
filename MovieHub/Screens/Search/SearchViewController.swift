//
//  MDSearchViewController.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 08/12/2023.
//

import UIKit

final class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        title = Strings.TAB_TWO_TITLE
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
