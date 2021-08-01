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
    private var singeltone: PaintUI?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 150, bottom: 0, right: 150)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var rightGradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [self.superview?.backgroundColor?.cgColor ??
                            UIColor.systemBackground.cgColor,
                           self.superview?.backgroundColor?.withAlphaComponent(0).cgColor ??
                            UIColor.systemBackground.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    
    private lazy var leftGradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var leftGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [self.superview?.backgroundColor?.withAlphaComponent(0).cgColor ??
                            UIColor.systemBackground.withAlphaComponent(0).cgColor,
                           self.superview?.backgroundColor?.cgColor ??
                            UIColor.systemBackground.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func configure(with model: PaintUI) {
        singeltone = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [collectionView, rightGradientView, leftGradientView].forEach{ self.addSubview($0)}
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FigureCollectionViewCell.self, forCellWithReuseIdentifier: "FigureCollectionViewCell")
    }
    
    
    private func settingGradient() {
        
        self.rightGradient.removeFromSuperlayer()
        self.rightGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width / 8, height: self.bounds.height)
        rightGradientView.layer.addSublayer(rightGradient)
        
        self.leftGradient.removeFromSuperlayer()
        self.leftGradient.frame = CGRect(x: 0, y: 0, width: -self.bounds.width / 8, height: self.bounds.height)
        leftGradientView.layer.addSublayer(leftGradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
            rightGradientView.topAnchor.constraint(equalTo: self.topAnchor),
            rightGradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightGradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rightGradientView.widthAnchor.constraint(equalToConstant: 20),
            
            leftGradientView.topAnchor.constraint(equalTo: self.topAnchor),
            leftGradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            leftGradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            leftGradientView.widthAnchor.constraint(equalToConstant: -20),
        ])
        settingGradient()
    }
}

extension FigureView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        figures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FigureCollectionViewCell",
                                                            for: indexPath) as? FigureCollectionViewCell else { return .init() }
        
        cell.configure(with: figures[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        PaintViewController.model.setShape(shape: figures[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.height * 0.8, height: self.frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellCenter = collectionView.convert(cell.center, to: self)
        debugPrint(cellCenter, collectionView.centerXAnchor)
//        collectionView.centerdHorizontally
        //debugPrint(collectionView.center.x, cellCenter.x, "\n")
        if cellCenter.y == self.center.y {
            
        }
//        if collectionView.cellForItem(at: indexPath)?.layout == self.center {
//            collectionView.cellForItem(at: indexPath)?.isSelected = true
//            //collectionView.reloadData()
//        }
    }
}
