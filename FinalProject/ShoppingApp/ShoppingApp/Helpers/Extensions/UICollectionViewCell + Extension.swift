//
//  UICollectionViewCell + Extension.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 12.04.2024.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
