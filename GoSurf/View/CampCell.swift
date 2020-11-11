//
//  CampCell.swift
//  GoSurf
//
//  Created by Pop on 18/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit

class CampCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.text = "Camp Name"
        lable.layer.cornerRadius = lable.frame.size.height/2
        lable.clipsToBounds = false
        lable.layer.shadowOpacity=0.4
        lable.layer.shadowOffset = CGSize(width: 3, height: 3)

        return lable
    }()
    
    let tapToDeleteLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.text = "Delete"
        lable.layer.cornerRadius = lable.frame.size.height/2
        lable.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lable.clipsToBounds = false
        lable.isHidden = true
        lable.backgroundColor = .red
        lable.layer.cornerRadius = 10
        lable.layer.shadowOpacity = 0
        lable.layer.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        lable.layer.masksToBounds = true
        lable.textAlignment = .center
        lable.layer.shadowOffset = CGSize(width: 0, height: 0)

        return lable
    }()
    
    let comingSoonLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .darkGray
        lable.font = UIFont.boldSystemFont(ofSize: 30)
        lable.text = "Coming Soon"
        lable.clipsToBounds = false
        lable.isHidden = true
        return lable
        
    }()
    
    
    
    var bookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.setTitle("Discover", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(titleLable)
        addSubview(bookButton)
        addSubview(comingSoonLable)
        addSubview(tapToDeleteLable)
        
        addConstraintsWithFormat(format:  "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: titleLable)
        addConstraintsWithFormat(format: "V:[v0]-20-|", views: titleLable)
        addConstraintsWithFormat(format: "V:|-16-[v0]", views: bookButton)
        addConstraintsWithFormat(format: "H:[v0(80)]-32-|", views: bookButton)
        addConstraintsWithFormat(format: "V:|-32-[v0]-4-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:[v0]-32-|", views: tapToDeleteLable)
        addConstraintsWithFormat(format: "V:|-40-[v0]", views: tapToDeleteLable)
        
        tapToDeleteLable.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        comingSoonLable.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor).isActive = true
        comingSoonLable.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor).isActive = true


           
       }
}
