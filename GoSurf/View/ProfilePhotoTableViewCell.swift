//
//  ProfilePhotoTableViewCell.swift
//  GoSurf
//
//  Created by Piyush on 22/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit



class ProfilePhotoTableViewCell: UITableViewCell {


    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "user")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let cellSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        


        addSubview(profileImageView)
        addSubview(cellSeparatorView)


        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: cellSeparatorView.bottomAnchor, constant: -64).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        cellSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

