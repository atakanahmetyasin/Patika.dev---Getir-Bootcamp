//
//  SecondVC.swift
//  GetirBootcampWeek2
//
//  Created by Ahmet Yasin Atakan on 29.03.2024.
//

import UIKit

class SecondVC: UIViewController {
    var callBack:  ((String) -> Void)?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @IBAction func saveDidTap(_ sender: Any) {
        guard let text = nameTextField.text else {
            return
        }
        callBack!(text)
        navigationController?.popViewController(animated: true)
    }
    
}
