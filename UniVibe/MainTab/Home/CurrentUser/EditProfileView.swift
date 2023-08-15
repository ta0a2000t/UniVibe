//
//  EditProfileView.swift
//  Gharrid
//
//  Created by Taha Al on 8/12/23.
//

import SwiftUI

struct EditProfileView: View {
    @Environment (\.dismiss) var dismiss

    //@State var selectedImage: PhotosPickerItem?
    @State var fullname: String = ""
    @State var bio: String = ""
    
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
                    
                    
                }.padding(.horizontal)
                
                Divider()
                
                ZStack {
                    Text("Edit").bold()
                    
                    Image(systemName: "person.circle")
                        .resizable().frame(width: 80, height: 80).background(.red).clipShape(Circle()).opacity(0.3)
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
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            VStack{
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }.font(.subheadline)
            .frame(height: 36)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
