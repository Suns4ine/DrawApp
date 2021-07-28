//
//  PaintViewController.swift
//  AutoLayout
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class PaintViewController: UIViewController {
    
    private var array = [UIView]()
    private let model: PaintUI = Singletone.shared
    
    private let deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("DeleteLast", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteLast(_:)), for: .touchUpInside)
        deleteButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)

        let myGesturuRecognizer = UIPanGestureRecognizer(target: self, action: #selector(myPan(_:)))
        self.view.addGestureRecognizer(myGesturuRecognizer)
    }
    
    @objc private func deleteLast(_ sender: UIButton) {
        guard array.count > 0 else {
            return
        }
        array[array.count - 1].isHidden = true
        array.remove(at: array.count - 1)
    }
    
    private var initialCenter: CGPoint = .zero
    
    @objc private func myPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialCenter = sender.location(in: view)
            let shape = createShape()
            array.append(shape)
            self.view.addSubview(array[array.count - 1])
        case .changed:
            let translation = sender.translation(in: view)
            array[array.count - 1].frame = CGRect(x: initialCenter.x, y: initialCenter.y, width: translation.x, height: translation.y)
            array[array.count - 1].setNeedsDisplay()
        default:
            break
        }
    }
    
    func createShape() -> UIView {
        switch model.shape {
        case .Rectangle:
            return RectView(frame: .zero)
        case .Treangle:
            return TreangleView(frame: .zero)
        case .Circle:
            return CircleView(frame: .zero)
        case .Oval:
            return OvalView(frame: .zero)
        }
    }
}



// MARK: - move shape (оставлю на всякий)
//    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
//        switch sender.state {
//        case .began:
//            initialCenter = treangleView.center
//        case .changed:
//            let translation = sender.translation(in: view)
//
//            treangleView.center = CGPoint(x: initialCenter.x + translation.x,
//                                          y: initialCenter.y + translation.y)
//        default:
//            break
//        }
//    }
