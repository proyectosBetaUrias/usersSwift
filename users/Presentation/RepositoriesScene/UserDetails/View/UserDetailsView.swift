//
//  UserDetailsView.swift
//  users
//
//  Created by jose Urias on 22/05/22.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject private var db_manager: DB_Manager = DB_Manager()
    let user : User
    @State var postModels: [Post] = []
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(user.name)
                    .foregroundColor(.green)
                    .font(.system(size: 18).bold())
                HStack{
                Image(systemName: "phone")
                    .foregroundColor(.green)
                Text(user.phone)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                }
                HStack{
                Image(systemName: "envelope")
                    .foregroundColor(.green)
                Text(user.email)
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
            NavigationView {
            List (self.postModels){(post) in
                VStack(alignment: .leading){
                    HStack(alignment: .top, spacing: 1){
                        Text(post.title)
                            .font(.system(size: 18).bold())
                    }
                    Spacer()
                    HStack(alignment: .top, spacing: 2){
                        Text(post.body)
                    }
                }
                Spacer()
        }
        }.navigationBarHidden(true)
        .onAppear( perform: {
            self.postModels =  DB_Manager().getPosts(id: user.id)
            print("onAppear")
            print(self.postModels)
            }
        )
    }
}

