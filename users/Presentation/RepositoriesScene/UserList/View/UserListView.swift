//
//  UserListView.swift
//  users
//
//  Created by jose Urias on 18/05/22.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var db_manager: DB_Manager = DB_Manager()
    @State var userModels: [User] = []
    @State private var search = ""
    
    var body: some View {
        
        NavigationView {
            List (self.userModels){(user) in
                NavigationLink(destination: UserDetailsView(user: user)) {
                VStack(alignment: .leading){
                    HStack(alignment: .top, spacing: 25){
                        Text(user.name)
                            .foregroundColor(.green)
                            .font(.system(size: 24).bold())
                    }
                    HStack(alignment: .top, spacing: 25){
                        Image(systemName: "phone")
                            .foregroundColor(.green)
                        Text(user.phone)
                        
                    }
                    HStack(alignment: .top, spacing: 25){
                        Image(systemName: "envelope")
                            .foregroundColor(.green)
                        Text(user.email)
                        
                    }
                    VStack(alignment: .trailing){
                        HStack{
                            Spacer()
                        Text("VER PUBLICACIONES")
                                .foregroundColor(.green)
                                .padding(.trailing,8)
                        }
                    }
                    .padding()
                }
                }
            
        }
            
        .navigationTitle("Prueba de Ingreso")
        .searchable(text: $search)
        .onAppear( perform: {
            self.userModels =  DB_Manager().getUsers()
            }
        )
        }
    }
    
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
