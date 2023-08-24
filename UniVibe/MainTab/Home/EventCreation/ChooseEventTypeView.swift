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
    let creatorID: String
    
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
        .navigationBarHidden(true)
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
        NavigationLink(destination: CreateEventView(creatorID: creatorID, isCommunityEvent: false)) {
            buttonLabel(text: "Personal Event", textColor: .white, backgroundColor: .purple)
        }
    }
    
    var organizationEventButton: some View {
        NavigationLink(destination: ChooseOrganizationView()) {
            buttonLabel(text: "Organization Event", textColor: .purple)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.purple)
                )
        }
    }
    
    var cancelButton: some View {
        Button("Cancel") {
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
            ChooseEventTypeView(creatorID: "sampleUserID")
        }
    }
}
