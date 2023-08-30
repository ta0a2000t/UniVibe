//
//  CreateEventView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI
import PhotosUI

struct CreateEventView: View {
    
    enum Field: Hashable {
        case activity_title, activity_desc, activity_date, acitivity_hours, activity_maxAttendeesCount
        case location_name, location_desc
    }
    
    // MARK: - Variables
    let creatorID: String
    let isCommunityEvent: Bool
    
    // MARK: - State and Environment Variables
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Field?
    @State var selectedImagePickerItem: PhotosPickerItem?
    let defaultImage =  Image(systemName: "figure.socialdance")

    @State var showConfirmationAlert = false
    @State var showCreationSuccessAlert = false
    @State var showCreationFailedAlert = false
    @State var title = ""
    @State var description = ""
    @State var date = Date()
    @State var numberOfHours = 1
    @State var locationName = ""
    @State var locationDescription = ""
    @State var coordinates = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    @StateObject var maxAttendeesInput = NumbersOnly()
    
    var currentUserViewModel = CurrentUserViewModel.shared
    
    @EnvironmentObject var homeViewModel : HomeViewModel

    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack {
                    EditableImageView(selectedImagePickerItem: $selectedImagePickerItem, currImage: defaultImage)
                    
                    
                    
                    
                    VStack(alignment: .center, spacing: 20) {
                        Section(header: Text("Activity Info")
                            .font(.title2)
                            .bold()
                            .padding(.top, 10)
                        ) {
                            //Text("Activity Info").font(.title2).bold().padding(.top, 10)
                            EditProfileRowView(title: "Title", placeholder: "Enter Activity Title", text: $title).focused($focusedField, equals: .activity_title)
                            EditProfileMultiLineView(title: "Description", placeholder: "Describe The Activity", text: $description).focused($focusedField, equals: .activity_desc)
                            DatePicker("Date", selection: $date, in: Date()...)
                                .focused($focusedField, equals: .activity_date)
                                .font(.callout)
                                .bold()
                            
                            Stepper("Number of Hours: \(numberOfHours)", value: $numberOfHours, in: 1...24).focused($focusedField, equals: .acitivity_hours).font(.callout).bold()
                            
                            
                            HStack {
                                Text("Max Attendees Count:").font(.callout).bold()
                                Spacer()
                                //TextField("Enter Count", value: $maxAttendeesCount, formatter: NumberFormatter())
                                TextField("Enter Count", text: $maxAttendeesInput.value).modifier(MyTextFieldModifier(horizontalPadding: 0))
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                    .focused($focusedField, equals: .activity_maxAttendeesCount).font(.callout).bold()
                                
                            }
                        }
                        
                        
                        
                        
                        Section(header: Text("Location Info")
                            .font(.title2)
                            .bold()
                            .padding(.top, 10)){
                                
                                //Text("Location Info").font(.title2).bold().padding(.top, 30)
                                EditProfileRowView(title: "Name", placeholder: "Enter Location Name", text: $locationName).focused($focusedField, equals: .location_name)
                                EditProfileMultiLineView(title: "Description", placeholder: "Describe The Place", text: $locationDescription).focused($focusedField, equals: .location_desc)
                            }
                        
                        MyLocationPicker(coordinates: $coordinates).frame(height: 200).padding(.top)
                        
                        
                    }.padding(.horizontal, 24)
                    Spacer()
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            createButtonClicked()
                        } label: {
                            Text("Create").bold()
                        }.disabled(title.isEmpty || description.isEmpty || locationName.isEmpty || locationDescription.isEmpty)//.buttonStyle(GrowingButton(enabledColor: .green))
                        
                    }
                    ToolbarItem(placement: .principal) {
                        
                        HStack {
                            Text("Create Event").bold()
                            Image(systemName: "square.and.pencil")
                        }
                        
                    }
                    
                    ToolbarItem(placement: .keyboard) {
                        
                        Button("Done") {
                            focusedField = nil
                        }.foregroundColor(.blue)
                    }
                    
                }.alert("Create Event?", isPresented: $showConfirmationAlert) {
                    Button("cancel", role: .cancel) {}
                    Button("Create") { confirmationAlertButtonClicked()}
                    
                }.alert("Event created successfully!", isPresented: $showCreationSuccessAlert) {
                    Button("OK") {eventCreationSuccessful()}
                }.alert("Event creation Failed :(", isPresented: $showCreationFailedAlert) {
                    Button("OK") {eventCreationFailed()}
                }
                
                
                
                
            }.linearGradientBackground()
            
            
            
        }
    }
    
    func createEvent() -> Event {
        var imageURL: String? = nil
        
        
        return Event(
            id: UUID().uuidString,
            creatorID:creatorID,
            creationDate: Date(),
            isCommunityEvent: isCommunityEvent,
            title: title,
            description: description,
            imageURL: imageURL,
            date: date,
            attendees: [],
            numberOfHours: numberOfHours,
            latitude: coordinates.latitude,
            longitude: coordinates.longitude,
            locationName: locationName,
            locationDescription: locationDescription,
            maxAttendeesCount: Int(maxAttendeesInput.value) ?? 1
        )
    }
    
    func createButtonClicked() {
        showConfirmationAlert = true
    }
    
    
    func confirmationAlertButtonClicked() {
        var createdEvent = createEvent()
        var success = false
        
        // asyncronous task
        Task {
            // add in cloud
            success = await EventDataModel.addToDB(event: createdEvent)

            if (success) {
                showCreationSuccessAlert = true
            } else {
                showCreationFailedAlert = true
            }
        }
        
        // is created by a community
        if isCommunityEvent {
            guard var community = DataRepository.getCommunityByID(id: creatorID) else {print("failed adding created event to community"); return}
            var communityViewModel = CommunityViewModel(community: community)
            communityViewModel.addCreatedEvent(event: createdEvent)
        } else {
            currentUserViewModel.addCreatedEvent(event: createdEvent)
        }
    }
    
    @MainActor
    func eventCreationSuccessful() {
        homeViewModel.isCreatingEvent = false
        //dismiss()
    }
    
    func eventCreationFailed() {
        
    }
    
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}


struct GrowingButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    let enabledColor : Color // do not choose black or white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(4)
            .background(isEnabled ? enabledColor : Color.gray.opacity(0.2))
            .foregroundStyle(isEnabled ? .primary: Color.gray)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 15)
    }
}


struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateEventView(creatorID: "testUserID8776875", isCommunityEvent: true)
        }
    }
}

class NumbersOnly: ObservableObject {
    let MAX_VALUE = 1000
    
    @Published var value = "1" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                    value = filtered
            }
            
            if let numericValue = Int(filtered), numericValue > MAX_VALUE {
                value = String(MAX_VALUE)
            }
            
            
        }
    }
}
