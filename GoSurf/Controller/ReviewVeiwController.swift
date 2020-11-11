//
//  ReviewVeiwController.swift
//  GoSurf
//
//  Created by Pop on 19/05/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ReviewVeiwController: UIViewController, UINavigationControllerDelegate {
    

    var reviewerName = String()
    var reviewerEmail: String? {
        didSet {
            ReviewOrEdit()
        }
    }
    var reviewFor = String()
    var contact = String()
    var rating = Int()
    var type = String()
    var id = String()
    
    var review: Review?
    
    var flag = 0 {
        didSet {
            
            // show the existing data
            self.titleLable.text = review!.reviewTitle
            self.reviewLable.text = review!.review
            self.ratingStackView.setStarsRating(rating: review!.rating!)
            
            self.id = review!.id!
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))
            
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.title = "Write a Review"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(self.handlePost))
        
        addDoneButtonOnKeyboard()
        
        // chek if review alredy posted
        

        
        

        
        let fGuesture = UITapGestureRecognizer(target: self, action: #selector(setRating))
        
        ratingStackView.addGestureRecognizer(fGuesture)

        fetchUser()
        
        
    
    }
    
    func addDoneButtonOnKeyboard(){
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        titleLable.inputAccessoryView = doneToolbar
        reviewLable.inputAccessoryView = doneToolbar

    }

    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }

    
    func ReviewOrEdit() {
                
                Database.database().reference().child("reviews").observe(.childAdded, with: { (snapshot) in
    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let reviewOne = Review(dictionary: dictionary)
                        reviewOne.id = snapshot.key

                        
                        if reviewOne.reviewerEmail == self.reviewerEmail && reviewOne.reviewFor == self.reviewFor {
                            
                            self.review = reviewOne
                            self.flag = 1
                            
                        } else {

                        }

                    }
    
        }, withCancel: nil)
    }
    
    
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func handleEdit() {
        
        let ref = Database.database().reference().child("reviews")
        
        
        let values = [    "review" : self.reviewLable.text as String,
                          "title" : self.titleLable.text!,
                          "reviewerName": self.reviewerName,
                          "reviewerEmail" : self.reviewerEmail as Any,
                          "reviewFor" : self.reviewFor,
                          "rating" : self.ratingStackView.starsRating ] as [String : Any]
        
        
        ref.child(self.id).updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            } else {
                
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
        
        // update avg. starRating of the person whome the review is given to ( email review for )
        
        
    }
    
    @objc func handlePost() {
        
        
        if titleLable.text == "" || self.ratingStackView.starsRating == 0 {
            
            let message = "Please enter review Title & Rating"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)

            // duration in seconds
            let duration: Double = 1

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
            }

            
        } else {
            
            let ref = Database.database().reference().child("reviews")
                    let childRef = ref.childByAutoId()
                    //is it there best thing to include the name inside of the message node

            
                    let values = [    "review" : reviewLable.text as String,
                                      "title" : titleLable.text!,
                                      "reviewerName": self.reviewerName,
                                      "reviewerEmail" : self.reviewerEmail as Any,
                                      "reviewFor" : self.reviewFor,
                                      "rating" : self.ratingStackView.starsRating ] as [String : Any]
            
            
                    print(values)


                    
                    childRef.updateChildValues(values) { (error, ref) in
                        if error != nil {
                            print(error!)
                            return
                        } else {
                            
                            self.dismiss(animated: true, completion: nil)
                            
                        }
            }
            
            // update avg. star rating of the person whome the review is given
            
        }
    }
    
    lazy var imageWidth = self.view.frame.width
    lazy var imageHeight = self.view.frame.width
    lazy var imageSize = CGSize(width:  imageWidth, height: ((imageHeight - 16 - 16)*(9/19) + 32 ))

        let ratingStackView: RatingView = {
            let view = RatingView()
            view.axis = .horizontal
            
            let button1 = UIButton()
            button1.setImage(#imageLiteral(resourceName: "starEmpty"), for: .normal)
            let button2 = UIButton()
            button2.setImage(#imageLiteral(resourceName: "starEmpty"), for: .normal)
            let button3 = UIButton()
            button3.setImage(#imageLiteral(resourceName: "starEmpty"), for: .normal)
            let button4 = UIButton()
            button4.setImage(#imageLiteral(resourceName: "starEmpty"), for: .normal)
            let button5 = UIButton()
            button5.setImage(#imageLiteral(resourceName: "starEmpty"), for: .normal)
            
            view.addArrangedSubview(button1)
            view.addArrangedSubview(button2)
            view.addArrangedSubview(button3)
            view.addArrangedSubview(button4)
            view.addArrangedSubview(button5)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.alignment = .center
            view.distribution = .equalSpacing
            view.spacing = 2
            view.isUserInteractionEnabled = true
            
            
            
            return view

        
        }()
    
        @objc func setRating(){
            print("HI")
            print(ratingStackView.starsRating)
            self.rating = ratingStackView.starsRating
        }
        
        let titleLable: UITextField = {
            let lable = UITextField()
            lable.translatesAutoresizingMaskIntoConstraints = false
            lable.placeholder = "Title"
            lable.font = UIFont.systemFont(ofSize: 24)
            return lable
        }()

        let reviewLable: UITextView = {
            let lable = UITextView()
            lable.translatesAutoresizingMaskIntoConstraints = true
            lable.isEditable = true
            lable.isScrollEnabled = false
            lable.font = UIFont.systemFont(ofSize: 18)
            lable.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            lable.backgroundColor = #colorLiteral(red: 0.9641213613, green: 0.9641213613, blue: 0.9641213613, alpha: 1)
            lable.layer.cornerRadius = 5
            return lable
        }()
        
    let descriptionBackground: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return view
        
    }()
        
    
    
    let descriptionTitleLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        lable.text = "Review (Optional)"
        return lable
    }()
    
    let rateLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 10)
        lable.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        lable.text = "Tap a Star to Rate"
        return lable
    }()
    
    
        
        func setupViews() {
            

            view.addSubview(titleLable)
            view.addSubview(reviewLable)
            view.addSubview(descriptionTitleLable)
            view.addSubview(descriptionBackground)
            view.addSubview(ratingStackView)
            view.addSubview(rateLable)

            

            view.addConstraintsWithFormat(format: "V:|-64-[v0]-4-[v1]-8-[v2]-16-[v3]-8-[v4][v5]", views: ratingStackView,rateLable,titleLable,descriptionTitleLable,reviewLable,descriptionBackground)
            view.addConstraintsWithFormat(format:  "H:|-16-[v0]-16-|", views: titleLable)
            view.addConstraintsWithFormat(format:  "H:|-12-[v0]-12-|", views: reviewLable)
            view.addConstraintsWithFormat(format:  "H:|-16-[v0]-16-|", views: descriptionTitleLable)

            
            reviewLable.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
            descriptionBackground.bottomAnchor.constraint(equalTo: reviewLable.bottomAnchor).isActive = true
            
            ratingStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            rateLable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
            
            
               
           }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
    //                self.navigationItem.title = dictionary["name"] as? String
                    
                    let user = User(dictionary: dictionary)
                    self.setupData(user)
                    self.setupViews()
                    
                }
                
                }, withCancel: nil)
        }
    
    
    func setupData(_ user: User) {
        
        self.reviewerName = user.name!
        self.reviewerEmail = user.email!
        
//        self.ReviewOrEdit()
        
        if user.contact != nil {
            self.contact = user.contact!
        }else {
            self.contact = "contact info not available"
        }
        
        
        
        
        
    }
}
