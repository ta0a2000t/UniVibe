//
//  EditProfileView.swift
//  Gharrid
//
//  Created by Taha Al on 8/12/23.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment (\.dismiss) var dismiss

    //@State var selectedImage: PhotosPickerItem?
    @State var fullname: String = ""
    @State var bio: String = ""
    @State var selectedImage: PhotosPickerItem?
    var body: some View {
        NavigationView {
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    
                    Spacer()
                    HStack {
                        Text("Edit").bold()
                        Image(systemName: "square.and.pencil")
                    }
                    Spacer()
                    
                    
                    Button {
                        
                    } label: {
                        Text("Save").bold()
                    }
                    
                    
                }.padding()
                
                Divider()
                
                PhotosPicker(selection: $selectedImage) {
                    VStack {
                        ZStack{
                            Text("Edit").bold().foregroundColor(.gray)
                            Image(systemName: "person.circle")
                                .resizable().frame(width: 80, height: 80)
                                .background(.gray).clipShape(Circle()).opacity(0.3)
                            
                        }
                        Text("Change Picture")
                    }
                    
                }
                
                //Divider()
                EditProfileRowView(title: "Name", placeholder: "Your Name", text: $fullname)
                
                EditProfileRowView(title: "Bio", placeholder: "Your Bio", text: $bio)
                Divider().hidden()
                
                Spacer()
                
            }
            
            
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title).font(.callout).bold()
                .frame(width: 100, alignment: .leading)
            VStack{
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }.font(.subheadline)
            .frame(height: 36)
    }
}

struct EditProfileMultiLineView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            
            Text(title).font(.callout).bold()
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextEditor(text: $text)
                    .frame(height: 100)
                    .padding(2)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(3)
            }
        }
        .font(.subheadline)
        .frame(height: 140) // Adjust the height as needed
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
