//
//  CatGridView.swift
//  Sword
//
//  Created by Bruno Silva on 29/08/2024.
//

import SwiftUI

struct CatGridView: View {
    
    @StateObject var viewModel = CatsGridViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.catsArray) { cat in
                        VStack {
                            CatRowView(cat: cat)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchCats()
            }
            .navigationTitle("Cats: \(viewModel.page)")
        }
    }
}

struct CatGridView_Previews: PreviewProvider {
    static var previews: some View {
        CatGridView()
    }
}
