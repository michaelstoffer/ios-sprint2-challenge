//
//  ShoppingItemCollectionViewCell.swift
//  Shopping List
//
//  Created by Michael Stoffer on 5/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ShoppingItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var hasBeenAddedLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    var shoppingItem: ShoppingItem? {
        didSet {
            self.updateViews()
        }
    }
    
    weak var delegate: ShoppingItemCollectionViewCellDelegate?

    @IBAction func shoppingItemTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenAdded(for: self)
    }
    
    private func updateViews() {
        guard let shoppingItem = self.shoppingItem else { return }
        
        self.nameLabel.text = shoppingItem.name
        self.imageView.image = UIImage(named: shoppingItem.name)
        self.hasBeenAddedLabel.text = shoppingItem.hasBeenAdded ? "Added" : "Not Added"
    }
}
