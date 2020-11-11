//
//  Review.swift
//  GoSurf
//
//  Created by Pop on 21/05/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit

class Review: NSObject {
    var id: String?
    var rating: Int?
    var review: String?
    var reviewTitle: String?
    var reviewFor: String?
    var reviewerName: String?
    var reviewerEmail: String?
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.rating = dictionary["rating"] as? Int
        self.review = dictionary["review"] as? String
        self.reviewTitle = dictionary["title"] as? String
        self.reviewFor = dictionary["reviewFor"] as? String
        self.reviewerName = dictionary["reviewerName"] as? String
        self.reviewerEmail = dictionary["reviewerEmail"] as? String

    }
}
