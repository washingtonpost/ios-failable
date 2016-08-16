//
//  MarvelCharacter.swift
//  FailableExample
//
//  Copyright (c) 2016 The Washington Post
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import ObjectMapper

public class MarvelCharacter: Mappable {
    var id: Int?
    var name: String?
    var characterDescription: String?
    var modified: Double?
    var thumbnailPath: String?
    var thumbnailExtension: String?
    var thumbnailURL: NSURL? {
        if let thumbnailPath = thumbnailPath,
            thumbnailExtension = thumbnailExtension {
            return NSURL(string: thumbnailPath + "/standard_large." + thumbnailExtension)
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