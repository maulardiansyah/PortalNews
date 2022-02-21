//
//  ServicesMethod.swift
//  PortalNews
//
//  Created by Maul on 21/02/22.
//

import Alamofire

extension Services {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default: return .get
        }
    }
}
