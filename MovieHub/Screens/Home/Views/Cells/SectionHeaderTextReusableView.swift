//
//  SectionHeaderTextReusableView.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import UIKit

final class SectionHeaderTextReusableView: UICollectionReusableView {
    
    static var nib: UINib {
        UINib(nibName: Key.NibNames.SectionHeaderTextReusableView, bundle: nil)
    }
        
    @IBOutlet weak var titleLabel: UILabel!
}
