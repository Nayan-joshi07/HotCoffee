//
//  OrderViewModel.swift
//  HotCoffe
//
//  Created by Nayan joshi on 16/01/21.
//  Copyright © 2021 Nayan joshi. All rights reserved.
//

import Foundation
class OrderListViewModel
{
    var ordersViewModel:[OrderViewModel]
    init()
    {
        self.ordersViewModel = [ordersViewModel]()
    }
}
extension OrderListViewModel
{
    func orderViewModel(at index:Int) -> OrderViewModel
    {
        return self.ordersViewModel[index]
    }
}
struct OrderViewModel
{
    let order : Order
}
extension OrderViewModel
{
    var name:String{
    return self.order.name
    }
    var email:String
    {
        return self.order.email
    }
    var type:String
    {
        return self.order.type.rawValue.capitalized
    }
    var size:String
    {
        return self.order.size.rawValue.capitalized
    }
}
