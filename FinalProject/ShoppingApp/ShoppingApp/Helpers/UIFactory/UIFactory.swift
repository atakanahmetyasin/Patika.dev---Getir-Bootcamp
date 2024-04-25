//
//  UIFactory.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 8.04.2024.
//

import UIKit

struct UIFactory {
    static func createLabel(color: UIColor, font: UIFont, text: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createImage(setImage: UIImage) -> UIImageView {
        let image = UIImageView()
        image.image = setImage
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.layer.borderWidth = 1
        image.layer.borderColor = CGColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    static func createButton(image: UIImage?, backgroundColor: UIColor?, tintColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.backgroundColor = backgroundColor
        button.tintColor = tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = CGColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
