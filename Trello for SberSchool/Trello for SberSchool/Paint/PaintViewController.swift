//
//  PaintViewController.swift
//  AutoLayout
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class PaintViewController: UIViewController {
    
    private var drawModel: DrawModel = DrawModel(name: "", wasSaved: false)
    private var index: Int = 2
    
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
        
       // self.view.addSubview(deleteButton)
        //deleteButton.addTarget(self, action: #selector(deleteLast(_:)), for: .touchUpInside)
       // deleteButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)

        self.navigationItem.rightBarButtonItems =
            [UIBarButtonItem(image: UIImage(named: "check-mark-black-outline"),
                             style: .done,
                             target: self,
                             action: #selector(saveDrawing)),
             UIBarButtonItem(image: UIImage(named: "undo"),
                             style: .done,
                             target: self,
                             action: #selector(deleteLast(_:)))]
        
        self.navigationController?.navigationBar.tintColor = .black
        
        let myGesturuRecognizer = UIPanGestureRecognizer(target: self, action: #selector(myPan(_:)))
        self.view.addGestureRecognizer(myGesturuRecognizer)
    }
    
    @objc
    private func saveDrawing() {
        
        let alertController = UIAlertController(title: "First Name",
                                                message: "Give a name to your drawing",
                                                preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let nameDrawningTextField = alertController.textFields?[0] {
                if let text = nameDrawningTextField.text {
                    if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        self.drawModel.name = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.finish(drawing: self.drawModel)
                    }
                }
            }
        }
        
        alertController.addTextField { (textField) in textField.placeholder = "Name" }

        alertController.addAction(confirmAction)
        alertController.addAction(.init(title: "Canel", style: .cancel, handler: nil))
        
        if drawModel.wasSaved == false {
            present(alertController, animated: true, completion: nil)
        } else {
            finish(drawing: drawModel)
        }
    }
    
    private func finish(drawing: DrawModel) {
        var drawing = drawing
        let vc = StartViewController()
        
        if drawing.wasSaved == false {
            drawing.wasSaved = true
            StartViewController.arrDrawings.addDrawing(with: drawing)
        } else {
            StartViewController.arrDrawings.editDrawing(with: drawing, index: index)
        }
        
        vc.viewWillAppear(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func configure(with model: DrawModel, index: Int) {
        drawModel = model
        self.index = index
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
