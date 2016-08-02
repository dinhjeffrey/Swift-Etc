/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import Alamofire
import SwiftyJSON

struct Definition {
    let title: String
    let description: String
    let imageURL: NSURL?
}

class DuckDuckGo {
    
    enum ResultType: String {
        case Answer = "A"
        case Exclusive = "E"    // Exclusive results include special cases like calculations
        
        // This uses SwiftyJSON to extrapolate the necessary data from the JSON response and construct a Definition containing a title, a description and an image URL.
        func parseDefinitionFromJSON(json: JSON) -> Definition {
            switch self {
            case .Answer:
                let heading = json["Heading"].stringValue
                let abstract = json["AbstractText"].stringValue
                let imageURL = NSURL(string: json["Image"].stringValue)
                
                return Definition(title: heading, description: abstract, imageURL: imageURL)
            case .Exclusive:
                let answer = json["Answer"].stringValue
                
                return Definition(title: "Answer", description: answer, imageURL: nil)
            }
        }
    }
    func performSearch(searchTerm: String, completion: ((definition: Definition?) -> Void)) {
        //1
        let parameters: [String: AnyObject] = ["q": searchTerm, "format": "json", "pretty": 1,
                                               "no_html": 1, "skip_disambig": 1]
        // 2
        Alamofire.request(.GET, "https://api.duckduckgo.com", parameters: parameters).responseJSON {
            _, _, result in
            //3
            if result.isFailure {
                completion(definition: nil)
            }
            
            //4 Optionally, bind the JSON response object to ensure it has a value, and then use it to construct a SwiftyJSON JSON struct.
            if let jsonObject: AnyObject = result.value {
                let json = JSON(jsonObject)
                
                //5 Next, grab the value for the Type key from the JSON, and use it to construct a ResultType enum, which is declared at the top of DuckDuckGo.swift.
                if let jsonType = json["Type"].string, resultType = ResultType(rawValue: jsonType) {
                    
                    //6 Finally, tell the result type to parse the definition out of the provided JSON object.
                    let definition = resultType.parseDefinitionFromJSON(json)
                    completion(definition: definition)
                }
            }
        }
    }
}
