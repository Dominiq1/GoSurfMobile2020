//
//  OfferingTableViewCell.swift
//  GoSurf
//
//  Created by Pop on 26/04/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit

class OfferingTableViewCell: UITableViewCell {
 
    lazy var surfboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "surfboard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var wetsuitImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "wetsuit")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let wetsuitLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(N.A.)"
        label.sizeToFit()
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let surfboardLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(N.A.)"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.sizeToFit()
        return label
    }()
    
    
    

    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(surfboardImageView)
        addSubview(wetsuitImageView)
        addSubview(wetsuitLable)
        addSubview(surfboardLable)
        
        
        wetsuitImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        wetsuitImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        wetsuitImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        wetsuitImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        wetsuitImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        wetsuitLable.leftAnchor.constraint(equalTo: wetsuitImageView.rightAnchor, constant: 4).isActive = true
        wetsuitLable.bottomAnchor.constraint(equalTo: wetsuitImageView.bottomAnchor).isActive = true
        
        surfboardImageView.topAnchor.constraint(equalTo: wetsuitImageView.topAnchor, constant: 0).isActive = true
        surfboardImageView.widthAnchor.constraint(equalTo: wetsuitImageView.widthAnchor, constant: 0).isActive = true
        surfboardImageView.heightAnchor.constraint(equalTo: wetsuitImageView.heightAnchor ).isActive = true
        surfboardImageView.leftAnchor.constraint(equalTo: wetsuitLable.rightAnchor, constant: 4).isActive = true
        
        surfboardLable.leftAnchor.constraint(equalTo: surfboardImageView.rightAnchor, constant: 4).isActive = true
        surfboardLable.bottomAnchor.constraint(equalTo: surfboardImageView.bottomAnchor).isActive = true

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


