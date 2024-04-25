//
//  UICollectionView + Extension.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 12.04.2024.
//

import UIKit

extension UICollectionView {
     func register<T: UICollectionViewCell>(_ cellType: T.Type) {
         register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        
    }
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
            guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
                fatalError("Unable to dequeue cell with identifier: \(T.reuseIdentifier)")
            }
            return cell
        }
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x,
                                             y: self.center.y,
                                             width: self.bounds.size.width,
                                             height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .secondaryLabel
        messageLabel.font = .systemFont(ofSize: 16, weight: .medium)
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20)
        ])
        
        self.backgroundView = emptyView
    
    }
}

//extension NSCollectionLayoutSize {
//    static func setDimension(withHeight height: NSCollectionLayoutDimension, withWidth width: NSCollectionLayoutDimension) -> NSCollectionLayoutItem {
//        let itemSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
//        return NSCollectionLayoutItem(layoutSize: itemSize)
//    }
//}
