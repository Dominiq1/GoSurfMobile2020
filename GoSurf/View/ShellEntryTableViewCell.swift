//
//  ShellEntrieTableViewCell.swift
//  GoSurf
//
//  Created by Piyush on 22/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit



class ShellEntryTableViewCell: UITableViewCell {


    let titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Entry #"
        label.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "arrowForward")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let cellSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        

        addSubview(titleLable)
        addSubview(arrowImageView)
        addSubview(cellSeparatorView)
        
        titleLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        titleLable.bottomAnchor.constraint(equalTo: cellSeparatorView.topAnchor, constant: -16).isActive = true
        
        arrowImageView.centerYAnchor.constraint(equalTo: titleLable.centerYAnchor).isActive = true
        arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        cellSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
