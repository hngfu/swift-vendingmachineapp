//
//  Products.swift
//  VendingMachineApp
//
//  Created by 조재흥 on 19. 1. 11..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Products: NSObject, NSCoding {
    
    //MARK: - Keys
    
    private let productLinesKey: String = "productLines"
    
    //MARK: Encode, Decode
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(productLines, forKey: self.productLinesKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        productLines = aDecoder.decodeObject(forKey: self.productLinesKey) as! [String: ProductLine]
    }
    
    //MARK: - Properties
    //MARK: Private
    
    private var productLines: [String: ProductLine] = [:]
    
    //MARK: - Methods
    
    func add(product: BeverageProduct) {

        if self.productLines[product.productType()] == nil {
            self.productLines[product.productType()] = ProductLine()
        }
        
        self.productLines[product.productType()]?.add(product)
    }
    
    func buy(productType: BeverageProduct.Type) -> BeverageProduct? {
        
        guard let productLine = self.productLines["\(productType)"] else { return nil }
        guard let product = productLine.buy() else { return nil }
        
        if productLine.isEmpty() {
            self.productLines["\(productType)"] = nil
        }
        
        return product
    }
    
    func updateNumber(of beverageType: BeverageProduct.Type, update: (Int) -> Void) {
        productLines["\(beverageType)"]?.updateNumberLabel(update) ?? update(0)
    }
}
