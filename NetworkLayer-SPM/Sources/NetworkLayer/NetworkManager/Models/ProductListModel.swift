//
//  ProductListModel.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation

// MARK: - Models

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let genreIds: [Int]?
}

struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int
}

struct Genre: Identifiable, Codable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String
    let homepage: String?
    let budget: Int
    let revenue: Int
    let runtime: Int?
    let status: String
    let spokenLanguages: [Language]
    let genres: [Genre]
    let releaseDate: String
    let posterPath: String?
}

struct Language: Codable {
    let englishName: String
}
