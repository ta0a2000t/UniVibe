//
//  CreateCommunityView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI
import PhotosUI

struct CreateCommunityView: View {
    
    // MARK: - State and Environment Variables
    @Environment(\.dismiss) var dismiss
    @State var selectedImagePickerItem: PhotosPickerItem?
    let defaultImage = Image(systemName: "person.3.fill")
    @State var showConfirmationAlert = false
    @State var showCreationSuccessAlert = false
    @State var showCreationFailedAlert = false
    
    @State var fullname = ""
    @State var email = ""
    @State var description = ""
    
    @State var interests : Set<String> = []

    
    @ObservedObject var currentUserViewModel = CurrentUserViewModel.shared
    
    var body: some View {
        
            ScrollView(.vertical){
                EditableImageView(selectedImagePickerItem: $selectedImagePickerItem, currImage: defaultImage)
                    
                    
                    
                    VStack(alignment: .center, spacing: 20) {
                        Section(header: Text("Community Info")
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 10)
                        ) {
                            EditProfileRowView(title: "Name", placeholder: "Enter Community Name", text: $fullname)
                            
                            
                            EditProfileRowView(title: "Enter your email", placeholder: "Enter Community Email", text: $email)
                                .textInputAutocapitalization(.never).keyboardType(.emailAddress)
                            
                            EditProfileMultiLineView(title: "Description", placeholder: "Describe The Community", text: $description)
                            



                            
                            
                            SectionAndSelectionsView(
                                title: "Interests",
                                selections: Binding<[String]>(
                                    get: { Array(self.interests) },
                                    set: { self.interests = Set($0) }
                                )
                            ).padding(.top, 50)
                            
                            NavigationLink(destination: InterestSelectionView(selectedInterests: $interests)) {
                                

                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                            .imageScale(.large)
                                        Text("Select Interests")
                                            .font(.headline)
                                    }
                                    .padding()
                                    .frame(width: 220, height: 60)
                                    .cornerRadius(15.0)
                            }

                        
                        
                        }
                        
                    }
                    .padding(.horizontal, 24)
                    Spacer()
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            createButtonClicked()
                        } label: {
                            Text("Create").bold()
                        }.disabled(fullname.isEmpty || description.isEmpty)//.buttonStyle(GrowingButton(enabledColor: .green))
                        
                    }
                    ToolbarItem(placement: .principal) {

                        HStack {
                            Text("Create Community").bold()
                            Image(systemName: "square.and.pencil")
                        }
                        
                    }
                }
                .alert("Community created successfully!", isPresented: $showCreationSuccessAlert) {
                    Button("OK") {communityCreationSuccessful()}
                }
                .alert("Community creation Failed :(", isPresented: $showCreationFailedAlert) {
                    Button("OK") {communityCreationFailed()}
                }.linearGradientBackground()
            }
    
    
    func createCommunity() -> Community {
        var imageURL: String? = nil
        // The imageURL might be populated later, depending on your PhotosPicker implementation
        
        return Community(
            id: UUID().uuidString,
            fullname: fullname, // Assuming `fullname` is available
            description: description, // Assuming `description` is available
            profileImageURL: imageURL,
            membersIDs: [], // Empty array, members can be added later
            email: email, // Assuming `email` is available
            organizerIDs: [currentUserViewModel.user.id], // Adding the creator as the first organizer
            createdEventsIDs: [], // Empty array, events can be added later
            interests: Array(interests) // The interests array can be populated through the UI
        )
    }


    func createButtonClicked() {
        // Show a confirmation alert similar to the Events scenario
        showConfirmationAlert = true
    }

    func confirmationAlertButtonClicked() {
        let createdCommunity = createCommunity()
        var success = false
        
        // Asynchronous task to save to database
        Task {
            success = await CommunityDataModel.addToDB(community: createdCommunity)
            if (success) {
                showCreationSuccessAlert = true
            } else {
                showCreationFailedAlert = true
            }
        }
        currentUserViewModel.addCommunity(community: createdCommunity)
    }

    func communityCreationSuccessful() {
        dismiss()
    }

    func communityCreationFailed() {
        // Handle the failure, perhaps prompt the user to try again
    }

    

}


struct CreateCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateCommunityView()
        }
    }
}
