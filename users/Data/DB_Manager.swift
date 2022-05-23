//
//  DB_Manager.swift
//  users
//
//  Created by jose Urias on 21/05/22.
//

import Foundation

import SQLite

class DB_Manager: ObservableObject {
    private var db: Connection!
    private var users: Table!
    
    private var id: Expression<Int>!
    private var name: Expression<String>!
    private var email: Expression<String>!
    private var phone: Expression<String>!
    
    @Published var usersf: [User] = []
    @Published var postsf: [Post] = []
    
    init(){
        do{
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            db = try! Connection("\(path)/users.sqlite3")
            users = Table("users")
            id = Expression<Int>("id")
            name = Expression<String>("name")
            email = Expression<String>("email")
            phone = Expression<String>("phone")
            
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
             
                            // if not, then create the table
                            try! db.run(users.create { (t) in
                                t.column(id, primaryKey: true)
                                t.column(name)
                                t.column(email, unique: true)
                                t.column(phone)
                            })
                             
                            // set the value to true, so it will not attempt to create the table again
                            UserDefaults.standard.set(true, forKey: "is_db_created")
                
                guard let url = URL(string: AppConfig.init().baseURL + "users") else {
                        return
                }
                    
                let task = URLSession.shared.dataTask(with: url){ [weak self] data, _ ,
                    error in
                    guard let data = data, error == nil else {
                        return;
                    }
                    do {
                        let userslst = try JSONDecoder().decode([User].self,
                                                             from: data)
                        DispatchQueue.main.async {
                            self?.usersf = userslst
                        }
                        
                            for user in userslst {
                                let sql = "insert into users(id, name, email, phone) values('\(user.id)','\(user.name)','\(user.email)','\(user.phone)')"
                                //print(user)
                                try self?.db.run(sql)
                            }
                        }
                        catch{
                        
                        }
                }
                task.resume()
            }
        }
        catch{
            print(error.localizedDescription)
        }
        getDb()
    }
    public func getDb(){
            
        guard let url = URL(string: AppConfig.init().baseURL + "users") else {
                return
        }
            
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _ ,
            error in
            guard let data = data, error == nil else {
                return;
            }
            do {
                let userslst = try JSONDecoder().decode([User].self,
                                                     from: data)
                DispatchQueue.main.async {
                    self?.usersf = userslst
                }
                
                    for user in userslst {
                        let sql = "insert into users(id, name, email, phone) values('\(user.id)','\(user.name)','\(user.email)','\(user.phone)')"
                        //print(user)
                        try self?.db.run(sql)
                    }
                }
                catch{
                
                }
        }
        task.resume()
    }
    

    public func getUsers()-> [User]{
        var usersModel: [User] = []
        
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            db = try! Connection("\(path)/users.sqlite3")
        users = users.order(id.desc)
        
        do {
            for user in try db.prepare(users){
                var userModel: User = User()
                userModel.id = user[id]
                userModel.name = user[name]
                userModel.email = user[email]
                userModel.phone = user[phone]
                
                usersModel.append(userModel)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        return usersModel
    }
    
    public func getPosts(id: Int) -> [Post]{
        print("getPosts")
        var postsModel: [Post] = []
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = URL(string: AppConfig.init().baseURL + "posts?userId=" + String(id)) else {
                return []
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _ ,
            error in
            guard let data = data, error == nil else {
                return;
            }
            do {
                print("aqui do")
                let postlst = try JSONDecoder().decode([Post].self,
                                                     from: data)
                print("postlst")
                        DispatchQueue.main.async {
                        self?.postsf = postlst
                        }
                    for user in postlst{
                        print(user)
                        var postModel: Post = Post()
                        postModel.id = user.id
                        postModel.title = user.title
                        postModel.body = user.body
                        
                        postsModel.append(postModel)
                        print(postsModel)
                    }
                sem.signal()
                }
                catch{
                
                }
        }
         task.resume()
        sem.wait()
        return postsModel
    }
}
