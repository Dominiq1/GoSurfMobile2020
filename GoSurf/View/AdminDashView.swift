
//
//  SwiftUIView.swift
//  GoSurf
//
//  Created by Dominiq Martinez on 10/25/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import SwiftUI
import UIKit
import Firebase


//---------------------------------

struct Client: Identifiable{
    var id  = UUID()
    let profileImage: String
    let fullName: String
    let date: String
    let Time: String
    let GoSurfStation: String
    let Price: String
}

var clientsThatNeedsApproval: [Client] = [.init(profileImage: "https://gosurf-bucket.s3-us-west-2.amazonaws.com/Dom+Picture.png", fullName: "Dominiq Martinez", date: "October 27, 2020", Time: "10:00am - 12:00 pm", GoSurfStation: "GoSurf Station 1", Price: "55.60")]
var clientsThatHaveActiveApts: [Client]?
var clientsHistory: [Client]?




//---------------------


@available(iOS 13.4, *)
struct AdminDashView: View{
    
    var AdminDash = AdminDashboardViewController()
    
//    //BuildClientsThatNeedApproval()
//  @State var  x  = 1
//  @State private var showNeedsApproval = false
//  @State private var ShowUpcoming = false
//  @State private var showHistory = false
//  ///--------------------------------------------
//
//  @State var isShowingDashView = true
  
  //#1 opening view
  var body: some View {
        VStack{
     ScrollViewDash()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top).scaledToFit()
    }
        

     }//view

}



@available(iOS 13.4, *)
struct ScrollViewDash: View {
    
    var needsApproval: [Client] = [person1]
    var history: [Client] = [person1]
    var activeAppointments: [Client] = [person1]
    
  
    var body: some View{
     
        VStack{
        TabView {
            VStack{
                        acceptDecline()

            }
                       .tabItem {
                           Image("NeedsApproval")
                           Text("Needs Approval")
                       }.tag(0)
        
         ActiveAppointmentsView()
                       .tabItem {
                           Image("ActiveAppointments")
                           Text("Active Appointments")
                       }.tag(1)
        historyAppointmentsView()
                       .tabItem {
                           Image("HistoryAppointments")
                           Text("History")
                       }.tag(0)
               }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20, alignment: .center)

        
        }//.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)

    }
    
    
    func ObserveAppointments(){
        // Get a reference to the database service
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            let ref = Database.database().reference().child("user-messages").child(uid)
            ref.observe(.childAdded, with: { (snapshot) in
                
                let userId = snapshot.key
                
                print(uid, userId)
                
                
                print(userId)
                
                
                print(userId)
                Database.database().reference().child("Admin-needsToApprove").child(uid).observe(.childAdded, with: { (snapshot) in
                    
                    let Appointments = snapshot.key
                    print(Appointments)
                    
                    }, withCancel: nil)
                
                }, withCancel: nil)
        
    }
    
    
}

//left off trying to get view in loweer container



//view that comes up when Upcoming button is tapped

@available(iOS 13.0, *)
struct ActiveAppointmentsView : View{
    var  activeAppointments: [Client] = []
    var body: some View{
        
        VStack{
        Button(action: {
            
        }
               , label: {
            Text("Book a session")
                .bold()
                .foregroundColor(.white)
                .frame(width: 200, height: 50, alignment: .center)
        })
        
        .background(Color(red: 22/255, green: 128/255, blue: 199/255))
        .cornerRadius(25)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120 , alignment: .center)
        
        }
        .border(Color.black)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
    }
  
}



//view that comes up when History button is tapped
@available(iOS 13.0, *)
struct historyAppointmentsView : View {
   
    var  activeAppointments: [Client] = [person1]
    var body: some View{
        
        if activeAppointments.count == 0{
            VStack{
            Button(action: {
                
            }
                   , label: {
                Text("No History")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50, alignment: .center)
            })
            
            .background(Color(red: 22/255, green: 128/255, blue: 199/255))
            .cornerRadius(25)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120, alignment: .center)
            
        
        

            }
            .border(Color.black)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
            
        }else{
//            List (activeAppointments, id:  \.id) {Item in
//                Text("This is one person")
//            }
            VStack{
                Text("Sometext")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
             
        
            }.background(Color(.blue))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
//
        }
        
   
       
    }
  
}



//view that comes up when needs approval button is tapped
@available(iOS 13.0, *)
struct acceptDecline: View {
    
        var seekingClients: [Client] =   clientsThatNeedsApproval


    //this is the orginizer for the data in the cells
    @available(iOS 13.0, *)
    var body: some View {
        
        VStack{
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
    
                Spacer(minLength: 1)
            VStack(alignment: .leading) {
    
                Text(Item.fullName)
                    .bold()
                    .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 10, idealHeight: 50, maxHeight: 60, alignment: .bottomLeading)
                Spacer()
                Text(Item.date)
                    .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 40, idealHeight: 40, maxHeight: 55, alignment: .topLeading)
                    
                Text(Item.Time)
                    .frame(minWidth: 80, idealWidth: 100, maxWidth: 160, minHeight: 10, idealHeight: 10, maxHeight: 20, alignment: .topLeading)
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
                let  acceptedUser = getAcceptedAppointmentData(array: seekingClients, Identifier: Item.id)
                print(acceptedUser.fullName)
            }
                   , label: {
                Text("Accept")
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
                Text("Decline")
                    .bold()
            })
                .foregroundColor(.white)
           
                .frame(minWidth: 5, idealWidth: 5, maxWidth: 75, minHeight: 5, idealHeight: 5, maxHeight: 50, alignment: .center)
                .background(Color(red: 199/255, green: 50/255, blue: 22/255))
                .cornerRadius(15.0)
                .buttonStyle(PlainButtonStyle())
                
                }
             
            }
            
        }.frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 20, alignment: .top)
        
        }
    } //var body closure
    }//main view


func getAcceptedAppointmentData(array: [Client], Identifier: UUID) -> Client{
    let arrMaxIndex: Int = array.count - 1
    var clientObject: Client? = nil
    for  i in 0...arrMaxIndex{
        if array[i].id == Identifier{
             clientObject = array[i]
        }
    }
  return clientObject!
}




var person1: Client =  .init( profileImage: "photographerImage", fullName: "Cameron Christian", date: "Saturday. November 21, 2020", Time: "12:00pm - -2:00pm", GoSurfStation: "GoSurf Station 5", Price: "55.60")

//-----------------------------------------
#if DEBUG
/*
@available(iOS 13.0, *)
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        //2
        acceptDecline(seekingClients: testData)
    }
}
 */
















@available(iOS 13.4, *)
struct Dashview : PreviewProvider {
    static var previews: some View {
        //2
       AdminDashView()
    }
}
#endif

