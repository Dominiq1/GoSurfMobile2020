//
//  SeperatorTableViewCell.swift
//  GoSurf
//
//  Created by Piyush on 22/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit

class SeperatorTableViewCell: UITableViewCell {

    
    let cellSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        

        addSubview(cellSeparatorView)
        addSubview(spaceView)
        
        spaceView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        spaceView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        spaceView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        spaceView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        

        cellSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellSeparatorView.topAnchor.constraint(equalTo: spaceView.bottomAnchor).isActive = true
        cellSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
