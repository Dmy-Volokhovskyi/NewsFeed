//
//  NewsModel.swift
//  NewsFeed
//
//  Created by Дмитро Волоховський on 02/02/2022.
//


import Foundation
import UIKit

struct NewsModel {
    var sourceName : String
    var author : String
    var title : String
    var description : String
    var url : String
    var imageUrl : String
    var publishDate : String
    
    init(sourseName : String, author : String,title : String, description : String,url : String,imageurl : String,publishedD : String){
        self.sourceName = sourseName
        self.url = url
        self.author = author
        self.title = title
        self.publishDate = publishedD
        self.description = description
        self.imageUrl = imageurl
    }
}

