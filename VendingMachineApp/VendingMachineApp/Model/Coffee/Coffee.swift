//
//  Coffee.swift
//  VendingMachineApp
//
//  Created by moon on 2018. 6. 23..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class Coffee: Beverage {
    override init(name: String, price: Int) {
        super.init(name: name, price: price)
    }
    
    required init() {
        super.init(name: DefaultData.coffee.name, price: DefaultData.coffee.price)
    }
}