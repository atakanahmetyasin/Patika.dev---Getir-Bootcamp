//
//  City.swift
//  Getir-Basic-Components
//
//  Created by Kerim Çağlar on 23.03.2024.
//

import Foundation

struct City {
    var name: String?
    var famus: String?
    var image: String
}

//Mülakat sorusu
/**
 Decodable nedir?
 Encodable nedir?
 typealias Codable = Decodable & Encodable şeklinde tanımlanmasının nedeni nedir?
 (İpucu: Solid prensiplerinden biri ile ilişkili)
 
 --- Cevap: Decodable gelen veriyi(Json, plist vs.) modelimize dönüştürüp kullanmamızı sağlar. Encodable ise modelimizin veriye dönüşmesini sağlar. typealias Codable = Decodable & Encodable ise Interface Segregation prensibine uygundur. Veri okuma ve veri dönüştürme işlevlerini tek bir çatı altında toplar.
 
 */
