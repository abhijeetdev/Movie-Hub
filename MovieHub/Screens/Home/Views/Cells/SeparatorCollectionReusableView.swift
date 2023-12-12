//
//  SeparatorCollectionReusableView.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import UIKit

final class SeparatorCollectionReusableView: UICollectionReusableView {
    
    let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        let inset = CGFloat(16)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            separatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        separatorView.backgroundColor = Colors.appGray
    }
    
    
}
