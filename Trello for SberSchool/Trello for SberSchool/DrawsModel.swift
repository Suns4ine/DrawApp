//
//  DrawsModel.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 30.07.2021.
//

import Foundation

struct DrawsModel {
    private (set) var arrary: [DrawModel] = [.init(name: "Новый Рисунок")]
    
    mutating func addDrawing(with model: DrawModel) {
        arrary.insert(model, at: 1)
    }
    
    mutating func deleteDrawModel(with numb: Int) {
        guard numb != 0 else { return }
        
        arrary.remove(at: numb)
    }
}
