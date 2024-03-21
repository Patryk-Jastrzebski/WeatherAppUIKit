//
//  Debouncable.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 21/03/2024.
//

import Foundation

protocol Debouncable: AnyObject {
    var searchWorkItem: DispatchWorkItem? { get set }
}

extension Debouncable {
    func debounceWith(completion: @escaping () -> Void) {
        searchWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            completion()
        }
        self.searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
    }
}
