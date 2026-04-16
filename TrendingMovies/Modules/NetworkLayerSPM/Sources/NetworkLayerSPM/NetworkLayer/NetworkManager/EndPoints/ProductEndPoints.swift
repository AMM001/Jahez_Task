//
//  ProductEndPoints.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

public typealias Headers = [String: String]

// if you wish you can have multiple services like this in a project
enum ServiceEndpoints {
    
    // organise all the end points here for clarity
    case fetchMovies(page: Int)
    case fetchGenres
    case fetchMovieDetails(id: Int)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchMovies , .fetchGenres , .fetchMovieDetails:
            return .GET
        }
    }
    
    // compose the NetworkRequest
    func createRequest(environment: AppEnvironment = .development) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Accept"] = "application/json"
        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .fetchGenres ,.fetchMovieDetails , .fetchMovies:
            return nil
        }
    }
    
    // compose urls for each request
    func getURL(from environment: AppEnvironment) -> String {
        let baseUrl = environment.serviceBaseUrl
        let apiKey = environment.apiKey
        
        switch self {
            
        case .fetchMovies(let page):
            return "\(baseUrl)/discover/movie" +
            "?api_key=\(apiKey)" +
            "&include_adult=false" +
            "&include_video=false" +
            "&language=en-US" +
            "&sort_by=popularity.desc" +
            "&page=\(page)"
            
        case .fetchGenres:
            return "\(baseUrl)/genre/movie/list?api_key=\(apiKey)"
            
        case .fetchMovieDetails(let id):
            return "\(baseUrl)/movie/\(id)?api_key=\(apiKey)"
        }
    }
}



