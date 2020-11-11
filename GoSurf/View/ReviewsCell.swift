//
//  ReviewsCell.swift
//  GoSurf
//
//  Created by Pop on 20/05/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    var reviews: [Review]? {
        didSet {
            self.horizontalCollectionView.reloadData()
        }
    }
 
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📝 Write a Review", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 22, g: 128, b: 210), for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
        
    }()
    
    fileprivate let horizontalCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "horizontalCell" )
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor(white: 1, alpha: 0)
        return cv
        
    }()
    
    let cellTitleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    


    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(button)
        addSubview(horizontalCollectionView)
        addSubview(cellTitleLable)
        
        cellTitleLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        cellTitleLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        
        button.topAnchor.constraint(equalTo: cellTitleLable.topAnchor, constant: 0).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        horizontalCollectionView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 0).isActive = true
        horizontalCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        horizontalCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        horizontalCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ReviewTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            
        return CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height - 16)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        print(reviews!.count)
        return reviews!.count
        

            

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! ReviewCollectionViewCell
        cell.titleLable.text = reviews![indexPath.row].reviewTitle
        cell.reviewLable.text = reviews![indexPath.row].review
        cell.nameLable.text =  "by " + reviews![indexPath.row].reviewerName!
        
        if reviews![indexPath.row].rating == 1 {
            
            cell.ratingsImageView.image = #imageLiteral(resourceName: "1stars")
            
        } else if  reviews![indexPath.row].rating == 2 {
            
            cell.ratingsImageView.image = #imageLiteral(resourceName: "2stars")
            
        } else if  reviews![indexPath.row].rating == 3 {
            
            cell.ratingsImageView.image = #imageLiteral(resourceName: "3stars")
                   
        } else if  reviews![indexPath.row].rating == 4 {
            
            cell.ratingsImageView.image = #imageLiteral(resourceName: "4stars")
                   
        } else if  reviews![indexPath.row].rating == 5 {
            
            cell.ratingsImageView.image = #imageLiteral(resourceName: "5stars")
                
        }
        
        return cell
            
        
        
    }
    
    
    
    
}



class ReviewCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    

    
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.text = "Title"
        return lable
    }()
    
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.text = "sub title"
        lable.textColor = .gray
        return lable
    }()
    
    lazy var ratingsImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "4stars")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    

    
    var view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .lightGray
        view.layer.opacity = 0.4
        return view
    }()
    
    let reviewLable: UITextView = {
        let lable = UITextView()
        lable.translatesAutoresizingMaskIntoConstraints = true
        lable.isEditable = false
        lable.isScrollEnabled = true
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lable.backgroundColor = UIColor(white: 1, alpha: 0)
        
        lable.text = "Review text"
        lable.layer.cornerRadius = 5
        return lable
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        

        addSubview(view)
        addSubview(titleLable)
        addSubview(nameLable)
        addSubview(ratingsImageView)
        addSubview(reviewLable)

        addConstraintsWithFormat(format: "V:|-8-[v0]", views: ratingsImageView)
        addConstraintsWithFormat(format: "H:[v0]-16-|", views: ratingsImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: titleLable)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: nameLable)
        addConstraintsWithFormat(format: "V:[v0]-8-|", views: nameLable)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: titleLable)
        addConstraintsWithFormat(format:"H:|-0-[v0]-0-|", views: view)
        addConstraintsWithFormat(format:"V:|-0-[v0]-0-|", views: view)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: reviewLable)
        
        ratingsImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        ratingsImageView.widthAnchor.constraint(equalToConstant: 76).isActive = true
        
        reviewLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 0).isActive = true
        reviewLable.bottomAnchor.constraint(equalTo: nameLable.topAnchor, constant: -2).isActive = true
        
        
        
        

           
           
       }
}


