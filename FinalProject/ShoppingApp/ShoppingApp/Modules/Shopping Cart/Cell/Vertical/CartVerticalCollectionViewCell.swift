//
//  CartVerticalCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 20.04.2024.
//

import UIKit

protocol CartVerticalCellProtocol: AnyObject {
    //a
    func setCount(_ count: Int)
    func setIsAddToBasketDidTap(_ isAddToBasketDidTap: Bool)
    
    //b
}

class CartVerticalCollectionViewCell: UICollectionViewCell {
    
    var cellPresenter: CartVerticalCellPresenterProtocol!
    
    let productImageView: UIImageView = {
        UIFactory.createImage(setImage: UIImage(systemName: "globe")!)
    }()
    let priceLabel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1),
                              font: .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14,weight: .bold),
                              text: "0.00 TL",
                              alignment: .left)
    }()
    let productNameLabel: UILabel = {
       let label = UIFactory.createLabel(color: UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1),
                              font: .openSansSemiBold(size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium),
                              text: "Product Name",
                              alignment: .left)
        return label
    }()
    let attributeLAbel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 1),
                              font: .openSansSemiBold(size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium),
                              text: "attribute",
                              alignment: .left)
    }()
    lazy var addBasketButton: UIButton = {
        let button = UIFactory.createButton(image: UIImage(systemName: "plus"),
                                            backgroundColor: .white,
                                            tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
        button.addTarget(self, action: #selector(addBasketDidTap), for: .touchUpInside)
        return button
    }()
    let countLabel: UILabel = {
        let label =  UIFactory.createLabel(color: .white,
                                           font: .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14,weight: .bold),
                                           text: "1",
                                           alignment: .center)
        label.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        return label
    }()
    lazy var removeBasketButton: UIButton = {
        let button = UIFactory.createButton(image: UIImage(systemName: "minus"),
                                            backgroundColor: .white,
                                            tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
        button.addTarget(self, action: #selector(removeBasketDidTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // a
    func setProduct(from cart: CartStruct ) {
        productImageView.image = cart.imageURL
        priceLabel.text =   String(format: "₺%.2f", cart.price)
        productNameLabel.text = cart.name
        attributeLAbel.text = cart.attribute
        countLabel.text = String(cart.count)
       }
    //b
    
    @objc func addBasketDidTap(_ sender: UIButton) {
        let numericString = priceLabel.text?.replacingOccurrences(of: "₺", with: "") ?? "0"
        let productPrice = Double(numericString) ?? 0.0
        guard let image = productImageView.image else {
            print("Image does not found")
            return
        }
        cellPresenter?.addBasketTapped(image: image, productPrice: productPrice, productName: productNameLabel.text ?? "", attribute: attributeLAbel.text ?? "")
    }
    
    @objc func removeBasketDidTap() {
        let numericString = priceLabel.text?.replacingOccurrences(of: "₺", with: "") ?? "0"
        let productPrice = Double(numericString) ?? 0.0
        cellPresenter?.removeBasketTapped(productName: productNameLabel.text ?? "", productPrice: productPrice)
    }

    private func addViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(attributeLAbel)
        contentView.addSubview(addBasketButton)
        contentView.addSubview(countLabel)
        contentView.addSubview(removeBasketButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productImageView.heightAnchor.constraint(equalToConstant: 74),
            productImageView.widthAnchor.constraint(equalToConstant: 74),
            
            productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productNameLabel.widthAnchor.constraint(equalToConstant: 143),
            productNameLabel.heightAnchor.constraint(equalToConstant: 34),
            
            attributeLAbel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            attributeLAbel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: attributeLAbel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,constant: 8),
            
            addBasketButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            addBasketButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            addBasketButton.widthAnchor.constraint(equalToConstant: 32),
            addBasketButton.heightAnchor.constraint(equalToConstant: 32),
            
            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            countLabel.trailingAnchor.constraint(equalTo: addBasketButton.leadingAnchor, constant: 0),
            countLabel.widthAnchor.constraint(equalToConstant: 38),
            countLabel.heightAnchor.constraint(equalToConstant: 32),
            
            removeBasketButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            removeBasketButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor),
            removeBasketButton.widthAnchor.constraint(equalToConstant: 32),
            removeBasketButton.heightAnchor.constraint(equalToConstant: 32),
        
        ])
    }

}

extension CartVerticalCollectionViewCell: CartVerticalCellProtocol {
    //a
    func setIsAddToBasketDidTap(_ isAddToBasketDidTap: Bool) {
        countLabel.isHidden = !isAddToBasketDidTap
        removeBasketButton.isHidden = !isAddToBasketDidTap
    }
    
    func setCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
    //b
}
