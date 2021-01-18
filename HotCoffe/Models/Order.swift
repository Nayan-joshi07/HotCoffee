//
//  Order.swift
//  HotCoffe
//
//  Created by Nayan joshi on 16/01/21.
//  Copyright © 2021 Nayan joshi. All rights reserved.
//

import Foundation
enum CoffeeType:String,Codable,CaseIterable
{
    case cappuccino
    case latte
    case espressino
    case cortado
}
enum CoffeSize:String,Codable,CaseIterable
{
    case small
    case medium
    case large
}
struct Order:Codable
{
    let name: String
    let email:String
    let type:String
    let size:String
}
extension Order
{
    static func create(vm:AddCoffeeOrderViewModel) -> Resource<Order?>
    {
        static var all:Resource<[Order]> =
        {
            guard let url = URL(string:"http://guarded-retreat-82533.herokuapp.com")
                else{
                    fatalError("URL is Incorrect")
            }
            return Resource<[Order]>(url:url)
        }()
        let order = Order(vm)
        guard let url = URL(string:"http://guarded-retreat-82533.herokuapp.com")
            else{
                fatalError("URL is Incorrect")
        }
        guard let data = try?JSONEncoder().encode(order)else
        {
            fatalError("Error encoding order!")
        }
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        return resource
    }
}
extension Order
{
    init?(_ vm: AddCoffeeOrderViewModel)
    {
        guard let name = vm.name,
        let email = vm.email,
            let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
            let selectedSize = CoffeSize(rawValue: vm.selectedSize!.lowercased()),else{
        return nil
    }
    self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
}
}
