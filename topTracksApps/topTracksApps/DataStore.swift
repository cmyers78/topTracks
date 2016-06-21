//
//  DataStore.swift
//  topTracksApps
//
//  Created by Christopher Myers on 6/20/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class DataStore: NSObject {
    
    
    // Data Store will hold all of our artists and arrays for the app
    
    // Make this singleton
    static let sharedInstance = DataStore()
    // create a private initializer
    override private init() {} // This prevents from additonal objects from being created
    
    var artistsArray = [Artist]()
    var tracksArray = [Track]()
    var albumsArray = [Album]()
    var relatedArtistsArray = [Artist]()
    
    func addArtists(theArtist : Artist) {
        self.artistsArray.append(theArtist)
    }
    
    func addTrack(theTrack : Track) {
        self.tracksArray.append(theTrack)
    }
    
    func addAlbum(theAlbum : Album) {
        self.albumsArray.append(theAlbum)
    }
    
    func addRelatedArtist(relatedArtist : Artist) {
        self.relatedArtistsArray.append(relatedArtist)
    }
}
