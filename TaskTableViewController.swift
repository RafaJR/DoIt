//
//  TaskTableViewController.swift
//  TaskManager
//
//  Created by Rafa on 20/7/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import UIKit
import CoreData

class TaskTableViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext;
    var taskList:[TaskForCellView] = [];
    
    // States of an activity.
    var statePending:State! = nil;
    var stateOnGoing:State! = nil;
    var stateDelayed:State! = nil;
    var stateDone:State! = nil;
    
    // New tasks registration form
    @IBOutlet weak var taskDescription: UITextField!
    @IBAction func onDescriptionClick(sender: UITextField) {
        self.taskDescription.layer.borderWidth = Constants.ONE;
    }
    @IBAction func onDescriptionChange(sender: UITextField) {
        self.taskDescription.layer.borderWidth = Constants.ZERO;
    }
    
    @IBOutlet weak var details: UITextView!
    
    @IBOutlet weak var initDate: UITextField!
    @IBAction func onInitDateChange(sender: UITextField) {
        
        // If the task is not for today, take the initial date introduced by the user by the date picker
        let initDate:NSDate = Constants.initDatePicker.date;
        let initDateString:String = Constants.DateFormatter.stringFromDate(initDate);
        self.initDate.text = initDateString;
        
        self.taskFormCoherentSetter();
        // When editing ends, the border color change to grey to indicate which text field is not being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 0 to make it invisible
        self.initDate.layer.borderWidth = Constants.ZERO;
    }
    @IBAction func onInitDateClick(sender: UITextField) {
        // When editing begins, the border color change to orange to indicate which text field is being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 1 to make it visible
        self.initDate.layer.borderWidth = Constants.ONE;
    }
    
    private func isInitDateToday()->Bool { // Return true if the begining day is today or false in any other case
        return self.initDate.text == Constants.DateFormatter.stringFromDate(NSDate());
        
    }
    
    private func isHoursIntervalCoherent()->Bool {
        if (self.endHour.text!.isEmpty ||
            self.initHour.text!.isEmpty) {
            
            return false;
            
        } else {
            let initHour:NSDate = Constants.hourFormatter.dateFromString(self.initHour.text!)!;
            let endHour:NSDate = Constants.hourFormatter.dateFromString(self.endHour.text!)!;
        
            return self.initDate.text == self.endDate.text &&
                initHour.earlierDate(endHour).isEqualToDate(initHour);
        }
    }
    
    @IBOutlet weak var endDate: UITextField!
    @IBAction func onEndDateChange(sender: UITextField) {
        
        let date = Constants.endDatePicker.date;
        let dateString = Constants.DateFormatter.stringFromDate(date);
        self.endDate.text = dateString;
        
        self.taskFormCoherentSetter();
        
        // When editing ends, the border color change to grey to indicate which text field is not being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 0 to make it invisible
        self.endDate.layer.borderWidth = Constants.ZERO;
    }
    
    @IBAction func onEndDateClick(sender: UITextField) {
        // When editing begins, the border color change to orange to indicate which text field is being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 1 to make it visible
        self.endDate.layer.borderWidth = Constants.ONE;
    }
    
    @IBOutlet weak var initHour: UITextField!
    @IBAction func onInitHourChange(sender: UITextField) {
        
        self.initHour.text = Constants.hourFormatter.stringFromDate(Constants.initHourPicker.date);
        self.taskFormCoherentSetter();
        
        // When editing ends, the border color change to grey to indicate which text field is not being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 0 to make it invisible
        self.initHour.layer.borderWidth = Constants.ZERO;
    }
    @IBAction func onInitHourClick(sender: UITextField) {
        // When editing begins, the border color change to orange to indicate which text field is being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 1 to make it visible
        self.initHour.layer.borderWidth = Constants.ONE;
    }
    
    @IBOutlet weak var endHour: UITextField!
    @IBAction func onEndHourChange(sender: UITextField) {
        self.endHour.text = Constants.hourFormatter.stringFromDate(Constants.endHourPicker.date);
        self.taskFormCoherentSetter();
        // When editing ends, the border color change to grey to indicate which text field is not being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 0 to make it invisible
        self.endHour.layer.borderWidth = Constants.ZERO;
    }
    @IBAction func onEndHourClick(sender: UITextField) {
        // When editing begins, the border color change to orange to indicate which text field is being edited.
        // The border color is orange by deffault, so it's neccesary to set the border width to 1 to make it visible
        self.endHour.layer.borderWidth = Constants.ONE;
    }
    
    @IBOutlet weak var isFunny: UISwitch!
    @IBAction func onIsFunnySwitchClick(sender: UISwitch) {
        // If the task is funny, it can not be boring
        if(self.isFunny.on) {
            self.isBoring.setOn(!self.isFunny.on, animated: true);
        }
    }
    @IBOutlet weak var isBoring: UISwitch!
    @IBAction func onBoringSwitchClick(sender: UISwitch) {
        // If the task is boring, it can not be funny
        if (self.isBoring.on) {
            self.isFunny.setOn(!self.isBoring.on, animated: true);
        }
    }
    @IBOutlet weak var isKind: UISwitch!
    @IBOutlet weak var isHateful: UISwitch!
    @IBOutlet weak var isProfitable: UISwitch!
    
    @IBAction func newTaskRegistration(sender: UIButton) {
        
        let alert:UIAlertView = UIAlertView(title: "Mensaje", message: "Comprobación de funcionalidad", delegate: nil, cancelButtonTitle: "Enterado");
        alert.show();
        
    }
    
    @IBAction private func loadTaskList() {
        //let tarea = NSEntityDescription.insertNewObjectForEntityForName("Tarea", inManagedObjectContext: self.managedObjectContext!) as! Tarea;
        
        var loadedTaskList:[Task] = [];
        //var task:Task = Task();
        //let init_stimated_date:NSDate = NSDate();
        //var finish_stimated_date:NSDate = init_stimated_date.dateByAddingTimeInterval(Constants.oneHourTimeInterval);
        let state:State = NSEntityDescription.insertNewObjectForEntityForName("State", inManagedObjectContext: self.managedObjectContext!) as! State;
        state.name = "Pendiente";
        state.state_description = "Pendiente";
        let properties:NSSet = NSSet();
        var property:Property = NSEntityDescription.insertNewObjectForEntityForName("Property", inManagedObjectContext: self.managedObjectContext!) as! Property;
        property.name = "Divertida";
        property.property_description = "Divertida";
        property.bonus = 10;
        properties.setByAddingObject(property);
        property = NSEntityDescription.insertNewObjectForEntityForName("Property", inManagedObjectContext: self.managedObjectContext!) as! Property;
        property.name = "Aburrida";
        property.property_description = "Aburrida";
        property.bonus = 100;
        properties.setByAddingObject(property);
        
        let now:NSDate = NSDate();
        let oneHourAfter:NSDate = now.dateByAddingTimeInterval(Constants.oneHourTimeInterval);
        
        for(var i = 0; i < 10; i++) {
            
            let task = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: self.managedObjectContext!) as! Task;
            task.short_description = "Simple testing task";
            task.detail = "The details of the testing task must be largest than it's short description";
            task.init_stimated_date = now;
            task.finish_stimated_date = oneHourAfter;
            task.state = state;
            task.properties = properties;
            
            loadedTaskList.append(task);
        }
        let limit = loadedTaskList.count;
        for(var i = 0; i < limit; i++) {
            
            taskList.append(TaskForCellView(task: loadedTaskList[i]));
            
        }
        
    }
    
    // Tasks search form
    @IBOutlet weak var isOnGoing: UISwitch!
    @IBOutlet weak var isToDo: UISwitch!
    @IBOutlet weak var isOverdue: UISwitch!
    @IBOutlet weak var isDone: UISwitch!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.formsInitialization(); // Initializing the form fields.
        self.initialDataCharge(); // Chargeing the initial data for the activities creation (states and properties).
        self.loadTaskList();
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return taskList.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Getting the tasks prepared for list view from the list
        let taskForCellView:TaskForCellView = taskList[indexPath.row] as TaskForCellView;
        //Configuring the cell for the view.
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! TaskTableViewCell;
        
        //Filling the cell values to print.
        cell.stateIcon.image = taskForCellView.stateIcon;
        cell.CellDescription.text = taskForCellView.taskDescription;
        //cell.CellDescription.textAlignment = NSTextAlignment.Center;
        cell.cellTime.text = taskForCellView.time;
        
        //Setting the cell color
        
        let cellBackgroundColor:UIColor = GlobalFunctions.getCellBackgroundColor(indexPath.item);
        
        cell.cellContentView.backgroundColor = cellBackgroundColor;
        cell.descriptionCellView.backgroundColor = Constants.tranparentColor;
        cell.timeCellView.backgroundColor = Constants.tranparentColor;
        cell.scoreCellView.backgroundColor = Constants.tranparentColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        return cell;
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    private func initialDataCharge() {
        
        let stateList:[State] = LocalDataAccess.loadStatesData();
        /*
        let statePending:State! = nil;
        let stateOnGoing:State! = nil;
        let stateDelayed:State! = nil;
        let stateDone:State! = nil;
        */
        
        let stateListCount:Int = stateList.count;
        
        if(!stateList.isEmpty && stateListCount != 0) {
            
        
            for(var i=0; i<stateListCount; i++){
                
                let alert1:UIAlertView = UIAlertView(title: "\(stateList[i].name)", message: "\(stateList[i].state_description)", delegate: nil, cancelButtonTitle: "Aceptar");
                alert1.show();
                
                if(stateList[i].name == Constants.entityStateDelayed) {
                    
                    self.stateDelayed = stateList[i];
                    
                }else if(stateList[i].name == Constants.entityStateDone) {
                    
                    self.stateDone = stateList[i];
                    
                }else if(stateList[i].name == Constants.entityStateOnGoing) {
                    
                    self.stateOnGoing = stateList[i];
                    
                }else if(stateList[i].name == Constants.entityStatePending) {
                    
                    self.statePending = stateList[i];
                    
                }
            
                /*let alert:UIAlertView = UIAlertView(title: "\(stateList[i].name)", message: "", delegate: nil, cancelButtonTitle: "\(stateList[i].state_description)");
                alert.show();*/
                
                /*
                let statePending:State! = nil;
                let stateOnGoing:State! = nil;
                let stateDelayed:State! = nil;
                let stateDone:State! = nil;
                */
            
            
            }
        }
        
        /*let alert1:UIAlertView = UIAlertView(title: "\(self.stateDelayed.name)", message: "\(self.stateDelayed.state_description)", delegate: nil, cancelButtonTitle: "Aceptar");
        alert1.show();
        let alert2:UIAlertView = UIAlertView(title: "\(self.stateDone.name)", message: "\(self.stateDone.state_description)", delegate: nil, cancelButtonTitle: "Aceptar");
        alert2.show();
        let alert3:UIAlertView = UIAlertView(title: "\(self.stateOnGoing.name)", message: "\(self.stateOnGoing.state_description)", delegate: nil, cancelButtonTitle: "Aceptar");
        alert3.show();
        let alert4:UIAlertView = UIAlertView(title: "\(self.statePending.name)", message: "\(self.statePending.state_description)", delegate: nil, cancelButtonTitle: "Aceptar");
        alert4.show();*/
        
        /*let alert1:UIAlertView = UIAlertView(title: "ein?", message: "comol?", delegate: nil, cancelButtonTitle: "Ah!");
        alert1.show();*/
        
    }
    
    private func formsInitialization() {
        
        // Task has no properties by deffault
        self.isFunny.setOn(false, animated: true);
        self.isBoring.setOn(false, animated: true);
        self.isKind.setOn(false, animated: true);
        self.isHateful.setOn(false, animated: true);
        self.isProfitable.setOn(false, animated: true);
        
        // Tasks search shows on going and pending tasks by deffault
        self.isOnGoing.setOn(true, animated: true);
        self.isToDo.setOn(true, animated: true);
        self.isOverdue.setOn(false, animated: true);
        self.isDone.setOn(false, animated: true);
        
        // The task is for today by deffault
        let currentDateStr:String = GlobalFunctions.getCurrentDate();
        self.initDate.text = currentDateStr;
        self.endDate.text = currentDateStr;
        // The task begins at current hour by deffault
        self.initHour.text = GlobalFunctions.getCurrentHour();
        // The task ends at an hour past current hour by deffault
        let endDate:NSDate = NSDate().dateByAddingTimeInterval(Constants.oneHourTimeInterval);
        self.endHour.text = GlobalFunctions.getFormatedHour(endDate);
        
        // Each date field has it's own date picker
        self.initDate.inputView = Constants.initDatePickerContainer; //Constants.initDatePicker;
        self.endDate.inputView = Constants.endDatePickerContainer;
        self.initHour.inputView = Constants.initHourDatePickerContainer;
        self.endHour.inputView = Constants.endHourDatePickerContainer;
        Constants.endHourPicker.date = endDate;
        
        // Text fields border color is orange, but they will be seen grey because the border whith is minor than 1
        self.taskDescription.layer.borderColor = Constants.orangeColor.CGColor;
        self.details.layer.borderColor = Constants.orangeColor.CGColor;
        self.initDate.layer.borderColor = Constants.orangeColor.CGColor;
        self.endDate.layer.borderColor = Constants.orangeColor.CGColor;
        self.initHour.layer.borderColor = Constants.orangeColor.CGColor;
        self.endHour.layer.borderColor = Constants.orangeColor.CGColor;
        
    }
    
    private func taskFormCoherentSetter() { // Make corrections in the dates and the hours fields following coherence rules
        
        // Catching the dates and hours from the form in a NSDate to make easier the operations.
        let initDate:NSDate = Constants.DateFormatter.dateFromString(self.initDate.text!)!;
        var endDate:NSDate = Constants.DateFormatter.dateFromString(self.endDate.text!)!;
        var initHour:NSDate = Constants.hourFormatter.dateFromString(self.initHour.text!)!;
        var endHour:NSDate = Constants.hourFormatter.dateFromString(self.endHour.text!)!;
        let currentDate:NSDate = NSDate();
        
        if(!self.isInitDateEarlierThanEndDate(initDate, endDate: endDate)) { // The end date can't be earlier than the begining date
            
            self.endDate.text = self.initDate.text;
            // Reseting the end date then of doing the correction
            endDate = Constants.DateFormatter.dateFromString(self.endDate.text!)!;
            Constants.endDatePicker.date = endDate;
            
        }
        
        if(self.isTaskBeginingToday()) { // If the task begins today, the begining hour can't be earlier than the curren one.
            
            if(self.isInitDateEarlierThanEndDate(initHour, endDate: currentDate)) {
                self.initHour.text = GlobalFunctions.getCurrentHour();
                //self.endHour.text = GlobalFunctions.getFormatedHour(currentDate.dateByAddingTimeInterval(Constants.oneHourTimeInterval));
                // Reseting the begining and ending hours then of doing the corrections
                initHour = Constants.hourFormatter.dateFromString(self.initHour.text!)!;
                Constants.initHourPicker.date = initHour;
            }
            
            Constants.initHourPicker.minimumDate = currentDate;
            
        }else {
            
            Constants.initHourPicker.minimumDate = nil;
        }
        
        if(self.isTaskForOneOnlyDay()) {
            
            if(!self.isInitDateEarlierThanEndDate(initHour, endDate: endHour)) {
                
                endHour = initHour.dateByAddingTimeInterval(Constants.oneHourTimeInterval);
                self.endHour.text = GlobalFunctions.getFormatedHour(endHour);
                Constants.endHourPicker.date = endHour;
                
            }
            
            Constants.endHourPicker.minimumDate = initHour;
            
        }else {
            
            Constants.endHourPicker.minimumDate = nil;
        }
        
        Constants.endDatePicker.minimumDate = initDate;
        Constants.endDatePicker.maximumDate = initDate.dateByAddingTimeInterval(Constants.timeInterval);
        
    }
    private func isInitDateEarlierThanEndDate(initDate:NSDate, endDate:NSDate)->Bool {
        
        return initDate.earlierDate(endDate).isEqualToDate(initDate);
        
    }
    private func isTaskBeginingToday()->Bool {
        
        return self.initDate.text == GlobalFunctions.getCurrentDate();
        
    }
    private func isTaskForOneOnlyDay()->Bool {
        
        return self.initDate.text == self.endDate.text;
        
    }

}
