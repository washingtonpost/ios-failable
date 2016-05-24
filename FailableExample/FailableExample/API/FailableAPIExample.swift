//
//  FailableAPIExample.swift
//  FailableExample
//
//  Created by Davis, William on 5/23/16.
//  Copyright © 2016 Washington Post. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension String  {
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)

        CC_MD5(str!, strLen, result)

        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }

        result.dealloc(digestLen)

        return String(format: hash as String)
    }
}

public class FailableAPIExample {

    static let instance = FailableAPIExample()

    let baseURLString = "https://gateway.marvel.com"
    let publicKey = "465d24febe0a74128ce9e47700bf33bc"
    let privateKey = "997943186330da9ceab1dad07e429f94ca7f7e4f"

    private var params: [String: String] {
        var iniParams = ["apikey": publicKey]
        let time = NSDate().timeIntervalSince1970
        let timestamp = String(format: "%.0f", time * 1000)
        iniParams["ts"] = timestamp
        iniParams["hash"] = (timestamp + privateKey + publicKey).md5
        iniParams["limit"] = "50"
        return iniParams
    }
    private var charactersURLString: String {
        return "\(baseURLString)/v1/public/characters"
    }

    public func getMarvelCharacters(completion: ((data: Failable<MarvelCharactersWrapper>) -> Void)?) {
        Alamofire.request(.GET, charactersURLString, parameters: params)
            .responseJSON { response in
                if let JSON = response.result.value,
                    data = JSON["data"] as? [String: AnyObject],
                    characters = Mapper<MarvelCharactersWrapper>().map(data) {
                    completion?(data: .Success(characters))
                } else {
                    let userInfo: [NSObject : AnyObject] = [ NSLocalizedDescriptionKey :
                        NSLocalizedString("No Content", value: "No content available", comment: ""),
                        NSLocalizedFailureReasonErrorKey :
                            NSLocalizedString("No Content", value: "No content available", comment: "")]
                    let error = NSError(domain: "FailableAPIExample", code: 204, userInfo: userInfo)
                    completion?(data: .Failure(error))
                }
        }
    }
}
