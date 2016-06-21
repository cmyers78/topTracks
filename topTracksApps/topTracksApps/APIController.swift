//
//  APIController.swift
//  topTracksApps
//
//  Created by Christopher Myers on 6/20/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class APIController: NSObject {
    
    // create a session constant
    let session = NSURLSession.sharedSession()
    
    func fetchRelatedArtists(artistID : String) {
        
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/related-artists"
        
        if let url = NSURL(string: urlString) {
            
            // 3. Create a Data Task for pulling the data from the URL
            
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                // Check if there is an error
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                // 5. Parse the JSON
                
                if let jsonDictionary = self.parseJSON(data) {
                    
                    if let artistsArray = jsonDictionary["artists"] as? JSONArray {
                        
                        for artistsDict in artistsArray {
                            
                            let relatedArtist = Artist(dict: artistsDict)
                            print(relatedArtist.name)
                            print(relatedArtist.artistID)
                            
                            
                            
                            
                        }
                    } else {
                        print("I could not parse the artists array")
                    }
                    
                } else {
                    print("I could no parse the jsonDictionary")
                }
                
            })
            task.resume()
        }
    }
    
    func fetchAlbum(artistID :String) {
        
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/albums"
        
        // 2. create url
        if let url = NSURL(string: urlString) {
            
            // 3. Create a Data Task for pulling the data from the URL
            
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                // Check if there is an error
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                // 5. Parse the JSON
                
                if let jsonDictionary = self.parseJSON(data) {
                    
                    if let itemsArray = jsonDictionary["items"] as? JSONArray {
                        
                        for itemsDict in itemsArray {
                            
                            let theAlbum = Album(dict: itemsDict)
                            print(theAlbum.albumName)
                            print(theAlbum.albumID)
                            
                            DataStore.sharedInstance.addAlbum(theAlbum)
                        }
                    } else {
                        print("I could not parse the items Array")
                    }
                } else {
                    print("I could not parse the jsonDictionary")
                }
            })
            task.resume()
        }
    }

    func fetchTopTracks(artistID : String) {
        // 1. Put URLString from web
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/top-tracks?country=US"
        
        // 2. create url
        if let url = NSURL(string: urlString) {
            
            // 3. Create a data task for pulling the data from the URL
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                // Check if there is an error
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                // 5. Parse the JSON
                
                if let jsonDictionary = self.parseJSON(data) {
                 //print(jsonDictonary)
                    
                    if let tracksArray = jsonDictionary["tracks"] as? JSONArray {
                        //print(tracksArray)
                        
                        for tracksDict in tracksArray {
                            
                            let theTrack = Track(poopDict: tracksDict)
//                            print(theTrack.name)
//                            print(theTrack.previewURL)
                            
                            DataStore.sharedInstance.addTrack(theTrack)
                        }
                        
                    } else {
                        print("I could not parse tracks Array")
                    }
                    
                } else {
                    print("I couldn't parse the jsonDictonary")
                }
            })
            task.resume()
        }
}
    
    // Fetch the Artists from the Web API
    func fetchArtist(query : String) {
        
        // 1. Put the URLSTring for the API Call
        let urlString = "https://api.spotify.com/v1/search?q=\(query)&type=artist"
        
        // 2. create url
        if let url = NSURL(string: urlString) {
            
            // 3. Create a Data Task for pulling the data from the URL
            
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                // Check if there is an error
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                if let jsonDictionary = self.parseJSON(data) {
                    print(jsonDictionary)
                    
                    if let artistsDict = jsonDictionary["artists"] as? JSONDictionary {
//                        print(artistsDict)
                        
                        if let itemsArray = artistsDict["items"] as? JSONArray {
                            
                            for itemsDict in itemsArray {
                                
                                let theArtist = Artist(dict: itemsDict)
                                
                                print(theArtist.name)
                                print(theArtist.artistID)
                                
                                DataStore.sharedInstance.addArtists(theArtist)
                            }
//                            print(itemsArray)
                            
                        }
                    }
                    
                    
                } else {
                    print("I could not parse the jsonDictionary")
                }
                
            })
                task.resume()
        }
        
        
    }
    
    // this method allows us to send NSDat and get back a JSONDictionary
    
    func parseJSON(data : NSData?) -> JSONDictionary? {
        
        var theDictionary : JSONDictionary? = nil
        // 5. Parse the JSON
        
        if let data = data {
            do {
                if let jsonDictonary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
                    
                    theDictionary = jsonDictonary
                    
                    
                } else {
                    print("Could not parse jsonDictionary")
                }
                
            } catch {
                
            }
        } else {
            print("Could not unwrap the data")
        }
        return theDictionary
        
    }
    // Fetch the Tracks from the Web API
    
    
}
