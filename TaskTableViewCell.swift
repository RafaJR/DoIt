//
//  TaskTableViewCell.swift
//  TaskManager
//
//  Created by Rafa on 12/8/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    //@IBOutlet weak var stateIcon: UIImageView!
    @IBOutlet weak var stateIcon: UIImageView!
    //@IBOutlet weak var time: UILabel!
    @IBOutlet weak var score: UILabel!
    //@IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var CellDescription: UITextView!
    @IBOutlet weak var cellTime: UITextView!
    
    // Content views
    @IBOutlet weak var descriptionCellView: UIView!
    @IBOutlet weak var timeCellView: UIView!
    @IBOutlet weak var scoreCellView: UIView!
    @IBOutlet weak var cellContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
