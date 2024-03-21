//
//  WeatherInfoTableViewCell.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 21/03/2024.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {
    
    private let weatherView: WeatherInfoView = {
        let view = WeatherInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configure(with data: Weather?) {
        addSubview(weatherView)
        
        NSLayoutConstraint.activate([
            weatherView.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherView.topAnchor.constraint(equalTo: topAnchor),
            weatherView.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        if let data {
            weatherView.configure(weather: data)
        }
    }
    
    override func prepareForReuse() {
        weatherView.prepareForReuse()
    }
}
