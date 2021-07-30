//
//  CircleView.swift
//  Trello for SberSchool
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class CircleView: UIView {
    
    var path: UIBezierPath!
    var color: UIColor = {
        return .clear
    }()
     
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
        
        color.setFill()
        path.fill()
    }
    
    func setColor(_ color: UIColor) {
        self.color = color
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}


