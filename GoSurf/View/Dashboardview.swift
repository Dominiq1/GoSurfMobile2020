//
//  DashboardView.swift
//  GoSurf
//
//  Created by Dominiq Martinez on 10/8/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import SwiftUI
import UIKit



@available(iOS 13.0, *)
struct DashboardView: View {
    //data://
   // var photographerImageCellTitles: [String] = ["Water Photography", "Photography Edits", "Featured Photographers" ]
  //  var photographerImageCellNames: [String] = ["Group Lessons", "Private Lessons" ,"Featured Instructors"]
   // var InstructorImageCellTitles: [String] = ["Group Lessons", "Private Lessons" ,"Featured Instructors"]
   // var InstructorImageCellSubTitles: [String] = ["Group Lessons", "Private Lessons" ,"Featured Instructors"]
    let defaults = UserDefaults.standard
    @State private var tabVisible = true
    @State private var selectedTab: Int = 0
    var body: some View{
        

            
        VStack{
            
       
           // Spacer(minLength: 10)
                
            
            ScrollView{
                DashViewHeader1()
               Spacer(minLength: 370)
                   //------------tab1-----------------
                photogScrollView()
            
            }
                
          
    
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height ,  alignment: .center)
           
               
    
    }
    

}




@available(iOS 13.0, *)
struct NavigationConfigurator: UIViewControllerRepresentable {
    
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}


   
@available(iOS 13.0, *)
struct DashViewHeader: View{
    var body: some View{
        HStack{
            ScrollView(.horizontal){
                Image("photog1")
                    .resizable()
                    .scaledToFill()
                .frame(width: 450, height:350 )
                .shadow(radius: 1)
            }
         
        }

    }


}



@available(iOS 13.0, *)
struct DashViewHeader1: View{
 var body: some View{
    
    
                ScrollView(.horizontal, showsIndicators: false){
                    Spacer(minLength:680)
                    HStack{
            
                        Text("Bringing the surf \ncommunity together.")
                            .font(.custom("Comfortaa-Bold", size: 20))
                            .bold()
                            .frame(width: 300, height: 300)
                            .offset(x: 20, y: -120)
                            .foregroundColor(.black)
                        ZStack{
                         
                        Image("DanielBocater")
                            .resizable()
                            .frame(width: 220, height:180)
                            .cornerRadius(5)
                            .shadow(color: .black, radius:20, x: 0, y: 0)
                          //===========================
                            
                            .offset(x: -160, y: 20)
                            
                            Image("BlackBack")
                                .resizable()
                                .frame(width: 220, height:180)
                                .cornerRadius(5)
                                .offset(x: -160, y: 20)
                                .opacity(0.2)
                            //================
                            Text("Photographer of the week")
                                .font(.custom("Futura-Bold", size: 20))
                                .frame(width: 200, height: 100, alignment: .center)
                                .foregroundColor(Color(.white))
                             
                                
                                .offset(x: -160, y: 70)
                        }
                        Spacer(minLength: 70)
                    //======================
                   
                        ZStack{
                         
                        Image("videographerImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height:180)
                            .cornerRadius(5)
                            .shadow(color: .black, radius:20, x: 0, y: 0)
                          //----------------------------
                            
                            .offset(x: -160, y: 20)
                            
                            Image("BlackBack")
                                .resizable()
                                .frame(width: 220, height:180)
                                .cornerRadius(5)
                                .offset(x: -160, y: 20)
                                .opacity(0.2)
                            //----------------------------
                            Text("Videographer of the week")
                                .font(.custom("Futura-Bold", size: 20))
                                .frame(width: 200, height: 100, alignment: .center)
                                .foregroundColor(Color(.white))
                             
                                
                                .offset(x: -160, y: 70)
                        }
                        Spacer(minLength: 70)
                        //======================
                       
                        ZStack{
                         
                        Image("instructorImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height:180)
                            .cornerRadius(5)
                            .shadow(color: .black, radius:20, x: 0, y: 0)
                            //------------------
                            
                            .offset(x: -160, y: 20)
                            
                            Image("BlackBack")
                                .resizable()
                                .frame(width: 220, height:180)
                                .cornerRadius(5)
                                .offset(x: -160, y: 20)
                                .opacity(0.2)
                            //------------------
                            Text("Instructor of the week")
                                .font(.custom("Futura-Bold", size: 20))
                                .frame(width: 200, height: 100, alignment: .center)
                                .foregroundColor(Color(.white))
                             
                                
                                .offset(x: -160, y: 70)
                        }
                  
                        Spacer(minLength: 70)
                        //======================
                       
                        ZStack{
                         
                        Image("CandidImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height:180)
                            .cornerRadius(5)
                            .shadow(color: .black, radius:20, x: 0, y: 0)
                            //------------------
                            
                            .offset(x: -160, y: 20)
                            
                            Image("BlackBack")
                                .resizable()
                                .frame(width: 220, height:180)
                                .cornerRadius(5)
                                .offset(x: -160, y: 20)
                                .opacity(0.2)
                            //------------------
                            Text("Popular Content of the week")
                                .font(.custom("Futura-Bold", size: 20))
                                .frame(width: 200, height: 100, alignment: .center)
                                .foregroundColor(Color(.white))
                             
                                
                                .offset(x: -160, y: 70)
                        }
                    //=======================
                    
                    }
                    
                }
                .offset( y: -120)
                .frame(width: 450, height: 50)
        

 }


}






@available(iOS 13.0, *)
struct photogScrollView: View{
    
    var photogImages : [String] = ["Photog1, photog2", "photog3"]
    var PhotogTitles: [String]  = ["Water Photography", "Film Photography", "Featured Photographers"]
    var availiblePhotogAdmins : [Int] = [22,15,18]
    var body: some View{
     
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                
                Spacer(minLength: 10)
            
                           Text("Photographers")
                            .font(.custom("Comfortaa-Bold", size: 20))
                           .bold()
                            .foregroundColor(.black)
                            .offset(x: 50)
                       ScrollView(.horizontal, showsIndicators: false){
                           HStack{
                            Spacer(minLength: 60)
                            VStack(){
                                   Image("photog1")
                                   .frame(width: 200, height:150 )
                                   .cornerRadius(5)
                                    .shadow(radius: 5)
                                    .onTapGesture {
                                 print("Glassing IMage Pressed")
                                        
                                }
                                Text("Water Photography")
                                    .font(.custom("confortaa", size: 20.00))
                                    .offset(x: -2)
                                
                                Text("22 photographers availible")
                                    .font(.custom("confortaa", size: 15.00))
                                    .foregroundColor(.gray)
                                    .offset(x: 0)
                                
                                Spacer(minLength: 20)
                                
                            }
                            //------------------------------
                            Spacer(minLength: 30)
                            //---------------------------
                            
                            VStack{
                                   Image("photog2")
                                    .frame(width: 200, height:150 )
                                    .cornerRadius(5)
                                     .onTapGesture {
                                  print("Glassing IMage Pressed")
                                         
                                 }
                                 Text("Film Photography")
                                     .font(.custom("confortaa", size: 20.00))
                                     .offset(x: -2)
                                 
                                 Text("16 photographers availible")
                                     .font(.custom("confortaa", size: 15.00))
                                     .foregroundColor(.gray)
                                     .offset(x: 0)
                                 
                                 Spacer(minLength: 20)
                                 
                            }
                            //------------------------------
                            Spacer(minLength: 30)
                            //---------------------------
                            VStack{
                            
                               Image("photog3")
                                .frame(width: 200, height:150 )
                                .cornerRadius(10)
                                 .onTapGesture {
                              print("Glassing IMage Pressed")
                                     
                             }
                             Text("Water Photography")
                                 .font(.custom("confortaa", size: 20.00))
                                 .offset(x: -2)
                             
                             Text("22 photographers availible")
                                 .font(.custom("confortaa", size: 15.00))
                                 .foregroundColor(.gray)
                                 .offset(x: 0)
                             
                             Spacer(minLength: 80)
                             
                            }
                            //---------------------------------
                                   Spacer(minLength: 50)
                               }
                        //-------------------------------
                       }
                       
                    Spacer(minLength: 10)
                
                Text("Instructors")
                 .font(.custom("Comfortaa-Bold", size: 20))
                .bold()
                    .foregroundColor(.black)
                 .offset(x: 50)
            
                    
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        //-------------------
                     Spacer(minLength: 60)
                        //------------------
                     VStack(){
                            Image("photog1")
                            .frame(width: 200, height:150 )
                            .cornerRadius(30)
                             .onTapGesture {
                          print("Glassing IMage Pressed")
                                 
                         }
                         Text("Water Photography")
                             .font(.custom("confortaa", size: 20.00))
                             .offset(x: -2)
                         
                         Text("22 photographers availible")
                             .font(.custom("confortaa", size: 15.00))
                             .foregroundColor(.gray)
                             .offset(x: 0)
                         
                         Spacer(minLength: 20)
                         
                     }
                        
                        //-------------------
                     Spacer(minLength: 20)
                        //------------------
                     VStack{
                            Image("photog2")
                             .frame(width: 200, height:150 )
                             .cornerRadius(30)
                              .onTapGesture {
                           print("Glassing IMage Pressed")
                                  
                          }
                          Text("Film Photography")
                              .font(.custom("confortaa", size: 20.00))
                              .offset(x: -2)
                          
                          Text("16 photographers availible")
                              .font(.custom("confortaa", size: 15.00))
                              .foregroundColor(.gray)
                              .offset(x: 0)
                          
                          Spacer(minLength: 20)
                          
                     }
                        //-------------------
                     Spacer(minLength: 20)
                        //------------------
                     VStack{
                     
                        Image("photog3")
                         .frame(width: 200, height:150 )
                         .cornerRadius(30)
                          .onTapGesture {
                       print("Glassing IMage Pressed")
                              
                      }
                      Text("Water Photography")
                          .font(.custom("confortaa", size: 20.00))
                          .offset(x: -2)
                      
                      Text("22 photographers availible")
                          .font(.custom("confortaa", size: 15.00))
                          .foregroundColor(.gray)
                          .offset(x: 0)
                      
                      Spacer(minLength: 80)
                      
                     }
                            Spacer(minLength: 50)
                    }
                }
                
                            Spacer(minLength: 30)
                        }
                      
                               
                    }
         
                         
                }
                   
    }


/*
struct DashboardView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        DashboardView()
    }
}

*/



@available(iOS 14.0, *)
struct MashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}



@available(iOS 13.0, *)
struct PhotogOfTheWeek: View {
    var body: some View{
           
        VStack{
            Text("Name")
        }
       
    }

}



@available(iOS 13.0, *)
struct topBar: View {
    var body : some View{
        VStack{
            HStack{
                
                Text("Dashboard").font(.system(size: 30)).fontWeight(.semibold).foregroundColor(Color(red:22, green: 128, blue: 199))
                    .offset(x: 30, y: -10)
                
                Spacer()
                
                Button(action: {
                    
                }){
                 Image("create")
                    .onTapGesture {
                            print("View Sessions Tapped")
                            
                    }
                }
                .foregroundColor(Color(.white))
                .offset(x: -30, y: -10)
                
                
            }
        }.padding(.top)
            .padding(.top,
                     (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
            .background(Color(red: 22/255, green: 128/255, blue: 199/255))
            .edgesIgnoringSafeArea(.top)
            .frame(width: 450, height: 100, alignment: .center)
    }
 }

