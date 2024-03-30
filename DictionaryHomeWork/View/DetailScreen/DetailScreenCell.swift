//
//  DetailScreenCell.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 22.03.2024.
//

import UIKit

class DetailScreenCell: UITableViewCell {
    
    let numberLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 20,weight: .medium),
                              textColor: .black,
                              text: "1 - ")
    }()
    let typeLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 25, weight: .bold),
                              textColor: .systemBlue,
                              text: "Noun")
    }()
    let definitionLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 15, weight: .medium), textColor: .black, text: "Definition")
    }()
    let exampleLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 15, weight: .medium), textColor: .black, text: "Example")
    }()
     let exampleSubLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 12, weight: .light), textColor: .systemGray, text: "The Dog homed")
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(numberLabel)
        addSubview(typeLabel)
        addSubview(definitionLabel)
        addSubview(exampleLabel)
        addSubview(exampleSubLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            typeLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 5),
        
            definitionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 12),
            definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            
            exampleLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 10),
            exampleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            
            exampleSubLabel.topAnchor.constraint(equalTo: exampleLabel.bottomAnchor, constant: 8),
            exampleSubLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
        ])
    }
    
}
