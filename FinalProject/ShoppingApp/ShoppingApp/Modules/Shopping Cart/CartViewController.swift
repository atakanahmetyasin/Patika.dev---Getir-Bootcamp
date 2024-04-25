//
//  CartViewController.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 18.04.2024.
//

import UIKit

// Header View
final class SectionHeaderView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
//

protocol CartViewControllerProtocol: AnyObject {
    func reloadData()
}

final class CartViewController: UIViewController {
    var presenter: CartPresenterProtocol?
    
    private lazy var myCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.register(CartVerticalCollectionViewCell.self)
        cv.register(CartSuggestedCollectionViewCell.self)
        cv.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "₺0.00"
        label.font = .openSansBold(size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
        label.backgroundColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createOrderButton: UIButton = {
        let button = UIFactory.createButton(image: nil,
                                            backgroundColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1),
                                            tintColor: .white)
        button.setTitle("Siparişi Tamamla", for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(createOrderDidTap), for: .touchUpInside)
        let totalPriceLabel = self.totalPriceLabel
        button.addSubview(totalPriceLabel)
        NSLayoutConstraint.activate([
            totalPriceLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            totalPriceLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: -80),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: 50) ,
            totalPriceLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
        return button
    }()
    
    private lazy var removeCartButton: UIButton = {
        let button = UIFactory.createButton(image: UIImage(systemName: "trash.fill"),
                                            backgroundColor: UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1),
                                            tintColor: .white)
        button.addTarget(self, action: #selector(removeCartDidTap), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sepetim"
        setupCollectionView()
        updateTotalPriceLabel()
        addViews()
        reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: removeCartButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.presenter?.viewDidLoad()
            self.reloadData()
        }
    }
    
    // TODO: ALERTLER İÇİN AYRI BİR DOSYA İÇİNDE YAPI OLUŞTUR.
    
    
    @objc func createOrderDidTap() { // presentera taşı
        let alert = UIAlertController(title: "", message: "Siparişiniz oluşturuldu", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Teşekkürler, aldığım en iyi hizmetti.", style: .default, handler: { [ weak self ] action in // forcing user to thank, because there are a lot of hardwork here
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                CartManager.shared.removeAllItemsFromCart()
                self?.reloadData()
                self?.totalPriceLabel.text = "₺0.00"
            }
        })
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    
    @objc func removeCartDidTap() { // presentera taşı
        let alert = UIAlertController(title: "Sepeti Boşaltmak İstediğinize emin misiniz?", message: "Eğer evete basarsanız, ürünleriniz sepetten silinecektir.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { [ weak self ] action in
            DispatchQueue.main.async {
                CartManager.shared.removeAllItemsFromCart()
                self?.reloadData()
                self?.totalPriceLabel.text = "₺0.00"
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    private func updateTotalPriceLabel() {
        totalPriceLabel.text = String(format: "₺%.2f", CartManager.shared.getTotalCartPrice()) // Formatlı olarak toplam fiyatı label'e yazıyorum
    }
    
    private func addViews() {
        view.addSubview(createOrderButton)
        
        NSLayoutConstraint.activate([
            createOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            createOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            createOrderButton.heightAnchor.constraint(equalToConstant: 50),
            createOrderButton.widthAnchor.constraint(equalToConstant: 351),
        ])
    }
    
    private func setupCollectionView() {
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
    
    private func section(for index: Int) -> Section {
        return index == 0 ? .vertical : .horizontal
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch self.section(for: sectionIndex) {
            case .vertical:
                return self.createVerticalSection()
            case .horizontal:
                return self.createHorizontalSection()
            }
        }
        return layout
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(92 + 19 + 34))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.91), heightDimension: .absolute(153))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 00, leading: 0, bottom: 50, trailing: 0)
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(74))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return layoutSection
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter != nil ? 2 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        switch section {
        case 0:
            if presenter.numberOfVerticalItems() == 0 {
                collectionView.setEmptyView(title: "Sepetiniz boş", message: "Lütfen ürün ekleyiniz")
            }
            return presenter.numberOfVerticalItems()
        case 1:
            return presenter.numberOfSuggestedItems()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        switch indexPath.section {
        case 0: // eğer boşsa "sepette ürün yok" mesajı göster.
            let cell: CartVerticalCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let cartManager = CartManager.shared.cartItems[indexPath.row]
            cell.setProduct(from: cartManager)
            return cell
        case 1:
            let cell: CartSuggestedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let productHorizontal = presenter.productElementSuggested(indexPath.item) {
                cell.cellPresenter = SuggestedCellPresenter(view: cell, productHorizontal: productHorizontal, basketPresenter: BasketPresenter(cartManager: CartManager()))
            }
                        let productSuggested = presenter.productElementSuggested[indexPath.item]
                        cell.configure(productSuggested: productSuggested)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeaderView
            headerView.configure(title: "Önerilen Ürünler")
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 44)
        }
        return .zero
    }
}

extension CartViewController: CartViewControllerProtocol {
    
    func reloadData() {
        self.myCollectionView.reloadData()
    }
}
