//
//  ListingViewController.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 8.04.2024.
//

import UIKit

enum Section {
    case horizontal
    case vertical
}

protocol ListingViewControllerProtocol: AnyObject {
    func reloadData()
    func createCompositionalLayout() -> UICollectionViewLayout
    func createHorizontalSection() -> NSCollectionLayoutSection
    func setupCollectionView()
    func createVerticalSection() -> NSCollectionLayoutSection
    
    var totalPriceLabel: UILabel { get set }
}

final class ListingViewController: UIViewController {
    var presenter: ListingPresenterProtocol?
    
     var totalPriceLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 35, y: 0, width: 56, height: 34))
        label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "₺0.00"
        label.font = .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
        label.backgroundColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var myBasketButton: UIButton = {
        let button = UIFactory.createButton(image: nil,
                                            backgroundColor: .white,
                                            tintColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1))
        button.addTarget(self, action: #selector(myBasketDidTap), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 91).isActive = true
        button.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        let basketImageView = UIImageView(image: UIImage(systemName: "cart.fill"))
        basketImageView.tintColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        basketImageView.frame = CGRect(x: 7, y: 8, width: 20, height: 20)
        
        let totalPriceLabel = self.totalPriceLabel
        
        button.addSubview(basketImageView)
        button.addSubview(totalPriceLabel)
        return button
    }()
    
    private lazy var myCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.register(ProductsHorizontalCollectionViewCell.self)
        cv.register(ProductsVerticalCollectionViewCell.self)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1)
        presenter?.viewDidLoad()
        setupCollectionView()
        setupNavigationController()
       
        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalPriceLabel), name: NSNotification.Name("updateTotalPrice"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self) // memory leak oluşmasın diye remove ediyorum.
    }
    
    @objc func myBasketDidTap() {
        presenter?.showCart()
    }
    
    @objc func updateTotalPriceLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [ weak self ] in
            self?.totalPriceLabel.text = String(format: "₺%.2f", CartManager.shared.getTotalCartPrice()) // Formatlı olarak toplam fiyatı label'e yazıyorum
        }
    }
    
    private func setupNavigationController() {
        title = "Ürünler"
        
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
    
    func section(for index: Int) -> Section {
        // index'in durumuna göre hangisinin çağrılacağını belirliyorum. Section enumına göre belirliyorum.
        return index == 0 ? .horizontal : .vertical
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch self.section(for: sectionIndex) {
            case .horizontal:
                return self.createHorizontalSection()
            case .vertical:
                return self.createVerticalSection()
            }
        }
        return layout
    }
    
    func createHorizontalSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(92 + 19 + 34))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.91), heightDimension: .absolute(153))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        return layoutSection
    }
    
    func createVerticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(153))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(185))

        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        
        return layoutSection
    }

    func setupCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = .white
        
        view.addSubview(myCollectionView)
        
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ListingViewController: UICollectionViewDelegate {
    
}

extension ListingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter != nil ? 2 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        
        switch section {
        case 0:
            return presenter.numberOfHorizontalItems()
        case 1:
            return presenter.numberOfVerticalItems()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        switch indexPath.section {
        case 0:
            let cell: ProductsHorizontalCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let productHorizontal = presenter.productElementHorizontal(indexPath.item) {
                cell.cellPresenter = HorizontalCellPresenter(view: cell, productHorizontal: productHorizontal, basketPresenter: BasketPresenter(cartManager: CartManager()))
            }
            return cell
        case 1:
            let cell: ProductsVerticalCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let productVertical = presenter.productElementVertical(indexPath.item) {
                cell.cellPresenter = VerticalCellPresenter(view: cell, productVertical: productVertical, basketPresenter: BasketPresenter(cartManager: CartManager()))
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //a
        switch indexPath.section {
        case 0:
            presenter?.productDetailHorizontal(indexPath.row)
        case 1:
            presenter?.productDetailVertical(indexPath.row)
        default:
            break
        }
    }
}

extension ListingViewController: ListingViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async { [ weak self ] in
            self?.myCollectionView.reloadData()
        }
    }
}

