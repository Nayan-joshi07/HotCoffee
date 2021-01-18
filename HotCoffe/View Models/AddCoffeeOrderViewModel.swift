//
//  AddCoffeeOrderViewModel.swift
//  HotCoffe
//
//  Created by Nayan joshi on 17/01/21.
//  Copyright © 2021 Nayan joshi. All rights reserved.
//

import Foundation
struct AddCoffeeOrderViewModel
{
    var name:String?
    var email:String?
    var selectedType:String?
    var selectedSize:String?
    var types:[String]
    {
        return CoffeeType.AllCases.map { $0.rawValue.capitalized }
    }
    var sizes:[String]
    {
        return CoffeSize.AllCases.map { $0.rawValue.capitalized }
    }
}
