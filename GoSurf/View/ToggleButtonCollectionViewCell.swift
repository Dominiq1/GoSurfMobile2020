//
//  ToggleButtonCollectionViewCell.swift
//  GoSurf
//
//  Created by Piyush on 28/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit

class ToggleButtonCollectinViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var button: ToggleButton = {
        let bt = ToggleButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        
        bt.titleLabel?.numberOfLines = 0
        bt.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.setTitle("28\nJuly", for: .normal)
        return bt
        
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func setupViews() {
        
        addSubview(button)
        
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
           
       }
}
