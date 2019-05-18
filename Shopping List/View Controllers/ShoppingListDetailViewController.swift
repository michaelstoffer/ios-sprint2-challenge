//
//  ShoppingListDetailViewController.swift
//  Shopping List
//
//  Created by Michael Stoffer on 5/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ShoppingListDetailViewController: UIViewController {
    
    @IBOutlet var listCountLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    
    var shoppingListController: ShoppingListController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }

    @IBAction func sendOrderTapped(_ sender: UIButton) {
        guard let name = self.nameTextField.text,
            let address = self.addressTextField.text else { return }
        
        self.showAlert(withName: name, withAddress: address)
    }
    
    private func updateViews() {
        if let controller = self.shoppingListController {
            self.listCountLabel.text = "You currently have \(controller.shoppingItemsAdded.count) item(s) in your shopping list."
        }
    }
    
    private func showAlert(withName name: String, withAddress address: String) {
        let alert = UIAlertController(title: "Delivery for \(name)", message: "Your shopping items will be delivered to \(address) in 15 minutes.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
