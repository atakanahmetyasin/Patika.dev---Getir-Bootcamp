//April 4 - Office Hour Project (Crazy Birds)
// Grup 1
// Alphan Ogün - Ahmet Yasin Atakan - Abdulrezzak Özdemir - Asya Atpulat - Berfin Kerpiççi

import Foundation

class Launcher {
    var teta: Double
    var speed: Double
    var distance = 0.0
    var g = 10.0
    
    init(teta: Double, speed: Double) {
        guard (0...90).contains(teta) else {
            fatalError("Theta (teta) value must be between 0 and 90 degrees.")
        }
        guard (0...100).contains(speed) else {
            fatalError("Speed value must be between 0 and 100 m/s.")
        }
        self.teta = teta
        self.speed = speed
        let angle = teta * Double.pi / 180
        self.distance = (speed * speed * sin(2 * angle)) / g
    }
}

class Bottle {
    var position: Double
    var delta: Double
    var isStanding: Bool
    
    init(position: Double, delta: Double) {
        guard position >= 0 && position <= 1500 else {
            fatalError("Position must be between 0 and 1500.")
        }
        guard delta >= 0.1 && delta <= 1 else {
            fatalError("Delta must be between 0.1 and 1.")
        }
        
        self.position = position
        self.delta = delta
        self.isStanding = true
    }
    
    func isHit(at distance: Double) -> Bool {
        let lowerBound = position - delta
        let upperBound = position + delta
        
        if distance >= lowerBound && distance <= upperBound {
            isStanding = false
            return true
        } else {
            return false
        }
    }
}

class Player {
    var username: String
    var score = 0 {
        didSet {
            print("Player: \(username) - Hit! Score = \(score)")
        }
    }
    
    init(username: String) {
        self.username = username
    }
    
    func changeUsername(_ username: String) {
        self.username = username
        print("Username has changed, new username: \(username)")
    }
}

class Game {
    var player: Player
    var bottle: Bottle
    var launcher: Launcher
    
    init(player: Player, bottle: Bottle, launcher: Launcher) {
        self.player = player
        self.bottle = bottle
        self.launcher = launcher
    }
    
    func throwBall() {
        print("\(player.username) throws ball at speed: \(launcher.speed), angle: \(launcher.teta) degree.")
        print("Bottle is at position: \(bottle.position)")
        if bottle.isHit(at: launcher.distance) {
            player.score += 1
        } else {
            print("Missed bottle..")
        }
    }
}

var player = Player(username: "Alphan")
var bottle = Bottle(position: 40, delta: 0.5)
var launcher = Launcher(teta: 45, speed: 20)

let game = Game(player: player, bottle: bottle, launcher: launcher)
game.throwBall()
