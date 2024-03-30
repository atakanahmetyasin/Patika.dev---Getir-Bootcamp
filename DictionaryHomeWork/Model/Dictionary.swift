//
//  Dictionary.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 21.03.2024.
//

import Foundation

// MARK: - Dictionary
struct Dictionaryw: Codable {
    let word, phonetic: String?
    let phonetics: [Phonetic]
    let meanings: [Meaning]
    let license: License
    let sourceUrls: [String]?
}

// MARK: - License
struct License: Codable {
    let name: String?
    let url: String?
}

// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String?
    let definitions: [Definition]
    let synonyms: [String]?
    let antonyms: [String]?
}

// MARK: - Definition
struct Definition: Codable {
    let definition: String?
    let synonyms, antonyms: [String]?
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    let text: String?
    let audio: String?
    let sourceURL: String?
    let license: License?

    enum CodingKeys: String, CodingKey {
        case text, audio
        case sourceURL = "sourceUrl"
        case license
    }
}