//
//  SingletoneUI.swift
//  AutoLayout
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

//MARK: --Может будет выступать единым источником правды
enum ShapeType: String {
    case Treangle = "triangle"
    case Rectangle = "rectangle" 
    case RectangleCorners = "rounded-rectangle"
    case Circle = "circle"
    case Oval = "ellipse"
    case Line = "diagonal-line"
}

protocol PaintUI {
    var color: UIColor { get }
    var shape: ShapeType { get }
    
    func setColor(color: UIColor)
    func setShape(shape: ShapeType)
}

class Singletone: PaintUI {
    
    static var shared: Singletone = {
        let instance = Singletone()
        return instance
    }()
    
    var color: UIColor = .clear
    var shape: ShapeType = .Line
    
    func setColor(color: UIColor) {
        self.color = color
    }
    
    func setShape(shape: ShapeType) {
        self.shape = shape
    }
    
    private init() {}
}
