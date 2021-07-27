//
//  OvalView.swift
//  Trello for SberSchool
//
//  Created by Афанасий Корякин on 27.07.2021.
//

import UIKit

class OvalView: UIView {
    var path: UIBezierPath!
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        self.path = UIBezierPath(ovalIn: self.bounds)
        UIColor.orange.setFill()
        path.fill()
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}


