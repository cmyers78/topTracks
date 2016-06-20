//
//  Track.swift
//  topTracksApps
//
//  Created by Christopher Myers on 6/20/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class Track: NSObject {
    
    var name : String = ""
    var previewURL : String = ""
    
    override init() {
        super.init()
        
        self.name = ""
        self.previewURL = ""
        
    }
    
    init(poopDict : JSONDictionary) {
        super.init()
        
        if let name = poopDict["name"] as? String {
            self.name = name
            
            
        } else {
            print("I could not parse track name")
        }
        
        if let previewURL = poopDict["preview_url"] as? String {
            self.previewURL = previewURL
            
            
        } else {
            print ("I could not parse the preview url")
        }
        

        
    }

}
