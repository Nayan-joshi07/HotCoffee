//
//  AddOrderViewController.swift
//  HotCoffe
//
//  Created by Nayan joshi on 16/01/21.
//  Copyright © 2021 Nayan joshi. All rights reserved.
//

import Foundation
import UIKit
protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order:Order,controller:UIViewController)
    func addCoffeeOrderViewControllerDidClose(controller:UIViewController)
}
class AddOrderViewController : UITableViewController,UITableViewDelegate,UITableViewDataSource
{
    var delegate:AddCoffeeOrderDelegate?
    private var vm = AddCoffeeOrderViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var emailTextField:UITextField!
    private var coffeeSizesSegmentedControl:UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private  func setupUI()
    {
        self.coffeeSizesSegmentedControl = UISegmentedControl(items:self.vm.sizes)
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentedControl)
        self.coffeeSizesSegmentedControl.topAnchor.constraints(equalTo:self.tableView.bottomAnchor,constant:20).isActive= true
        self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive= true
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell",for:indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    @IBAction func close()
    {
        if let delegate = self.delegate
        {
            delegate.addCoffeeOrderViewControllerDidClose(controller: self)
        }
    }
    @IBAction func save()
    {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let seletedSize = self.coffeeSizesSegmentedControl.titleForSegment(at:self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow else{
            fatalError("Error in selecting Coffee")
        }
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = seletedSize
        self.vm.selectedType = self.vm.types[indexPath.row]
        Webservice().load(resource: Order.create(vm: self.vm)){
            result in
            switch result
            {
            case .success(let order):
                if let order = order,
                    let delegate = self.delegate{
                    DispatchQueue.main.asyc
                        {
                            delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
