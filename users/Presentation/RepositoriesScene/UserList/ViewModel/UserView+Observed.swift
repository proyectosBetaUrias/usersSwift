//
//  UserView+Observed.swift
//  users
//
//  Created by jose Urias on 18/05/22.
//

import SwiftUI

extension ContentView {
    class Observed: ObservableObject {
        @Published var user = User(id: 0,name: "", email: "", phone: "")
    }
}	

