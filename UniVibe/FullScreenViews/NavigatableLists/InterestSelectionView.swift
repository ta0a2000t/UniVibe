//
//  InterestSelectionView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI

struct InterestSelectionView: View {
    @Environment(\.colorScheme) private var colorScheme

    let predefinedInterests: [String] = ["3D Printing", "Academic Clubs", "Acrobatics", "Adventure Sports", "Amateur Astronomy", "Amateur Radio", "Animals", "Anime", "Aquarium Keeping", "Aquascaping", "Archaeology", "Archery", "Art", "Astrology", "Astronomy", "Badminton", "Baking", "Ballet", "Ballroom Dancing", "Bar Crawling", "Baseball", "Basketball", "Beach Volleyball", "Beatboxing", "Beer Pong", "Billiards", "Binge-Watching", "Birdwatching", "Blogging", "Board Games", "Book Clubs", "Bookbinding", "Bowling", "Boxing", "Breakdancing", "Brewing", "Bridge", "Bungee Jumping", "Calligraphy", "Camping", "Candle Making", "Canoeing", "Card Games", "Ceramics", "Charity Work", "Cheerleading", "Chess", "Choir", "Club Sports", "Coffee Brewing", "Coffee Shop Hopping", "Coin Collecting", "Comedy", "Comics", "Concerts", "Cooking", "Cornhole", "Crafting", "Crafts", "Cross-stitching", "Cryptography", "Cycling", "DIY", "DIY Projects", "Dance Clubs", "Dancing", "Debate", "Digital Art", "Dining Out", "Dodgeball", "Dorm Room Decorating", "Drawing", "Drone Flying", "Drone Racing", "Entrepreneurship", "Escape Rooms", "Falconry", "Fan Fiction", "Fashion", "Film Making", "Fishing", "Fitness", "Fitness Classes", "Flea Market Shopping", "Foosball", "Frisbee", "Gaming", "Gardening", "Genealogy", "Geocaching", "Go", "Going to the Gym", "Golf", "Graffiti", "Graphic Novels", "Guitar Playing", "Hackathons", "Ham Radio", "Herpetology", "Hiking", "History", "Home Decor", "Horseback Riding", "Hot Air Ballooning", "Ice Skating", "Improv", "Intramural Sports", "Investing", "Jazz Band", "Jogging", "Juggling", "Karaoke", "Kayaking", "Keychain Collecting", "Kickball", "Kite Flying", "Knitting", "LARPing", "Languages", "Laser Tag", "Latin Dance", "License Plate Collecting", "Listening to Podcasts", "Live Music", "Lockpicking", "Machine Learning", "Macramé", "Magic", "Magic Tricks", "Manga", "Martial Arts", "Mathematics", "Meditation", "Meme Making", "Metal Detecting", "Mixology", "Model Building", "Movie Nights", "Movies", "Music", "Musicals", "Mythology", "Nature", "Night Life", "Open Mic Nights", "Origami", "Paintball", "Painting", "Parades", "Paragliding", "Parkour", "Pets", "Philosophy", "Photography", "Photomicrography", "Ping Pong", "Podcasting", "Poetry", "Poetry Readings", "Poker", "Politics", "Pottery", "Programming", "Public Speaking", "Puppetry", "Puzzles", "Quilting", "Quiz Nights", "Radio Shows", "Rafting", "Reading", "Record Collecting", "Recycling", "Remote Control Boats", "Remote Control Cars", "Remote Control Planes", "Road Trips", "Robotics", "Rock Climbing", "Role-Playing Games", "Rollerblading", "Rowing", "Running", "Sailing", "Salsa Dancing", "Scavenger Hunts", "Scrapbooking", "Scuba Diving", "Sewing", "Shopping", "Shortwave Listening", "Skateboarding", "Skiing", "Skydiving", "Slacklining", "Sneaker Collecting", "Snorkeling", "Snowboarding", "Soap Making", "Soccer", "Social Media", "Softball", "Spoken Word", "Sports", "Sports Fans", "Stamp Collecting", "Stand-up Comedy", "Stargazing", "Sticker Collecting", "Study Groups", "Surfing", "Swimming", "Table Tennis", "Tabletop Role-Playing", "Tailgating", "Tap Dancing", "Tarot Reading", "Technology", "Tennis", "Theater", "Thrift Shopping", "Travel", "Trivia", "Ultimate Frisbee", "Urban Exploration", "Video Editing", "Virtual Reality", "Vlogging", "Voice Acting", "Volleyball", "Volunteering", "Water Polo", "Web Development", "Weightlifting", "Whittling", "Wine Tasting", "Woodworking", "Writing", "Yoga", "Ziplining", "Zoology", "Zumba"]


    @State private var searchText: String = ""
    @Binding var selectedInterests: Set<String>
    
    var body: some View {
        VStack{
            
            SectionAndSelectionsView(
                title: "Selected",
                selections: Binding<[String]>(
                    get: { Array(self.selectedInterests) },
                    set: { self.selectedInterests = Set($0) }
                )
            ).padding(.vertical, 50).padding(.horizontal, 24)
            
            
            TextField("Search for interests", text: $searchText)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            List(filteredInterests, id: \.self) { interest in
                Button(action: {
                    if selectedInterests.contains(interest) {
                        selectedInterests.remove(interest)
                    } else {
                        selectedInterests.insert(interest)
                    }
                }) {
                    HStack {
                        Text(interest)
                        Spacer()
                        if selectedInterests.contains(interest) {
                            Image(systemName: "checkmark")
                        }
                    }
                }.listRowBackground(ColorUtilities.dynamicBackgroundColor(for: colorScheme).opacity(0.5))
            }.listStyle(.plain)
            
            .navigationBarTitle("Select Interests")

            
        }.linearGradientBackground()

        
    }
    
    var filteredInterests: [String] {
        predefinedInterests.filter { searchText.isEmpty ? true : $0.lowercased().contains(searchText.lowercased()) }
    }
    
}


struct InterestSelectionView_Previews0: View {
    @State var lst : Set<String> = []
    var body: some View {
            InterestSelectionView(selectedInterests: $lst)
        
    }
}


struct InterestSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InterestSelectionView_Previews0()
        }
    }
}
