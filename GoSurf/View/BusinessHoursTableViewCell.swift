//
//  BusinessHoursTableViewCell.swift
//  GoSurf
//
//  Created by Piyush on 28/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit



class BusinessHoursTableViewCell: UITableViewCell {


    let timeLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8:00am to 5:00pm"
        label.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let dayLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Monday"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    lazy var watchImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "watch")
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
    
    let toggleButton: UISwitch = {
        let bt = UISwitch()
//        bt.tintColor = UIColor(r: 22, g: 128, b: 210)
        bt.isOn = true
        bt.onTintColor = UIColor(r: 22, g: 128, b: 210)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(toggleButton)
        addSubview(watchImageView)
        addSubview(cellSeparatorView)
        addSubview(timeLable)
        addSubview(dayLable)
        //addSubview(toggleButton)
        

        //nil,-16
        toggleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        toggleButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        //16,16
        watchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        watchImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        //16,1
        dayLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dayLable.leftAnchor.constraint(equalTo: watchImageView.rightAnchor, constant: 16).isActive = true
        
        timeLable.topAnchor.constraint(equalTo: dayLable.bottomAnchor, constant: 5).isActive = true
        timeLable.leftAnchor.constraint(equalTo: watchImageView.rightAnchor, constant: 16).isActive = true
        //16
        timeLable.bottomAnchor.constraint(equalTo: cellSeparatorView.topAnchor, constant: -5).isActive = true
        
        
        
        cellSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //cellSeparatorView.bottomAnchor.constraint(equalTo:timeLable.bottomAnchor, constant: 5).isActive = true
        cellSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
      
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
