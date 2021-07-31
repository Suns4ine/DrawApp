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
        label.textAlignment = .left
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let imageAdd: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.image = image.image?.tinted(with: .black)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [imageAdd, backgroundImage, nameDraw].forEach{ addSubview($0)}
        
        self.backgroundColor = .secondarySystemFill
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with model: DrawModel) {
        nameDraw.text = model.name
        
        if let image = model.background {
            backgroundImage.image = image
        }
        
        if model.wasSaved == true {
            imageAdd.isHidden = true
        } else {
            nameDraw.textAlignment = .center
            imageAdd.isHidden = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            nameDraw.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameDraw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameDraw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameDraw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            imageAdd.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageAdd.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension UIImage {
    func tinted(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
}
