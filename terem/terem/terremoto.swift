//
//  terremoto.swift
//  terem
//
//  Created by svitlana vykhor on 01/02/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import Foundation

import MapKit
import SwiftyJSON
import Alamofire



class TYpes: NSObject
{
    let place: String?
    let time: Double?
    let mag: Double?
    
    init(place: String, time: Double?, mag:Double?)
    
    {
        self.place = place
        self.time = time
        self.mag = mag
        
        super.init()
        
}
    
  
    }
    
    
