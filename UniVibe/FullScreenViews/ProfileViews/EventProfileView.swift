//
//  EventProfileView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI
import CoreLocation

struct EventProfileView: View {
    @State var showLocationButtonSheet: Bool = false
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var currentUserViewModel = CurrentUserViewModel.shared
    @ObservedObject var eventViewModel : EventViewModel
    @State var isCurrentUserAttending: Bool = false

    init(event: Event) {
        self.eventViewModel = EventViewModel(event: event)
    }
    
    var body: some View {
        
        
        VStack{
            //Text("\(currentUserViewModel.user.fullname)")
            ScrollView{
                VStack(alignment: .leading) {
                    if let imageURL = eventViewModel.event.imageURL {
                        Image(imageURL).resizable().frame(width: UIScreen.main.bounds.width, height:200)
                            .padding(.horizontal)
                        
                    } else {
                        // nothing ?
                    }
                    
                    Text(eventViewModel.event.title).font(.title).bold().padding(.vertical).padding(.horizontal)
                    
                    EventDateDetailsView(date: eventViewModel.event.date, numberOfHours: eventViewModel.event.numberOfHours).padding(.horizontal)
                    
                    Button {
                        
                        showLocationButtonSheet.toggle()
                    } label: {
                        EventLocDetailsView(locationName: eventViewModel.event.locationName, locationDescription: eventViewModel.event.locationDescription).padding(.horizontal)
                    }
                    
                    EventChatDetailsView().padding(.horizontal)
                    
                    AttendeesDetailsView(event: eventViewModel.event).padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            reserveButtonClicked()
                            
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


                    
                    TitleAndBodyView(title:"Description", textBody: eventViewModel.event.description).padding(.horizontal).padding(.vertical)
                    
                    VStack {
                        MapWithPinView(coordinates: .constant(CLLocationCoordinate2D(latitude: eventViewModel.event.latitude, longitude: eventViewModel.event.longitude))).padding()
                            .frame(height: 250)
                    }
                    
                    
                    
                    
                }
            }
            
            
            
            Spacer()
            //
            if eventViewModel.event.isCommunityEvent {
                if let comm = eventViewModel.getCreatingCommunity() {
                    CommunityInListView(community: .constant(comm))
                }
                
            } else {
                if let usr = eventViewModel.getCreatingUser() {
                    UserInListView(user: .constant(usr))
                }
            }
            
            
        }.linearGradientBackground()
        
        
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Image(systemName: "figure.socialdance")
            }
            
        }
        .confirmationDialog("Go to Google Maps or copy link.", isPresented: $showLocationButtonSheet) {
            Button("Open in Maps") { eventViewModel.event.launchAppleMaps()}
            Button("Copy Location Link") {
                eventViewModel.event.copyLocationToClipBoard()
            }
            
            Button("Cancel", role: .cancel) { }
        }.onAppear{
            self.isCurrentUserAttending = eventViewModel.isUserAttending(id: currentUserViewModel.user.id)
        }
        
    }
    
    
    func reserveButtonClicked() {
        if isCurrentUserAttending == false {
            currentUserViewModel.addReservedEvent(event: eventViewModel.event)
            eventViewModel.addAttendee(user: currentUserViewModel.user)
        } else {
            currentUserViewModel.removeReservedEvent(event: eventViewModel.event)
            eventViewModel.removeAttendee(user: currentUserViewModel.user)
        }
        
        
        
        
    }
    
    
    
    
    
}

struct EventProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EventProfileView(event: Event.MOCK[0])
    }
}


