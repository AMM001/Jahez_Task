//
//  CachedMovie.swift
//  MoviesSPM
//
//  Created by vodafone on 16/04/2026.
//

import Foundation
import SwiftData
import NetworkLayerSPM

@Model
public final class CachedMovie {

    @Attribute(.unique)
    public var id: Int

    var title: String
    var originalTitle: String
    var originalLanguage: String
    var overview: String

    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?

    var genreIds: [Int]
    var popularity: Double
    var voteAverage: Double
    var voteCount: Int
    var adult: Bool
    var video: Bool

    public init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.originalLanguage = movie.originalLanguage
        self.overview = movie.overview
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genreIds
        self.popularity = movie.popularity
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
        self.adult = movie.adult
        self.video = movie.video
    }

    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            originalTitle: originalTitle,
            originalLanguage: originalLanguage,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            genreIds: genreIds,
            popularity: popularity,
            voteAverage: voteAverage,
            voteCount: voteCount,
            adult: adult,
            video: video
        )
    }
}
