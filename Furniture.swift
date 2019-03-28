//
//  Furniture.swift
//  HomeFurniture
//
//  Created by Eliana Boado on 3/5/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//


import Foundation;

class Furniture {
    let name: String;
    let description: String;
    var imageData: Data?;
    
    init(name: String, description: String, imageData: Data? = nil) { //default parameter value
        self.name = name;
        self.description = description;
        self.imageData = imageData;
    }
}
