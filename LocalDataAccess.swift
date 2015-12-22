//
//  LocalDataAccess.swift
//  DoIt
//
//  Created by Rafa on 20/12/15.
//  Copyright © 2015 rafael.jimenez.reina. All rights reserved.
//

import UIKit
import CoreData

class LocalDataAccess {
    
    // Declareation of the neccesary contexto for the data entities management.
    static let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext;
    
    
    // Method to charge de activities states from local data-base. If they doesn't exist, they will be created.
    static func loadStatesData()->[State]{
    
        //var stateList:[NSManagedObject] = []; // Array to get the full state list from de local data-base.
        var stateList:[State] = []; // Array to get the full state list from de local data-base.
        
        let entityState = NSEntityDescription.entityForName(Constants.entityState, inManagedObjectContext: LocalDataAccess.managedObjectContext!); // Definition of the entity type for the data-base request.
        
        let requestStates = NSFetchRequest(); // Declaration of the request to get the states from the local data-base.
        requestStates.entity = entityState; // Indication for the request of the entity type previously created.
        
        var error:NSError?; // var to save a possible error occurred during the request
        
        do {
            
            stateList = try managedObjectContext?.executeFetchRequest(requestStates) as! [State]; // Execution of the request to get the full state list from the data-base.
            
        } catch let error1 as NSError { // If any error happens, it's catched and the execution of the app is not stopped.
            error = error1
            stateList = [];
            let alert:UIAlertView = UIAlertView(title: "Error", message: "Error de consulta en la base de datos local. \(error?.localizedFailureReason)", delegate: nil, cancelButtonTitle: "Aceptar");
            alert.show();
        };
        
        if (stateList.isEmpty || stateList.count == 0) {
            
            //let alert:UIAlertView = UIAlertView(title: "Error", message: "No se han encontrado estados para las actividades en la base de datos.", delegate: nil, cancelButtonTitle: "Lo siento");
            //alert.show();
            
            let statePending:State = NSEntityDescription.insertNewObjectForEntityForName(Constants.entityState, inManagedObjectContext: self.managedObjectContext!) as! State; // Declaration of the entity type for saving.
            statePending.name = Constants.entityStatePending; // State data charge
            statePending.state_description = "Todavía falta algún tiempo para que de comienzo la realización de la actividad."; //State data Charge.
            //stateList.append(statePending);
            
            let stateOnGoing:State = NSEntityDescription.insertNewObjectForEntityForName(Constants.entityState, inManagedObjectContext: self.managedObjectContext!) as! State; // Declaration of the entity type for saving.
            stateOnGoing.name = Constants.entityStateOnGoing; // State data charge
            stateOnGoing.state_description = "La actividad está en marcha."; //State data Charge.
            //stateList.append(stateOnGoing);
            
            let stateDelayed:State = NSEntityDescription.insertNewObjectForEntityForName(Constants.entityState, inManagedObjectContext: self.managedObjectContext!) as! State; // Declaration of the entity type for saving.
            stateDelayed.name = Constants.entityStateDelayed; // State data charge
            stateDelayed.state_description = "La actividad ya debería haber concluido ¡Lleva retraso!"; //State data Charge.
            //stateList.append(stateDelayed);
            
            let stateDone:State = NSEntityDescription.insertNewObjectForEntityForName(Constants.entityState, inManagedObjectContext: self.managedObjectContext!) as! State; // Declaration of the entity type for saving.
            stateDone.name = Constants.entityStateDone; // State data charge
            stateDone.state_description = "Enhorabuena. Ya has terminado esta activdad."; //State data Charge.
            //stateList.append(stateDone);
            
            do {
                try managedObjectContext?.save();
            } catch let error2 as NSError {
                error = error2;
                stateList = [];
                let alert:UIAlertView = UIAlertView(title: "Error", message: "Ha ocurrido un error en la actualización de los estados de las avtividades. \(error?.localizedFailureReason)", delegate: nil, cancelButtonTitle: "Aceptar");
                alert.show();
            };
            
            self.loadStatesData(); // Reccursive call to get the saved states from local data-base.
            
            
        } /*else {
            
            // get your app managemenent context
            
            let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
            let context = appDel.managedObjectContext!;
            let fetchRequest = NSFetchRequest(entityName:"Locations");
            
            var error: NSError?
            let locationsArray = context.executeFetchRequest(fetchRequest); //executeFetchRequest(fetchRequest,error: &error)!;
            context.deleteObject(locationsArray[rowIndex.row] as NSManagedObject)
            
            var error:NSError? = nil
            if (!managedContext.save(&error)){
                abort()
            }
            
            for(var i = 0; i < stateList.count; i++) {
                
                context.deleteObject(stateList[i]);
            }
            
        }*/
        
        return stateList;
        
        
    }
    
    /*static func guardar(sender: AnyObject) {
        
        let tarea = NSEntityDescription.insertNewObjectForEntityForName("Tarea", inManagedObjectContext: self.managedObjectContext!) as! Tarea;
        
        tarea.texto = txtTarea.text!;
        
        var error:NSError?;
        
        do {
            try managedObjectContext?.save()
        } catch let error1 as NSError {
            error = error1
        };
        
        
        if let err = error {
            //error al guardar
            let alert:UIAlertView = UIAlertView(title: "Error", message: "Error al guardar", delegate: nil, cancelButtonTitle: "ok");
            alert.show();
        }else{
            //objeto guardado
            txtTarea.text = "";
            let alert:UIAlertView = UIAlertView(title: "Mensaje", message: "Tarea guardada correctamente", delegate: nil, cancelButtonTitle: "ok");
            alert.show();
        }
        
    }*/

}
