//
//  InterestSelectionView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI

struct InterestSelectionView: View {
    @Environment(\.colorScheme) private var colorScheme

    let interestsCategories: MyCategories = DataRepository.shared.getGoalsCategories()
    //DataRepository.shared.getInterestsCategories()


    @State private var searchText: String = ""
    @Binding var selectedInterests: Set<String>
    
    
    var filteredInterests: [String] {
        let allInterests = interestsCategories.allCategoriesCombined()
        return allInterests.filter {
            searchText.isEmpty || $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    
    var body: some View {
        VStack{
            
            SectionAndSelectionsView(
                title: "Selected",
                selections: Binding<[String]>(
                    get: { Array(self.selectedInterests) },
                    set: { self.selectedInterests = Set($0) }
                )
            ).padding(.vertical, 50).padding(.horizontal, 24)
            
            
            TextField("Search for interests", text: $searchText)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            List {
                ForEach(interestsCategories.getCategoryNames().sorted(), id: \.self) { categoryTitle in
                    let interests = interestsFor(category: categoryTitle)
                    if !interests.isEmpty {
                        Section(header: Text(categoryTitle)) {
                            ForEach(interests.sorted(), id: \.self) { interest in
                                Button(action: {
                                    toggleInterestSelection(for: interest)
                                }) {
                                    HStack {
                                        Text(interest)
                                        Spacer()
                                        if selectedInterests.contains(interest) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }.listRowBackground(Color(.systemBackground).opacity(0.5))
                            }
                        }
                    }
                }

            }.listStyle(.plain)
            
            .navigationBarTitle("Interests")

            
        }.linearGradientBackground()

        
    }
    /*
    var filteredInterests: [String] {
        predefinedInterests.filter { searchText.isEmpty ? true : $0.lowercased().contains(searchText.lowercased()) }
    }
    */
    
    private func interestsFor(category: String) -> [String] {
        let categoryArray = interestsCategories.getCategoryArrayByName(name: category)
        
        if searchText.isEmpty {
            return categoryArray
        } else {
            return categoryArray.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private func toggleInterestSelection(for interest: String) {
        if selectedInterests.contains(interest) {
            selectedInterests.remove(interest)
        } else {
            selectedInterests.insert(interest)
        }
    }
    
}


struct InterestSelectionView_Previews0: View {
    @State var lst : Set<String> = []
    var body: some View {
            InterestSelectionView(selectedInterests: $lst)
        
    }
}


struct InterestSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InterestSelectionView_Previews0()
        }
    }
}
