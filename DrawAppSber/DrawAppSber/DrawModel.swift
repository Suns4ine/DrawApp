//
//  DrawModel.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 29.07.2021.
//

import Foundation
import UIKit


struct DrawModel {
    var name: String
    var wasSaved: Bool
    var background: UIImage?
    let identifier: Int
    var arrayView: [UIView] = []
    private static var identifierFactory = 0
    
    private static func getUniqueIndex() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(name: String, wasSaved: Bool = false, background: UIImage?) {
        self.name = name
        self.wasSaved = wasSaved
        self.background = background
        self.identifier = DrawModel.getUniqueIndex()
    }
    
}

