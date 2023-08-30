
//
//  SelectCommunitiesView.swift
//  UniVibe
//
//  Created by Taha Al on 8/29/23.
//

import SwiftUI

struct SelectCommunitiesView: View {
    @ObservedObject var viewModel: SelectCommunitiesViewModel
    @Environment(\.colorScheme) var colorScheme

    init(communitiesIDs: Binding<Set<String>>) {
        // Initialize the viewModel with the Binding
        self.viewModel = SelectCommunitiesViewModel(communitiesIDs: communitiesIDs)
    }

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.communities) { community in
                    CommunityItemView(
                        community: community,
                        isSelected: viewModel.selectedCommunities.contains(community.id)
                    )
                    .listRowBackground(ColorUtilities.dynamicBackgroundColor(for: colorScheme).opacity(0.5))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.toggleCommunitySelection(community: community)
                    }
                }
            }
            .padding(.top)
            .listStyle(.plain)
            .navigationBarTitle("Choose Organization")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        // Handle navigation here
                    } label: {
                        Text("Next")
                    }.disabled(viewModel.selectedCommunities.isEmpty)
                }
            }
            .linearGradientBackground()
        }
    }
}

class SelectCommunitiesViewModel: ObservableObject {
    @Published var communities: [Community] // Initialize this as you like
    @Published var selectedCommunities: Set<String> {
        didSet {
            // Update the external communitiesIDs whenever selectedCommunities changes
            self._communitiesIDs.wrappedValue = selectedCommunities
        }
    }

    private var _communitiesIDs: Binding<Set<String>>

    init(communitiesIDs: Binding<Set<String>>) {
        self._communitiesIDs = communitiesIDs
        // Initialize selectedCommunities from the external Binding
        self.selectedCommunities = communitiesIDs.wrappedValue
        self.communities = DataRepository.shared.communities // Initialize your communities here
    }

    func toggleCommunitySelection(community: Community) {
        if selectedCommunities.contains(community.id) {
            selectedCommunities.remove(community.id)
        } else {
            selectedCommunities.insert(community.id)
        }
    }
}

struct SelectCommunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCommunitiesView(communitiesIDs: .constant(Set<String>()))
    }
}
