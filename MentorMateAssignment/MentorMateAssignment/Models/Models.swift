//
//  LocationModel.swift
//  MentorMateAssignment
//
//  Created by Zain Ali on 5/21/22.
//

import Foundation

struct RootModel: Codable
{
    var results: [LocationModel]
}

struct LocationModel: Codable
{
    var fsq_id: String
    var name: String
}
