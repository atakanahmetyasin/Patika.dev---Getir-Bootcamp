//
//  ViewController.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 21.03.2024.
//

import UIKit

final class SearchVC: UIViewController {
    private let viewModel = SearchViewModel()
    private let defaults = UserDefaults.standard
    private var searchHistory: [String] = []
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        bar.keyboardAppearance = .default
        bar.keyboardType = .default
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    lazy var searchButton: UIButton = {
       let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = UIColor(white: 1, alpha: 0.9)
        button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let historyTableView: UITableView = {
       let tv = UITableView()
        tv.register(HistoryTableViewCell.self, forCellReuseIdentifier: "cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addViews()
        historyTableView.delegate = self
        historyTableView.dataSource = self
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedHistory = defaults.stringArray(forKey: "searchHistory") {
            searchHistory = savedHistory
        }
        historyTableView.reloadData()
    }

    @objc private func searchButtonDidTap() {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        viewModel.fetchDictionary(word: searchText) { [weak self] success in
            guard success else {
                // Handle failure, show alert, etc.
                return
            }
            let detailsVC = DetailScreenVC()
            detailsVC.detailsArray = self?.viewModel.dictionaryArray ?? []
//            detailsVC.meaningArray = self?.viewModel.meaningsArray ?? []
            detailsVC.definitionArray = self?.viewModel.definitionArray ?? []
            detailsVC.bothDictionary = self?.viewModel.bothDictionary ?? [:]
            self?.navigationController?.pushViewController(detailsVC, animated: true)
        }
        
        if searchHistory.count >= 5 {
            searchHistory.removeFirst()
        }
        searchHistory.append(searchText)
        
        defaults.setValue(searchHistory, forKey: "searchHistory")
        historyTableView.reloadData()
        
    }

    private func addViews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        searchBar.delegate = self
    }
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(searchButton)
        view.addSubview(historyTableView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
        
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 100),
            
            historyTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            historyTableView.heightAnchor.constraint(equalToConstant: 250),
            
        ])
    }

}

extension SearchVC: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
//        defaults.setValue(searchText, forKey: "searchText")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        
        cell.historyLabel.text = searchHistory[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = searchHistory[indexPath.row]
        viewModel.fetchDictionary(word: selectedWord) { [ weak self ] success in
            guard success else {
                return
            }
            let detailsVC = DetailScreenVC()
            detailsVC.detailsArray = self?.viewModel.dictionaryArray ?? []
            detailsVC.definitionArray = self?.viewModel.definitionArray ?? []
            detailsVC.bothDictionary = self?.viewModel.bothDictionary ?? [:]
            self?.navigationController?.pushViewController(detailsVC, animated: true)
        }

            
        }
    }
    

