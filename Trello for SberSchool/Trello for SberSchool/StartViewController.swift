//
//  ViewController.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 27.07.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    private let screenSize = UIScreen.main.bounds
    private let arrDrawings: [Int] = Array(-100...100)
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = createLayout()
        //collectionLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .init(), collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let buttonPresentPaintVC: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        button.setTitle("Paint", for: .reserved)
        button.backgroundColor = .black
        return button
    }()

    private func editTitle() {
        switch arrDrawings.count {
        case 0: self.title = "You don't have a draw"
        case 1: self.title = "You have \(arrDrawings.count) draw"
        default: self.title = "You have \(arrDrawings.count) drawnings"
        }
    }
    

    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 1
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(screenSize.width/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3) // <---
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitle()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newDraw))
        view.backgroundColor = .systemGreen
        [collectionView].forEach{ view.addSubview($0)}
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StartCollectionViewCell.self, forCellWithReuseIdentifier: "StartCollectionViewCell")
        buttonPresentPaintVC.backgroundColor = .red
        //view.addSubview(buttonPresentPaintVC)
    }
    
//    @objc private func tappedPaintButton(_ sender: UIButton) {
//        let vc = PaintViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    @objc private func newDraw() {
        let vc = PaintViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDrawings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StartCollectionViewCell",
                                                            for: indexPath) as? StartCollectionViewCell else { return .init() }
        
        cell.backgroundColor = UIColor.init(cgColor: CGColor(red: .random(), green: .random(), blue: .random(), alpha: 1))
        cell.configure(with: .init(name: String(arrDrawings[indexPath.row])))
        
        return cell
    }
    
    //Размеры ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: screenSize.width * 0.3155, height: screenSize.width * 0.3155)
    }
    
 //   Расстояние между ячейками
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return CGFloat(1)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newDraw()
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

//
//private func createLayout() -> UICollectionViewLayout {
//    let layout = UICollectionViewCompositionalLayout {
//        (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//        let leadingItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
//                                               heightDimension: .fractionalHeight(1.0)))
//        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//        let trailingItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .fractionalHeight(0.3)))
//
//        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        let trailingGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
//                                               heightDimension: .fractionalHeight(1.0)),
//            subitem: trailingItem, count: 2)
//
//        let bottomNestedGroup = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .fractionalHeight(0.6)),
//            subitems: [leadingItem, trailingGroup])
//
//        let topItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 3.0),
//                                               heightDimension: .fractionalHeight(0.3)))
//        topItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//        let nestedGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .fractionalHeight(0.4)),
//            subitems: [topItem, bottomNestedGroup])
//        let section = NSCollectionLayoutSection(group: nestedGroup)
//        return section
//
//    }
//    return layout
//}
