//
//  Rover.swift
//  Assessment4
//
//  Created by Colton Brenneman on 6/20/23.
//

import Foundation

//struct TopLevelDictionary: Decodable {
//    let photos: [Photo]
//}
//
//struct Photo: Decodable {
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case sol
//        case imagePath = "img_src"
//        case earthDate = "earth_date"
//        case rover
//    }
//    let id: Int
//    let sol: Int
//    let rover: Rover
//    let imagePath: String
//    let earthDate: String
//}
//
//struct Rover: Decodable {
//    private enum CodingKeys: String, CodingKey {
//        case roverID = "id"
//        case name
//        case launchDate = "launch_date"
//        case camera
//    }
//    let roverID: Int
//    let name: String
//    let launchDate: String
//    let camera: [Camera]
//}
//
//struct Camera: Decodable {
//    private enum CodingKeys: String, CodingKey {
//        case cameraName = "name"
//        case fullCameraName = "full_name"
//    }
//    let cameraName: String
//    let fullCameraName: String
//}
struct TopLevelDictionary: Decodable {
    let photos: [Photo]
}

struct Photo: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case sol
        case imagePath = "img_src"
        case earthDate = "earth_date"
        case camera
        case rover
    }
    
    let id: Int
    let sol: Int
    let imagePath: String
    let earthDate: String
    let camera: Camera // The camera information directly under the photo
    let rover: Rover
}

struct Rover: Decodable {
    private enum CodingKeys: String, CodingKey {
        case roverID = "id"
        case name
        case launchDate = "launch_date"
    }
    
    let roverID: Int
    let name: String
    let launchDate: String
}

struct Camera: Decodable {
    private enum CodingKeys: String, CodingKey {
        case cameraName = "name"
        case fullCameraName = "full_name"
    }
    
    let cameraName: String
    let fullCameraName: String
}
