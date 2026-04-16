//
//  AppEnvironment.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation

public enum AppEnvironment: String, CaseIterable {
    case development
    case staging
    case production
}

extension AppEnvironment {

    var serviceBaseUrl: URL {URL(string: "https://api.themoviedb.org/3")!}
    
    var apiKey: String {
        switch self {
        case .development:
            return "0ceb331c030926057b16cb25c02a5446"
        case .staging:
            return "0ceb331c030926057b16cb25c02a5446"
        case .production:
            return "0ceb331c030926057b16cb25c02a5446"
        }
    }
}
