//
//  NSErrorExtensions.swift
//  CTFS_Wallet
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit

//MARK: Error Codes
enum NetworkStatusCode:Int {
    case REQUEST_SUCCESS  = 200
    case REQUEST_TIMEOUT = -1001
}
//MARK: Error Message
enum ErrorManager:Error
{
    
    case NoInternetAvaialble
    case NoBaseUrlAvailable
    case NoApiResponse
    case JsonParsingError
    case HttpError(statusCode:Int)
    case UnkonwnError
    
    var descrption : String
    {
        switch self {
        case .NoInternetAvaialble:
            return "Its seems to be Offline"
        case .NoBaseUrlAvailable:
            return "Api basr url not "
        case .JsonParsingError:
            return "Not valid Json"
        case .HttpError(let statusCode):
            return generateHttpErrorMessage(statusCode: statusCode)
        default:
            return "Unknown Error"
        }
    }
}


// MARK: Create Http Error Message based on Status Code
func generateHttpErrorMessage(statusCode:Int) -> String
{
    switch statusCode {
    case NetworkStatusCode.REQUEST_SUCCESS.rawValue:
         return "Network Call Success"
    case NetworkStatusCode.REQUEST_TIMEOUT.rawValue:
        return "Request Time Out For Api Calls"
    default:
         return "Unknown Error"
    }
}








