//
//  SignUpView.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct SignUpView2: View {
    @StateObject var viewModel = SignUpView2ViewModel()
    @Binding var navigationStackPath: NavigationPath
    @State var isInterestSelectionViewPresented: Bool = false
    @State var isInterestSelectionViewPresentedGoals: Bool = false
    @State var isSelectCommunitiesViewPresented: Bool = false
    @EnvironmentObject var registrationViewModel : RegistrationViewModel
    var body: some View {
        ScrollView {
            VStack {
                
                Spacer()
                
                Text("Personalize Profile").font(.largeTitle).foregroundColor(.purple).padding(.bottom, 30).fontDesign(.rounded).bold()
                
                VStack {
                    
                    SectionAndSelectionsView(
                        title: "Interests",
                        selections: Binding<[String]>(
                            get: { Array(viewModel.interests) },
                            set: { viewModel.interests = Set($0) }
                        )
                    )
                    
                    
                    
                    Button(action: {
                        // logic for showing interest selection view
                        isInterestSelectionViewPresented = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                            Text("Select Interests")
                                .font(.headline)
                        }
                        .padding()
                        .frame(width: 220, height: 60)
                        .cornerRadius(15.0)
                        .foregroundColor(.blue)
                    }.sheet(isPresented: $isInterestSelectionViewPresented) {
                        InterestSelectionView(title: "Interests", selectedInterests: $viewModel.interests)
                    }
                    
                    SectionAndSelectionsView(
                        title: "Goals",
                        selections: Binding<[String]>(
                            get: { Array(viewModel.goals) },
                            set: { viewModel.goals = Set($0) }
                        )
                    ).padding(.top)
                    
                    Button(action: {
                        // logic for showing goals selection view
                        isInterestSelectionViewPresentedGoals = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                            Text("Select Goals")
                                .font(.headline)
                        }
                        .padding()
                        .frame(width: 220, height: 60)
                        .cornerRadius(15.0)
                        .foregroundColor(.blue)
                    }.sheet(isPresented: $isInterestSelectionViewPresentedGoals) {
                        InterestSelectionView(title: "Goals", selectedInterests: $viewModel.goals)
                    }
                    
                    
                    /*
                     CommunityListView(communities: Binding<[String]>(
                     get: { Array(self.viewModel.joinedCommunitiesIDs) },
                     set: { self.viewModel.goals = Set($0) }
                     ))*/
                    
                    List {
                        ForEach(DataRepository.getCommunitiesByIDs(ids: Array(viewModel.joinedCommunitiesIDs))) { community in
                            
                            CommunityInListView(community: .constant(community))
                            
                        }
                        
                        
                    }.frame(minHeight: 200, maxHeight: 500)
                    
                    Button(action: {
                        // logic for showing goals selection view
                        isSelectCommunitiesViewPresented = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                            Text("Select Communities")
                                .font(.headline)
                        }
                        .padding()
                        .frame(width: 220, height: 60)
                        .cornerRadius(15.0)
                        .foregroundColor(.blue)
                    }.sheet(isPresented: $isSelectCommunitiesViewPresented) {
                        SelectCommunitiesView(communitiesIDs: $viewModel.joinedCommunitiesIDs)
                        
                    }
                }
                
                
                Button {
                    viewModel.nextClicked()
                } label: {
                    Text("Next")
                        .font(.headline)
                        .frame(width: 250, height:50)
                        .cornerRadius(25)
                }
                .disabled(viewModel.isNextButtonDisabled)
                .buttonStyle(GrowingButton(enabledColor: .purple))
                .padding(.vertical, 30)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoOnTopMiddleView()
                }
            }
            
            .navigationDestination(isPresented: $viewModel.showNextView) {
                SignUpView3(navigationStackPath: $navigationStackPath).environmentObject(registrationViewModel)
            }.onAppear{
                viewModel.setup(registrationViewModel: registrationViewModel)
            }
            
        }
    }
}


struct SignUpView2_Previews: PreviewProvider {
    static var previews: some View {
        //SignUpView2()
        EmptyView()
    }
}



class SignUpView2ViewModel: ObservableObject {
    @Published var interests: Set<String> = []
    @Published var goals: Set<String> = []
    @Published var joinedCommunitiesIDs: Set<String> = []
    
    @Published var showNextView: Bool = false
    var registrationViewModel: RegistrationViewModel?
    
    var isNextButtonDisabled: Bool {
        return interests.isEmpty || joinedCommunitiesIDs.isEmpty
    }
    
    func setup(registrationViewModel: RegistrationViewModel) {
        self.registrationViewModel = registrationViewModel
        print("inited registrationViewModel")
    }

    func nextClicked() {
        registrationViewModel!.interests = Array(interests)
        registrationViewModel!.goals = Array(goals)
        registrationViewModel!.joinedCommunitiesIDs = Array(joinedCommunitiesIDs.map { $0 })
        showNextView = true
    }
}
