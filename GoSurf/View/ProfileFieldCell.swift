//
//  ProfileFieldCell.swift
//  GoSurf
//
//  Created by Pop on 15/04/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit



class ProfileFieldCell: UITableViewCell {



    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }


    let nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scene #"
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
           return label
       }()
    

    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        

        addSubview(nameLable)
        addSubview(detailLable)

        
        nameLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        nameLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true

        detailLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        detailLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        detailLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 0).isActive = true
        detailLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
