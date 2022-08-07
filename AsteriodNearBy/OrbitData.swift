//
//  OrbitData.swift
//  AsteriodNearBy
//
//  Created by Admin on 05/08/22.
//

import Foundation

struct OrbitData: Decodable {
    let element_count: Int
    let near_earth_objects: [String: [Astro]]

    
//    IN CASE OWN VALUE_NAME CONVENTION
//    enum CodingKeys: String, CodingKey {
//        case elementCount = "element_count"
//        case nearEarthObjects = "near_earth_objects"
//    }
}

struct Astro: Codable {
    let id: String
    let name: String
}

//struct OrbitData: Decodable {
//    let element_count: Int
   // let near_earth_objects: Objects
    
//    enum CodingKeys: String, CodingKey {
//        case element_count
//        case near_earth_objects
//        
//    }
    
//    init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.element_count = try container.decode(Int.self, forKey: .element_count)
//        self.near_earth_objects = try container.decode(Objects.self, forKey: .near_earth_objects)
//
//    }
//}

//struct Objects: Decodable {
//
//
//    let _date: [Asteriod]
//}
//
//
//struct Asteriod: Decodable {
//    let id: String
//    let name: String
//}


struct RelativeVelocity: Codable {
    let kmPerSecond: String
    let kmPerHour: String
    let milesPerHour: String
    
    enum CodingKeys: String, CodingKey {
        case kmPerSecond = "kilometers_per_second"
        case kmPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

struct MissDistance: Codable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
}

struct CloseApproachData: Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String
    let epochDateCloseApproach: Int64
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: String
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

struct Asteriod: Codable {
    let id: String
    let name: String
    let neoReferenceId: String
    let nasaJPLUrl: String
    let absoluteMagnitude: Double
    let estimatedDiameter: [String: [String:Double]]
    let isPotentiallyHazardousAsteriod: Bool
    let closeApproachData: [CloseApproachData]
    let isSentryObject: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case neoReferenceId = "neo_reference_id"
        case nasaJPLUrl = "nasa_jpl_url"
        case absoluteMagnitude = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteriod = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}

struct Links: Codable {
    let prev: String
    let next: String
    let current: String
    
    enum CodingKeys: String, CodingKey {
        case prev
        case next
        case current = "self"
    }
}

struct Asteriods: Codable {
    let links: Links
    let elementCount: Int
    let nearEarthObjects: [String: [Asteriod]]
    
    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}
