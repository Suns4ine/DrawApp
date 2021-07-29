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
    
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .init(), collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let buttonPresentPaintVC: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        button.setTitle("Paint", for: .reserved)
        button.addTarget(self, action: #selector(tappedPaintButton(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        [collectionView].forEach{ view.addSubview($0)}
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StartCollectionViewCell.self, forCellWithReuseIdentifier: "StartCollectionViewCell")
        buttonPresentPaintVC.backgroundColor = .red
        //view.addSubview(buttonPresentPaintVC)
    }
    
    @objc private func tappedPaintButton(_ sender: UIButton) {
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
        
        cell.backgroundColor = .systemRed
        cell.configure(with: .init(name: String(arrDrawings[indexPath.row])))
        return cell
    }
    
    //Размеры ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width * 0.3155, height: screenSize.width * 0.3155)
    }
    
    //Расстояние между ячейками
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return CGFloat(1)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PaintViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
