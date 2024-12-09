//
//  AWError.swift
//  Aware
//
//  Created by christian on 10/25/24.
//

import Foundation

enum AWError: LocalizedError, Equatable {
    case authNotDetermined
    case sharingDenied(quantityType: String)
    case noData
    case unableToCompleteRequest
    case invalidInputValue
    
    var errorDescription: String? {
        switch self {
        case .authNotDetermined:
            "Need Access to Health Data"
        case .sharingDenied(let quantityType):
            "No Write Access for \(quantityType)"
        case .noData:
            "No Data"
        case .unableToCompleteRequest:
            "Unable to Complete Request"
        case .invalidInputValue:
            "Invalid Input"
        }
    }
    
    var failureReason: String {
        switch self {
        case .authNotDetermined:
            "You have not granted Steps access to your Health Data. Please visit Settings > Health > Data Access & Devices."
        case .sharingDenied(let quantityType):
            "You have not granted access to upload your \(quantityType) data. \n\nYou can change this in Settings > Health > Data Access & Devices"
        case .noData:
            "There is no data for this Health metric."
        case .unableToCompleteRequest:
            "Unable to complete your request at this time. Please try again later."
        case .invalidInputValue:
            "Input value must be a number with a maxium of one decimal place."
        }
    }
}
