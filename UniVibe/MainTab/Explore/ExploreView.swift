//
//  ExploreView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//


import SwiftUI
// TODO add a Picker view, to choose between community & individual posts.
struct ExploreView: View {
    @State private var searchText: String = ""
    let searchTypesIndices = [0, 1, 2]
    @State private var selectedSearchTypeIdx : Int
    
    //@EnvironmentObject private var viewModel: UserViewModel

    @StateObject var exploreViewModel = ExploreViewModel()
    
    let communities: [Community] = Community.MOCK


    init() {
        selectedSearchTypeIdx = searchTypesIndices[0]
        
    }

    var body: some View {
        
        NavigationStack {
            VStack {

                Picker("Search Type", selection: $selectedSearchTypeIdx) {
                    ForEach(searchTypesIndices, id: \.self) { index in
                        if(index == 0) {
                            Text("All")
                        } else if (index == 1) {
                            Image(systemName: "person.3.fill")
                        } else {
                            Image(systemName: "person.fill")
                        }
                    }
                }
                .pickerStyle(.segmented)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(searchResults, id: \.id) { item in
                            if let community = item as? Community {
                                NavigationLink(destination: CommunityProfileView(community: community).navigationBarBackButtonHidden(true)) {
                                    CommunityInListView(community: community)
                                }
                            } else if let user = item as? User {
                                NavigationLink(destination: UserProfileView(user: user).navigationBarBackButtonHidden(true)) {
                                    UserInListView(user: user)
                                }
                            }
                        }
                    }

                    .padding(.top, 8)
                    .searchable(text: $searchText, prompt: "Search...") {
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("univibe_logo").resizable().scaledToFit().frame(height: 35).padding()
                    }
                }
            }
        }
    }
    
    
    
    var searchResults: [SearchResultItemProtocol] {
        let users = exploreViewModel.users

        func getItemsInList() -> [SearchResultItemProtocol] {
            if selectedSearchTypeIdx == 0 {
                return communities + users
            } else if selectedSearchTypeIdx == 1 {
                return communities
            } else {
                return users
            }
        }
        
        if searchText.isEmpty {
            return getItemsInList()
        } else {
            return getItemsInList()
                .filter { item in
                    item.fullname.lowercased().contains(searchText.lowercased())
                }
        }
    }
    
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
