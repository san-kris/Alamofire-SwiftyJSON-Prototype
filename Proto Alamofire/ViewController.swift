//
//  ViewController.swift
//  Proto Alamofire
//
//  Created by Santosh Krishnamurthy on 1/27/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    // URL endpoint
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchRequest(searcString: "USA")
    }

    // use Alamofire to make HTTP request
    func fetchRequest(searcString: String) -> Void {
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts",
            "exintro" : "",
            "explaintext" : "",
            "titles" : searcString,
            "indexpageids" : "",
            "redirects" : "1"
          ]
        
        // responseData method returns Data object in response.value
        AF.request(wikipediaURl, method: .get, parameters: parameters).responseData { response in
            // response.result contains .suvvess or .error objects
            // response.data is the data returned from server
            // response.value is the Data object returnd if success
            print(response.result)
            switch response.result{
            case .success(let result):
                // the result is of .success type  and stores data value
                print(result)
            case .failure(let error):
                // the result is of .failure type  and stores data value
                print("Failed too get respoonse \(error)")
            }
            // Value contains the Data response as optional
            print(response.value)
            print("**********************************")
            // print response in console in string format
            debugPrint(response)
            print("**********************************")
            // create a new swiftyJSON object using Data object in API response
            let responseJSON: JSON = JSON(response.value!)
            // query values in response by subscripting JSON object
            let pageID = responseJSON["query"]["pageids"][0]
            print(responseJSON)
        }
        
        /* // Using responseDecodable function to decode API response
        AF.request(wikipediaURl, method: .get, parameters: parameters).responseDecodable(of: HTTPResponse.self, queue: DispatchQueue.main) { response in
            // response.result contains .suvvess or .error objects
            // response.data is the data returned from server
            // response.value is the decoded structure based on Decodable type provided as input
            print(response.result)
            switch response.result{
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
            print(response.value)
            let httpResponse = response.value!
            print (httpResponse.query.pageids.first)
            print("**********************************")
            debugPrint(response)
            
            let responseJSON: JSON = JSON(response.value)
            let pageID = responseJSON["query"]["pageids"][0]
            print(pageID)
        }
         */
    }
}

