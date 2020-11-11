//
//  User.swift
//  GoSurf
//
//  Created by Pop on 24/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var name: String?
    var email: String?
    var type: String?
    var businessType: String?
    var contact: String?
    var bio: String?
    var profileImageUrl: String?
    var imageOneUrl: String?
    var imageTwoUrl: String?
    var imageThreeUrl: String?
    var address: String?
    var shortAddress: String?
    var rate: String?
    var latitude: Double?
    var longitude: Double?
    var surfboards: String?
    var wetsuits: String?
    var starRating: Double?
    var reviewCount: Int?
    
    
    
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.type = dictionary["type"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        self.imageOneUrl = dictionary["imageOneUrl"] as? String
        self.imageTwoUrl = dictionary["imageTwoUrl"] as? String
        self.imageThreeUrl = dictionary["imageThreeUrl"] as? String
        self.bio = dictionary["bio"] as? String
        self.businessType = dictionary["businessType"] as? String
        self.address = dictionary["address"] as? String
        self.shortAddress = dictionary["shortAddress"] as? String
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.rate = dictionary["rate"] as? String
        self.contact = dictionary["contact"] as? String
        self.surfboards = dictionary["surfboards"] as? String
        self.wetsuits = dictionary["wetsuits"] as? String
        self.starRating = dictionary["starRating"] as? Double
        self.reviewCount = dictionary["reviewCount"] as? Int 
    }
}
