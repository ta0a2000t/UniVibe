//
//  SettingsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI


struct SettingsView: View {
    let settings: Array<Setting> = [
       Setting(title: "logout", color: .red, imageName: "rectangle.portrait.and.arrow.right")
       
       /*,
       Setting(title: "widget", color: .yellow, imageName: "star.square.fill"),
       Setting(title: "some other setting", color: .green, imageName: "location.square.fill"),
       Setting(title: "another setting", color: .gray, imageName: "bookmark.square.fill")
        */
    ]
    
    var body: some View {
        NavigationView {
             List {
               ForEach(settings, id: \.self) { setting in
                   Button {
                       ActionToDo(selectionName:  setting.title)
                   } label: {
                       HStack {
                         SettingImage(color: setting.color, imageName: setting.imageName)
                         Text(setting.title)
                       }
                   }
                   
                   
               }
             }
             .navigationTitle("settings")
               
            
        }
    }
    

    
    func ActionToDo(selectionName: String) {
        switch selectionName {
        case "logout":
            AuthService.shared.signout()
        default:
            break
            
        }
    }
}


struct Setting: Hashable {
 let title: String
 let color: Color
 let imageName: String
}

struct SettingImage: View {
 let color: Color
 let imageName: String
 
 var body: some View {
   Image(systemName: imageName)
     .resizable()
     .foregroundStyle(color)
     .frame(width: 25, height: 25)
 }
}

struct RootSettingView: View {
 let viewToDisplay: String
 var body: some View {
   switch viewToDisplay {
   case "logout":
     Text("logout")
       
   case "widget":
     Text("WidgetSettingView()")
   case "some other setting":
     Text("SomeOtherSettingView()")
   case "another setting":
     Text("AnotherSettingView()")
   default:
     RootSettingView(viewToDisplay: "")
   }
 }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
