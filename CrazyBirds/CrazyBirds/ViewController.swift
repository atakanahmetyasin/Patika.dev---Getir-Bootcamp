//
//  ViewController.swift
//  CrazyBirds
//
//  Created by Ahmet Yasin Atakan on 28.03.2024.
//

import UIKit

struct BallThrower {
    let angle: Int
    let speed: Int
}

struct Player {
    let userName: String
    let score: Int
    
    init(name: String, score: Int) {
        self.userName = name
        self.score = score
    }
    
    func showInfo() {
        print("Player: \(userName), score: \(score)")
    }
}
struct Game {
    let player: Player
    let ballThrower: BallThrower
    let bottle: Bool
}

struct Alert {
    static func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        ViewController().present(alert, animated: true)
    }
}

protocol Functions {
    func getName() -> String?
    func getBottleLocation() -> (Int, Int)?
    func getAngleAndSpeed() -> (Int, Int)?
    func ballDidThrow()
}

final class ViewController: UIViewController {
    var isBallDidThrow: Bool = false
    var isBottleDidHit: Bool = false
    var playerScore = 0
    
//    private let nameTF: UITextField = {
//      let tf = UITextField()
//        tf.placeholder = "Please enter your name"
//        tf.font = UIFont.systemFont(ofSize: 12, weight: .medium)
//
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
    lazy var startButton: UIButton = {
       let button = UIButton()
        button.setTitle("Start Game", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    @objc func startDidTap() {
      
    }
    
    private func addViews() {
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 120),
            startButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
}


extension ViewController: Functions {
    
    func getName() -> String? {
        print("Please enter your name: ")
        if let name = readLine() {
            return name
        }
        else {
            return "Guest"
        }
    }
    
    func getBottleLocation() -> (Int, Int)? {
        print("Please enter the x location")
        if let xLocationStr = readLine(), let xLocation = Int(xLocationStr) {
            print("Please enter the y location")
            if let yLocationStr = readLine(), let yLocation = Int(yLocationStr) {
                return (xLocation,yLocation)
            }
            else {
                Alert.showAlert(message: "Invalid y Location")
                return nil
            }
        }
        else {
            Alert.showAlert(message: "Invalid x Location")
            return nil
        }
    }
    
    func getAngleAndSpeed() -> (Int, Int)? {
        print("Please enter angle: ")
        if let angleStr = readLine(), let angle = Int(angleStr) {
            print("Please enter speed: ")
            if let speedStr = readLine(), let speed = Int(speedStr) {
               return (angle, speed)
            }
            else {
                Alert.showAlert(message: "Invalid speed declaration")
                return nil
            }
        }
        else {
            Alert.showAlert(message: "Invalid angle declaration")
            return nil
        }
    }
    
    func ballDidThrow() {
        if isBallDidThrow {
            if isBottleDidHit {
                playerScore += 1
            }
        }
    }
}
