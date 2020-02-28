//
//  ViewController.swift
//  terem
//
//  Created by svitlana vykhor on 26/01/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    let geocoder = CLGeocoder()

    
    @IBOutlet weak var karta: MKMapView!//kartamapa
    
    
    @IBOutlet weak var selector: UISegmentedControl!
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //ensendemos spinner para demostrar que se estan cargando datos
        self.showSpinner(onView: self.view)

        if(infoArray.count == 0) {//infoArray contione datos que sacamos del geo
            self.loadData()
        } else {
            self.refreshData()
        }
        
        karta.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshData()
    }
    

    func loadData(){
        infoArray.removeAll()
        let URL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"
        
        Alamofire.request(URL).responseData { (resData) -> Void in
            if((resData.result.value) != nil) {
                let json = JSON(resData.result.value!)
                for item in json["features"].arrayValue {
                    if let coordinates = item["geometry"].dictionaryValue["coordinates"]?.arrayObject as? [Double] {
                        if let title = item["properties"].dictionaryValue["title"]?.stringValue {
                            
                            let ts: Double? = item["properties"].dictionaryValue["time"]?.doubleValue
                            var date: Date? = nil
                            if (ts != nil) {
                                
                                date = Date(timeIntervalSince1970: ts!/1000)
                            }
                            
                            let mag: Double? = item["properties"].dictionaryValue["mag"]?.doubleValue
                            
                            let place: String = item["properties"].dictionaryValue["place"]?.stringValue ?? ""
                            
                            let s = Geo(title: title, locationName: place, date: date, mag: mag, coordinate: CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0]))

                            infoArray.append(s)//infoArray =datos que sacamos para tabla
                        }
                    }
                }
            }
            // apagamos el spinner
            data = infoArray
            self.refreshData()
            self.removeSpinner()
        }
    }

    func refreshData(){
        self.karta.removeAnnotations(self.karta.annotations)
        for s in data {
            self.karta.addAnnotation(s)
        }
    }
    
    private let regionRadius:CLLocationDistance = 1000 //1km-1.6km
    
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius*2.0,longitudinalMeters: regionRadius*2.0)
        karta.setRegion(coordinateRegion, animated: true)
    }
    
}

extension ViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->MKAnnotationView?
    {
        
        if let annotation = annotation as? Geo{//geo clase con datos que recogemos de GEOJSN
            
            let identifire = "pin"
            var view :MKPinAnnotationView
            
            if let dequeuedView = karta.dequeueReusableAnnotationView(withIdentifier: identifire) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                
//                view = dequeuedView as! MKPinAnnotationView
                view = dequeuedView
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifire)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
               // view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                
                view.image = UIImage(named: "earthquake")
                
               
               
                
                if annotation.mag != nil {//tamaño de pin dependiendo de magnitud
                    switch (annotation.mag!) {
                    case ...2.5:
                        var frame = view.frame
                        frame.size.width = 10
                        frame.size.height = 10
                        
                        view.frame = frame
                        break
                    case 2.5...4.5:
                        var frame = view.frame
                        frame.size.width = 20
                        frame.size.height = 20
                        view.frame = frame
                        break
                    case 4.5...:
                        var frame = view.frame
                        frame.size.width = 35
                        frame.size.height = 35
                        view.frame = frame
                        break
                    default:
                        
                        break
                    }
                }
            }
            return view
        }
        return nil
    }

    func lookUpCurrentLocation(location:CLLocation?,completionHandler: @escaping (CLPlacemark?)//convertir coordenadas al pais
                    -> Void ) {
        // Use the last reported location.

        if let lastLocation = location {
            let geocoder = CLGeocoder()

            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}
