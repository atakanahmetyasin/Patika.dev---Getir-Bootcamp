//
//  WeatherTableViewCell.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 4.04.2024.
//

import UIKit

class WeatherTableViewCell: UITableViewCell, NetworkManagerOutputProtocol {
    func getWeatherOutput(date: String, minTemp: Double, maxTemp: Double, icon: String) {
        dayLabel.text = date
        weatherImageView.downloadImageKingFisher(urlString: icon)
        minTempLabel.text = "\(minTemp)"
        maxTempLabel.text = "\(maxTemp)"
    }
    
    static let identifier = "WeatherTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
