//
//  Environment.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    
    var serviceBaseUrl: String {
        switch self {
        case .development, .staging, .production:
            return "https://api.themoviedb.org/3"
        }
    }
    
    var apiKey: String {
        switch self {
        case .development:
            return "DEV_API_KEY"
        case .staging:
            return "STAGING_API_KEY"
        case .production:
            return "PROD_API_KEY"
        }
    }
}
