//
//  SearchViewModel.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 21.03.2024.
//

import Foundation


class SearchViewModel {
    private let networkManager: ServiceProtocol
    var dictionaryArray: [Dictionaryw] = []
    var meaningsArray: [Meaning] = []
    var definitionArray: [Definition] = []
    var bothDictionary: [String : [String]] = [:]
    var filteredWords: [Dictionaryw] = []

    
    init(networkManager: ServiceProtocol = APIManager()) {
        self.networkManager = networkManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchDictionary(word: String, completion: @escaping (Bool) -> Void) {
        dictionaryArray.removeAll()
            meaningsArray.removeAll()
            definitionArray.removeAll()
            bothDictionary.removeAll()
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
            print(NetworkError.urlError)
            completion(false)
            return
        }
        print(url)
        networkManager.fetchData(from: url) { [ weak self ] (result: Result<[Dictionaryw],NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.dictionaryArray = data
                    print(self?.dictionaryArray)
                    for i in 0..<data.count {
                        for j in 0..<data[i].meanings.count {
                            if let partOfSpeech = data[i].meanings[j].partOfSpeech {
                                       // Check if the key already exists in the dictionary
                                       if var definitions = self?.bothDictionary[partOfSpeech] {
                                           // If the key exists, append the new definitions
                                           definitions.append(contentsOf: data[i].meanings[j].definitions.map { $0.definition ?? "" })
                                           self?.bothDictionary[partOfSpeech] = definitions
                                       } else {
                                           // If the key doesn't exist, create a new entry with the definitions
                                           self?.bothDictionary[partOfSpeech] = data[i].meanings[j].definitions.map { $0.definition ?? "" }
                                       }
                                   }
                            self?.definitionArray.append(contentsOf: data[i].meanings[j].definitions)
                        }
                        
                    }
                    completion(true)
                }
            case .failure(let error):
                print("Error: ", error.localizedDescription)
                completion(false)
            }
        }
    }
    
}
