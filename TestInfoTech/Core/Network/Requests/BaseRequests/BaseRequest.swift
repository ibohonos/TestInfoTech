//
//  BaseRequest.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

protocol BaseRequest {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var params: [String: Any]? { get set }
    var headers: [String: String]? { get set }
}
