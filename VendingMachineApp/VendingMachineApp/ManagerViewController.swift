//
//  ManagerViewController.swift
//  VendingMachineApp
//
//  Created by 조재흥 on 19. 1. 22..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {

    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet var stockLabels: [UILabel]!
    @IBOutlet weak var historyOfPurchaseView: PieGraphView!
    
    //MARK: - Methods
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyOfPurchaseView.becomeFirstResponder()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateNumberOfProductLabel),
                                               name: .didChangeNumberOfProduct,
                                               object: nil)
        
        historyOfPurchaseView.dataSource = VendingMachine.shared
        update(stockLabels: stockLabels)
    }
    
    //MARK: Pirvate
    
    @objc private func updateNumberOfProductLabel(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo else { return }
        guard let numberOfProduct = userInfo[UserInfoKey.numberOfProduct] as? Int else { return }
        guard let labelToUpdate = userInfo[UserInfoKey.labelToUpdate] as? Int else { return }
        
        stockLabels[labelToUpdate - 1].text = "\(numberOfProduct)개"
    }
    
    //MARK: IBAction
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAddBeverageButton(_ sender: UIButton) {
        let tag = sender.tag
        guard let beverageType = Mapper.shared.mapping(by: tag) as? BeverageProduct.Type else { return }
        
        let product = Beverage.produce(product: beverageType)
        
        VendingMachine.shared.add(product: product)
    }
}
