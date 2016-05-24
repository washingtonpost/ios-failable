//
//  MarvelCharacter.swift
//  FailableExample
//
//  Created by Davis, William on 5/24/16.
//  Copyright © 2016 Washington Post. All rights reserved.
//

import Foundation
import ObjectMapper

public class MarvelCharactersWrapper: Mappable {
    var result: [[String : AnyObject]]?
    var characters: [MarvelCharacter]? {
        return Mapper<MarvelCharacter>().mapArray(result)
    }

    required public init?(_ map: Map){
        if map.JSONDictionary["results"] == nil {
            return nil
        }
    }

    public func mapping(map: Map) {
        result <- map["results"]
    }
}

public class MarvelCharacter: Mappable {
    var id: Int?
    var name: String?
    var characterDescription: String?
    var modified: Double?
    var thumbnailPath: String?
    var thumbnailExtension: String?
    var thumbnailURLString: String? {
        if let thumbnailPath = thumbnailPath,
            thumbnailExtension = thumbnailExtension {
            return thumbnailPath + "/standard_large." + thumbnailExtension
        } else {
            return nil
        }
    }
    //comics (ComicList, optional): A resource list containing comics which feature this character.,
    //stories (StoryList, optional): A resource list of stories in which this character appears.,
    //events (EventList, optional): A resource list of events in which this character appears.,
    //series (SeriesList, optional): A resource list of series in which this character appears.

    required public init?(_ map: Map) {

    }

    // Mappable
    public func mapping(map: Map) {
        id                      <- map["id"]
        name                    <- map["name"]
        characterDescription    <- map["description"]
        modified                <- map["modified"]
        thumbnailPath           <- map["thumbnail.path"]
        thumbnailExtension      <- map["thumbnail.extension"]
    }
}