//
//  CharacterModel.swift
//  RM-API
//
//  Created by Rosendo Vazquez on 14/11/22.
//

import Foundation

struct CharacterModel: Codable {
    var info:Info?
    var results:[CharacterApi]?
}

struct CharacterApi : Codable {
    var id:Int?
    var name:String?
    var status:String?
    var species:String?
    var type:String?
    var gender:String?
    var origin:Item?
    var location:Item?
    var image:String?
    var episode:[String]?
    var url:String?
    var created:String?
}

struct Item : Codable {
    var name:String?
    var url:String?
}

struct Info : Codable{
    var count:Int?
    var pages:Int?
    var next:String?
    var prev:String?
}
