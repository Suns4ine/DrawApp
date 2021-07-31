//
//  ViewController.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 27.07.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    private let screenSize = UIScreen.main.bounds
    static var arrDrawings: DrawsModel = .init()
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = createCustomLayout()
        
        let collectionView = UICollectionView(frame: .init(), collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private func editTitle() {
        switch StartViewController.arrDrawings.arrary.count - 1 {
        case 0: self.title = "You don't have a draw"
        case 1: self.title = "You have \(StartViewController.arrDrawings.arrary.count - 1) draw"
        default: self.title = "You have \(StartViewController.arrDrawings.arrary.count - 1) drawnings"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.editTitle()
            }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitle()
        view.backgroundColor = .white
        [collectionView].forEach{ view.addSubview($0)}
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(newDraw))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StartCollectionViewCell.self, forCellWithReuseIdentifier: "StartCollectionViewCell")
    }
    
    @objc private func newDraw(with index: Int) {
        let vc = PaintViewController()
        debugPrint(StartViewController.arrDrawings.arrary[index].identifier)
        vc.configure(with: StartViewController.arrDrawings.arrary[index])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StartViewController.arrDrawings.arrary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StartCollectionViewCell",
                                                            for: indexPath) as? StartCollectionViewCell else { return .init() }
        
        //cell.backgroundColor = UIColor.init(cgColor: CGColor(red: .random(), green: .random(), blue: .random(), alpha: 1))
        cell.configure(with: StartViewController.arrDrawings.arrary[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            self.navigationItem.rightBarButtonItem?.isEnabled = false
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        newDraw(with: indexPath.row)
    }
    
    func createCustomLayout() -> UICollectionViewLayout {
       let layout = UICollectionViewCompositionalLayout {
           (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

           let spacing: CGFloat = 1
           let height = UIScreen.main.bounds.width

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
                                                         leading: spacing/2,
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

           let secondBottomNestedGroup = NSCollectionLayoutGroup.horizontal(
               layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(height * 2/3)),
               subitems: [trailingGroup, leadingItem])

           let firstNestedGroup = NSCollectionLayoutGroup.vertical(
               layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(height)),
               subitems: [group, firstBottomNestedGroup])
           
           let secondNestedGroup = NSCollectionLayoutGroup.vertical(
               layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(height)),
               subitems: [group, secondBottomNestedGroup])
           
           let arrNestedGrpup = NSCollectionLayoutGroup.vertical(
               layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(height * 2)),
               subitems: [firstNestedGroup ,secondNestedGroup])
           
           let section = NSCollectionLayoutSection(group: arrNestedGrpup)
           return section

       }
       return layout
   }

}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
