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
    
    @State var isCurrentUserAttending: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView{
                    VStack(alignment: .leading) {
                        if let imageURL = event.imageURL {
                            Image(imageURL).resizable().frame(width: UIScreen.main.bounds.width, height:200)
                                .padding(.horizontal)
                            
                        } else {
                            // nothing ?
                        }
                        
                        Text(event.title).font(.title).bold().padding(.vertical).padding(.horizontal)
                        
                        EventDateDetailsView(date: event.date, numberOfHours: event.numberOfHours).padding(.horizontal)
                        
                        Button {
                            
                            showLocationButtonSheet.toggle()
                        } label: {
                            EventLocDetailsView(locationName: event.locationName, locationDescription: event.locationDescription).padding(.horizontal)
                        }
                        
                        EventChatDetailsView().padding(.horizontal)
                        
                        AttendeesDetailsView(event: event).padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    isCurrentUserAttending.toggle()
                                }
                            } label: {
                                Image(systemName: isCurrentUserAttending ? "checkmark.circle.fill" : "calendar.badge.plus")
                                    .font(.system(size: 24))
                                    .foregroundColor(isCurrentUserAttending ? .green : .blue)
                                    .scaleEffect(isCurrentUserAttending ? 1.2 : 1.0)
                                Text(isCurrentUserAttending ? "Attending" : "Attend")
                                    .font(.headline)
                                    .foregroundColor(isCurrentUserAttending ? .green : .blue)
                                    .padding()
                                    
                            }
                            .padding()
                            
                            Spacer()
                        }


                        
                        TitleAndBodyView(title:"Description", textBody: event.description).padding(.horizontal).padding(.vertical)
                        
                        VStack {
                            MapWithPinView(latitude: event.latitude, longitude: event.longitude).padding()
                                .frame(height: 250)
                        }
                        
                        
                        
                        
                    }
                }
                
                
                
                Spacer()
                CommunityInListView(community: Community.MOCK[0])
            }.linearGradientBackground()
            
        }
        .toolbar {
            
            ToolbarItem(placement: .principal) {
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
