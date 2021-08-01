//
//  CellColor.swift
//  Trello for SberSchool
//
//  Created by Афанасий Корякин on 31.07.2021.
//

import UIKit

class CellColor: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func setColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
}

