//
//  FailableAPIExample.swift
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

public enum FailableError: ErrorType {
    case FailableExampleError(String)

    public var description: String {
        switch self {
            case .FailableExampleError(let message):
                return message
        }
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

    public func getMarvelCharacters(completion: ((data: Failable<[MarvelCharacter]>) -> Void)?) {
        Alamofire.request(.GET, charactersURLString, parameters: params)
            .responseJSON { response in
                if let JSON = response.result.value,
                    data = JSON["data"] as? [String: AnyObject],
                    characters = Mapper<MarvelCharacter>().mapArray(data["results"]) {
                    completion?(data: .Success(characters))
                } else {
                    completion?(data: .Failure(FailableError.FailableExampleError("no results")))
                }
        }
    }
}
