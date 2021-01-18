//
//  OrderTableViewController.swift
//  HotCoffe
//
//  Created by Nayan joshi on 16/01/21.
//  Copyright © 2021 Nayan joshi. All rights reserved.
//

import Foundation
import UIKit

class OrderTableViewController : UITableViewController,AddCoffeeOrderDelegate
{
    var orderListViewModel = OrderListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
         controller.dismiss(animated: true, completion: nil)
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row:self.orderListViewModel.ordersViewModel.count-1,ection:0)], with: .automatic)
    }
    private func populateOrders()
    {
        Webservice().load(resource: Order.all)[weak self]
        {
            result in
            switch result
            {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nacC = segue.destination as? UINavigationController,
        let addCoffeeOrderVC = navC.viewController.first as?AddOrderViewController
            else
        {
            faltalError("Error performing Segue!")
        }
        addCoffeeOrderVC.delegate = self
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.orderListViewModel.ordersViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell",for:indexPath)
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        return cell
    }
}
