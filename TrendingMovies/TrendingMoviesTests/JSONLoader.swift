//
//  JSONLoader.swift
//  TrendingMoviesTests
//
//  Created by vodafone on 15/04/2026.
//

import Foundation

enum JSONLoader {

    static func load<T: Decodable>(
        filename: String,
        bundle: Bundle
    ) -> T {
        let url = bundle.url(forResource: filename, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
