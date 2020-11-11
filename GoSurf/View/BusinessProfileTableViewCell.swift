//
//  BusinessProfileTableViewCell.swift
//  GoSurf
//
//  Created by Piyush on 12/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//


import UIKit



class BusinessProfileTableViewCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    // what we want - name, rating, price and location


//
    let detailLable: UITextView = {
           let label = UITextView()
           label.font = UIFont.systemFont(ofSize: 16)
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Script"
           label.isEditable = false
           label.isScrollEnabled = false
           label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           label.layer.cornerRadius = 7
           return label
       }()
    
    
    // nameLable
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Next Available "
        return lable
    }()
    
    
    let priceLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.sizeToFit()
        lable.text = "60 $/hr"
        return lable
    }()
    
    let estimatedPriceLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.textColor = .gray
        lable.text = "estimated cost"
        return lable
    }()
    
    let locationLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .darkGray
        lable.text = "Location not mentioned"
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.sizeToFit()
        return lable
    }()
    
    let ratingLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .darkGray
        lable.text = "0.0"
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.sizeToFit()
        return lable
    }()
    
    
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "instructorImage")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var ratingsImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "4stars")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var locationMarkerImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "placeMarker")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // number of reviews in brackets
    let reviewsLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 13)
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "(20)"
        return lable
    }()
    
    
    
    
    

    

    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        

        addSubview(profileImageView)
        addSubview(nameLable)
        addSubview(priceLable)
        addSubview(locationLable)
        addSubview(ratingsImageView)
        addSubview(reviewsLable)
        addSubview(estimatedPriceLable)
        addSubview(locationMarkerImageView)
        addSubview(ratingLable)

        


        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.17).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.17).isActive = true

        
        nameLable.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 0).isActive = true
        nameLable.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16).isActive = true
        
        ratingLable.leftAnchor.constraint(equalTo: nameLable.leftAnchor,constant: 0).isActive = true
        ratingLable.centerYAnchor.constraint(equalTo: ratingsImageView.centerYAnchor, constant: 1).isActive = true
        
        ratingsImageView.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 10).isActive = true
        ratingsImageView.leftAnchor.constraint(equalTo: ratingLable.rightAnchor, constant: 2).isActive = true
        ratingsImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        ratingsImageView.widthAnchor.constraint(equalToConstant: 76).isActive = true
        
        
        reviewsLable.centerYAnchor.constraint(equalTo: ratingsImageView.centerYAnchor, constant: 0).isActive = true
        reviewsLable.leftAnchor.constraint(equalTo: ratingsImageView.rightAnchor, constant: 6).isActive = true
        
        locationMarkerImageView.leftAnchor.constraint(equalTo: nameLable.leftAnchor,constant: 0).isActive = true
        locationMarkerImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        locationMarkerImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        locationMarkerImageView.centerYAnchor.constraint(equalTo: locationLable.centerYAnchor).isActive = true
        
        
        locationLable.topAnchor.constraint(equalTo: ratingsImageView.bottomAnchor, constant: 10).isActive = true
        locationLable.leftAnchor.constraint(equalTo: locationMarkerImageView.rightAnchor, constant: 2).isActive = true
        locationLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        
        priceLable.topAnchor.constraint(equalTo: locationLable.bottomAnchor, constant: 10).isActive = true
        priceLable.leftAnchor.constraint(equalTo: nameLable.leftAnchor, constant: 0).isActive = true
        priceLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        estimatedPriceLable.topAnchor.constraint(equalTo: priceLable.topAnchor).isActive = true
        estimatedPriceLable.leftAnchor.constraint(equalTo: priceLable.rightAnchor, constant: 6).isActive = true 
        



        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

