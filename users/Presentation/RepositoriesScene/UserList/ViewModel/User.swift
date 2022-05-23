//
//  User.swift
//  users
//
//  Created by jose Urias on 18/05/22.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    
    
    public var id: Int = 0
    public var name: String = ""
    public var email: String = ""
    public var phone: String = ""
    
    init(id: Int? = 0, name: String? = "", email: String? = "", phone: String? = ""){
        self.id = id ?? 0
        self.name = name ?? ""
        self.email = email ?? ""
        self.phone = phone ?? ""
    }
}
