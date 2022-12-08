//
//  TabBar.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-05.
//

import SwiftUI

struct TabBar: View {
    //MARK: - Property
    var action: ()  -> Void
    
    //MARK: - Body
    var body: some View {
        ZStack {
            //MARK: - Arc Shape
            Arc()
                .fill(Color.tabBarBackground)
                .frame(height: 88)
                .overlay {
                    // MARK: Arc Border
                    Arc()
                        .stroke(Color.tabBarBorder, lineWidth: 0.5)
                }
            
            //MARK: - Tab Items
            HStack {
                //MARK: - Expand Button
                Button {
                    action()
                    impact.impactOccurred()
                } label: {
                    Image(systemName: "doc.plaintext")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 33, height: 33)
                }
                Spacer()
                //MARK: - List Button(Navigation to weatherView)
                NavigationLink {
                    if #available(iOS 16.0, *) {
                        WeatherView()
                    } else {
                        // Fallback on earlier versions
                    }
                } label: {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 33, height: 33)
                    
                }
            }// HStuck
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
            
        }
        .frame(maxHeight: .infinity,alignment: .bottom)
        .ignoresSafeArea(.all)
    }
}
