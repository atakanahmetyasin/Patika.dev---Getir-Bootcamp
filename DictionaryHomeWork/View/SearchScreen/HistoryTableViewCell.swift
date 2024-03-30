//
//  HistoryTableViewCell.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 26.03.2024.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    let firstButton: UIButton = {
        UIFactory.createButton(title: nil,
                               setImage: UIImage(systemName: "magnifyingglass"))
    }()
    let historyLabel: UILabel = {
        UIFactory.createLabel(font: UIFont.systemFont(ofSize: 12),
                              textColor: .black,
                              text: "history")
    }()
    let arrowButton: UIButton = {
        UIFactory.createButton(title: nil,
                               setImage: UIImage(systemName: "arrow.right"))
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addViews() {
        contentView.addSubview(firstButton)
        addSubview(historyLabel)
        contentView.addSubview(arrowButton)
        
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: topAnchor,constant:5),
            firstButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            firstButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            firstButton.widthAnchor.constraint(equalToConstant: 50),
            
            historyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            historyLabel.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor, constant: 15),
            historyLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5),
            
            arrowButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            arrowButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            arrowButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
