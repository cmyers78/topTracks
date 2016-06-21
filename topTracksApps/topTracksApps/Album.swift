//
//  Album.swift
//  topTracksApps
//
//  Created by Christopher Myers on 6/20/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class Album: NSObject {

    var albumName : String = ""
    var albumID : String = ""
    
    override init() {
        super.init()
        
        self.albumName = ""
        self.albumID = ""
        
    }
    
    init(dict : JSONDictionary) {
        super.init()
        
        if let name = dict["name"] as? String {
            self.albumName = name
            
        } else {
            print("I could not parse the album name")
        }
        
        if let albumID = dict["id"] as? String {
            self.albumID = albumID
            
        } else {
            print("I could not parse the album id")
        }
    }
}
