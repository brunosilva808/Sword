//
//  ContentView.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import SwiftUI

final class CatsGridViewModel: ObservableObject {
    private let apiService: APIService
    private (set) var page = 0
    @Published var catsArray: [Cat] = []
    @Published var searchTerm = ""
    
    var isLoading = false
    
    var filteredCatsArray: [Cat] {
        guard !searchTerm.isEmpty else { return catsArray }
        return catsArray.filter{$0.breedName.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    func isLastCat(id: String) -> Bool {
        return catsArray.last?.id == id ? true : false
    }
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchCats() async {
        if !isLoading {
            isLoading = true
            let array = await apiService.fetchImages(.thumb, page: page, limit: 25)
            catsArray.append(contentsOf: array)
            page += 1
            isLoading = false
        }
    }
}

struct CatsGridView: View {
    
    @StateObject var viewModel = CatsGridViewModel()
    @EnvironmentObject var coreDataManager: CoreDataManager
    private let columns = [ GridItem(.adaptive(minimum: 100)) ]
    
    var body: some View {
        NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.filteredCatsArray, id: \.id) { cat in
                            NavigationLink(destination: DetailView(cat: cat).environmentObject(coreDataManager)) {
                                CatView(cat: cat)
                                    .environmentObject(coreDataManager)
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
                    .searchable(text: $viewModel.searchTerm, prompt: "Search Breeds")
                } .padding()
            .task {
                await viewModel.fetchCats()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatsGridView()
    }
}
