//
//  ViewController.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 27.07.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    private let paintVC = PaintViewController()
    
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
        buttonPresentPaintVC.backgroundColor = .red
        view.addSubview(buttonPresentPaintVC)
    }
    
    @objc private func tappedPaintButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(paintVC, animated: true)
    }
}

