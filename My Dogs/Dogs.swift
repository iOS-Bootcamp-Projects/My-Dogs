//
//  Dogs.swift
//  My Dogs
//
//  Created by Aamer Essa on 29/11/2022.
//

import UIKit

protocol dogs {
    
   func addNewDogs(dogesName:String,dogsColor:String,dogsFavoriteTreat:String,dogesImage:Data)
    func editDogs(dogesName:String,dogsColor:String,dogsFavoriteTreat:String,dogesImage:Data,destination:Int)
    func deletDoga(destination:Int) 
}
