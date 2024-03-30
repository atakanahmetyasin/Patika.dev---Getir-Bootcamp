

/* --- Ödev: Notification Center ile addObserver sonrası memory leak oluşmaması için ne yapmalı.
   --- Cevap: deInit içerisinde removeObserver(self) metodunu kullanmalıyız.
 
   --- Ödev: Closure ile veri taşıma:
   --- Cevap: SecondVC içerisinde, var callBack:  ((String) -> Void)? oluşturdum ve gerekli kodları yazdım. Başarıyla closure ile veriyi taşıdım.



*/
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func goNextPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        vc.callBack = { text in
            self.nameLabel.text = "Your name is: \(text)"
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

