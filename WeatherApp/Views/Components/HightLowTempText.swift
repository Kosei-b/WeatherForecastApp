//
//  HightLowTempText.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-15.
//

import SwiftUI


struct HightLowTempText: View {
    //MARK: - Property
    var date: Date
    var HighTemp: String
    var LowTemp: String
    
    var isActive: Bool {
        if date.formatAsAbbreviatedDateIsActiveDay() == Date().formatAsAbbreviatedDateIsActiveDay(){
            return true
        } else {
            return false
        }
    }
    //MARK: - Body
    var body: some View {
        Text(isActive ?   "H:\(HighTemp)°   L:\(LowTemp)°" : "")
    }
}
