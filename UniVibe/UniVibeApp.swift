//
//  UniVibeApp.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct UniVibeApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        
        // remove the word "back"
        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance

        // does not work, "back" word is not deleted
        /*
        if let image = UIImage(systemName: "arrowshape.left.fill") {

            // set image
            UINavigationBar.appearance().backIndicatorImage = image
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        }
         */
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()//.environment(\.colorScheme, .dark)
        }
    }
}



struct Previews_UniVibeApp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
