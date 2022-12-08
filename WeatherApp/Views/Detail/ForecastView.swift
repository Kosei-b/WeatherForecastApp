//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-05.
//

import SwiftUI
import MapKit
import WeatherKit


@available(iOS 16.0, *)
struct ForecastView: View {
    
    //MARK: - Property
    @State private var selection = 0
    var bottomSheetTranslationProrated: CGFloat = 1
    @State var hourWeathers: [HourWeather] = []
    @State var dayWeathers: [DayWeather] = []
    @State var currentWeather: CurrentWeather?
    @StateObject private var locationManager = LocationManager()
    @State private var weather: Weather?
    let weatherService = WeatherService.shared
    
    //MARK: - Handle 24Hours Hour Weather List Date
    var now24: Int {
        let now12: String = Date().formatAsAbbreviatedTimeNow()// ooPM
        let now: Int
        if now12.hasSuffix("PM"){
            now = Int(now12.dropLast(2)) ?? 0
            return now + 12
        } else {
            now = Int(now12.dropLast(2)) ?? 0
            return now
        }
    }
    
    var dropInt: Int {
        let nowInt = now24
        if nowInt == 22 {
            return 0
        } else if nowInt == 23 {
            return 1
        } else if nowInt == 24 {
            return 2
        } else {
           return 2 + nowInt
        }
    }
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                //MARK: - SegmentedControl
                SegmentedControl(selection: $selection)
                // MARK: Forecast Cards
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        if selection == 0 {
                            //MARK: - Hourly-ForecastCard
                            ForEach(hourWeathers.dropFirst(dropInt).prefix(24), id: \.self.date) { hourForecast in
                                HourForecastCard(forecastImgName: "\(hourForecast.symbolName)", forecastTemp: String(hourForecast.temperature.value), precipitationChance: hourForecast.precipitationChance, date: hourForecast.date)
                            }//: ForEach selection = 0
                        } else {
                            //MARK: - 10-Day ForecastCard
                            ForEach(dayWeathers, id: \.self.date) { dayForecast in
                                DayForecastCard(forecastImgName: "\(dayForecast.symbolName)", forecastHightTemp: String(dayForecast.highTemperature.value), forecastLowTemp: String(dayForecast.precipitationChance), precipitationChance: dayForecast.precipitationChance, date: dayForecast.date)
                            }//: ForEach selection = 1
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
                
                // MARK: Forecast Widgets
                Image("Forecast Widgets")
                    .opacity(bottomSheetTranslationProrated)
            }
            .task(id: locationManager.currentLocation) {
                do {
                    if let location = locationManager.currentLocation {
                        
                        let weather = try await weatherService.weather(for: location)
                        currentWeather = weather.currentWeather
                        
                        let dailyForecast = try await weatherService.weather(for: location, including: .daily)
                        dayWeathers = dailyForecast.forecast
                        
                        let hourlyForecast = try await weatherService.weather(for: location, including: .hourly)
                        hourWeathers = hourlyForecast.forecast
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
        }// Scroll View
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            //MARK: - Bottom Sheet Separater
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity,alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            // MARK: Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }// body
}
