//
//  ChooseEventTypeView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI

struct ChooseEventTypeView: View {
    // MARK: - Properties
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject var homeViewModel : HomeViewModel

    let userID: String
    
    // MARK: - Body
    var body: some View {
        VStack {

            
            Spacer()
            
            titleSection
            
            Spacer()
            
            personalEventButton
            
            organizationEventButton
            
            Spacer()
            
            cancelButton
        }
    }
}

// MARK: - View Components
private extension ChooseEventTypeView {
    
    var titleSection: some View {
        Text("Choose Event Type")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.purple)
            .padding()
    }
    
    var personalEventButton: some View {
        NavigationLink(destination: CreateEventView(creatorID: userID, isCommunityEvent: false).environmentObject(homeViewModel)) {
            buttonLabel(text: "Personal Event", textColor: .white, backgroundColor: .purple)
        }.environmentObject(homeViewModel)
    }
    
    var organizationEventButton: some View {
        NavigationLink(destination: ChooseOrganizationView().environmentObject(homeViewModel)) {
            buttonLabel(text: "Organization Event", textColor: .purple)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.purple)
                )
        }.environmentObject(homeViewModel)
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            homeViewModel.isCreatingEvent = false
            presentationMode.wrappedValue.dismiss()
        }
        .foregroundColor(.purple)
        .padding()
    }
    
    func buttonLabel(text: String, textColor: Color, backgroundColor: Color = .clear) -> some View {
        Text(text)
            .font(.headline)
            .foregroundColor(textColor)
            .frame(width: 200, height: 50)
            .background(backgroundColor)
            .cornerRadius(25)
            .padding()
    }
}

// MARK: - Preview
struct ChooseEventTypeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ChooseEventTypeView(userID: "sampleUserID")
        }
    }
}
