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
        
        case location_name
        case location_desc
    }
    
    let user: User
    @Environment (\.dismiss) var dismiss
    @FocusState private var focusedField: Field?

    @State var selectedImagePickerItem: PhotosPickerItem?
    @State private var currImage: Image = Image(systemName: "figure.socialdance")

    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var numberOfHours: Int = 1
    @State var locationName: String = ""
    @State var locationDescription: String = ""
    
    

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

                    
                    
                    Divider()
                    
                    VStack(alignment: .center, spacing: 20) {
                        Text("Activity Info").font(.title2).bold().padding(.top, 30)
                        EditProfileRowView(title: "Title", placeholder: "", text: $title).focused($focusedField, equals: .activity_title)
                        EditProfileMultiLineView(title: "Description", placeholder: "", text: $description).focused($focusedField, equals: .activity_desc)
                        DatePicker("Date", selection: $date).focused($focusedField, equals: .activity_date)
                        Stepper("Number of Hours: \(numberOfHours)", value: $numberOfHours, in: 1...24).focused($focusedField, equals: .acitivity_hours)
                        
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
                            let event = createEvent()
                            user.addCreatedEvent(event: event)
                        } label: {
                            Text("Create").bold()
                        }.disabled(title.isEmpty || description.isEmpty || locationName.isEmpty || locationDescription.isEmpty).buttonStyle(GrowingButton())
                        
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
                    
                }
                    
            
            
        }
        
        
        
        
    }
    
    func createEvent() -> Event {
        var imageURL: String? = nil

        
        return Event(
            id: UUID().uuidString,
            creatorID: user.id,
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
            locationDescription: locationDescription
        )
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
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(3)
            .background(isEnabled ? Color.green : Color.white)
            .foregroundStyle(isEnabled ? Color.white : Color.gray)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView(user: User.MOCK_USERS[0])
    }
}
