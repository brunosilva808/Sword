//
//  ImageGridView.swift
//  Sword
//
//  Created by Bruno Silva on 28/08/2024.
//

import SwiftUI

struct ImageGridView: View {
    
    @StateObject var viewModel = CatsGridViewModel()
    private let columns = [ GridItem(.adaptive(minimum: 100)) ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.catsArray) { cat in
                    ImageLoadView(urlString: cat.url)
                        .frame(minWidth: 100, minHeight: 100)
                        .onAppear {
                            if viewModel.isLastCat(id: cat.id) {
                                Task {
                                    await viewModel.fetchCats()
                                }
                            }
                        }
                }
            }
        }
        .task {
            await viewModel.fetchCats()
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView()
    }
}
