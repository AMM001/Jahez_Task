//
//  CachedMovieDetails.swift
//  MoviesSPM
//
//  Created by vodafone on 16/04/2026.
//

import Foundation
import SwiftData
import NetworkLayerSPM

@Model
public final class CachedMovieDetails {

    @Attribute(.unique)
    public var id: Int

    var title: String
    var originalTitle: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String
    var runtime: Int?
    var status: String
    var budget: Int
    var revenue: Int
    var homepage: String?

    public init(details: MovieDetails) {
        self.id = details.id
        self.title = details.title
        self.originalTitle = details.originalTitle
        self.overview = details.overview
        self.posterPath = details.posterPath
        self.backdropPath = details.backdropPath
        self.releaseDate = details.releaseDate
        self.runtime = details.runtime
        self.status = details.status
        self.budget = details.budget
        self.revenue = details.revenue
        self.homepage = details.homepage
    }

    func toDomain() -> MovieDetails {
        MovieDetails(
            id: id,
            title: title,
            originalTitle: originalTitle,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            runtime: runtime,
            status: status,
            budget: budget,
            revenue: revenue,
            genres: [],
            spokenLanguages: [],
            homepage: homepage
        )
    }
}
