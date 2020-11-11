//
//  PaymentSwiftui.swift
//  GoSurf
//
//  Created by Dominiq Martinez on 11/3/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {

static let supportedNetworks: [PKPaymentNetwork] = [
    .amex,
    .masterCard,
    .visa
]

    var serviceProvided: String?
    var costBeforetaxes: Double?
    var taxFee = 5.00
    var greateThanhundredTaxFee = 0.05
var paymentController: PKPaymentAuthorizationController?
var paymentSummaryItems = [PKPaymentSummaryItem]()
var paymentStatus = PKPaymentAuthorizationStatus.failure
var completionHandler: PaymentCompletionHandler?

func startPayment(completion: @escaping PaymentCompletionHandler) {

    
    if costBeforetaxes! <= 100.00{
        let amount = PKPaymentSummaryItem(label: serviceProvided!, amount: NSDecimalNumber(value: costBeforetaxes!), type: .final)
        let taxForLessthanHundred = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(value: taxFee ), type: .final)
        let Total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: taxFee + costBeforetaxes! ), type: .final)
        paymentSummaryItems = [amount, taxForLessthanHundred, Total ];
        
        
    }else{
        let amount = PKPaymentSummaryItem(label: serviceProvided!, amount: NSDecimalNumber(value: costBeforetaxes!), type: .final)
        let taxForGreaterThanHundred = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(value: greateThanhundredTaxFee * costBeforetaxes! ), type: .final)
        let Total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: (greateThanhundredTaxFee * costBeforetaxes!) + costBeforetaxes! ), type: .final)
        paymentSummaryItems = [amount, taxForGreaterThanHundred, Total];
    }
    
    completionHandler = completion

    // Create our payment request
    let paymentRequest = PKPaymentRequest()
    paymentRequest.paymentSummaryItems = paymentSummaryItems
    paymentRequest.merchantIdentifier = "merchant.com.YOURDOMAIN.YOURAPPNAME"
    paymentRequest.merchantCapabilities = .capability3DS
    paymentRequest.countryCode = "US"
    paymentRequest.currencyCode = "USD"
    paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks

    // Display our payment request
    paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
    paymentController?.delegate = self
    paymentController?.present(completion: { (presented: Bool) in
        if presented {
            NSLog("Presented payment controller")
        } else {
            NSLog("Failed to present payment controller")
            self.completionHandler!(false)
         }
     })
  }
}

/*
    PKPaymentAuthorizationControllerDelegate conformance.
*/
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {



        // Here you would send the payment token to your server or payment provider to process
        // Once processed, return an appropriate status in the completion handler (success, failure, etc)
        paymentStatus = .success
   

    completion(paymentStatus)
}

func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
    controller.dismiss {
        DispatchQueue.main.async {
            if self.paymentStatus == .success {
                self.completionHandler!(true)
            } else {
                self.completionHandler!(false)
            }
        }
    }
}

}
