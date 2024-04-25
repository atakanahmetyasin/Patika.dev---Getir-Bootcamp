//
//  ProductsHorizontalCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 8.04.2024.
//

import UIKit

protocol HorizontalCellProtocol: AnyObject {
    func setProductImageView(_ imageName: String)
    func setPriceLabel(_ price: String)
    func setProductNameLabel(_ productName: String)
    func setAttributeLabel(_ attribute: String)
    
    //a
    func setCount(_ count: Int)
    func setIsAddToBasketDidTap(_ isAddToBasketDidTap: Bool)
    var countLabel: UILabel { get set }
    //b
}

final class ProductsHorizontalCollectionViewCell: UICollectionViewCell {
    
    var cellPresenter: HorizontalCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    let productImageView: UIImageView = {
        UIFactory.createImage(setImage: UIImage(systemName: "globe")!)
    }()
    let priceLabel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1),
                              font: .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14,weight: .bold),
                              text: "0.00 TL", alignment: .left)
    }()
    let productNameLabel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1),
                              font: .openSansSemiBold(size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium),
                              text: "Product Name", alignment: .left)
    }()
    let attributeLAbel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 1),
                              font: .openSansSemiBold(size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium),
                              text: "attribute", alignment: .left)
    }()
    lazy var addBasketButton: UIButton = {
        let button = UIFactory.createButton(image: UIImage(systemName: "plus"),
                               backgroundColor: .white,
                               tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
        button.addTarget(self, action: #selector(addBasketDidTap), for: .touchUpInside)
        return button
    }()
    var countLabel: UILabel = {
        let label =  UIFactory.createLabel(color: .white,
                                           font: .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14,weight: .bold),
                                           text: "1",
                                           alignment: .center)
        label.isHidden = true
//        label.text = "\(CartManager.shared.totalCount)"
        label.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        return label
    }()
    lazy var removeBasketButton: UIButton = {
        let button = UIFactory.createButton(image: UIImage(systemName: "minus"),
                                            backgroundColor: .white,
                                            tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
        button.addTarget(self, action: #selector(removeBasketDidTap), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setIsAddToBasketDidTap(false)
    }
    
    @objc func addBasketDidTap(_ sender: UIButton) {
        let numericString = priceLabel.text?.replacingOccurrences(of: "₺", with: "") ?? "0"
        let productPrice = Double(numericString) ?? 0.0
        guard let image = productImageView.image else {
            print("Image does not found")
            return
        }
        cellPresenter.addBasketTapped(image: image, productPrice: productPrice, productName: productNameLabel.text ?? "", attribute: attributeLAbel.text ?? "")
    }
    
    @objc func removeBasketDidTap() {
        let numericString = priceLabel.text?.replacingOccurrences(of: "₺", with: "") ?? "0"
        let productPrice = Double(numericString) ?? 0.0
        cellPresenter.removeBasketTapped(productName: productNameLabel.text ?? "", productPrice: productPrice)
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
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 4),
            productImageView.heightAnchor.constraint(equalToConstant: 92),
            productImageView.widthAnchor.constraint(equalToConstant: 92),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            priceLabel.widthAnchor.constraint(equalToConstant: 92),
            priceLabel.heightAnchor.constraint(equalToConstant: 19),
            
            productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 4),
            productNameLabel.widthAnchor.constraint(equalToConstant: 92),
            productNameLabel.heightAnchor.constraint(equalToConstant: 33),

            attributeLAbel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            attributeLAbel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 4),
            attributeLAbel.widthAnchor.constraint(equalToConstant: 92),
            attributeLAbel.heightAnchor.constraint(equalToConstant: 16),
            
            addBasketButton.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor,constant: -45),
            addBasketButton.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor,constant: 45),
            addBasketButton.heightAnchor.constraint(equalToConstant: 32),
            addBasketButton.widthAnchor.constraint(equalToConstant: 32),
            
            countLabel.topAnchor.constraint(equalTo: addBasketButton.bottomAnchor),
            countLabel.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor,constant: 50),
            countLabel.heightAnchor.constraint(equalToConstant: 32),
            countLabel.widthAnchor.constraint(equalToConstant: 32),
            
            removeBasketButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 0),
            removeBasketButton.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor,constant: 50),
            removeBasketButton.heightAnchor.constraint(equalToConstant: 32),
            removeBasketButton.widthAnchor.constraint(equalToConstant: 32),
      
        
        ])
    }
}

extension ProductsHorizontalCollectionViewCell: HorizontalCellProtocol {
 
    
    //a
    func setIsAddToBasketDidTap(_ isAddToBasketDidTap: Bool) {
        countLabel.isHidden = !isAddToBasketDidTap
        removeBasketButton.isHidden = !isAddToBasketDidTap
    }
    
    func setCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
    //b
    
    func setProductImageView(_ imageName: String) {
        productImageView.downloadImage(urlString: imageName)
    }
    
    func setPriceLabel(_ price: String) {
        priceLabel.text = price
    }
    
    func setProductNameLabel(_ productName: String) {
        productNameLabel.text = productName
    }
    
    func setAttributeLabel(_ attribute: String) {
        attributeLAbel.text = attribute
    }
}
