//
//  CircleView.swift
//  Trello for SberSchool
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class CircleView: UIView {
    var path: UIBezierPath!
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        
        self.path = UIBezierPath(ovalIn: CGRect(
                                    x: self.frame.size.width/2 - self.frame.size.height/2,
                                    y: 0.0,
                                    width: self.frame.size.height,
                                    height: self.frame.size.height))
        
        UIColor.orange.setFill()
        path.fill()
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}


