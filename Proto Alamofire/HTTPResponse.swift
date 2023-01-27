//
//  HTTPResponse.swift
//  Proto Alamofire
//
//  Created by Santosh Krishnamurthy on 1/27/23.
//

import Foundation

struct HTTPResponse: Decodable{
    let query: Query
}

struct Query: Decodable {
    let pageids: [String]
}
