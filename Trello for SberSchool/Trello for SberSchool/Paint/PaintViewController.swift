//
//  PaintViewController.swift
//  AutoLayout
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class PaintViewController: UIViewController {
    
    private lazy var blankButton: UIBarButtonItem = {
        let button = UIBarButtonItem.menuButton(self, action: #selector(deleteLast(_:)), imageName: "")
        button.isEnabled = false
        return button
    }()
    
    private let model: PaintUI = Singletone.shared
    private let colorReuseId = "colorReuseId"
    
    private var colors = [UIColor.blue , .blue, .red, .brown, .cyan, .darkGray, .darkText, .gray, .green, .orange, .purple, .magenta, .systemIndigo, .yellow, .white]
    private var touch = Set<UITouch>()
    private var array = [UIView]()
    private var initialCenter: CGPoint = .zero
    private var drawModel: DrawModel?
    private var selectColorPicker = false
    
    private lazy var colorPickerView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.dataSource = self
        tv.register(CellColor.self, forCellReuseIdentifier: colorReuseId)
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 30
        return tv
    }()
    
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

        self.navigationItem.rightBarButtonItems =
            [UIBarButtonItem.menuButton(self,
                                        action: #selector(saveDrawing),
                                        imageName: "tick"),
             blankButton,
             UIBarButtonItem.menuButton(self,
                                        action: #selector(deleteLast(_:)),
                                        imageName: "undo (1)")]
        self.navigationController?.navigationBar.tintColor = .black
        
        let myGesturuRecognizer = UIPanGestureRecognizer(target: self, action: #selector(myPan(_:)))
        self.view.addGestureRecognizer(myGesturuRecognizer)
        self.view.addSubview(colorPickerView)
        colorPickerView.frame = CGRect(x: 20, y: 100, width: 30, height: 30)
        model.setColor(color: colors[0])
    }
    
    private func finish(drawing: DrawModel) {
        var drawing = drawing
        let vc = StartViewController()
        
        drawing.background = getImageRender()
        drawing.arrayView = array
        
        if drawing.wasSaved == false {
            drawing.wasSaved = true
            StartViewController.arrDrawings.addDrawing(with: drawing)
        } else {
            StartViewController.arrDrawings.editDrawing(with: drawing)
        }
        
        vc.viewWillAppear(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func configure(with model: DrawModel) {
        drawModel = model
    }
    
    private func updatePickers() {
        self.view.bringSubviewToFront(colorPickerView)
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

extension PaintViewController : UITableViewDelegate, UITableViewDataSource {
    
    func getImageRender() -> UIImage {
        self.colorPickerView.isHidden = true
       return self.view.asImage()
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
                updatePickers()
            default:
                let shape = createShape()
                array.append(shape)
                self.view.addSubview(array[array.count - 1])
                updatePickers()
            }
        case .changed:
            switch model.shape {
            case .Line:
                array[array.count - 1].touchesMoved(self.touch, with: nil)
                array[array.count - 1].setNeedsDisplay()
                updatePickers()
            default:
                let translation = sender.translation(in: view)
                array[array.count - 1].frame = CGRect(x: initialCenter.x, y: initialCenter.y, width: translation.x, height: translation.y)
                array[array.count - 1].setNeedsDisplay()
                updatePickers()
            }
        default:
            break
        }
    }
    
    private func createShape() -> UIView {
        switch model.shape {
        case .Rectangle:
            let rectangle = RectView(frame: .zero)
            rectangle.setColor(model.color)
            return rectangle
        case .RectangleCorners:
            let rectangleCorners = RectableCornersView(frame: .zero)
            rectangleCorners.setColor(model.color)
            return rectangleCorners
        case .Treangle:
            let treangle = TreangleView(frame: .zero)
            treangle.setColor(model.color)
            return treangle
        case .Circle:
            let circle = CircleView(frame: .zero)
            circle.setColor(model.color)
            return circle
        case .Oval:
            let oval = OvalView(frame: .zero)
            oval.setColor(model.color)
            return oval
        case .Line:
            let line = LineView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            line.setColor(model.color)
            return line
        }
    }
    
    @objc
    private func saveDrawing() {
        guard var drawing = drawModel else { return }
        let alertController = UIAlertController(title: "First Name",
                                                message: "Give a name to your drawing",
                                                preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let nameDrawningTextField = alertController.textFields?[0] {
                if let text = nameDrawningTextField.text {
                    if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        drawing.name = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.finish(drawing: drawing)
                    }
                }
            }
        }
        
        alertController.addTextField { (textField) in textField.placeholder = "Name" }

        alertController.addAction(confirmAction)
        alertController.addAction(.init(title: "Canel", style: .cancel, handler: nil))
        
        if drawModel?.wasSaved == false {
            present(alertController, animated: true, completion: nil)
        } else {
            finish(drawing: drawing)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: colorReuseId, for: indexPath) as! CellColor
        let color = colors[indexPath.row]
        cell.setColor(color)
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let color = colors[indexPath.row]
        switch selectColorPicker {
        case true:
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
              options: .curveEaseIn,
              animations: {
                self.colorPickerView.frame = CGRect(x: 20, y: 100, width: 30, height: 30 * 7)
              },
              completion: nil)
            self.selectColorPicker.toggle()
        case false:
            self.colorPickerView.frame = CGRect(x: 20, y: 100, width: 30, height: 30)
            self.colors[0] = color
            self.colorPickerView.reloadData()
            self.selectColorPicker.toggle()
        }
        
        model.setColor(color: color)
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return menuBarItem
    }
}
