//
//  UserDashView.swift
//  GoSurf
//
//  Created by Dominiq Martinez on 10/30/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import SwiftUI
import UIKit
import PassKit

@available(iOS 13.0, *)
struct UserDashView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


@available(iOS 13.0, *)
@available(iOS 13.0, *)
struct payNplay: View{
    
    var seekingClients: [Client] =  [
        .init(profileImage: "https://gosurf-bucket.s3-us-west-2.amazonaws.com/Dom+Picture.png", fullName: "Dominiq Martinez", date: "Sunday, January 22, 2020", Time: "12:00pm - 12:00pm", GoSurfStation:"GoSurf Station 2", Price: "55.60"),
        .init(profileImage: "https://gosurf-bucket.s3-us-west-2.amazonaws.com/Andrew+Picture.png" , fullName: "Andrew Davidson", date: "Friday, February 1, 2020", Time: "5:00pm - 6:00pm", GoSurfStation: "Gosurf Station 1", Price: "55.60" ),
        person1
    ]
    //1
    
    @State private var showPaymentView = false
    
    var body: some View{
        
            List (seekingClients, id:  \.id) {Item in
                HStack{
                    Spacer(minLength: 1)
                    VStack{
                        Spacer()
                        //edit the image for users profile image
                        if #available(iOS 14.0, *) {
                            RemoteImage(url: Item.profileImage)
                             //    Image(Item.profileImage).resizable()
                                .frame(width: 80.0, height: 75.0)
                                .cornerRadius(12)
                              
                        } else {
                            Image(Item.profileImage).resizable()
                           .frame(width: 80.0, height: 75.0)
                           .cornerRadius(10)
                            // Fallback on earlier versions
                        }
                        Spacer(minLength: 75 )
                    }
        
                    Spacer(minLength: 10)
                VStack(alignment: .leading) {
        
                    Text(Item.fullName)
                        .bold()
                        .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 10, idealHeight: 50, maxHeight: 60, alignment: .bottomLeading)
                    Spacer()
                    Text(Item.date)
                        .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 40, idealHeight: 40, maxHeight: 55, alignment: .topLeading)
                    Text(Item.Time)
                        .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 10, idealHeight: 20, maxHeight: 20, alignment: .topLeading)
                    Text(Item.GoSurfStation)
                        .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 10, idealHeight: 20, maxHeight: 20, alignment: .bottomLeading)
                    Text ( "$ \(Item.Price)")
                        .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 10, idealHeight: 20, maxHeight: 20, alignment: .bottomLeading)
                    Spacer(minLength: 25)
                    
                }
                    Spacer(minLength:10)
                                  //--------Accept Button------------
                    VStack{
                        Spacer(minLength: 1)
                Button(action: {
                    self.showPaymentView.toggle()
                    //-------------------
                }
                       , label: {
                    Text("Pay Now")
                        .bold()
                })
                    .foregroundColor(.white)
                    .frame(minWidth: 5, idealWidth: 80, maxWidth: 80, minHeight: 5, idealHeight: 5, maxHeight: 50, alignment: .center)
                    .background(Color(red: 50/255, green: 150/255, blue: 50/255))
                    .cornerRadius(15.0)
                  .buttonStyle(PlainButtonStyle())
                  
                       Spacer(minLength: 1)
                    //---------Decline Button-----------
                Button(action: {  let  acceptedUser = getAcceptedAppointmentData(array: seekingClients, Identifier: Item.id)
                        print(acceptedUser.fullName)}
                       , label: {
                    Text("Cancel")
                        .bold()
                })
                    .foregroundColor(.white)
                    .frame(minWidth: 5, idealWidth: 5, maxWidth: 75, minHeight: 5, idealHeight: 5, maxHeight: 50, alignment: .center)
                    .background(Color(red: 199/255, green: 50/255, blue: 22/255))
                    .cornerRadius(15.0)
                    .buttonStyle(PlainButtonStyle())
                        Spacer(minLength: 1)
                    }
                    Spacer(minLength: 1)
                
                    
                    
                   }//var body closure
              }
        //-------------------
            
        }
            //---------------
}

@available(iOS 13.0, *)
struct ContentView: View {
    
    @Binding var showPaymentView: Bool

    
let paymentHandler = PaymentHandler()

    var body: some View {
        
        VStack{
            VStack{
                Spacer(minLength: 40)
                HStack{
                    
                Text("Dismiss")
                    .bold()
                    .frame(width: 100, height: 100, alignment: .center)
                    .offset(x: 270)
                    .foregroundColor(Color(.white))
                    Spacer()
                        .onTapGesture(perform: {
                            showPaymentView.toggle()
                        })
                    
                Image("chatIcon")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .offset(x: -298)
                    .onTapGesture(perform: {
                        print("chat Icon pressed")
                    })
                }
                Spacer()
            }
    
        VStack{
        
            Spacer(minLength: 10)
        
    
        if #available(iOS 14.0, *) {
            RemoteImage(url: "https://firebasestorage.googleapis.com/v0/b/gosurf-mobile.appspot.com/o/images%2FiD0lneXxv3ZFQlQhZIeC4N0rjIF3?alt=media&token=a324a6db-6c32-4f5a-a35d-2a43b01db670")
           //RemoteImage(url:person1.profileImage)
             //    Image(Item.profileImage).resizable()
                .frame(width: 300.0, height: 250.0)
                .shadow(radius: 30 )
                .scaledToFit()
                .cornerRadius(5)
        } else {
            Image(person1.profileImage).resizable()
           .frame(width: 80.0, height: 40.0)
           .cornerRadius(10)
            // Fallback on earlier versions
        }
            //---------------------------------
            Spacer()
            VStack{

                Text("Congratulations! You're all set to")
                    .foregroundColor(Color(.white))
                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
                    .bold()
                    
                Image("gosurf")
                    .resizable()
                    .frame(width: 200, height: 50, alignment: .center)
                
                Text("\t    Your session with \n\(person1.fullName)  is set for \n\t \(person1.Time)\n\t    \(person1.GoSurfStation)")
                    .foregroundColor(Color(.white))
                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
                    .bold()
                    .frame(width: 400, height: 100, alignment: .center)
                    
            }
            
        
            //---------------------------------

    Button(action: {
        
        self.paymentHandler.costBeforetaxes = 155.00
        self.paymentHandler.serviceProvided = "Go Surf Mobile Photography session with \(person1.fullName)"
            self.paymentHandler.startPayment { (success) in
                if success {
                    print("Success")
                } else {
                    print("Failed")
                }
            }
        }, label: {
            
            Text("PAY WITH  APPLE")
            .font(Font.custom("HelveticaNeue-Bold", size: 16))
            .padding(10)
            .foregroundColor(.black)
                .background(Color(.white))
                .cornerRadius(25)
                .frame(width: 300, height: 90, alignment: .center)
    })
            Spacer(minLength: 100)
        }
        }
      
        .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 25, alignment: .center)
        .background(Color(red: 22/255, green: 122/255, blue: 199/255))
        
    }
    
}



@available(iOS 13.0, *)
struct UserDashView_Previews: PreviewProvider {
    static var previews: some View {
   // ContentView()
      payNplay()
    }
 }


