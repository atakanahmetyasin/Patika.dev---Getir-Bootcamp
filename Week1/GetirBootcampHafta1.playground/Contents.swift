import Foundation
//     Hashable:
//     Mülakat Sorusu: Array ile Set arasındaki farklar? - Set ile Arrayden hangisi daha hızlı erişim sağlar?
//     ÖDEV: Hashable protokolü set ler için neden avantaj sağlar?

//    Cevap: Array içerisinde aynı veriler bulunabilirken Set içerisinde sadece bir kopyası bulunabilir. Array elemanları sıralı bir şekilde saklarken, Setler karışık bir şekilde saklar. Set'in time complexity'si O(1)'dir yani constanttır. Arrayin ise O(n) olduğunda arrayin büyüklüğüne bağlı olarak time complexity'si değişir. Bu durumda hangisinin daha hızlı erişim sağladığı duruma göre değişiklik gösterecektir.
//     Set içerisinde duplicate value bulunamaz. Hash value ise her instance için bir int değer veriyor. Bu sayede duplicate value olanları set tanıyor ve sadece birini saklıyor.

///--------------------  QUESTİON 1: -----------------
// 1- Elimizde sadece harflerden oluşan (noktalama işareti veya sayılar yok) uzun stringler olsun. Bu stringler içinde bazı harflerin tekrar edeceğini düşünün. Mesela 'a' harfi 20 farklı yerde geçiyor olabilir. Bir fonksiyon ile verilen parametre değerine eşit ve daha fazla bulunan harfleri siliniz.Sonra geriye kalan stringi ekrana yazdırınız.
//Örnek string: "aaba kouq bux"
//Tekrar sayısı 2 verildiğinde : a,b,u silinmeli ve ekrana "koq x" yazılmalı
//Tekrar sayısı 3 verildiğinde : a silinmeli ve ekrana "b kouq bux"
//Tekrar sayısı 4 verildiğinde : hiç bir harf silinmeyip aynı string yazılmalı

func question1(_ str: String, _ number: Int) {
    var charCount = [Character: Int]()
    
    for char in str {
        charCount[char, default: 0] += 1
    }
    
    var result = ""
    
    for char in str {
        if charCount[char]! <= number {
            result.append(char)
        }
    }
    print(result)
}

///--------------------  QUESTİON 2: -----------------
//2- Elimizde uzun bir cümle olsun. Bazı kelimelerin tekrar ettiği bir cümle düşünün. İstediğimiz ise, hangi kelimeden kaç tane kullanıldığını bulmak.
//  String = "Merhaba nasılsınız iyiyim siz nasılsınız bende iyiyim"
//  Merhaba 1 kere, nasılsınız 2 kere iyiyim 2 kere

func wordsCount(str: String) {
    let newArr = str.components(separatedBy: " ")
    var newDict: [String: Int] = [:]

    for word in newArr {
        if let count = newDict[word] {
            newDict[word] = count + 1
        }
        else {
            newDict[word] = 1
        }
    }

    for (word, count) in newDict {
        print("\(word): \(count) kere")
    }
}
wordsCount(str: "Merhaba nasılsınız iyiyim siz nasılsınız bende iyiyim")

///----------------------  Multiples of 3 or 5 (euler 1st) ---------------------
///
//Problem 1
//If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3,5,6 and 9. The sum of these multiples is 23.
//Find the sum of all the multiples of 3 or 5 below 1000.

func problem1() -> Int {
    var sum = 0
    for number in 1..<1000 {
        if number % 3 == 0 || number % 5 == 0 {
            sum = sum + number
        }
    }
    print(sum)
    return sum
}


/// --------------- euler 2nd - By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms. --------

func problem2() -> Int {
    var sum = 0
    var a = 1
    var b = 2

    while a <= 4000000 {
        if a % 2 == 0 {
            sum += a
        }
        let temp = a
        a = b
        b = temp + b
    }
print(sum)
    return sum
}

/// ---------- euler 3. question: What is the largest prime factor of the number 600851475143? ----------

func largestPrimeFactor() {
    var number = 600851475143
    var largestFactor = 0

    while number % 2 == 0 {
        largestFactor = 2
        number /= 2
    }

    var factor = 3
    while factor * factor <= number {
        if number % factor == 0 {
            largestFactor = factor
            number /= factor
        } else {
            factor += 2
        }
    }
    if number > 2 {
        largestFactor = number
    }

}
largestPrimeFactor()

/// ---------- euler 4. Question: Find the largest palindrome made from the product of two 3-digit numbers. --------

var palindrome = 0

for i in 100..<1000 {
    for j in 100..<1000 {
        let number = String(i * j)
        let reversedNumber = String(number.reversed())
        if number == reversedNumber {
            palindrome = max(palindrome, Int(number) ?? 0)
        }
    }
}
print("Largest palindrome:", palindrome)

/// ----------------------- euler 5. Question: ----------------
///
let num = (2...20).reduce(1, *)

var result = num

for i in 2...20 {
    while result % i == 0 {
        var isDivisible = true
        for j in 2...20 {
            if (result / i) % j != 0 {
                isDivisible = false
                break
            }
        }
        if isDivisible {
            result /= i
        } else {
            break
        }
    }
}

print(result)


/// Fonksiyona parametre olarak verilen sayıya göre + - karakterlerini ekrana yazdıran bir fonksiyon yaınız. Örneğin 1 için sadece +, 2 için +-, 5 için +-+-+ şeklinde olmalıdır

 func plusMinus(number: Int) {
 var arr: [String] = []
 
 for i in 1...number {
 if i % 2 == 1 {
 arr.append("+")
 }
 else if i % 2 == 0 {
 arr.append("-")
 }
 }
 print(arr.joined(separator: ""))
 }
 plusMinus(number: 5)

/// Fonksiyona parametre olarak verilen sayıyı en büyük yapacak şekilde 5 sayısını ilgili basamağa koyunuz. Örneğin parametre 0 için çıktı 50 olmalıdır. Parametre 28 için 528, parametre 920 için 9520 olmalıdır

func makeLargest(_ number: Int) -> Int {
    var numberStr = String(number)
    var result = 0
    
    let negative = number < 0
    let absoluteValue = abs(number)
    
    for (index, digitChar) in numberStr.enumerated() {
        let digit = Int(String(digitChar))!
        
        if digit < 5 || index == numberStr.count - 1 {
            numberStr.insert(contentsOf: "5", at: numberStr.index(numberStr.startIndex, offsetBy: index))
            break
        }
    }

    result = Int(numberStr)!
    if negative {
        result *= -1
    }
    return result
}

print(makeLargest(0))
print(makeLargest(28))
print(makeLargest(920))

/// Girilen bir sayının asal olup olmadığını bulan bir extension yazınız.

 extension Int {
    static func primeNumbers(number: Int) -> Bool {
        guard number >= 2 else {
               return false // 2'den küçük sayılar asal değildir
           }

           for i in 2...Int(Double(number).squareRoot()) {
               if number % i == 0 {
                   return false // Sayı i'ye bölünebiliyorsa asal değildir
               }
           }

           return true // Sayı herhangi bir böleni olmadığı için asaldır
    }
}
 print(Int.primeNumbers(number: 12))

/// iki parametreli ve farklı tipli bir generic örneği yapınız (T,U)

 struct Person<U,T> {
    let name: U
    let age: T
    init(name: U, age: T) {
        self.name = name
        self.age = age
    }
}

 let firstPerson = Person(name: "Ahmet", age: 12)
 let twoPerson = Person(name: ["Ahmet", "Mehmet"], age: (26,21))


/// Exercism 1: Write your code for the 'Difference Of Squares' exercise here.

class Squares {
    let number: Int

    init(_ number: Int) {
        self.number = number
    }

    var squareOfSum: Int {
        let sum = (number * (number + 1)) / 2
        return sum * sum
    }

    var sumOfSquares: Int {
        return (number * (number + 1) * (2 * number + 1)) / 6
    }
    var differenceOfSquares: Int {
        return squareOfSum - sumOfSquares
    }
}

/// Exercism 2:   Write your code for the 'Gigasecond' exercise in this file.

func gigasecond(from date: Date) -> Date {
    let gigasecond: TimeInterval = 1_000_000_000

    let oneGigasecondLater = date.addingTimeInterval(gigasecond)

    return oneGigasecondLater
}

/// Exercism 3:      Write your code for the 'Leap' exercise in this file.

class Year {
    var calendarYear: Int
    init(calendarYear: Int) {
        self.calendarYear = calendarYear
    }

    var isLeapYear: Bool {
        if calendarYear % 4 == 0 {
            if calendarYear % 100 == 0 {
                if calendarYear % 400 == 0 {
                    return true
                } else {
                    return false
                }
            } else {
                return true
            }
        } else {
            return false
        }
    }
}
let year = Year(calendarYear: 2100)
year.isLeapYear


/// Exercism 4: // Write your code for the 'Rna Transcription' exercise in this file.

 func toRna(_ dna: String) -> String {
    var dnaArr = Array(dna)
    var newDnaArr: [String] = []
    for i in 0..<dnaArr.count {
        if dnaArr[i] == "G" {
            newDnaArr.append("C")
        }
        else if dnaArr[i] == "C" {
            newDnaArr.append("G")
        }
        else if dnaArr[i] == "A" {
            newDnaArr.append("U")
        }
        else if dnaArr[i] == "T" {
            newDnaArr.append("A")
        }

    }

    return newDnaArr.joined()
}
 toRna("ACGTGGTCTTAA")

/// Exercism 5:   // Write your code for the 'SpaceAge' exercise in this file.

class SpaceAge {
    var second: Double
    init(_ second: Double) {
        self.second = second
    }

    var onEarth: Double {
        return second / 60 / 60 / 24 / 365.26
    }

    var onMercury: Double {
        return onEarth / 0.2408467
    }
    var onVenus: Double {
        return onEarth /  0.61519726
    }
    var onMars: Double {
        return onEarth /  1.8808158
    }
    var onJupiter: Double {
        return onEarth / 11.862615
    }
    var onSaturn: Double {
        return onEarth / 29.447498
    }
    var onUranus: Double {
        return onEarth / 84.016846
    }
    var onNeptune: Double {
        return onEarth /  164.79132
    }
}
let age = SpaceAge(2_134_835_688)
age.onEarth
age.onMercury

/// Exercism 6:   // Write your code for the 'SumOfMultiples' exercise in this method.

 func toLimit(_ limit: Int, inMultiples: [Int]) -> Int {
    var sum = 0
    for num in 1..<limit {
        var isMultiple = false
        for factor in inMultiples {
            if factor != 0 && num % factor == 0 {
                isMultiple = true
            }
        }
        if isMultiple {
            sum += num
        }
    }
    return sum
}

/// Exercism 7: // Write your code for the 'TwoFer' exercise in this file.
///
func twoFer(name: String? = nil) -> String {
    let person = name ?? "you"
    return "One for \(person), one for me."
}

/// Exercism 8:  Write your code for the 'Reverse String' exercise in this file.
func reverseString(_ input : String) -> String {
    var reversedString = String(input.reversed())
    
    return reversedString
}

/// Exercism 9: "BOB"

class Bob {
    static func response(_ message: String) -> String {
   let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if trimmedMessage.isEmpty {
        return "Fine. Be that way!"
    }
    
    if trimmedMessage == trimmedMessage.uppercased() && trimmedMessage != trimmedMessage.lowercased() {
        if trimmedMessage.hasSuffix("?") {
            return "Calm down, I know what I'm doing!"
        } else {
            return "Whoa, chill out!"
        }
    }
    
    if trimmedMessage.hasSuffix("?") {
        return "Sure."
    }
    
    return "Whatever."

    }
}

/// Exercism 10 :     // Write your code for the 'Etl' exercise in this file.
///
class ETL {
    static func transform(_ old: [String: [String]]) -> [String: Int] {
        var newFormat: [String: Int] = [:]

        for (point, letters) in old {
            for letter in letters {
                newFormat[letter.lowercased()] = Int(point) ?? 0
            }
        }

        return newFormat
    }
}
