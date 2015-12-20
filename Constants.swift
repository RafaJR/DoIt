//
//  Constants.swift
//  TaskManager
//
//  Created by Rafa on 26/7/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import UIKit

class Constants {
    
    // Data format patterns
    static let DATE_FORMAT:String = "dd'/'MM'/'yyyy";
    static let HOUR_FORMAT:String = "HH':'mm";
    //static let TASK_LIST_DATE_FORMAT:String = "'Quedan 'dd' dias, 'hh' horas y, 'mm' minutos para finalizar'"
    // Data format formatters
    static let DateFormatter : NSDateFormatter = Constants.getFormatter(Constants.DATE_FORMAT);
    static let hourFormatter : NSDateFormatter = Constants.getFormatter(Constants.HOUR_FORMAT);
    
    // Initial data
    static let MIDNIGHT:String = "00:00";
    //static let timeInterval:NSTimeInterval = 5*24*60*60;
    static let timeInterval:NSTimeInterval = 432000; // Five days
    static let oneHourTimeInterval:NSTimeInterval = 3600; // One hour
    static let oneMinuteInterval:NSTimeInterval = 60; // One minute
    
    // Colors
    static let whiteColor:UIColor = UIColor(white: 1, alpha: 1);
    static let transparentWhiteColor:UIColor = UIColor(white: 1, alpha: 0.3);
    static let orangeColor: UIColor = UIColor(red: 1, green: 88/255, blue: 37/255, alpha: 1);
    static let transparentOrangeColor: UIColor = UIColor(red: 250/255, green: 247/255, blue: 233/255, alpha: 1);//#faf7ea
    static let tranparentColor:UIColor = UIColor(white: 1, alpha: 0);
    
    // Global date picker
    static var initDatePicker:UIDatePicker = Constants.getDatePicker();
    static var endDatePicker:UIDatePicker = Constants.getDatePicker();
    static var initHourPicker:UIDatePicker = Constants.getHourDatePicker();
    static var endHourPicker:UIDatePicker = Constants.getHourDatePicker();
    
    // Date picker view container
    static let initDatePickerContainer:UIView = Constants.getInitDatePickerContainer();
    static let endDatePickerContainer:UIView = Constants.getEndDatePickerContainer();
    static let initHourDatePickerContainer:UIView = Constants.getInitHourPickerContainer();
    static let endHourDatePickerContainer:UIView = Constants.getEndHourPickerContainer();
    
    // Current screen parameters
    static let screenRect:CGRect = UIScreen.mainScreen().bounds; // The dispositive screen size to determine the view entities location.
    static let datePickerWidth:CGFloat = 300; // date picker width
    static let datePickerHeight:CGFloat = screenRect.size.height * 0.5; // Calculation of the parameter to the date picker height of the dispositive.
    static let datePickerViewHeight = datePickerHeight * 0.7;
    static let datePickerHorizontalCenter:CGFloat = (screenRect.size.width - Constants.datePickerWidth) * 0.5; // Calculation of the parameter to horizontally center de date picker view in the dispositive screen.
    static let datePickerButtonsViewVerticalCenter:CGFloat = Constants.datePickerViewHeight + Constants.datePickerVerticalCenter + Constants.datePickerViewHeight * 0.05; // Calculation of the parameter to verticaly center de date picker buttons view.
    static let datePickerVerticalCenter = (Constants.datePickerHeight - Constants.datePickerViewHeight) * 0.5; // Calculation of the parameter to vertically center de date picker view in the dispositive screen.
    //static let datePickerVerticalCenter:CGFloat = 10;
    //static let datePickerButtonViewHeight = Constants.datePickerHeight * 0.15;
    static let datePickerButtonViewHeight = CGFloat(20);

    
    //Magic numbers
    static let ZERO:CGFloat = 0;
    static let ONE:CGFloat = 1;
    static let HOURS_OF_THE_DAY:Int = 24;
    static let MINUTES_OF_AN_HOUR:Int = 60;    
    
    // Preloaded images
    static let completedIcon:UIImage = UIImage(named: "Completed32px.png")!; /*<div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a>             is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>*/
    static let delayedIcon:UIImage = UIImage(named: "Delayed32px.png")!;
    static let onGoingOrPendingIcon:UIImage = UIImage(named: "OnGoingOrPending32px.png")!;
    
    static func getFormatter(format:String)->NSDateFormatter {
        
        let formatter : NSDateFormatter = NSDateFormatter();
        formatter.dateFormat = format;
        
        return formatter;
        
    }
    
    static func getGlobalPickerContainer()->UIView {
        
        let pickerContainer = UIView();
        //[UIView appearanceWhenContainedIn:[UITableView class], [UIDatePicker class], nil].backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        pickerContainer.frame = CGRectMake(Constants.datePickerHorizontalCenter, 0, Constants.datePickerWidth, Constants.datePickerHeight);
        pickerContainer.backgroundColor = Constants.transparentOrangeColor;
        pickerContainer.layer.cornerRadius = 0.5;
        //pickerContainer.alpha = 0.5;
        
        let datePickerButtonsView:UIView = UIView();
        
        datePickerButtonsView.frame = CGRectMake(Constants.datePickerHorizontalCenter, Constants.datePickerButtonsViewVerticalCenter, Constants.datePickerWidth, Constants.datePickerButtonViewHeight);
        datePickerButtonsView.backgroundColor = Constants.transparentOrangeColor;
        
        // Date picker 'OK' and 'Cancel' buttons
        let buttonWidth:CGFloat = Constants.datePickerWidth * 0.45;
        let cancelButton:UIButton = UIButton();
        cancelButton.frame = CGRectMake(0, 0, buttonWidth, Constants.datePickerButtonViewHeight);
        cancelButton.backgroundColor = Constants.orangeColor;
        cancelButton.setTitle("Cancelar", forState: .Normal);
        cancelButton.setTitleColor(Constants.whiteColor, forState: .Normal);
        cancelButton.setTitleShadowColor(Constants.whiteColor, forState: .Normal);
        
        let doneButton:UIButton = UIButton();
        doneButton.frame = CGRectMake(buttonWidth + (Constants.datePickerWidth * 0.1), 0, buttonWidth, Constants.datePickerButtonViewHeight);
        doneButton.backgroundColor = Constants.orangeColor;
        doneButton.setTitle("Introducir", forState: .Normal);
        doneButton.setTitleColor(Constants.whiteColor, forState: .Normal);
        doneButton.setTitleShadowColor(Constants.whiteColor, forState: .Normal);
        
        // Adding de sub-vies to de date picker
        datePickerButtonsView.addSubview(cancelButton);
        datePickerButtonsView.addSubview(doneButton);
        pickerContainer.addSubview(datePickerButtonsView);
        
        return pickerContainer;
        
    }
    
    static func getInitDatePickerContainer()->UIView {
        
        let pickerContainer:UIView = self.getGlobalPickerContainer();
        
        pickerContainer.addSubview(self.initDatePicker);
        
        return pickerContainer;
        
    }
    
    static func getEndDatePickerContainer()->UIView {
        
        let pickerContainer:UIView = self.getGlobalPickerContainer();
        
        pickerContainer.addSubview(self.endDatePicker);
        
        return pickerContainer;
    }
    
    static func getInitHourPickerContainer()->UIView {
        
        let pickerContainer:UIView = self.getGlobalPickerContainer();
        
        pickerContainer.addSubview(self.initHourPicker);
        
        return pickerContainer;
        
    }
    
    static func getEndHourPickerContainer()->UIView {
        
        let pickerContainer:UIView = self.getGlobalPickerContainer();
        
        pickerContainer.addSubview(self.endHourPicker);
        
        return pickerContainer;
        
    }
    
    static func getGlobalDatePicker()->UIDatePicker {
        
        
        //pickerContainer.frame = CGRectMake(0.0, 600.0, 320.0, 300.0)
        //pickerContainer.backgroundColor = UIColor.whiteColor()
        
        //picker.frame    = CGRectMake(0.0, 20.0, 320.0, 300.0)
        
        let datePicker:UIDatePicker = UIDatePicker();
        let date:NSDate = NSDate();
        datePicker.date = date;
        // Not allowed to introduce a date previous to current
        datePicker.minimumDate = date;
        // Not allowed to introduce a date after five days of current
        datePicker.maximumDate = date.dateByAddingTimeInterval(Constants.timeInterval);
        
        // Date picker design patterns
        datePicker.setValue(self.orangeColor, forKeyPath: "textColor") //Date characters color.
        datePicker.backgroundColor = self.whiteColor;
        
        datePicker.frame = CGRectMake(Constants.datePickerHorizontalCenter, Constants.datePickerVerticalCenter, Constants.datePickerWidth, Constants.datePickerViewHeight);
        datePicker.layer.borderWidth = 2;
        datePicker.layer.borderColor = Constants.orangeColor.CGColor;
        
        return datePicker;
        
    }
    
    static func getDatePicker()->UIDatePicker {
    
        let datePicker = self.getGlobalDatePicker();
    
        datePicker.datePickerMode = .Date;
        
        return datePicker;
    }
    
    static func getHourDatePicker()->UIDatePicker {
        
        let datePicker = self.getGlobalDatePicker();
        
        datePicker.datePickerMode = .Time;
        
        return datePicker;
    }
    
    static func resetDataPickers() {
        Constants.initDatePicker = Constants.getGlobalDatePicker();
        Constants.endDatePicker = Constants.getGlobalDatePicker();
        Constants.initHourPicker = Constants.getGlobalDatePicker();
        Constants.endHourPicker = Constants.getGlobalDatePicker();
        
    }
    
    
   
}
