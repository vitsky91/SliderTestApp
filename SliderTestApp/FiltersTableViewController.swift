//
//  FiltersTableViewController.swift
//  SliderTestApp
//
//  Created by Vitalii Sydorskyi on 1/26/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import MultiSlider
import UIKit

class FiltersTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var resetBarButton: UIBarButtonItem!
    @IBOutlet weak var applyButton: UIButton!
    
    private let cellId = "CustomTableViewCell"
    private let cellHeight: CGFloat = 84
    private let sectionHeight: CGFloat = 54
    private let numberOfSections = 4
    
    let defaultMinimumValues = [1, 1, 18, 7]
    let defaultMaximumValues = [30, 30, 20, 14]
    
    var filledMinimumValues = [1, 1, 18, 7]
    var filledMaximumValues = [30, 30, 20, 14]
    
    var delegate: MainVCProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTable()
        setupButton()
    }
    
    override func viewDidLayoutSubviews() {
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: CGFloat((sectionHeight + cellHeight) * CGFloat(numberOfSections)))
        
        tableView.reloadData()
    }
    
    
    fileprivate func prepareTable() {
        
        tableView.isScrollEnabled = false
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    private func setupButton() {
        
        applyButton.layer.cornerRadius = 15.0
    }
    
    @IBAction func didResetTapped() {
        
        tableView.reloadData()
        resetBarButton.isEnabled = false
        filledMinimumValues = defaultMinimumValues
        filledMaximumValues = defaultMaximumValues
    }
    
    @IBAction func didSaveButtonTapped() {
        
        delegate.adjustLabels(minArray: filledMinimumValues, maxArray: filledMaximumValues)
        navigationController?.popViewController(animated: true)
    }
}

extension FiltersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomTableViewCell {
            
            cell.config(min: CGFloat(defaultMinimumValues[indexPath.section]), max: CGFloat(defaultMaximumValues[indexPath.section]))
            
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // Sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sectionHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return String(section + 1)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfSections
    }
}

// MARK: - Cell delegate
extension FiltersTableViewController: CellDelegateProtocol {
    
    func segmentValueChangedInCell(cell: CustomTableViewCell) {
        
        let section = tableView.indexPath(for: cell)?.section ?? 0
        
        filledMinimumValues[section] = Int(cell.leftLabel.text?.digits ?? "") ?? 0
        filledMaximumValues[section] = Int(cell.rightLabel.text?.digits ?? "") ?? 0
        
        let isLeftEqual = defaultMinimumValues == filledMinimumValues
        let isRightEqual = defaultMaximumValues == filledMaximumValues
        
        resetBarButton.isEnabled = isLeftEqual && isRightEqual ? false : true
        
    }
    
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
