//
//  GobalFunctions.swift
//  TaskManager
//
//  Created by Rafa on 26/7/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import UIKit

class GlobalFunctions {
    static func getCurrentDate()->String { // Returns de current date in a String with the format 'dd/MM/yyyy'
        
        let currentDate:String = Constants.getFormatter(Constants.DATE_FORMAT).stringFromDate(NSDate());
        return currentDate;
        
    }
    
    static func getCurrentHour()->String { // Returns de current hour in a String with the format 'HH:mm'
        
        let currentHour:String = Constants.getFormatter(Constants.HOUR_FORMAT).stringFromDate(NSDate());
        return currentHour;
        
    }
    static func getFormatedHour(date:NSDate)->String { // Returns de current hour in a String with the format 'HH:mm'
        
        let currentHour:String = Constants.getFormatter(Constants.HOUR_FORMAT).stringFromDate(date);
        return currentHour;
        
    }
    
    static func getTimeIntervalFromNow(end:NSDate)->String {
        
        let dHoursOfDay:Double = Double(Constants.HOURS_OF_THE_DAY);
        let dMinutesOfHour:Double = Double(Constants.MINUTES_OF_AN_HOUR);
        
        
        let timeInterval:NSTimeInterval = end.timeIntervalSinceNow;
        let dTimeInterval:Double = timeInterval.advancedBy(0);
        
        var dMinutes:Double = dTimeInterval / Double(dHoursOfDay);
        var dHours:Double = dMinutes / Double(dMinutesOfHour);
        let dDays:Double = dHours / Double(dMinutesOfHour);
        
        
        let iDays:Int = Int(dDays);
        dHours = (dDays - Double(iDays)) * dHoursOfDay;
        let iHours:Int = Int(dHours);
        dMinutes = (dHours - Double(iHours)) * dMinutesOfHour;
        let iMinutes:Int = Int(dMinutes);
        
        //return Constants.getFormatter(Constants.TASK_LIST_DATE_FORMAT).stringFromDate(date);
        return "\(iDays) - \(iHours) - \(iMinutes)";
        
    }
    
    static func getCellBackgroundColor(position:Int) -> UIColor {
        
        //var backgroundColor:UIColor = Constants.whiteColor;
        
        if (position % 2 == 0) {
            
            return Constants.transparentOrangeColor;
            
        } else {
            
            return Constants.whiteColor;
            
        }
        
    }
    
    /*static func getGlobalDatePicker(date:NSDate)->UIDatePicker {
        
        var datePicker:UIDatePicker = UIDatePicker();
        // Not allowed to introduce a date previous to the parameter one
        datePicker.minimumDate = date;
        // Not allowed to introduce a date after five days of current
        var timeInterval:NSTimeInterval = 5*24*60*60;
        datePicker.maximumDate = date.dateByAddingTimeInterval(timeInterval);
        
        return datePicker;
        
    }*/
    
   
}
