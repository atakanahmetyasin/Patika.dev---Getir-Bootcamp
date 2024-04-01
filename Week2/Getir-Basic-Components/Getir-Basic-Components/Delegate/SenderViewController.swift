//
//  SenderViewController.swift
//  Getir-Basic-Components
//
//  Created by Kerim Çağlar on 23.03.2024.
//

import UIKit


protocol MessageDelegate: AnyObject {
    func sendMessage(text: String)
}

class SenderViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    weak var delegate: MessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendMessageButton(_ sender: UIButton) {
        guard let text = messageTextField.text else { return }
        delegate?.sendMessage(text: text)
        dismiss(animated: true)
    }
    
}
