//
//  MediaTableViewCell.swift
//  GoSurf
//
//  Created by Pop on 26/04/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


@available(iOS 13.0, *)
class MediaTableViewCell: UITableViewCell {
    
    
    
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }


    let mediaTitleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Media"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()

    
    let ImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view 
    }()
    
    lazy var imageViewOne: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var imageViewTwo: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.gray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var imageViewThree: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.darkGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var mediaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View all media", for: UIControl.State())
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 22, g: 128, b: 199), for: UIControl.State())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    

  
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(mediaButton)
        addSubview(mediaTitleLable)
        addSubview(ImageContainer)

        
        mediaTitleLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        mediaTitleLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true

        ImageContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        ImageContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        ImageContainer.topAnchor.constraint(equalTo: mediaTitleLable.bottomAnchor, constant: 8).isActive = true
        ImageContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true

        
        ImageContainer.addSubview(imageViewOne)
        ImageContainer.addSubview(imageViewTwo)
        ImageContainer.addSubview(imageViewThree)
        
        imageViewOne.topAnchor.constraint(equalTo: ImageContainer.topAnchor, constant: 0).isActive = true
        imageViewOne.bottomAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 0).isActive = true
        imageViewOne.widthAnchor.constraint(equalTo: ImageContainer.widthAnchor, multiplier: 1/3).isActive = true
        imageViewOne.leftAnchor.constraint(equalTo: ImageContainer.leftAnchor, constant: 0).isActive = true
        

        imageViewTwo.topAnchor.constraint(equalTo: ImageContainer.topAnchor, constant: 0).isActive = true
        imageViewTwo.bottomAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 0).isActive = true
//        imageViewTwo.widthAnchor.constraint(equalToConstant: ImageContainer.frame.width/3 - 2 ).isActive = true
        imageViewTwo.widthAnchor.constraint(equalTo: ImageContainer.widthAnchor, multiplier: 1/3).isActive = true
        imageViewTwo.leftAnchor.constraint(equalTo: imageViewOne.rightAnchor, constant: -2).isActive = true

        imageViewThree.topAnchor.constraint(equalTo: ImageContainer.topAnchor, constant: 0).isActive = true
        imageViewThree.bottomAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 0).isActive = true
//        imageViewThree.widthAnchor.constraint(equalToConstant: ImageContainer.frame.width/3 - 2 ).isActive = true
        imageViewThree.widthAnchor.constraint(equalTo: ImageContainer.widthAnchor, multiplier: 1/3).isActive = true
//        imageViewThree.leftAnchor.constraint(equalTo: imageViewTwo.rightAnchor, constant: -2).isActive = true
        imageViewThree.rightAnchor.constraint(equalTo: ImageContainer.rightAnchor, constant: 0).isActive = true
        
        
        mediaButton.topAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 8).isActive = true
        mediaButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
//        mediaButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        mediaButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        mediaButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
