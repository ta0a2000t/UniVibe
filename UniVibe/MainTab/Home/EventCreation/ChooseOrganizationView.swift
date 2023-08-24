//
//  ChooseOrganizationView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI
struct ChooseOrganizationView: View {
    @ObservedObject var viewModel: ChooseOrganizationViewModel = ChooseOrganizationViewModel()
    @State private var navigateToCreateEvent: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.communities) { community in
                    HStack {
                        Text(community.fullname)
                        Spacer()
                        if viewModel.selectedCommunity?.id == community.id {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedCommunity = community
                    }
                }
            }
            .navigationBarTitle("Choose Organization")
            .navigationBarItems(trailing: Button("Next") {
                navigateToCreateEvent = true
            }
            .disabled(viewModel.selectedCommunity == nil))
            .background(
                // Adjust according to the new recommended navigation method for iOS 16
                NavigationLink(
                    "",
                    destination: CreateEventView(creatorID: "123", isCommunityEvent: true),
                    isActive: $navigateToCreateEvent
                )
                
                
                .hidden()
            )
        }
    }
}


class ChooseOrganizationViewModel: ObservableObject {
    @Published var communities: [Community] = Community.MOCK  // Populate this array with your Community objects
    @Published var selectedCommunity: Community? = nil
    
    
}



struct ChooseOrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOrganizationView()
    }
}
