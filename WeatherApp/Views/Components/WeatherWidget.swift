//
//  WeatherWidget.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-05.
//

import SwiftUI
import WeatherKit
import MapKit


@available(iOS 16.0, *)
struct WeatherWidget: View {
    //MARK: - Property
    var forecast: Forecast

    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: Trapezoid
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 174)
            
            // MARK: Content
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    // MARK: Forecast Temperature
                    Text("\(forecast.temperature)°")
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading, spacing: 2) {

                        // MARK: Forecast Location
                        Text(forecast.location)
                            .font(.body)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    
                    // MARK: Forecast Icon
                    Image(systemName: "\(forecast.icon)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120,height: 120)
                        .padding(.trailing, 24)
                    
                    
                    // MARK: Weather
                    Text(forecast.weather.rawValue)
                        .font(.footnote)
                        .padding(.trailing, 24)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 184, alignment: .bottom)
    }
}
