//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-09-30.
//

import SwiftUI
import WeatherKit

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                ContentView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
