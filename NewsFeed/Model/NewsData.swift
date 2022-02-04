//
//  WeatherData.swift
//  NewsFeed
//
//  Created by Дмитро Волоховський on 02/02/2022.
//

import Foundation

// MARK: - NewsModel
struct NewsData : Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}
//
//// MARK: - Article
struct Article : Codable {
    let source: Source
    let author: String?
    let title :String?
    let description : String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source : Codable {
    let id: Int?
    let name: String?
}
