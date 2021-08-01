//
//  RectView.swift
//  AutoLayout
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class RectView: UIView {
    
    var path: UIBezierPath!
    var color: UIColor = {
        return .clear
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        self.createRectangle()
        color.setFill()
        path.fill()
    }
    
    func setColor(_ color: UIColor) {
        self.color = color
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createRectangle() {
        // Initialize the path.
        path = UIBezierPath()
     
        // Specify the point that the path should start get drawn.
        //path.move(to: CGPoint(x: 200, y: 100))
        path.move(to: CGPoint(x: 0.0, y: 0.0))
     
        // Create a line between the starting point and the bottom-left side of the view.
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
     
        // Create the bottom line (bottom-left to bottom-right).
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
     
        // Create the vertical line from the bottom-right to the top-right side.
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
     
        // Close the path. This will create the last line automatically.
        path.close()
    }
        
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}
