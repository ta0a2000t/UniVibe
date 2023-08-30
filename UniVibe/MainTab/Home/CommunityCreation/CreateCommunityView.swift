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
    @State var isInterestSelectionViewPresented: Bool = false
    @State var isInterestSelectionViewPresentedGoals: Bool = false

    enum Field: Hashable {
        case fullname, email, description
    }

    @FocusState private var focusedField: Field?

    @State var fullname = ""
    @State var email = ""
    @State var description = ""
    
    @State var interests : Set<String> = []
    @State var goals : Set<String> = []

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
                                .focused($focusedField, equals: .fullname)

                            EditProfileRowView(title: "Enter your email", placeholder: "Enter Community Email", text: $email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .focused($focusedField, equals: .email)

                            EditProfileMultiLineView(title: "Description", placeholder: "Describe The Community", text: $description)
                                .focused($focusedField, equals: .description)
                            



                            VStack{
                                SectionAndSelectionsView(
                                    title: "Interests",
                                    selections: Binding<[String]>(
                                        get: { Array(self.interests) },
                                        set: { self.interests = Set($0) }
                                    )
                                )
                                
                                Button(action: {
                                    isInterestSelectionViewPresented.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                            .imageScale(.large)
                                        Text("Select Interests")
                                            .font(.headline)
                                    }
                                    .padding()
                                    .frame(width: 220, height: 60)
                                    .cornerRadius(15.0)
                                    .foregroundColor(.blue)
                                }
                                .sheet(isPresented: $isInterestSelectionViewPresented) {
                                    InterestSelectionView(title: "Interests", selectedInterests: $interests)
                                }

                                

                                SectionAndSelectionsView(
                                    title: "For Those Who Wanna",
                                    selections: Binding<[String]>(
                                        get: { Array(self.goals) },
                                        set: { self.goals = Set($0) }
                                    )
                                ).padding(.top)
                                
                                Button(action: {
                                    isInterestSelectionViewPresentedGoals.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                            .imageScale(.large)
                                        Text("Select Goals")
                                            .font(.headline)
                                    }
                                    .padding()
                                    .frame(width: 220, height: 60)
                                    .cornerRadius(15.0)
                                    .foregroundColor(.blue)
                                }
                                .sheet(isPresented: $isInterestSelectionViewPresentedGoals) {
                                    InterestSelectionView(title: "Goals", selectedInterests: $goals)
                                }

                                
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
                }.alert("Create Event?", isPresented: $showConfirmationAlert) {
                    Button("cancel", role: .cancel) {}
                    Button("Create") { confirmationAlertButtonClicked()}

                }.alert("Community created successfully!", isPresented: $showCreationSuccessAlert) {
                    Button("OK") {communityCreationSuccessful()}
                }
                .alert("Community creation Failed :(", isPresented: $showCreationFailedAlert) {
                    Button("OK") {communityCreationFailed()}
                }.linearGradientBackground()
            }
    
    
    func createCommunity() -> Community {
        var imageURL: String? = nil
        
        return Community(
            id: UUID().uuidString,
            fullname: fullname,
            description: description,
            profileImageURL: imageURL,
            membersIDs: [currentUserViewModel.user.id],
            email: email,
            organizerIDs: [currentUserViewModel.user.id],
            createdEventsIDs: [],
            interests: Array(interests),
            goals: Array(goals)
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
        currentUserViewModel.addOrganizingCommunity(community: createdCommunity)
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
