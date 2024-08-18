//
//  ContentView.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import SwiftUI

final class ViewModel: ObservableObject {
    private let apiService: APIService
    private var page = 0
    @Published var catsArray: [Cat] = []
    @Published var searchTerm = ""
    
    var filteredCatsArray: [Cat] {
        guard !searchTerm.isEmpty else { return catsArray }
        return catsArray.filter{$0.name.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    func isLastCat(id: String) -> Bool {
        return catsArray.last?.id == id ? true : false
    }
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchCats() async {
        catsArray.append(contentsOf: await apiService.fetchImages(.thumb, page: page, limit: 25))
        page += 1
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    private let columns = [ GridItem(.adaptive(minimum: 100)) ]
    
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.filteredCatsArray, id: \.id) { cat in
                            CatView(cat: cat)
                                .onAppear {
                                    if viewModel.isLastCat(id: cat.id) {
                                        print("LAST CAT")
                                        Task {
                                            await viewModel.fetchCats()
                                        }
                                    }
                                }
                        }
                    }
                    .searchable(text: $viewModel.searchTerm, prompt: "Search Breeds")
                    
                } .padding()
            }
            .padding()
            .task {
                await viewModel.fetchCats()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
