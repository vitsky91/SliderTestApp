//
//  CustomTableViewCell.swift
//  SliderTestApp
//
//  Created by Vitalii Sydorskyi on 1/26/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import UIKit
import MultiSlider
import CoreGraphics

protocol CellDelegateProtocol {
    func segmentValueChangedInCell(cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var multiSlider: MultiSlider!
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    private(set) var minValue: CGFloat = 0
    private(set) var maxValue: CGFloat = 0
    
    var delegate: CellDelegateProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(min: CGFloat, max: CGFloat) {
        
        multiSlider.minimumValue = min
        multiSlider.maximumValue = max
        
        minValue = min
        maxValue = max
        
        multiSlider.value = [min, max]
        
        let leftLabelText = String(Int(min))
        let rightLabelText = String(Int(max))
        
        leftLabel.text = leftLabelText + " ночь"
        rightLabel.text = maxValue != max ? "\(rightLabelText) ночь" : "Более \(rightLabelText) ночей"
        multiSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {

        let leftLabelText = String(Int(slider.value.first.value ?? 0))
        let rightLabelText = String(Int(slider.value.last.value ?? 0))
        
        leftLabel.text = leftLabelText + " ночь"
        rightLabel.text = maxValue != slider.value.last.value ?? 0 ? "\(rightLabelText) ночь" : "Более \(rightLabelText) ночей"
        
        delegate?.segmentValueChangedInCell(cell: self)
    }
}
