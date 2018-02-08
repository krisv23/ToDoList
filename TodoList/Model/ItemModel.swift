//
//  itemModel.swift
//  TodoList
//
//  Created by Kristopher Valas on 2/7/18.
//  Copyright © 2018 Kristopher Valas. All rights reserved.
//

import Foundation

class ItemModel {
    
    var title : String
    var isChecked : Bool
    
    init(_ title : String, _ isChecked : Bool) {
        self.title = title
        self.isChecked = isChecked
    }
    
}
