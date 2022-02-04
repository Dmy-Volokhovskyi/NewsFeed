//
//  NewsManager.swift
//  NewsFeed
//
//  Created by Дмитро Волоховський on 02/02/2022.
//

import Foundation
protocol NewsManagerDelegate{
    func gotTheFeed(_ newsmanager : NewsManager, news : [NewsModel])
    func didFallWithError (error : Error)
}

class NewsManager {
    var delegate : NewsManagerDelegate?
    var newsArray = [NewsModel]()
    
    func getFeed () {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=ua&apiKey=350634f45bec489e92d8027c414de9fd")
      performRequest(withUrl: url!)
    }
    func performRequest (withUrl url : URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            print ("Into the Closure")
            if error != nil {
                self.delegate?.didFallWithError(error: error!)
                return
            }
            if let data = data {
                print ("Into the Closure Data gotten")
                print(data)
              if let news = self.parseJson(data){
                    self.delegate?.gotTheFeed(self, news: news)
                }
            }
        }
        task.resume()
    }
    func parseJson (_ newsData : Data) -> [NewsModel]?{
        let decoder = JSONDecoder()
        print ("Into the Decoder  Data gotten")
        do {
            let decodedNews = try decoder.decode(NewsData.self, from: newsData)
            for article in 0...decodedNews.articles.count-1{
                let newNews = NewsModel(sourseName: decodedNews.articles[article].source.name ?? "N/A",
                                        author: decodedNews.articles[article].author ?? "N/A",
                                        title: decodedNews.articles[article].title ?? "N/A",
                                        description: decodedNews.articles[article].description ?? "N/A",
                                        url:decodedNews.articles[article].url ?? "N/A",
                                        imageurl: decodedNews.articles[article].urlToImage ?? "N/A",
                                        publishedD: decodedNews.articles[article].publishedAt ?? "N/A")
                self.newsArray.append(newNews)
            }
        }catch{
            self.delegate?.didFallWithError(error: error)
            print ("Into the Closure Data gotten corrupted")
        }
        return newsArray
    }
}
