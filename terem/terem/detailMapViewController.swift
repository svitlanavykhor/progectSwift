//
//  detailMapViewController.swift
//  terem
//
//  Created by svitlana vykhor on 25/02/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import UIKit
import MapKit

class detailMapViewController: UIViewController {
    var g: Geo? = nil
    @IBOutlet weak var map: MKMapView!
   
    @IBOutlet weak var locationlabel: UILabel!
    
    @IBOutlet weak var timelabel: UILabel!
    
    @IBOutlet weak var magnitud: UILabel!
    @IBOutlet weak var selector: UISegmentedControl!
    
    @IBAction func choice(_ sender: Any) {
        switch selector.selectedSegmentIndex {
              case 0:
                  map.mapType = .standard
              case 1:
                  
                  map.mapType = .satellite
              default:
                  break
              }
        
        
        
    }
    func set(g: Geo) {
        self.g = g
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.g == nil) {
            return
        }
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        self.locationlabel.text = self.g!.title
        if (self.g!.mag != nil) {
            self.magnitud.text = String(format:"%.2f", self.g!.mag!)
        } else {
            self.magnitud.text = ""
        }

        if(self.g!.date != nil) {
            self.timelabel.text = formatter.string(from: self.g!.date!)
        } else {
            self.timelabel.text = ""
        }
        
        self.map.addAnnotation(self.g!)

        self.map.setRegion(MKCoordinateRegion(center: self.g!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)

    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
