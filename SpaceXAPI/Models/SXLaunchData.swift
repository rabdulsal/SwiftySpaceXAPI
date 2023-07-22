//
//  SXLaunchData.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import Foundation
/**
 Abstract -- Include following data:
 - Mission Name -- "mission_name"
     - Rocket Name -- "rocket_name"
     - Launch Site Name -- "launch_site" : { "site_name" }
     - Date of Launch -- "launch_date_unix/utc/local"
     - Launch patch image, or default image when not provided by the API -- "links" : { "mission_patch" }
 */
struct SXLaunchData : Codable {
    
    var missionName, rocketName, launchSite, launchDate, launchDetails, missionPatchImgStr, missionPatchImgStrSmall: String
    
    var patchImgURL: URL? {
        return URL(string: missionPatchImgStr)
    }
    
    var patchImgURLSmall: URL? {
        return URL(string: missionPatchImgStrSmall)
    }
    
    var launchDateDisplay : String {
        return SXDateFormatter.MakeHumanReadableDateString(self.launchDate)
    }
    
    // CodingKeys Enum
    enum RootCodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case rocket = "rocket"
        case launchDate = "launch_date_local"
        case launchSite = "launch_site"
        case links = "links"
        case details = "details"
        
        enum RocketCodingKeys: String, CodingKey {
            case rocketName = "rocket_name"
        }
        
        enum LaunchSiteCodingKeys: String, CodingKey {
            case siteName = "site_name"
        }
        enum LinksCodingKeys: String, CodingKey {
            case missionPatchImgStr = "mission_patch"
            case missionPatchImgStrSmall = "mission_patch_small"
        }
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let rocketContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.RocketCodingKeys.self, forKey: .rocket)
        let launchSiteContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.LaunchSiteCodingKeys.self, forKey: .launchSite)
        let linksContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.LinksCodingKeys.self, forKey: .links)
        self.missionName = try rootContainer.decode(String?.self, forKey: .missionName) ?? ""
        self.launchDetails = try rootContainer.decode(String?.self, forKey: .details) ?? ""
        self.rocketName = try rocketContainer.decode(String?.self, forKey: .rocketName) ?? ""
        self.launchSite = try launchSiteContainer.decode(String?.self, forKey: .siteName) ?? ""
        self.launchDate = try rootContainer.decode(String?.self, forKey: .launchDate) ?? ""
        self.missionPatchImgStr = try linksContainer.decode(String?.self, forKey: .missionPatchImgStr) ?? ""
        self.missionPatchImgStrSmall = try linksContainer.decode(String?.self, forKey: .missionPatchImgStrSmall) ?? ""
    }
}
