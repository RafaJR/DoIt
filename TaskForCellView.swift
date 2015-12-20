//
//  TaskForCellView.swift
//  TaskManager
//
//  Created by Rafa on 13/8/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import UIKit

class TaskForCellView: NSObject {
    
    var stateIcon:UIImage!;
    var time:String!;
    var score:String!;
    var taskDescription:String!;
    
    init(task:Task) {
        
        self.stateIcon = Constants.completedIcon;
        self.taskDescription = task.short_description;
        let timeIntervalView:TimeIntervalView = TimeIntervalView(end: task.finish_stimated_date);
        
        self.time = "\(timeIntervalView.days) - \(timeIntervalView.hours) - \(timeIntervalView.minutes)";
        self.score = String(task.getStimatedScore());        
    }
    
    override init(){
        self.taskDescription = "";
        self.time = "";
        self.score = "0";
        self.stateIcon = Constants.completedIcon;
        
    }
   
}