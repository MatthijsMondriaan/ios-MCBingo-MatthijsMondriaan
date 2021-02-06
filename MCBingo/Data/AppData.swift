//
//  AppData.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 06/02/2021.
//

import UIKit

class AppData {
    
    static let shared = AppData()
    static let defaults = UserDefaults(suiteName: "general")

    private init() {}
    
    let onChange = Event<Void>(queue: .main)
    
    var welcome: Welcome? {
        get { return AppData.defaults?.get(forKey: "welcome", decodable: Welcome.self) ?? nil }
        set {
            if newValue != nil {
                try? AppData.defaults?.set(forKey: "welcome", encodable: newValue)
            } else {
                AppData.defaults?.set(nil, forKey: "welcome")
            }
            onChange.emit()
        }
    }
}
