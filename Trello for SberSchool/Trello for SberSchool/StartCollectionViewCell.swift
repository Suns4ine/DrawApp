//
//  StartCollectionViewCell.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 29.07.2021.
//

import Foundation
import UIKit

final class StartCollectionViewCell: UICollectionViewCell {
    
    private let nameDraw: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [nameDraw].forEach{ addSubview($0)}
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with model: DrawModel) {
        nameDraw.text = model.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            nameDraw.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameDraw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameDraw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nameDraw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
