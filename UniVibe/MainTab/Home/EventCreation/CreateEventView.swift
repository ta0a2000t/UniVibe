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
    @State private var currImage = Image(systemName: "figure.socialdance")
    @State var showConfirmationAlert = false
    @State var showCreationSuccessAlert = false
    @State var showCreationFailedAlert = false
    @State var title = ""
    @State var description = ""
    @State var date = Date()
    @State var numberOfHours = 1
    @State var locationName = ""
    @State var locationDescription = ""
    @State var createdEvent: Event? = nil
    
    @ObservedObject var maxAttendeesInput = NumbersOnly()
    @EnvironmentObject var currentUserViewModel: CurrentUserViewModel
    
    
    var body: some View {
        
            ScrollView(.vertical){
                VStack {
                    PhotosPicker(selection: $selectedImagePickerItem) {
                        VStack {
                            currImage
                                .resizable()
                                .scaledToFit()
                                .padding(30)
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                                
                                .overlay(
                                    ZStack {
                                        Circle()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(Color.blue.opacity(0.3))
                                        Image(systemName: "pencil")
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                    }
                                )
                            
                            
                            Text("Tap to Edit Picture")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.blue)
                                .opacity(0.8)
                                .shadow(radius: 3).padding(.top, -30)
                            
                        }
                        
                        
                        
                    }.onChange(of: selectedImagePickerItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    let image = Image(uiImage: uiImage)
                                    currImage = image
                                }
                            }
                            
                        }
                    }
                    


                    
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

                        
                    }.padding(.horizontal, 24)
                    Spacer()
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            createButtonClicked()
                        } label: {
                            Text("Create").bold()
                        }.disabled(title.isEmpty || description.isEmpty || locationName.isEmpty || locationDescription.isEmpty).buttonStyle(GrowingButton(enabledColor: .green))
                        
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
    
    func createEvent() -> Event {
        var imageURL: String? = nil
        
        
        return Event(
            id: UUID().uuidString,
            creatorID:creatorID,
            creationDate: Date(),
            isCommunityEvent: false, // Change this as needed
            title: title,
            description: description,
            imageURL: imageURL,
            date: date,
            attendees: [],
            numberOfHours: numberOfHours,
            latitude: 0.0, // Change this as needed
            longitude: 0.0, // Change this as needed
            locationName: locationName,
            locationDescription: locationDescription,
            maxAttendeesCount: Int(maxAttendeesInput.value) ?? 1
        )
    }
    
    func createButtonClicked() {
        showConfirmationAlert = true
    }
    
    
    func confirmationAlertButtonClicked() {
        createdEvent = createEvent()
        var success = false
        
        // asyncronous task
        Task {
            success = await EventDataModel.addToDB(event: createdEvent!)

            if (success) {
                showCreationSuccessAlert = true
            } else {
                showCreationFailedAlert = true
            }
        }
        currentUserViewModel.addCreatedEvent(event: createdEvent!)
    }
    
    func eventCreationSuccessful() {
        dismiss()
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
        CreateEventView(creatorID: "testUserID8776875", isCommunityEvent: true)
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
