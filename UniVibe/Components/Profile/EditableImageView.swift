//
//  EditableImageView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI
import PhotosUI

struct EditableImageView: View {
    @Binding var selectedImagePickerItem: PhotosPickerItem?
    @State var currImage: Image
    
    var body: some View {
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
    }
}

struct EditableImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditableImageView(selectedImagePickerItem: .constant(nil), currImage: Image(systemName: "person.crop.circle"))
    }
}

