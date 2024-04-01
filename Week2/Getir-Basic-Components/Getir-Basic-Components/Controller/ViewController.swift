//
//  ViewController.swift
//  Getir-Basic-Components
//
//  Created by Kerim Çağlar on 23.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: UIViewController yaşam döngüsünü araştırınız, methodların kulanım senaryoları için birer örnek yazınız. (loadView gibi methodlarıda araştırınız)
    /*
     
     loadView: Normalde UIViewController tarafından otomatik olarak çağrılan bir metoddur. Ancak ayrı olarak çağırıp görünümü özelleştirmek için kullanılabilir.
     loadIfWeNeeded: Eğer ViewController daha set edilmediyse VC'nin viewini yükler.
     viewDidLoad: View memoryde oluşturulduktan sonra ve bir defa çağrılır. Veri yüklemesi, UI bileşenlerinin ayarlanması gibi senaryolarda kullanılabilir.
     viewWillAppear: View ekranda görünmeden önce çağrılır. Görünüm ekrana her geldiğinde çağrılır. Örnek olarak uygulama açılmadan ekranın ortasında dönen bir activity indicator olabilir.
     viewDidAppear: View ekranda gözüktükten hemen sonra çağrılır. Animasyon kullanacaksak ViewDidAppear içinde kullanabiliriz.
     viewWillDisappear: View ekrandan remove edilmeden hemen önce çağrılır. Örneğin kullanıcı bir form doldurdu ancak kaydetmeden geri butonuna bastı. Kullanıcıya formu kaydetmek ister misiniz? sorusunu burada sorabilriiz.
     viewDidDisappear: View ekrandan remove edildikten hemen sonra çağrılır. Animasyonu burada durdurabiliriz.
     viewWillLayoutSubviews: Görünümün alt görünümleri düzenlenmeden önce çağrılır. Bir view'in alt görünümlerini düzenlemek için kullanabiliriz.
     ViewDidLayoutSubviews: Görünümün alt görünümleri düzenlendikten sonra çağrılır. Bir view'in alt görünümlerini düzenledikten sonra ek düzenlemeler yapmak için kullanabiliriz.
     
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Merhaba uygulama ayağa kalktı")
        
        /*let frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        let label = UILabel(frame: frame)
        label.backgroundColor = .red
        label.text = "Getir Bootcampe hoş geldiniz!"
        //label.textColor = .white
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        //label.font = UIFont(name: "Avenir", size: 20)
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        view.addSubview(label)*/
        
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.gray, for: .normal)
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let message = messageTextField.text, !message.isEmpty else { return }
        messageLabel.text = message
        messageTextField.text = ""
    }
    


}

