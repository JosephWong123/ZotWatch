//
//  DepartmentsTableViewController.swift
//  GroupProject
//
//  Created by Atef Kai Benothman on 6/4/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate
{
    func userDidEnterInformation(info:NSString)
}

class DepartmentsTableViewController: UITableViewController
{
    
    var delegate:DataEnteredDelegate? = nil
    
    var arrayDepartments = NSMutableArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        // THIS PASSES THE LINES FROM department_names.txt INTO AN ARRAY
        let bundle = Bundle.main
        let path = bundle.path(forResource: "department_names", ofType: "txt")
        
        let filemgr = FileManager.default
        if filemgr.fileExists(atPath: path!)
        {
            do
            {
                let fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                let readings = fullText.components(separatedBy: "\n") as [String]
                
                for i in 1..<readings.count
                {
                    arrayDepartments.add(readings[i])
                }
                
                //print(arrayDepartments)
                
            }
            catch let error as NSError
            {
                print("Error: \(error)")
            }
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return arrayDepartments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentCell", for: indexPath)
        
        let department = arrayDepartments[indexPath.row]
        
        cell.textLabel?.text = department as? String
        cell.detailTextLabel?.text = ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let department = arrayDepartments[indexPath.row]
        
        if (delegate != nil)
        {
            let information:NSString = department as! NSString
            delegate!.userDidEnterInformation(info: information)
            
            self.navigationController?.popViewController(animated: true)
        }
        
        dismiss(animated: true, completion: nil)
        
    }

    
    
}
