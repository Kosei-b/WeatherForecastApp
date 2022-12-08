//
//  HourForecastCard.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-09.
//

import SwiftUI
import WeatherKit

@available(iOS 16.0, *)
struct HourForecastCard: View {
    
    //MARK: - Property
    var forecastImgName: String
    var forecastTemp: String
    var precipitationChance: Double
    var date: Date
    
    var isActive: Bool {
        if date.formatAsAbbreviatedDateIsActiveTime() == Date().formatAsAbbreviatedDateIsActiveTime(){
            return true
        } else {
            return false
        }
    }

    //MARK: - Body
    var body: some View {
            ZStack {
                // MARK: Card
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                    .frame(width: 60, height: 146)
                    .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                    .overlay {
                        // MARK: Card Border
                        RoundedRectangle(cornerRadius: 18)
                            .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                            .blendMode(.overlay)
                    }
                    .innerShadow(shape: RoundedRectangle(cornerRadius: 18), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
                
                // MARK: Content
                VStack(spacing: 16) {
                    // MARK: Forecast Date
                    Text(isActive ? "Now" :  date.formatAsAbbreviatedTime())
                        .font(.subheadline.weight(.semibold))
                    VStack(spacing: -4) {
                        // MARK: Forecast Small Icon
                        Image(systemName: forecastImgName)
                            .font(.system(size: 25))
                        // MARK: Forecast Probability
                        Text(precipitationChance, format: .percent)
                            .font(.footnote.weight(.semibold))
                            .foregroundColor(Color.probabilityText)
                            .opacity(precipitationChance > 0.15 ? 1 : 0)
                    }
                    .frame(height: 42)
                    // MARK: Forecast Temperture
                    Text("\(forecastTemp)°")
                        .font(.system(size: 15))
                }//: VStack
            }//: ZStack
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 60, height: 146)
    }//: Body
}
