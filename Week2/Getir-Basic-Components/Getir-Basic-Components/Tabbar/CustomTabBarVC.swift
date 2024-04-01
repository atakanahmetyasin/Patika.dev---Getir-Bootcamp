//
//  CustomTabBarVC.swift
//  Getir-Basic-Components
//
//  Created by Ahmet Yasin Atakan on 1.04.2024.
//

import UIKit

final class CustomTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 1
        setupMiddleButton() 
    }
    
    private func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 24, y: -25, width: 60, height: 60))
        middleButton.setBackgroundImage(UIImage(systemName: "house"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.7
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.tabBar.addSubview(middleButton)
        self.view.layoutIfNeeded()
    }
}
