//
//  usersApp.swift
//  users
//
//  Created by jose Urias on 18/05/22.
//

import SwiftUI

@main
struct usersApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
    
    private func syncdb()async{
        await DB_Manager().getDb()
    }
}
