//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 20/03/2024.
//

import UIKit

class WeatherInfoView: UIView {
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 64, weight: .semibold)
        return label
    }()
    
    private let weatherDescriptionLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let weatherDescriptionLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(cityNameLabel)
        addSubview(temperatureLabel)
        addSubview(weatherDescriptionLabel1)
        addSubview(weatherDescriptionLabel2)
        addSubview(weatherIconImageView)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel1.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel2.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            temperatureLabel.leadingAnchor.constraint(equalTo: cityNameLabel.leadingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            
            weatherDescriptionLabel1.leadingAnchor.constraint(equalTo: cityNameLabel.leadingAnchor),
            weatherDescriptionLabel1.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            
            weatherDescriptionLabel2.leadingAnchor.constraint(equalTo: cityNameLabel.leadingAnchor),
            weatherDescriptionLabel2.topAnchor.constraint(equalTo: weatherDescriptionLabel1.bottomAnchor, constant: 5),
            
            weatherIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 150),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        let heightConstraint = heightAnchor.constraint(equalToConstant: 200)
        heightConstraint.isActive = true
    }
    
    func configure(weather: Weather) {
        cityNameLabel.text = weather.name
        temperatureLabel.text = weather.main?.temperature?.kelvinToCelsiusString ?? ""
        weatherDescriptionLabel1.text = "Max temperature: \(weather.main?.tempMax?.kelvinToCelsiusString ?? "")"
        weatherDescriptionLabel2.text = "Min temperature: \(weather.main?.tempMin?.kelvinToCelsiusString ?? "")"
        weatherIconImageView.image = UIImage(named: weather.details.first?.icon ?? Asset.Assets.Weather._01n.name)
    }
    
    func prepareForReuse() {
        cityNameLabel.text = nil
        temperatureLabel.text = nil
        weatherDescriptionLabel1.text = nil
        weatherDescriptionLabel2.text = nil
        weatherIconImageView.image = nil
    }
}
