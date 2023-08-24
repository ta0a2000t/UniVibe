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
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        List {
            ForEach(viewModel.communities) { community in
                CommunityItemView(community: community, isSelected: viewModel.selectedCommunity?.id == community.id)
                    .listRowBackground(ColorUtilities.dynamicBackgroundColor(for: colorScheme).opacity(0.5))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedCommunity = community
                    }
            }
        }.padding(.top)
        .listStyle(.plain)
        .navigationBarTitle("Choose Organization")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                
                NavigationLink {
                    if let community = viewModel.selectedCommunity {
                        CreateEventView(creatorID: community.id, isCommunityEvent: true)
                    }
                    
                } label: {
                    Text("Next")
                }.disabled(viewModel.selectedCommunity == nil)
            }
        }
        
        .linearGradientBackground()
        
    }
}


class ChooseOrganizationViewModel: ObservableObject {
    @Published var communities: [Community] = Community.MOCK  // Populate this array with your Community objects
    @Published var selectedCommunity: Community? = nil
    
    
}

struct CommunityItemView: View {
    var community: Community
    var isSelected: Bool
    
    var body: some View {
        ZStack{
            
            
            NavigationLink {
                CreateEventView(creatorID: community.id, isCommunityEvent: true)
            } label: {
                EmptyView()
            }.opacity(0)
            
            
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
