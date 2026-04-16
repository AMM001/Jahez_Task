//
//  Movie.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation

// MARK: - Movie Response

public struct MovieResponse: Codable {
    public let page: Int
    public let results: [Movie]
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie

public struct Movie: Identifiable, Codable {

    public let id: Int
    public let title: String
    public let originalTitle: String
    public let originalLanguage: String
    public let overview: String

    public let posterPath: String?
    public let backdropPath: String?

    public let releaseDate: String?
    public let genreIds: [Int]

    public let popularity: Double
    public let voteAverage: Double
    public let voteCount: Int

    public let adult: Bool
    public let video: Bool
    
   public init(id: Int, title: String, originalTitle: String, originalLanguage: String, overview: String, posterPath: String?, backdropPath: String?, releaseDate: String?, genreIds: [Int], popularity: Double, voteAverage: Double, voteCount: Int, adult: Bool, video: Bool) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.adult = adult
        self.video = video
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case adult
        case video
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
    }
}

// MARK: - Genre Response

public struct GenreResponse: Codable {
    public let genres: [Genre]
}

// MARK: - Genre

public struct Genre: Identifiable, Codable {
    public let id: Int
    public let name: String
}

// MARK: - Movie Details

public struct MovieDetails: Identifiable, Codable {

    public let id: Int
    public let title: String
    public let originalTitle: String
    public let overview: String

    public let posterPath: String?
    public let backdropPath: String?

    public let releaseDate: String
    public let runtime: Int?
    public let status: String

    public let budget: Int
    public let revenue: Int

    public let genres: [Genre]
    public let spokenLanguages: [Language]
    public let homepage: String?
    
   public init(id: Int, title: String, originalTitle: String, overview: String, posterPath: String?, backdropPath: String?, releaseDate: String, runtime: Int?, status: String, budget: Int, revenue: Int, genres: [Genre], spokenLanguages: [Language], homepage: String?) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.status = status
        self.budget = budget
        self.revenue = revenue
        self.genres = genres
        self.spokenLanguages = spokenLanguages
        self.homepage = homepage
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case runtime
        case status
        case budget
        case revenue
        case genres
        case spokenLanguages = "spoken_languages"
        case homepage
        case originalTitle = "original_title"
    }
}

// MARK: - Language

public struct Language: Codable {
    public let englishName: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
    }
}

// MARK: - Image Helpers (Optional but Recommended)

public extension Movie {

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")
    }
}
