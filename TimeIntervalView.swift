//
//  TimeIntervalView.swift
//  TaskManager
//
//  Created by Rafa on 9/11/15.
//  Copyright © 2015 rafael.jimenez.reina. All rights reserved.
//

import UIKit

class TimeIntervalView: NSObject {
    
    let days:String!;
    let hours:String!;
    let minutes:String!;
    
    init(days:String, hours:String, minutes:String) {
    
        self.days = days;
        self.hours = hours;
        self.minutes = minutes;
        
    }
    
    init(end:NSDate) { //Recibes the end date and inits the time interval from now to the end date.
        
        let dHoursOfDay:Double = Double(Constants.HOURS_OF_THE_DAY);
        let dMinutesOfHour:Double = Double(Constants.MINUTES_OF_AN_HOUR);
        
        
        let timeInterval:NSTimeInterval = end.timeIntervalSinceNow; // Time interval from now to the end date in secons.
        let dTimeInterval:Double = timeInterval.advancedBy(0);      // The previous time interval ina Double value format, to enable mathematical operations.
        
        //Conversion form seconds to days, hours and minutes.
        var dMinutes:Double = dTimeInterval / Double(dHoursOfDay);
        var dHours:Double = dMinutes / Double(dMinutesOfHour);
        let dDays:Double = dHours / Double(dMinutesOfHour);
        
        // Distribution of the time counts for the three scales
        let iDays:Int = Int(dDays);
        dHours = (dDays - Double(iDays)) * dHoursOfDay;
        let iHours:Int = Int(dHours);
        dMinutes = (dHours - Double(iHours)) * dMinutesOfHour;
        let iMinutes:Int = Int(dMinutes);
        
        self.days = String(iDays);
        self.hours = String(iHours);
        self.minutes = String(iMinutes);
        
    }

}
