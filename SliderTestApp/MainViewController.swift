//
//  MainViewController.swift
//  SliderTestApp
//
//  Created by Vitalii Sydorskyi on 1/26/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import UIKit

protocol MainVCProtocol {
    func adjustLabels(minArray: [Int], maxArray: [Int])
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    
    var firstLabelValue = (0, 0)
    var secondLabelValue = (0, 0)
    var thirdLabelValue = (0, 0)
    var fourLabelValue = (0, 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateLabels()
    }
    
    func updateLabels() {
        
        firstLabel.text = "Выбрано ночей от " + String(firstLabelValue.0) + " до " + String(firstLabelValue.1)
        secondLabel.text = "Выбрано ночей от " + String(secondLabelValue.0) + " до " + String(secondLabelValue.1)
        thirdLabel.text = "Выбрано ночей от " + String(thirdLabelValue.0) + " до " + String(thirdLabelValue.1)
        fourLabel.text = "Выбрано ночей от " + String(fourLabelValue.0) + " до " + String(fourLabelValue.1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? FiltersTableViewController {
            dest.delegate = self
        }
    }


}

extension MainViewController: MainVCProtocol {
    
    func adjustLabels(minArray: [Int], maxArray: [Int]) {
        
        firstLabelValue.0 = minArray[0]
        firstLabelValue.1 = maxArray[0]
        
        secondLabelValue.0 = minArray[1]
        secondLabelValue.1 = maxArray[1]
        
        thirdLabelValue.0 = minArray[2]
        thirdLabelValue.1 = maxArray[2]
        
        fourLabelValue.0 = minArray[3]
        fourLabelValue.1 = maxArray[3]
    }
    
    
}

