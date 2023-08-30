//
//  sandbox.swift
//  UniVibe
//
//  Created by Taha Al on 8/26/23.
//

import SwiftUI

import SwiftUI

struct EventCardView: View {
    let event: Event // Assuming you have an Event struct based on your provided properties
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Display event image if imageURL is available
            if let imageURL = event.imageURL {
                // Load and display the image using an async task
                AsyncImage(url: URL(string: imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150) // Adjust the image height as needed
                            .clipped()
                    } else if phase.error != nil {
                        // Placeholder or error handling image
                        Color.gray.frame(height: 150) // You can customize this
                    } else {
                        // Loading indicator
                        ProgressView()
                    }
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.headline)

                    HStack {
                        Spacer()
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        
                        Text("\(TimeHelpers.formatEventDate(event.date))")
                            .font(.subheadline)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Image(systemName: "location.fill")
                            .foregroundColor(.green) // You can adjust this color
                        Text("\(event.locationName)")
                            .font(.subheadline)
                        Spacer()
                    }
                    
                    Text(event.description)
                        .font(.body)
                }
                Spacer()
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.5)) // Use your custom color here
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        EventCardView(event: Event.MOCK[0])
            .previewLayout(.sizeThatFits)
    }
}
