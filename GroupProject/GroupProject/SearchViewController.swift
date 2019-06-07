//
//  SearchViewController.swift
//  GroupProject
//
//  Created by Atef Kai Benothman on 6/4/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

class SearchViewController: UIViewController, DataEnteredDelegate
{

    @IBOutlet weak var departmentNameTextField: UITextField!
    @IBOutlet weak var courseCodeTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
//        GetCourseInfo.findCourses(quarter: 92, year: 2019, dept: "COMPSCI", success: { courseArray in
//            for cours in courseArray {
//                print(cours.courseNum3)
//                print(cours.courseTitle3)
//
//            }
//
//        }) { (Error) in
//            print("\(Error)")
//        }
        
    }

    
    func userDidEnterInformation(info: NSString)
    {
        departmentNameTextField.text = info as String
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "addDept")
        {
            let secondVC:DepartmentsTableViewController = segue.destination as! DepartmentsTableViewController
            
            secondVC.delegate = self
        }
    }
 
    
}
