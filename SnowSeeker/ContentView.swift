//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Yuri Gerasimchuk on 28.07.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

enum SortMethod {
    case none, alphabetical, country
}

struct ContentView: View {
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var isShowingConfirmationDialog = false
    @State private var sort = SortMethod.none
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                        )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button {
                    isShowingConfirmationDialog = true
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            .confirmationDialog("Sort by", isPresented: $isShowingConfirmationDialog) {
                Button("Default") { sort = .none }
                Button("By name") { sort = .alphabetical }
                Button("By country") { sort = .country }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
//        .phoneOnlyStackNavigationView()
        
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var sortedResorts: [Resort] {
        switch sort {
        case .none:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
