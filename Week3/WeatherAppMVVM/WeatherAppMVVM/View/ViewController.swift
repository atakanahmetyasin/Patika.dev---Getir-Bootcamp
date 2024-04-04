//
//  ViewController.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//
/*
 Tek ekran olacak.
 Kendi konumumu alacağım.
 
 
 */

import UIKit
import Kingfisher
import CoreLocation

final class ViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    private let viewModel = WeatherViewModel(service: NetworkManager())

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.setupUI()
        }
        getCurrentLocation()
        weatherTableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        viewModel.reloadDataDelegate = { [weak self] in
            DispatchQueue.main.async {
                self?.weatherTableView.reloadData()
            }
        }
    }
    
    // MARK: HELPERS
    
    private func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global(qos: .background).async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    private func setupUI() {
        cityLabel.text = viewModel.weatherModel?.location.name ?? "no data"
        temperatureLabel.text = "\(viewModel.weatherModel?.current.tempC ?? 0)°"
        conditionLabel.text = viewModel.weatherModel?.current.condition.text
        maxTemp.text = "H: \(viewModel.forecastArray.first?.day.maxtempC ?? 0)°"
        minTemp.text = "L: \(viewModel.forecastArray.first?.day.mintempC ?? 0)°"
        weatherImageView.downloadImageKingFisher(urlString: "https:\(viewModel.weatherModel?.current.condition.icon ?? "")" )
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.forecastArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        let forecast = viewModel.forecastArray[indexPath.row]
        cell.getWeatherOutput(date: forecast.date,
                              minTemp: (forecast.day.mintempC),
                              maxTemp: (forecast.day.maxtempC),
                              icon: "https:\(forecast.day.condition.icon)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        viewModel.getWeatherData(latitude: location.latitude, longitude: location.longitude)
    }
}
