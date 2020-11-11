//
//  VersionNameTableViewCell.swift
//  GoSurf
//
//  Created by Piyush on 22/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit

class VersionNameTableViewCell: UITableViewCell {


    let titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Version: 1.0 - Build: 14"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        

        addSubview(titleLable)
        
        titleLable.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        titleLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 32).isActive = true
        titleLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32).isActive = true
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
