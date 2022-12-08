//
//  HomeView.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-05.
//

import SwiftUI
import BottomSheet
import CoreLocation
import WeatherKit
import MapKit


//MARK: - HomeVeiw
@available(iOS 16.0, *)
struct HomeView: View {
    
    //MARK: - Property
    //: Weather Property
    @StateObject private var locationManager = LocationManager()
    @State private var weather: Weather?
    let weatherService = WeatherService.shared
    @State var currentWeather: CurrentWeather?
    @State var hourWeathers: [HourWeather] = []
    @State var dayWeathers: [DayWeather] = []
    
    //: Reverce Geocording
    @State var cityName: String

    //: UI Property
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString(String(currentWeather?.temperature.value ?? 0.0) + "°" + (hasDragged ?" | " + String(currentWeather?.condition.description ?? "")  : "\n "))
        
        if let temp = string.range(of: String(currentWeather?.temperature.value ?? 0.0) + "°"){
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .regular)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | "){
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: String(currentWeather?.condition.description ?? "")){
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        return string
    }
    
    //MARK: - Regeocoding
    func regeocoding(lat: CLLocationDegrees,long: CLLocationDegrees){
        let location = CLLocation(latitude: lat, longitude: long)
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if let city = placemarks?.first?.locality {
                    self.cityName = city
                }
        }
    }//: regeocoding func
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                let imageOacity = bottomSheetTranslationProrated  * 3
                
                ZStack {
                    //MARK: - BackGround Color
                    Color.background
                        .ignoresSafeArea(.all)
                    
                    //MARK: - Weather Icon
                    Image(systemName: currentWeather?.symbolName ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 133,height: 133)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 293)
                        .opacity(1 - imageOacity)
                        .animation(.easeInOut)
                        .shadow(radius: 10)
                    
                    //MARK: - Weather Info (Text)
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)){
                        //: City Name
                        Text(cityName)
                            .font(.largeTitle)
                        //: weather Discription
                        VStack {
                            Text(attributedString)
                            VStack {
                                Text(String(currentWeather?.condition.description ?? ""))
                                //Hight & Low Temp Data
                                ForEach(dayWeathers, id: \.self.date) { dayForecast in
                                    HightLowTempText(date: dayForecast.date, HighTemp: String(dayForecast.highTemperature.value), LowTemp: String(dayForecast.lowTemperature.value))
                                }//: ForEach
                            }
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.secondary)
                            .opacity(1 - bottomSheetTranslationProrated)
                        }
                        Spacer()
                    }// VStuck
                    .padding(.top,51)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    
                    //MARK: - Bottom Sheet View
                    BottomSheetView(position: $bottomSheetPosition) {
                    } content: {
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut) {
                            if bottomSheetPosition == BottomSheetPosition.top {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                    }
                    //MARK: - Tab bar
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                    
                }// Geomrtry
            }// NavigationView
            .navigationBarHidden(true)
            .task(id: locationManager.currentLocation) {
                do {
                    if let location = locationManager.currentLocation {
                        let weather = try await weatherService.weather(for: location)
                        currentWeather = weather.currentWeather
                        
                        let hourlyForecast = try await weatherService.weather(for: location, including: .hourly)
                        hourWeathers = hourlyForecast.forecast
                        
                        let dailyForecast = try await weatherService.weather(for: location, including: .daily)
                        dayWeathers = dailyForecast.forecast
                        
                       //MARK: - Do Regoecording()
                        regeocoding(lat: location.coordinate.latitude, long: location.coordinate.longitude)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }// ZStuck
    }// Body
}
