//
//  APIEndpoints.swift
//  users
//
//  Created by jose Urias on 18/05/22.
//

import Foundation

class APIEndpoints: ObservableObject{
    @Published var users: [User] = []
    //static let shared = APIEndpoints( baseURL: URL(string: "https://jsonplaceholder.typicode.com/")!)
    
    //let baseURL : URL
    
    func getUsers() async{
        let task = await DB_Manager().getUsers
        
        print(users)
        guard let url = URL(string: AppConfig.init().baseURL + "users") else {
            return
        }
        
        //let task = URLSession.shared.dataTask(with: url){ [weak self] data, _ ,
        //    error in
        //    guard let data = data, error == nil else {
        //        return;
        //    }
        //    do {
        //        let users = try JSONDecoder().decode([User].self,
        //                                             from: data)
        //        DispatchQueue.main.async {
        //            self?.users = users
        //        }
        //    }
        //    catch{
        //
        //    }
        //}
        //task.resume()
    }
}
