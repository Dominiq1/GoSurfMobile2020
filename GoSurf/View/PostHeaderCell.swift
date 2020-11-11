//
//  PostHeaderCell.swift
//  GoSurf
//
//  Created by Pop on 29/10/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit


class PostHeaderCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    

    
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .black
        lable.font = UIFont.boldSystemFont(ofSize: 36)
        lable.text = "All posts"
        return lable
    }()
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        

        addSubview(titleLable)
        

        

        addConstraintsWithFormat(format: "H:|-16-[v0]", views: titleLable)
        addConstraintsWithFormat(format: "V:|-10-[v0]", views: titleLable)

       }
}
