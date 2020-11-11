//
//  PaymentsVIewController.swift
//  GoSurf
//
//  Created by Dominiq Martinez on 11/2/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import SwiftUI
import PassKit



class Payments: UIViewController{
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        makePayment()
        
        print((" \n Payment View Did load is called.\n"))
    }
    
       private var paymentrequest: PKPaymentRequest = {
              let request = PKPaymentRequest()
              request.merchantIdentifier = "merchant.gosurf.com"
              request.supportedNetworks = [.masterCard, .visa, .discover,.vPay, .privateLabel, .quicPay]
              request.supportedCountries = ["US"]
              request.merchantCapabilities = .capability3DS
              request.countryCode = "US"
              request.currencyCode = "USD"
              request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Photography Session", amount: 55.00)]
              return request
      }()
    
    
    //call this function in the button tapped function too 
    func makePayment(){
        print("Make Payment called")
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentrequest)
        controller!.delegate = self
        present(controller!, animated: true) {
            print("Completed")
        }
    }
        

}

extension Payments: PKPaymentAuthorizationViewControllerDelegate{
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
      //  controller.dismiss(animated: true, completion: nil)
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    
    
    
    
}
