//
//  OnboardingViewController.swift
//  OnboardPage
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "collectionViewCell"
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
        
    func setup(_ page: OnboardingModel) {
            myImageView.image = page.image
            firstLabel.text = page.title
            secondLabel.text = page.description
        }

    }
