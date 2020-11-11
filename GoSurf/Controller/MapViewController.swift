//
//  MapViewController.swift
//  GoSurf
//
//  Created by Pop on 31/03/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapViewController: UIViewController, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var fromProfile: Bool = false
    
    var userToShow: User?

    var BeachIdentity: [goSurfStation] = []
    //this beachnames and beach coordinates match together by index value. (e.g. : The coordinates for imperial beach are the first index of beach coorindates)
    var BeachCoordinates : [Int: [Double]] = [0 :[32.5819,-117.1325], 1:[32.6754,-117.1738], 2:[32.7302,-117.2565], 3:[32.7481,-117.2528], 4:[ 32.7525,-117.2520],5:[32.7762,-117.2532],6:[32.7944,-117.2560], 7:[32.7972,-117.2571],8:[32.8052,-117.2622],9:[ 32.8083,-117.2662],10:[ 32.8150,-117.2734],11:[ 32.8309,-117.2808],]
    var BeachNames: [String?] = ["Imperial Beach", "Coronado Shores", "Sunset Cliffs", "Ocean Beach", "North Ocean Beach", "Mission Beach", "Pacific Beach South ", "Pacific Beach North ", "Old Mans at Tourmaline", "PB Point", "Birdrock", "Windansea"]
    
    struct goSurfStation {
        var Longitude :Double = 0.0
        var Latitude : Double = 0.0
        var beachName: String! = ""
        var beachStation: Int = 0
    }

    

   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        mapView.delegate = self
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = view.safeAreaInsets.top
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        view.addSubview(mapView)
        
        
        if fromProfile == false {
             buildStations(stationList: BeachIdentity)
            fetchUser()
            //stations()
            setGoSurfStations(list:BeachIdentity)
         
            
            

            
        } else {
            
            
        }
        
        
        checkLocationServices()
  
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        

        
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil )
    }
    
    var users = [User]()
    
    var user: User? {
        didSet {
            
            if fromProfile == true {
            let annotation = CustomPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: user!.latitude!, longitude: user!.longitude! )
            annotation.title = user!.name
            
            if user!.businessType == "Instructor" || user!.businessType == "Coach" {
                    
                    annotation.imageName = #imageLiteral(resourceName: "surfInstructor")
                    
            } else if user!.businessType == "Camp" {
                    
                    annotation.imageName = #imageLiteral(resourceName: "tentColor")

                    
            } else if user!.businessType == "Photographer" {
                    
                    annotation.imageName = #imageLiteral(resourceName: "cameraColor")

                    
            } else if user!.businessType == "Videographer" {
                    
                    annotation.imageName = #imageLiteral(resourceName: "vidoeCameraColor")
            
                }
            
            mapView.addAnnotation(annotation)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
}
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // code
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // code
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse:
            // do map stuff
            
            break
        case .denied:
            // show alert
            
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            // show alert
            
            break
            
        case .authorizedAlways:
            
            break
            
        @unknown default:
            break
        }
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    }
    
    func checkLocationServices()  {
        if CLLocationManager.locationServicesEnabled() {
            
            setupLocationManager()
            checkLocationAuthorization()
            
            
        } else {
            // show alert
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = MKMapType.standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        view.showsUserLocation = true
        view.center = view.center
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        

    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
            guard annotation is CustomPointAnnotation else { return nil }
    
            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
    
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
    
                    annotationView?.setSelected(true, animated: false)
    
                })
    
    
            } else {
                annotationView!.annotation = annotation
            }
            
            let cpa = annotation as! CustomPointAnnotation
            annotationView!.image = cpa.imageName
    
            return annotationView
    }
    
    
    func stations(){
        

            let gosurfstation = CustomPointAnnotation()
    gosurfstation.coordinate = CLLocationCoordinate2D(latitude: 32.5819
, longitude: -117.1325
)
        gosurfstation.title = "Imperial Beach"
            gosurfstation.subtitle = "Go Surf Station"
            gosurfstation.imageName = #imageLiteral(resourceName: "goSurfIcon")
                

        DispatchQueue.main.async(execute: {
         //   print(self.BeachNames[i]!)
         //   print(self.BeachIdentity[i].Latitude)
        //  print(self.BeachIdentity[i].Longitude)
        //  print(NumOfBeaches)
        //   print("-----")
                self.mapView.addAnnotation(gosurfstation)
                                                              
                                                                                })
        
    
    }
    
    func setGoSurfStations(list: [goSurfStation]){
    print("--------------------------------")
       // var Counter: Int = BeachIdentity.count - 1
       // var i: Int = 0
        let stations: [goSurfStation] = list
        let NumOfBeaches: Int = stations.count - 1
        var stationNum : Int = 1
        var printable: [CustomPointAnnotation] = []
        //fill printable array with this loop
        for i in 0...NumOfBeaches{
            print(i)
                let gosurfstation = CustomPointAnnotation()
            gosurfstation.coordinate = CLLocationCoordinate2D(latitude:stations[i].Latitude, longitude: stations[i].Longitude)
            print("=`=`=`=`=`=`=``=`=`=`")
            print(stations[i].Latitude)
            print(stations[i].Longitude)
            
            print("=`=`=`=`=`=`=``=`=`=`")
            
            gosurfstation.title = stations[i].beachName!
            print("=`=`=`=`=`=`=``=`=`=`")
            print(stations[i].beachName!)
            print("=`=`=`=`=`=`=``=`=`=`")
            gosurfstation.subtitle = "Go Surf Station \(stationNum)"
            print("=`=`=`=`=`=`=``=`=`=`")
            print(NumOfBeaches)
            print("=`=`=`=`=`=`=``=`=`=`")
            gosurfstation.imageName = #imageLiteral(resourceName: "goSurfIcon")
            print("=`=`=`=`=`=`=``=`=`=`")
            print(gosurfstation)
            print("=`=`=`=`=`=`=``=`=`=`")
            printable.append(gosurfstation)
            stationNum += 1
            
        }
        
        //dispatche queue

            DispatchQueue.main.async(execute: {
             //   print(self.BeachNames[i]!)
             //   print(self.BeachIdentity[i].Latitude)
            //  print(self.BeachIdentity[i].Longitude)
            //  print(NumOfBeaches)
            //   print("-----")
                for i in 0...NumOfBeaches{
                    self.mapView.addAnnotation(printable[i])
                }
               
                                                                                    })
            

        }

    

    
        func fetchUser() {
            
                Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let user = User(dictionary: dictionary)
                        user.id = snapshot.key
    
                        if user.type == "Business" && user.address != nil {
                            self.users.append(user)
                            self.user = user
                            
//                            let annotation = MKPointAnnotation()
                            
                            let annotation = CustomPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: user.latitude!, longitude: user.longitude! )
                            annotation.title = user.name
                            annotation.subtitle = user.businessType
                            
                            if user.businessType == "Instructor" || user.businessType == "Coach" {
                                
                                annotation.imageName = #imageLiteral(resourceName: "surfInstructor")
                                
                            } else if user.businessType == "Camp" {
                                
                                annotation.imageName = #imageLiteral(resourceName: "tentColor")

                                
                            } else if user.businessType == "Photographer" {
                                
                                annotation.imageName = #imageLiteral(resourceName: "cameraColor")

                                
                            } else if user.businessType == "Videographer" {
                                
                                annotation.imageName = #imageLiteral(resourceName: "vidoeCameraColor")
                        
                            }
        
                            
                            DispatchQueue.main.async(execute: {

                                            self.mapView.addAnnotation(annotation)
            
                                
                            })
                            
                        }
        
                    }
    
                    }, withCancel: nil)
            }
    
    ///Dom----------------------
    
    
    func buildStations(stationList: [goSurfStation]){
        
        let NumOfBeaches = BeachNames.count
        
        for i in 0...NumOfBeaches-1{
            var stationBeingAdded: goSurfStation = goSurfStation()
            stationBeingAdded.beachName = BeachNames[i]!
            stationBeingAdded.Longitude = BeachCoordinates[i]![1]
            stationBeingAdded.Latitude = BeachCoordinates[i]![0]
            BeachIdentity.append(stationBeingAdded)
        }
    }
    
}

// custom anotation class
class CustomPointAnnotation: MKPointAnnotation {
    var imageName: UIImage!
    
    
    
    
}


