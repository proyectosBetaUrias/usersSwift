//
//  AppConfig.swift
//  users
//
//  Created by jose Urias on 18/05/22.
//

import Foundation

final class AppConfig {
    var baseURL: String = "https://jsonplaceholder.typicode.com/"
}

enum LoadingStatus {
    case loading
    case success
    case error
}
