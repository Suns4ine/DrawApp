//
//  RectangleCornersView.swift
//  Trello for SberSchool
//
//  Created by Афанасий Корякин on 30.07.2021.
//

import UIKit

class RectableCornersView: UIView {
    
    var path: UIBezierPath!
    var color: UIColor = {
        return .clear
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 15.0)
        
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
