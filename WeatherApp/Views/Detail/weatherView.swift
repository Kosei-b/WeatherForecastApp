//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-05.
//

import SwiftUI
import MapKit
import WeatherKit

@available(iOS 16.0, *)
struct WeatherView: View {
    
    //MARK: - Property
    @State private var searchText = ""
   
    var searchResults: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            // MARK: Background
            Color.background
                .ignoresSafeArea()
            // MARK: Weather Widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResults) { forecast in
                        if #available(iOS 16.0, *) {
                            WeatherWidget(forecast: forecast)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                
            }//scroll View
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }//: ZStuck
        .overlay {
            // MARK: Navigation Bar
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
    }
}
