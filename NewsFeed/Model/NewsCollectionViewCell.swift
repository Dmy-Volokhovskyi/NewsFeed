//
//  NewsCollectionViewCell.swift
//  NewsFeed
//
//  Created by Дмитро Волоховський on 02/02/2022.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    let newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let titleTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        textView.layer.cornerRadius = 13
        return textView
    }()
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return textView
    }()
    let authorTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return textView
    }()
    let dateTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        textView.layer.cornerRadius = 13
        return textView
    }()
    let sourceTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        textView.layer.cornerRadius = 13
        return textView
    }()
    var news : NewsModel? {
        didSet{
            guard let unwreppedNews = news else {return}
            //set Title text
            let titleAT = NSMutableAttributedString(string: unwreppedNews.title, attributes: [NSAttributedString.Key.font : UIFont(name: "Times New Roman", size: 26)!, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor : UIColor.white])
            titleTextView.attributedText = titleAT
            titleTextView.textAlignment = .center
            //set Description Text
            let descriptionAT = NSMutableAttributedString(string: unwreppedNews.description, attributes: [NSAttributedString.Key.font : UIFont(name: "Times New Roman", size: 19)!,NSAttributedString.Key.foregroundColor : UIColor.white])
            descriptionTextView.attributedText = descriptionAT
            descriptionTextView.textAlignment = .center
            print(unwreppedNews.description)
            //set Author
            let authorAT = NSMutableAttributedString(string: unwreppedNews.author, attributes: [NSAttributedString.Key.font : UIFont(name: "Times New Roman", size: 22)!,NSAttributedString.Key.foregroundColor : UIColor.white])
            authorTextView.attributedText = authorAT
            authorTextView.textAlignment = .left
            //set date
            let dateAT = NSMutableAttributedString(string: unwreppedNews.publishDate, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.white])
            dateTextView.attributedText = dateAT
            dateTextView.textAlignment = .left
            //set sourse
            let sourceAT = NSMutableAttributedString(string: unwreppedNews.sourceName, attributes: [NSAttributedString.Key.font : UIFont(name: "Times New Roman", size: 15)!,NSAttributedString.Key.foregroundColor : UIColor.white])
            sourceTextView.attributedText = sourceAT
            sourceTextView.textAlignment = .right
            
            let imageURL = URL(string: unwreppedNews.imageUrl)
            ImageLoader.image(for: imageURL!) { image in
                self.newsImageView.image = image
            }
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        addSubview(newsImageView)
        newsImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: -80).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 40).isActive = true
       
        //set Description Text
        //set Author
        //set date
        //set sourse
        let bottomInformationStackView = UIStackView(arrangedSubviews: [dateTextView,authorTextView, descriptionTextView,sourceTextView])
        bottomInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomInformationStackView.distribution = .fill
        bottomInformationStackView.layer.cornerRadius = 8
        newsImageView.addSubview(bottomInformationStackView)
        bottomInformationStackView.axis = .vertical
        NSLayoutConstraint.activate([
            bottomInformationStackView.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor,constant: -15),
            bottomInformationStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            bottomInformationStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -70),

        ])
        bottomInformationStackView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        bottomInformationStackView.layer.cornerRadius = 13
        newsImageView.addSubview(titleTextView)
        titleTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        
    }
}
