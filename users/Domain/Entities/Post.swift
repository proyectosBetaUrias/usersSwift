//
//  Post.swift
//  users
//
//  Created by jose Urias on 23/05/22.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    
    
    public var userId: Int = 0
    public var id: Int = 0
    public var title: String = ""
    public var body: String = ""
    
    init(userId: Int? = 0, id: Int? = 0, title: String? = "", body: String? = ""){
        self.userId = userId ?? 0
        self.id = id ?? 0
        self.title = title ?? ""
        self.body = body ?? ""
        
    }
}
