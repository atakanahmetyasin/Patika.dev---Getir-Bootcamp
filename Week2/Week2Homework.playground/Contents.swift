//import UIKit
///*
//--- Ödev: masksToBounds ne işe yarar? Masks to bound ile clip to fark nedir?
//--- Cevap: 200x200 kırmızı renkli bir parentView dikdörtgenimiz olduğunu düşünelim. Ben bu dikdörtgenin içerisine 250x250 mavi bir dikdörtgen eklemek istersem ya da başka bir boyutta ama kırmızı dikdörtgenin sınırlarını aşan bir şekilde eklersem clipstobounds ile mavi dikdörtgenin taşan kısımlarını keserek parentView'in içerisine sığdırmış olurum. masksToBounds view'in subview'larını da etkilerken, cliptsToBounds subview'ları etkilemez. 
// 
//--- Ödev: Notification Center ile addObserver sonrası memory leak oluşmaması için ne yapmalı.
//--- Cevap: deInit içerisinde removeObserver(self) metodunu kullanmalıyız.
// 
// */
//
///// ----- Exercism 1: "Accumulate" Question: ---
//
//// extension Array {
////    func accumulate<U>(_ operation: (Element) -> U) -> [U] {
////        var result = [U]()
////        
////        for element in self {
////            result.append(operation(element))
////        }
////        
////        return result
////    }
////}
//
///// ----- Exercism 2: "GradeSchool" Question: ---
//
////class GradeSchool {
////    var persons: [String: Int] = [:]
////    
////    func roster() -> [String] {
////        persons.sorted {$0.1 == $1.1 ? $0.0 < $1.0 : $0.1 < $1.1}.map {$0.0}
////    }
////    func addStudent(_ name: String, grade: Int) -> Bool {
////        guard !persons.keys.contains(name) else { return false }
////        persons[name] = grade
////        return true
////    }
////    func studentsInGrade(_ grade: Int) -> [String] {
////        return persons.filter { $1 == grade }.map { $0.0 }.sorted()
////    }
////}
//
///// ----- Exercism 3: "Grains" Question: ---
//
////enum GrainsError: Error {
////  case inputTooLow
////  case inputTooHigh
////}
////struct Grains {
////  static var total: UInt64 {
////    let squared = try! Array(1...64).map(square)
////    return squared.reduce(0) { $0 + $1 }
////  }
////  
////  static func square(_ num: Int) throws -> UInt64 {
////    if num < 1 {
////      throw GrainsError.inputTooLow
////    }
////    if num > 64 {
////      throw GrainsError.inputTooHigh
////    }
////    if num == 1 {
////      return 1
////    } else {
////      return try! square(num - 1) * 2
////    }
////  }
////}
//
//
///// ----- Exercism 4: "Hamming" Question: ---
//
////enum SequenceError: Error{
////    case notSameLength
////}
////func compute(_ dnaSequence: String, against: String) throws -> Int? {
////    guard dnaSequence.count == against.count else { throw SequenceError.notSameLength}
////    return zip(dnaSequence, against).filter{$0 != $1}.count
////}
//
///// ----- Exercism 5: "Isogram" Question: ---
//
////func isIsogram(_ word: String) -> Bool {
////    var lettersSeen = Set<Character>()
////    
////    for char in word.lowercased() {
////        if char != " " && char != "-" {
////            if lettersSeen.contains(char) {
////                return false
////            }
////            lettersSeen.insert(char)
////        }
////    }
////        return true
////}
//
//
///// ----- Exercism 6: "List Ops" Question: ---
//
////func append<T>(_ a: Array<T>, _ b: Array<T>) -> Array<T> {
////    return a + b
////}
////func concat<T>(_ a: Array<T>...) -> Array<T> {
////    return Array(a.joined())
////}
////func length<T>(_ a: Array<T>) -> Int {
////    return a.count
////}
////func filter<T>(_ a: Array<T>, _ f: (T) -> Bool) -> Array<T> {
////    return a.filter(f)
////}
////func map<T>(_ a: Array<T>, _ f: (T) -> T) -> Array<T> {
////    return a.map(f)
////}
////func foldLeft<T, A>(_ a: Array<T>, accumulated: A, combine: (A, T) -> A) -> A {
////    return a.reduce(accumulated, combine)
////}
////func foldRight<T, A>(_ a: Array<T>, accumulated: A, combine: (T, A) -> A) -> A {
////    guard let head = a.last else { return accumulated }
////    return foldRight(a.dropLast(), accumulated: combine(head, accumulated), combine: combine)
////}
////func reverse<T>(_ a: Array<T>) -> Array<T> {
////    return a.reversed()
////}
//
//
///// ----- Exercism 7: "Nucleotide Count" Question: ---
/////
////enum NucleotideCountErrors: Error {
////case invalidNucleotide
////}
////class DNA {
////let nucleotideCounts: [String: Int]
////init(strand: String) throws {
////    nucleotideCounts = try strand.reduce(into: ["A": 0, "C": 0, "G": 0, "T": 0], {
////        counts, nucleotide in
////        let nucleotide = String(nucleotide)
////        guard counts[nucleotide] != nil else { throw NucleotideCountErrors.invalidNucleotide }
////        counts[nucleotide]! += 1
////    })
////}
////func counts() -> [String: Int] {
////    nucleotideCounts
////}
////}
//
///// ----- Exercism 8: "Raindrops" Question: ---
//
////func raindrops(_ number: Int) -> String {
////  var result: String = ""
////  if number % 3 == 0 { result += "Pling" }
////  if number % 5 == 0 { result += "Plang" }
////  if number % 7 == 0 { result += "Plong" }
////  
////  return result == "" ? String(number) : result
////}
//
///// ----- Exercism 9: "Binary Search" Question: ---
////
////enum BinarySearchError: Error {
////    case valueNotFound
////}
////class BinarySearch {
////    let collection: [Int]
////    init(_ collection: [Int] = []) {
////        self.collection = collection
////    }
////    func searchFor(_ target: Int) throws -> Int {
////        var l = 0
////        var r = self.collection.count - 1
////        while l <= r {
////            let middle = (l + r) / 2
////            if self.collection[middle] == target {
////                return middle
////            }
////            self.collection[middle] < target ? (l = middle + 1) : (r = middle - 1)
////        }
////        throw BinarySearchError.valueNotFound
////    }
////}
//
///// ----- Exercism 10: "Circular Buffer" Question: ---
//
////enum CircularBufferError: Error {
////    case bufferEmpty
////    case bufferFull
////}
////struct CircularBuffer {
////    let capacity: Int
////    var bufferArray = [Int]()
////    mutating func read() throws -> Int {
////        guard !bufferArray.isEmpty else { throw CircularBufferError.bufferEmpty }
////        return bufferArray.removeFirst()
////    }
////    mutating func write(_ number: Int) throws {
////        guard bufferArray.count != capacity else { throw CircularBufferError.bufferFull }
////        bufferArray.append(number)
////    }
////    mutating func clear() {
////        bufferArray.removeAll()
////    }
////    mutating func overwrite(_ number: Int) {
////        if bufferArray.count == capacity {
////            bufferArray.remove(at: 0)
////            bufferArray.append(number)
////        } else {
////            bufferArray.append(number)
////        }
////    }
////}
//
//
///// ----- Euler 6th Question:
//
////func sumSquareDifference(_ n: Int) -> Int {
////    let sum = (n * (n + 1)) / 2
////    let sumOfSquares = (n * (n + 1) * (2 * n + 1)) / 6
////    let squareOfSum = sum * sum
////    return squareOfSum - sumOfSquares
////}
//
//
///// ----- Euler 7th Question:
//
////func isPrime(_ number: Int) -> Bool {
////    guard number >= 2 else { return false }
////    guard number != 2 else { return true }
////    guard number % 2 != 0 else { return false }
////    
////    var i = 3
////    while i * i <= number {
////        if number % i == 0 {
////            return false
////        }
////        i += 2
////    }
////    return true
////}
////
////func findNthPrime(_ n: Int) -> Int? {
////    guard n > 0 else { return nil }
////    
////    var count = 0
////    var number = 2
////    
////    while count < n {
////        if isPrime(number) {
////            count += 1
////            if count == n {
////                return number
////            }
////        }
////        number += 1
////    }
////
////    return nil
////}

//var name: String = "Ahmet" {
//    willSet { 
//        print("The name will be changed from \(name) to the \(newValue)")
//    }
//    didSet {
//        print("The name is changed to the \(name) from \(oldValue)")
//    }
//}
//
//name = "Mehmet"
