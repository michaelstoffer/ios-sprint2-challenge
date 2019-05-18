//
//  ShoppingListCollectionViewDelegate.swift
//  Shopping List
//
//  Created by Michael Stoffer on 5/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol ShoppingItemCollectionViewCellDelegate: class {
    func toggleHasBeenAdded(for cell: ShoppingItemCollectionViewCell)
}
