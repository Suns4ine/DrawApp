//
//  FigureView.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 31.07.2021.
//

import Foundation
import UIKit

final class FigureView: UIView {
    
    private let figures: [ShapeType] = [.Circle, .Line, .Oval, .Rectangle, .RectangleCorners, .Treangle]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = UICollectionView(frame: .init(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [collectionView].forEach{ self.addSubview($0)}
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FigureCollectionViewCell.self, forCellWithReuseIdentifier: "FigureCollectionViewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension FigureView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        figures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FigureCollectionViewCell",
                                                            for: indexPath) as? FigureCollectionViewCell else { return .init() }
        
        //cell.backgroundColor = UIColor.init(cgColor: CGColor(red: .random(), green: .random(), blue: .random(), alpha: 1))
        cell.configure(with: figures[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.frame.height, height: self.frame.height)
    }
}
