//
//  PaintViewController.swift
//  AutoLayout
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class PaintViewController: UIViewController {
    
    private let model: PaintUI = Singletone.shared
    private var touch = Set<UITouch>()
    private var array = [UIView]()
    private var initialCenter: CGPoint = .zero
    
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
    
    @objc private func myPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialCenter = sender.location(in: view)
            
            switch model.shape {
            case .Line:
                let shape = createShape()
                shape.touchesBegan(Set<UITouch>(), with: nil)
                array.append(shape)
                self.view.addSubview(array[array.count - 1])
            default:
                let shape = createShape()
                array.append(shape)
                self.view.addSubview(array[array.count - 1])
            }
        case .changed:
            switch model.shape {
            case .Line:
                array[array.count - 1].touchesMoved(self.touch, with: nil)
                array[array.count - 1].setNeedsDisplay()
            default:
                let translation = sender.translation(in: view)
                array[array.count - 1].frame = CGRect(x: initialCenter.x, y: initialCenter.y, width: translation.x, height: translation.y)
                array[array.count - 1].setNeedsDisplay()
            }
        default:
            break
        }
    }
    
    private func createShape() -> UIView {
        switch model.shape {
        case .Rectangle:
            return RectView(frame: .zero)
        case .RectangleCorners:
            return RectableCornersView(frame: .zero)
        case .Treangle:
            return TreangleView(frame: .zero)
        case .Circle:
            return CircleView(frame: .zero)
        case .Oval:
            return OvalView(frame: .zero)
        case .Line:
            return LineView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        }
    }
    
    @objc private func deleteLast(_ sender: UIButton) {
        guard array.count > 0 else {
            return
        }
        array[array.count - 1].isHidden = true
        array.remove(at: array.count - 1)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touch = touches
    }
}
