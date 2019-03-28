//
//  Room.swift
//  HomeFurniture
//
//  Created by Eliana Boado on 3/5/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//


import Foundation;

class Room {
    let name: String;
    let furniture: [Furniture];
    
    init(name: String, furniture: [Furniture]) {
        self.name = name;
        self.furniture = furniture;
    }
}
