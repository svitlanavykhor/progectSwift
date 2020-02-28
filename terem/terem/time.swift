//
//  time.swift
//  terem
//
//  Created by svitlana vykhor on 31/01/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import Foundation
import MapKit
import AddressBook
import SwiftyJSON
import Alamofire



class time: NSObject, MKAnnotation
{
    let mag: Double?
    let place: String?
    let time : Double?
    
    init(mag:Double , place: String?, time:Date)
    
    {
        self.mag = mag
        self.place = place
        self.time = time
        super.init()
        
}
    
    var subtitle: String? {
        return locationName
    }
    
    }

