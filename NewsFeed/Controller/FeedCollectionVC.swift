//
//  FeedCollectionVC.swift
//  NewsFeed
//
//  Created by Дмитро Волоховський on 02/02/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FeedCollectionVC: UICollectionViewController {
    
 var newsManager = NewsManager()
    var newsArray = [NewsModel]()
    var indexPath = IndexPath(item: 0, section: 0)
    let SafariButton : UIButton = {
        let button = UIButton(type: .system)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "safari", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    var currentArticle  = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // add Btn
       setupBtns()
        //setupDelegate
        newsManager.delegate = self
        //Set up paging
        collectionView.isPagingEnabled = true
        // Get Data
        newsManager.getFeed()
        //Set navBar Title
        self.title = "News Feed"
        // Register cell classes
        self.collectionView!.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return newsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        cell.news = newsArray[indexPath.item]
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        // Configure the cell
    
        return cell
    }
    
}

extension FeedCollectionVC : NewsManagerDelegate {
    func gotTheFeed(_ newsmanager: NewsManager, news: [NewsModel]) {
        newsArray = news
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    func didFallWithError(error: Error) {
        print (error)
    }
}
extension FeedCollectionVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.y
         currentArticle = Int( x / view.frame.height)
        
    }
    @objc func handleNext () {
        
        if let url = URL(string: newsArray[currentArticle].url) {
            UIApplication.shared.open(url)
        }
    }
    func setupBtns (){
        // add Btn
        view.addSubview(SafariButton)
        //setup
        SafariButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        SafariButton.leadingAnchor.constraint(equalTo: view.trailingAnchor,constant: -70).isActive = true
        SafariButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        SafariButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        SafariButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        SafariButton.tintColor = .black
//        SafariButton.layer.borderColor = CGColor(red: 1, green: 0, blue: 1, alpha: 1)
//        SafariButton.layer.borderWidth = 5
    }
}
