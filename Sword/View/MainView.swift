//
//  MainView.swift
//  Sword
//
//  Created by Bruno Silva on 19/08/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu 1", systemImage: "menubar.rectangle")
                }
            
            FavouritesGridView()
                .tabItem {
                    Label("Menu 2", systemImage: "menubar.rectangle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
