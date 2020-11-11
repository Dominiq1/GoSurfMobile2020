//
//  AddressPickViewController.swift
//  GoSurf
//
//  Created by Pop on 23/05/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

protocol AddAddressDelegate {
    func addAddress(shortAddress: String,address: String, latitude: Double, longitude: Double)
 
}

class AddressPickViewController: UIViewController, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var delegate: AddAddressDelegate?
    
    var previousLocation: CLLocation?
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        

        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set", style: .plain, target: self, action: #selector(handleSet))
        
            let leftMargin:CGFloat = 0
            let topMargin:CGFloat = view.safeAreaInsets.top
            let mapWidth:CGFloat = view.frame.size.width
            let mapHeight:CGFloat = view.frame.size.height - 120
            
            mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
            mapView.delegate = self
        
            view.addSubview(mapView)
            view.addSubview(bgView)
            view.addSubview(addressLable)
            view.addSubview(pinImage)
        
            checkLocationServices()
            
            
            bgView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            bgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            bgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
        
            addressLable.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
            addressLable.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        
        pinImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pinImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pinImage.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        pinImage.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
            
        
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil )
    }
    
    var shortAddress: String?
    
    @objc func handleSet() {
        
        guard let address = addressLable.text, addressLable.text != "" else {
            print("Error")
            return
        }
        
        delegate?.addAddress(shortAddress: shortAddress ?? "" ,address: address, latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        dismiss(animated: true, completion: nil )
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // code
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse:
            // do map stuff
            startTackingUserLocation()

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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


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
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addressLable: UILabel = {
        let lable = UILabel()
        lable.text = "Address"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let pinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Pin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    

    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    

    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            let state = placemark.administrativeArea ?? ""
            
        
            
            DispatchQueue.main.async {
//                self.addressLable.text = "\(streetNumber), \(streetName),  ( \(Double(round(1000*(mapView.centerCoordinate.latitude))/1000)), \(Double(round(1000*(mapView.centerCoordinate.longitude))/1000)) )"
                
                self.addressLable.text = "\(streetNumber), \(streetName), \(city), \(state)"
                self.shortAddress = "\(city), \(state)"
                
                
            }
        }
    }
    
    
    
    
}



