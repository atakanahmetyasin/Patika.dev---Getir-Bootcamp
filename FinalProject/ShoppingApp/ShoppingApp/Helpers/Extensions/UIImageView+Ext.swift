//
//  UIImage.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 10.04.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(urlString: String) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}
