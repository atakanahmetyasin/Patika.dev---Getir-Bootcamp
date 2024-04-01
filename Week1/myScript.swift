#!/usr/bin/env swift
import Foundation
print("Merhaba, Getir!, Swift Bootcamp")
//var users = ["sinem", "rezzak", "merve", "ahmet", "ecem"]


/*if users.contains("") {
         print("Error, there is an empty user name")
}else {
          for user in users {
  print(user.capitalized)
}
}*/

print("Enter your name:")
var name = readLine(strippingNewline: true)
print("Hello \(name ?? "anonymous")")

// userların tüm harflerini büyütüp Z'Den A'ya sıralı olacak şekilde yazınız.

