//
//  FigureCollectionViewCell.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 31.07.2021.
//

import Foundation
import UIKit

final class FigureCollectionViewCell: UICollectionViewCell {
    
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = image.image?.tinted(with: .black)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = self.frame.height/2
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clearCell()
        setup()
    }
        
        required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    private func clearCell() {
        image.image = nil
    }
    
    func configure(with model: ShapeType) {
        clearCell()
        
        image.image = UIImage(named: model.rawValue)
    }
    
    private func setup() {
        [image, circleView].forEach{ self.addSubview($0)}
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: self.topAnchor),
            circleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            image.heightAnchor.constraint(equalToConstant: 48),
            image.widthAnchor.constraint(equalToConstant: 48),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
