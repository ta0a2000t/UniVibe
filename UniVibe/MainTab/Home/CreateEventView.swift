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
        case activity_title
        case activity_desc
        case activity_date
        case acitivity_hours
        case activity_maxAttendeesCount
        
        case location_name
        case location_desc
        
    }
    
    let creatorID: String // ID of currentUser or community
    let isCommunityEvent: Bool // true iff the creator is currentUser
    
    @Environment (\.dismiss) var dismiss
    @FocusState private var focusedField: Field?
    
    @State var selectedImagePickerItem: PhotosPickerItem?
    @State private var currImage: Image = Image(systemName: "figure.socialdance")
    
    @State var showConfirmationAlert: Bool = false
    
    @State var showCreationSuccessAlert: Bool = false
    @State var showCreationFailedAlert: Bool = false

    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var numberOfHours: Int = 1
    @State var locationName: String = ""
    @State var locationDescription: String = ""
    

    @ObservedObject var maxAttendeesInput = NumbersOnly()

    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack {
                    PhotosPicker(selection: $selectedImagePickerItem) {
                        VStack {
                            ZStack{
                                currImage
                                    .resizable().scaledToFit().frame(width: UIScreen.main.bounds.width, height: 150).padding().opacity(0.5)
                                    .overlay(RoundedRectangle(cornerRadius: 8).frame(width:  UIScreen.main.bounds.width, height: 150).opacity(0.1))
                                Text("Tap to Edit Picture").font(.title).bold().foregroundColor(.blue)

                            }
                            
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
                        Text("Activity Info").font(.title2).bold().padding(.top, 10)
                        EditProfileRowView(title: "Title", placeholder: "", text: $title).focused($focusedField, equals: .activity_title)
                        EditProfileMultiLineView(title: "Description", placeholder: "", text: $description).focused($focusedField, equals: .activity_desc)
                        DatePicker("Date", selection: $date).focused($focusedField, equals: .activity_date).font(.callout).bold()
                        Stepper("Number of Hours: \(numberOfHours)", value: $numberOfHours, in: 1...24).focused($focusedField, equals: .acitivity_hours).font(.callout).bold()
                        
                        
                        HStack {
                            Text("Max Attendees Count:").font(.callout).bold()
                            Spacer()
                            //TextField("Enter Count", value: $maxAttendeesCount, formatter: NumberFormatter())
                            TextField("Enter Count", text: $maxAttendeesInput.value)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($focusedField, equals: .activity_maxAttendeesCount).font(.callout).bold().frame(width: 80)
                            
                            Text("curr: \(maxAttendeesInput.value)")
                        }
                        


                        
                        Text("Location Info").font(.title2).bold().padding(.top, 30)
                        EditProfileRowView(title: "Name", placeholder: "", text: $locationName).focused($focusedField, equals: .location_name)
                        EditProfileMultiLineView(title: "Description", placeholder: "", text: $locationDescription).focused($focusedField, equals: .location_desc)
                        
                    }.padding(.horizontal, 35)
                    Spacer()
                    
                }
                
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
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
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

                    
            
            
        }
        
        
        
        
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
        let event = createEvent()
        var success = false
        
        // asyncronous task
        Task {
            success = await EventDataModel.addToDB(event: event)
            if (success) {
                showCreationSuccessAlert = true
            } else {
                showCreationFailedAlert = true
            }
        }
        
        //user.addCreatedEvent(event: event)

        
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
            .padding(3)
            .background(isEnabled ? enabledColor : Color.gray.opacity(0.2))
            .foregroundStyle(isEnabled ? .primary: Color.gray)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
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
