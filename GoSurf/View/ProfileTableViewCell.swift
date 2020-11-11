//
//  ProfileTableViewCell.swift
//  GoSurf
//
//  Created by Pop on 26/04/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit



class ProfileTableViewCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }


    let nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Profile Name"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()

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
    
    let availabilityTitleLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Next Available "
        return lable
    }()
    
    let availabilityLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "Weekdays \n9:00am - 5:00pm"
        return lable
    }()
    
    let priceLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "60 $/hr"
        return lable
    }()
    
    let locationLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(r: 22, g: 128, b: 210)
        lable.text = "View Location ➤"
        lable.numberOfLines = 0
        lable.underline()
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.sizeToFit()
        return lable
    }()
    
    
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "instructorImage")
        imageView.layer.cornerRadius = 10
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
    
    let reviewsLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textColor = UIColor(r: 22, g: 128, b: 210)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "12 Ratings"
        return lable
    }()
    
    
    
    
    

    

    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        

        addSubview(nameLable)
//        addSubview(detailLable)
        addSubview(profileImageView)
        addSubview(availabilityTitleLable)
        addSubview(availabilityLable)
        addSubview(priceLable)
        addSubview(locationLable)
        addSubview(ratingsImageView)
        addSubview(reviewsLable)

        
        nameLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        nameLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true

        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        profileImageView.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 9).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        availabilityTitleLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 9).isActive = true
        availabilityTitleLable.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16).isActive = true
        
        
        availabilityLable.topAnchor.constraint(equalTo: availabilityTitleLable.bottomAnchor, constant: 2).isActive = true
        availabilityLable.leftAnchor.constraint(equalTo: availabilityTitleLable.leftAnchor, constant: 0).isActive = true
        availabilityLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        priceLable.topAnchor.constraint(equalTo: availabilityLable.bottomAnchor, constant: 6).isActive = true
        priceLable.leftAnchor.constraint(equalTo: availabilityTitleLable.leftAnchor, constant: 0).isActive = true
        priceLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        locationLable.topAnchor.constraint(equalTo: priceLable.bottomAnchor, constant: 6).isActive = true
        locationLable.leftAnchor.constraint(equalTo: availabilityTitleLable.leftAnchor, constant: 0).isActive = true
        locationLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        ratingsImageView.topAnchor.constraint(equalTo: locationLable.bottomAnchor, constant: 6).isActive = true
        ratingsImageView.leftAnchor.constraint(equalTo: availabilityTitleLable.leftAnchor, constant: 0).isActive = true
//        ratingsImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        ratingsImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        ratingsImageView.widthAnchor.constraint(equalToConstant: 76).isActive = true
        
        reviewsLable.topAnchor.constraint(equalTo: ratingsImageView.bottomAnchor, constant: 6).isActive = true
        reviewsLable.leftAnchor.constraint(equalTo: availabilityTitleLable.leftAnchor, constant: 0).isActive = true
        reviewsLable.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: 10)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

