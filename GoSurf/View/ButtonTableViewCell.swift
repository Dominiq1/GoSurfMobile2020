//
//  ButtonTableViewCell.swift
//  GoSurf
//
//  Created by Pop on 26/04/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
 
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("Book Session", for: UIControl.State())
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        return button
        
    }()

    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        //addSubview(button)
        //8,60,32,-16
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


