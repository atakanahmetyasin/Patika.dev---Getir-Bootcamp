//
//  DetailScreenVC.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 22.03.2024.
//

import UIKit

enum WordType {
    case noun
    case verb
    case adjective
}

class DetailScreenVC: UIViewController {
    private let viewModel = SearchViewModel()
    var detailsArray: [Dictionaryw] = []
    var definitionArray: [Definition] = []
    var bothDictionary: [String : [String]] = [:]
    
    var selectedWordType: WordType?
    
    let myTableView: UITableView = {
        let tv = UITableView()
        tv.register(DetailScreenCell.self, forCellReuseIdentifier: "cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let wordLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 40,weight: .bold),
                              textColor: .black,
                              text: "Error")
    }()
    let phoneticLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 25,weight: .light),
                              textColor: .black,
                              text: "Error")
    }()
    lazy var audioButton: UIButton = {
        let button = UIFactory.createButton(title: "", setImage: nil)
        let largeconfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .default)
        button.setImage(UIImage(systemName: "waveform.circle",withConfiguration: largeconfig), for: .normal)
        button.layer.cornerRadius = 30
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    lazy var nounButton: UIButton = {
        let button = UIFactory.createButton(title: "Noun", setImage: nil)
        button.addTarget(self, action: #selector(nounButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var verbButton: UIButton = {
        let button = UIFactory.createButton(title: "Verb", setImage: nil)
        button.addTarget(self, action: #selector(verbButtonDidTap), for: .touchUpInside)
        return button
    }()
    lazy var adjButton: UIButton = {
        let button = UIFactory.createButton(title: "Adj", setImage: nil)
        button.addTarget(self, action: #selector(adjButtonDidTap), for: .touchUpInside)
        return button
    }()
    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    @objc func nounButtonDidTap() {
//        filteredWords = detailsArray.filter{$0.meanings.contains{$0.partOfSpeech == "noun"}}
        myTableView.reloadData()
    }

    @objc func verbButtonDidTap() {
//        filteredWords = detailsArray.filter{$0.meanings.contains{$0.partOfSpeech == "verb"}}
        myTableView.reloadData()
    }

    @objc func adjButtonDidTap() {
//        filteredWords = detailsArray.filter{$0.meanings.contains{$0.partOfSpeech == "adjective"}}
        myTableView.reloadData()
    }
    
    
    private func addViews() {
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
        
    }
    private func addSubviews() {
        view.addSubview(colorView)
        view.addSubview(wordLabel)
        view.addSubview(phoneticLabel)
        view.addSubview(audioButton)
        view.addSubview(nounButton)
        view.addSubview(verbButton)
        view.addSubview(adjButton)
        view.addSubview(myTableView)
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            colorView.heightAnchor.constraint(equalToConstant: 180),
            
            wordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            
            phoneticLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8),
            phoneticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            
            audioButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            audioButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27),
            audioButton.widthAnchor.constraint(equalToConstant: 60),
            audioButton.heightAnchor.constraint(equalToConstant: 60),
            
            nounButton.topAnchor.constraint(equalTo: phoneticLabel.bottomAnchor, constant: 20),
            nounButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 13),
            nounButton.widthAnchor.constraint(equalToConstant: 80),
            nounButton.heightAnchor.constraint(equalToConstant: 40),
            
            verbButton.topAnchor.constraint(equalTo: phoneticLabel.bottomAnchor,constant: 20),
            verbButton.leadingAnchor.constraint(equalTo: nounButton.trailingAnchor,constant: 5),
            verbButton.widthAnchor.constraint(equalToConstant: 80),
            verbButton.heightAnchor.constraint(equalToConstant: 40),
            
            adjButton.topAnchor.constraint(equalTo: phoneticLabel.bottomAnchor, constant: 20),
            adjButton.leadingAnchor.constraint(equalTo: verbButton.trailingAnchor,constant: 5),
            adjButton.widthAnchor.constraint(equalToConstant: 80),
            adjButton.heightAnchor.constraint(equalToConstant: 40),
            
            myTableView.topAnchor.constraint(equalTo: colorView.bottomAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
}

extension DetailScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalCount = 0
        for (_, value) in bothDictionary {
            totalCount += value.count
        }
        return  totalCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        phoneticLabel.text = detailsArray.first?.phonetic
        wordLabel.text = detailsArray.first?.word
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailScreenCell

        var currentPosIndex = 0
            var currentDefinitionIndex = indexPath.row
            for (_, definitions) in bothDictionary {
                if currentDefinitionIndex < definitions.count {
                    break
                }
                currentDefinitionIndex -= definitions.count
                currentPosIndex += 1
            }
            
            let partOfSpeech = Array(bothDictionary.keys)[currentPosIndex]
            cell.typeLabel.text = partOfSpeech
        
        let shortDictionary = definitionArray[indexPath.row]
        cell.numberLabel.text = "\(indexPath.row + 1) -"
//        cell.definitionLabel.text = shortDictionary.definition
        cell.definitionLabel.text = detailsArray[indexPath.row].meanings[indexPath.row].definitions[indexPath.row].definition
//        cell.exampleLabel.text = shortDictionary.example
        cell.exampleLabel.text = detailsArray[indexPath.row].meanings[indexPath.row].definitions[indexPath.row].example
        return cell
    }
}




