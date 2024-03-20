//
//  UITableView+Extension.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        let id = String(describing: cell)
        guard let cell = self.dequeueReusableCell(withIdentifier: id, for: indexPath) as? T else {
            fatalError("fatal error")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cell: T.Type) {
        let name = String(describing: cell)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }
}
