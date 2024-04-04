//
//  Extension UIImage.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 3.04.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImageKingFisher(urlString: String) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}
