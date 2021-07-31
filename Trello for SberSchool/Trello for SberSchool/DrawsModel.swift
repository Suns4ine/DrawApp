//
//  DrawsModel.swift
//  Trello for SberSchool
//
//  Created by Vyacheslav Pronin on 30.07.2021.
//

import Foundation

struct DrawsModel {
    private (set) var arrary: [DrawModel] = [.init(name: "Новый Рисунок", background: nil)]
    
    mutating func addDrawing(with model: DrawModel) {
        arrary.insert(model, at: 1)
    }
    
    mutating func editDrawing(with model: DrawModel, index: Int) {
        guard index != 0 && index >= 1 && index <= arrary.count - 1 else { return }
        arrary[index] = model
    }
    
    mutating func deleteDrawModel(with numb: Int) {
        guard numb != 0 && numb >= 1 && numb <= arrary.count - 1 else { return }
        
        arrary.remove(at: numb)
    }
}
