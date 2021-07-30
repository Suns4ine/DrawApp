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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitle()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newDraw))
        view.backgroundColor = .white
        [collectionView].forEach{ view.addSubview($0)}
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StartCollectionViewCell.self, forCellWithReuseIdentifier: "StartCollectionViewCell")
        buttonPresentPaintVC.backgroundColor = .red
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let spacing: CGFloat = 1
            let height = self.screenSize.width

            let topItem = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: topItem)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: spacing/2,
                                                              leading: spacing/2,
                                                              bottom: spacing/2,
                                                              trailing: spacing/2)
        
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(height/3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem:
                                                            item, count: 3)
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                          leading:
                                                            spacing/2,
                                                          bottom: 0,
                                                          trailing: spacing/2)
            
            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6669),
                                                   heightDimension: .absolute(height * 2/3)))
            
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: spacing/2,
                                                                leading: spacing/2,
                                                                bottom: spacing/2,
                                                                trailing: spacing/2)

            let trailingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(height/3)))
            
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: spacing/2,
                                                                 leading: spacing/2,
                                                                 bottom: spacing/2,
                                                                 trailing: spacing/2)

            var trailingGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                                   heightDimension: .absolute(height * 2/3)),
                subitem: trailingItem, count: 2)

            let firstBottomNestedGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(height * 2/3)),
                subitems: [leadingItem, trailingGroup])

            trailingGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333),
                                                   heightDimension: .absolute(height * 2/3)),
                subitem: trailingItem, count: 2)
//
//            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: spacing/2,
//                                                                leading: spacing,
//                                                                bottom: spacing/2,
//                                                                trailing: spacing/2)
//            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: spacing/2,
//                                                                 leading: spacing/2,
//                                                                 bottom: spacing/2,
//                                                                 trailing: 0)
//            trailingGroup.contentInsets = NSDirectionalEdgeInsets(top: 0,
//                                                                 leading: 0,
//                                                                 bottom: 0,
//                                                                 trailing: 0)
//
            let secondBottomNestedGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(height * 2/3)),
                subitems: [trailingGroup, leadingItem])
//            secondBottomNestedGroup.contentInsets = NSDirectionalEdgeInsets(top: 0,
//                                                                 leading: spacing/2,
//                                                                 bottom: 0,
//                                                                 trailing: spacing/2)
            //secondBottomNestedGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            //group.interItemSpacing = .fixed(spacing)
            //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

            let firstNestedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(height)),
                subitems: [group, firstBottomNestedGroup])
            
            let secondNestedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(height)),
                subitems: [group, secondBottomNestedGroup])
            
            let arrNestedGrpup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height * 2)), subitems: [firstNestedGroup ,secondNestedGroup])
            
            let section = NSCollectionLayoutSection(group: arrNestedGrpup)
            return section

        }
        return layout
    }
    
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

//private func createLayout() -> UICollectionViewLayout {
//    let spacing: CGFloat = 1
//    let itemSize = NSCollectionLayoutSize(
//        widthDimension: .fractionalWidth(1.0),
//        heightDimension: .fractionalHeight(1.0))
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//    let groupSize = NSCollectionLayoutSize(
//        widthDimension: .fractionalWidth(1.0),
//        heightDimension: .absolute(screenSize.width/3))
//    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3) // <---
//    group.interItemSpacing = .fixed(spacing)
//
//    let section = NSCollectionLayoutSection(group: group)
//    section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
//    section.interGroupSpacing = spacing
//
//    let layout = UICollectionViewCompositionalLayout(section: section)
//    return layout
//}
