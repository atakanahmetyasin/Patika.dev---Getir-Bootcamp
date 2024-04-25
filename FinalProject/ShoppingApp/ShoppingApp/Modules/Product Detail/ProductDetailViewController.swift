//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 10.04.2024.
//

import UIKit

protocol ProductDetailViewControllerProtocol: AnyObject {
    func setupViews()
    
    //a
    func setCount(_ count: Int)
    func setIsAddToBasketDidTap(_ isAddToBasketDidTap: Bool)
    //b
}

final class ProductDetailViewController: UIViewController{
    
    var presenter: ProductDetailPresenterProtocol?
    private lazy var totalPriceLabel: UILabel = {
          let label = UILabel(frame: CGRect(x: 35, y: 0, width: 56, height: 34))
          label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
          label.textAlignment = .center
          label.numberOfLines = 1
        label.text = presenter?.totalPrice
          label.font = .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
          label.backgroundColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1)
          label.adjustsFontSizeToFitWidth = true
          return label
      }()
    
  lazy var myBasketButton: UIButton = {
       let button = UIFactory.createButton(image: nil,
                                           backgroundColor: .white,
                                           tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
       button.addTarget(self, action: #selector(myBasketDidTap), for: .touchUpInside)
       button.widthAnchor.constraint(equalToConstant: 91).isActive = true
       button.heightAnchor.constraint(equalToConstant: 34).isActive = true
       
       let basketImageView = UIImageView(image: UIImage(systemName: "cart.fill"))
       basketImageView.tintColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
       basketImageView.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
       
      let totalPriceLabel = self.totalPriceLabel
     
       button.addSubview(basketImageView)
       button.addSubview(totalPriceLabel)
       return button
   }()
    
    private lazy var productImageView: UIImageView = {
        UIFactory.createImage(setImage: UIImage(systemName: "globe")!)
    }()
    private lazy var priceLabel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1),
                              font: .openSansBold(size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold),
                              text: "0.00 TL", alignment: .center)
    }()
    private lazy var productNameLabel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1),
                              font: .openSansSemiBold(size: 16) ?? UIFont.systemFont(ofSize: 20, weight: .medium),
                              text: "Product Name", alignment: .center)
    }()
    private lazy var attributeLAbel: UILabel = {
        UIFactory.createLabel(color: UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 1),
                              font: .openSansSemiBold(size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium),
                              text: "attribute", alignment: .center)
    }()
    private lazy var addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addBasketDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var countLabel: UILabel = {
        let label =  UIFactory.createLabel(color: .white,
                                           font: .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14,weight: .bold),
                                           text: "1",
                                           alignment: .center)
        label.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return label
    }()
    private lazy var removeBasketButton: UIButton = {
        let button = UIFactory.createButton(image: UIImage(systemName: "trash"),
                                            backgroundColor: .white,
                                            tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
        button.addTarget(self, action: #selector(removeBasketDidTap), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    private lazy var plusButton: UIButton = {
        let button = UIFactory.createButton(image: UIImage(systemName: "plus"),
                                            backgroundColor: .white,
                                            tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
        button.addTarget(self, action: #selector(plusDidTap), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    private lazy var basketStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(removeBasketButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(plusButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViews()
        print("DEBUG: ", priceLabel.text)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalPriceLabel), name: NSNotification.Name("updateTotalPrice"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func myBasketDidTap() {
        presenter?.showCart()
    }
    
    // Navigation item içindeki totalPriceLabel'ı güncelliyorum.
    @objc func updateTotalPriceLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [ weak self ] in
            self?.totalPriceLabel.text = String(format: "₺%.2f", CartManager.shared.getTotalCartPrice()) // Formatlı olarak toplam fiyatı label'e yazıyorum
        }
    }
    
    private func setupNavigationController() {
        title = "Ürün Detayı"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        guard let navigationController else {
            print("There is no navigation controller")
            return
        }
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myBasketButton)
    }
    
    @objc func addBasketDidTap() {
        addBasketButton.isHidden = true
        let numericString = priceLabel.text?.replacingOccurrences(of: "₺", with: "").replacingOccurrences(of: ",", with: ".") ?? "0"
        let productPrice = Double(numericString) ?? 0.0

        guard let image = productImageView.image else {
            print("Image does not found")
            return
        }
        
        presenter?.addBasketTapped(image: image, productPrice: productPrice, productName: productNameLabel.text ?? "", attribute: attributeLAbel.text ?? "")
    }
    
    @objc func plusDidTap() {
//        presenter?.count += 1
        let numericString = priceLabel.text?.replacingOccurrences(of: "₺", with: "").replacingOccurrences(of: ",", with: ".") ?? "0"
        let productPrice = Double(numericString) ?? 0.0

        guard let image = productImageView.image else {
            print("Image does not found")
            return
        }
        presenter?.addBasketTapped(image: image, productPrice: productPrice, productName: productNameLabel.text ?? "", attribute: attributeLAbel.text ?? "")    }
    
    @objc func removeBasketDidTap() {
        let numericString = priceLabel.text?.replacingOccurrences(of: "₺", with: "").replacingOccurrences(of: ",", with: ".") ?? "0"
        let productPrice = Double(numericString) ?? 0.0
        presenter?.removeBasketTapped(productName: productNameLabel.text ?? "", productPrice: productPrice)
        if presenter?.count == 0 {
            addBasketButton.isHidden = false
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(productImageView)
        view.addSubview(priceLabel)
        view.addSubview(productNameLabel)
        view.addSubview(attributeLAbel)
        view.addSubview(addBasketButton)
        view.addSubview(basketStackView)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 88),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 343),
            priceLabel.heightAnchor.constraint(equalToConstant: 27),
            
            productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            productNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productNameLabel.widthAnchor.constraint(equalToConstant: 343),
            productNameLabel.heightAnchor.constraint(equalToConstant: 44),

            attributeLAbel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            attributeLAbel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attributeLAbel.widthAnchor.constraint(equalToConstant: 343),
            attributeLAbel.heightAnchor.constraint(equalToConstant: 16.34),
            
            addBasketButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            addBasketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addBasketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addBasketButton.heightAnchor.constraint(equalToConstant: 50),
            
            basketStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            basketStackView.heightAnchor.constraint(equalToConstant: 48),
            basketStackView.widthAnchor.constraint(equalToConstant: 146),
            
            ])
    }
}

extension ProductDetailViewController: ProductDetailViewControllerProtocol {
    func setIsAddToBasketDidTap(_ isAddToBasketDidTap: Bool) {
        basketStackView.isHidden = !isAddToBasketDidTap
    }
    
    func setCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
    
    func setupViews() {
        productImageView.downloadImage(urlString: presenter?.productDetail?.productImage ?? "")
        productNameLabel.text = presenter?.productDetail?.productName ?? ""
        priceLabel.text = presenter?.productDetail?.productPrice ?? ""
        attributeLAbel.text = presenter?.productDetail?.productAttribute ?? ""
      }
}
