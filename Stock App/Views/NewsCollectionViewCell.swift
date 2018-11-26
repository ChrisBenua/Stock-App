//
//  NewsCollectionViewCell.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    /// Store corresponding NewsItem
    var newsItem : NewsItem! {
        didSet {
            titleTextLabel.text = newsItem.title
            previewTextLabel.text = newsItem.text
            //UIImage.downloadImage(urlStr: newsItem.externalUrl, imageView: imageView)
            newsItem.nestedElems[0].url = newsItem.nestedElems[0].url.makeSafeUrl()
            UIImage.downloadImage(urlStr: newsItem.nestedElems[0].url, imageView: imageView)
        }
    }
    /// Label for title in CollectionViewCell
    let titleTextLabel : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 1, left: 4, bottom: 1, right: 2))
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.mainTitleLabelColor()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = -1
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    /// Label for text in CollectionView
    let previewTextLabel : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 1, left: 4, bottom: 1, right: 2))
        //label.text = "ipsum dolor amet"
        label.backgroundColor = UIColor.mainTextLabelColor()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.numberOfLines = -1
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .left
        //label.backgroundColor = UIColor.lightGray
        return label
    }()
    /// Cornered analog for ContentView
    let mainCellView : UIView = {
        let iv = UIView()
        iv.clipsToBounds = true
        return iv
    }()
    /// View with shadows, below all views in cells
    let shadowView : ShadowView = {
        let view = ShadowView()
        return view
    }()
    /// Image View for displaying content Image
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 30//half of size
        
        return iv
    }()
    
    ///Configure layer of mainCellView
    func layerSetUp() {
        mainCellView.layer.cornerRadius = 8
        mainCellView.backgroundColor = UIColor.mainCellBackgroundColor()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(shadowView)
        
        shadowView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        contentView.addSubview(mainCellView)
        layerSetUp()
        mainCellView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        mainCellView.addSubview(imageView)
        mainCellView.addSubview(titleTextLabel)
        mainCellView.addSubview(previewTextLabel)
        imageView.anchor(top: mainCellView.topAnchor, left: mainCellView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 60, height: 60)
        
        titleTextLabel.anchor(top: mainCellView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 45)
        
        //previewTextLabel.anchor(top: titleTextLabel.bottomAnchor, left: imageView.rightAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)//д
        
        previewTextLabel.anchor(top: imageView.bottomAnchor, left: mainCellView.leftAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
