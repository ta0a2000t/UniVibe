//
//  EventProfileView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct EventProfileView: View {
    let event: Event
    @State var showLocationButtonSheet: Bool = false
    @Environment (\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    if let imageURL = event.imageURL {
                        Image(imageURL).resizable().frame(width: UIScreen.main.bounds.width, height:200)
                            /*
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 10)
                                     
                                .fill(.purple))
                             */
                            .padding(.horizontal)
                        
                    } else {
                        // nothing?
                    }
                    
                    Text(event.title).font(.title).bold().padding(.vertical).padding(.horizontal)
                    
                    EventDateDetailsView(date: event.date, numberOfHours: event.numberOfHours).padding(.horizontal)
                    
                    Button {
                        
                        showLocationButtonSheet.toggle()
                    } label: {
                        EventLocDetailsView(locationName: event.locationName, locationDescription: event.locationDescription).padding(.horizontal)
                    }
                    
                    EventChatDetailsView().padding(.horizontal)
                    
                    AttendeesDetailsView(attendeesCount: event.attendees.count).padding(.horizontal)
                    TitleAndBodyView(title:"Description", textBody: event.description).padding(.horizontal).padding(.vertical)
                    
                    Spacer()
                    CommunityInListView(community: Community.MOCK[0]).padding(.horizontal)
                    
                    
                    
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                //Text("event.title")
                //    .font(.headline)
                //    .accessibilityAddTraits(.isHeader)
                Image(systemName: "figure.socialdance")
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left").resizable()
                }
                
            }
            
        }.toolbarBackground(.visible)
        .confirmationDialog("Go to Google Maps or copy link.", isPresented: $showLocationButtonSheet) {
            Button("Open in Maps") { event.launchAppleMaps()}
            Button("Copy Location Link") {
                event.copyLocationToClipBoard()
            }
            
            Button("Cancel", role: .cancel) { }
        }
        
    }
}

struct EventProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EventProfileView(event: Event.MOCK[0])
    }
}
