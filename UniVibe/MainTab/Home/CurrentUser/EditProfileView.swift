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
    
    @EnvironmentObject var homeViewModel : HomeViewModel

    var body: some View {
        
        NavigationView {
            VStack {
                
                NavigationLink {
                    CreateEventView(creatorID: "dsfdfsfds", isCommunityEvent: true).environmentObject(homeViewModel)
                    
                    //Text("sdoifjiof")
                } label: {
                    Text("press")
                }.padding(.bottom, 100)
                

                
                
                
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
                
                EditProfileMultiLineView(title: "Bio", placeholder: "Your Bio", text: $bio)
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
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(.headline)
                .bold().padding(.trailing, 7)
            
            
            TextField(placeholder, text: $text)
                .modifier(MyTextFieldModifier(horizontalPadding: 0))
        }
        .frame(height: 50)
        .cornerRadius(10)
        
        
    }
}




struct EditProfileMultiLineView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .bold()
            VStack{
                ZStack(alignment: .top) {
                    TextEditor(text: $text).background(Color.clear)
                        //.frame(height: 100)
                        .scrollContentBackground(.hidden) // <- Hide it
                        .modifier(MyTextFieldModifier(horizontalPadding: 0))
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray.opacity(0.5)).padding(.top)
                            .font(.callout)
                        
                    }
                }
            }.cornerRadius(10)
                .frame(minHeight: 100, maxHeight: 200)
                .shadow(color: Color.gray.opacity(0.2), radius: 0, x: 1, y: 2)

        }

    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
