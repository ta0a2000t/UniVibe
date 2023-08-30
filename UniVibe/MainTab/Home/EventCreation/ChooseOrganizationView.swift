//
//  ChooseOrganizationView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI

struct ChooseOrganizationView: View {
    @StateObject var viewModel: ChooseOrganizationViewModel = ChooseOrganizationViewModel(communities: CurrentUserViewModel.shared.getOrganizingCommunities())
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var homeViewModel : HomeViewModel

    var body: some View {
        VStack{
            List {
                ForEach(viewModel.communities) { community in
                    CommunityItemView(community: community, isSelected: viewModel.isSelected(community))
                        .listRowBackground(ColorUtilities.dynamicBackgroundColor(for: colorScheme).opacity(0.5))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.selectCommunity(community)
                        }
                }
            }
            .padding(.top)
            .listStyle(.plain)
            .navigationBarTitle("Choose Organization")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        if let community = viewModel.selectedCommunity {
                            CreateEventView(creatorID: community.id, isCommunityEvent: true).environmentObject(homeViewModel)
                        }
                    } label: {
                        Text("Next")
                    }
                    .environmentObject(homeViewModel)
                    .disabled(viewModel.isNextButtonDisabled)
                }
            }
            .linearGradientBackground()
        }
    }
}



class ChooseOrganizationViewModel: ObservableObject {
    @Published var communities: [Community]
    @Published var selectedCommunity: Community? = nil
    
    init(communities: [Community]) {
        self.communities = communities
    }
    
    func selectCommunity(_ community: Community) {
        self.selectedCommunity = community
    }
    
    func isSelected(_ community: Community) -> Bool {
        return selectedCommunity?.id == community.id
    }
    
    var isNextButtonDisabled: Bool {
        return selectedCommunity == nil
    }
}


struct CommunityItemView: View {
    var community: Community
    var isSelected: Bool

    var body: some View {
        ZStack{
            HStack(spacing: 16) {
                // Profile image with a default placeholder
                if let url = community.profileImageURL, let imageURL = URL(string: url) {
                    // Assuming you have a RemoteImage view that takes a URL
                    Image("zuckerberg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                } else {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(community.fullname)
                        .font(.headline)
                    Text(community.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    Text("\(community.membersIDs.count) Members")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 8)
        
        }
    }
}



struct ChooseOrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChooseOrganizationView()
        }
    }
}
