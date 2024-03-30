//
//  UIFactory.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 22.03.2024.
//

import UIKit

struct UIFactory {
    static func createLabel(font: UIFont, textColor: UIColor, text: String) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.text = text
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createButton(title: String?, setImage: UIImage?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        button.setImage(setImage, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .regular)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}
