//
//  MainView.swift
//  Sword
//
//  Created by Bruno Silva on 19/08/2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var coreDataManager = CoreDataManager()
    
    var body: some View {
        TabView {
            ContentView()
                .environmentObject(coreDataManager)
                .tabItem {
                    Label("Menu 1", systemImage: "menubar.rectangle")
                }
            
            FavouritesGridView()
                .environmentObject(coreDataManager)
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
