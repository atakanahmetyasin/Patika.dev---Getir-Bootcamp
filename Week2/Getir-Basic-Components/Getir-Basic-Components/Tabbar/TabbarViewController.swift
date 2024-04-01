//
//  TabbarViewController.swift
//  Getir-Basic-Components
//
//  Created by Kerim Çağlar on 24.03.2024.
//

import UIKit

class TabbarViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        guard let tabbar = tabBarController?.tabBar else { return }
        tabbar.backgroundColor = .systemBlue
        tabbar.tintColor = .black
        tabbar.unselectedItemTintColor = .red
        
        tabbar.layer.cornerRadius = 30
        tabbar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //  Yorum içine almak zorunda kaldım çünkü orta buton çıkıntısını yok ediyordu.      tabbar.layer.masksToBounds = true // bu ne işe yarar
        
        // Mask to bound ile clip to fark nedir
        // CEVAP: Ayri bir dosya içerisinde yazıp gitHub'a pushladım.
        
        tabbar.layer.borderWidth = 2
        tabbar.layer.borderColor = UIColor.black.cgColor
        tabbar.items?.forEach { item in
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -50) // Y değerini artırarak öğeleri yukarı hareket ettirir
        }
        //orta buton hafif önde olacak şekilde nasıl yapılıyor örnek yapınız.
        // ÇÖZÜM: CustomTabBarVC oluşturdum. İstenildiği gibi oldu.
        
        // itemlar çok altta normalde daha yukarda durmaz mı? Bunu nasıl yapıyoruz
        // ÇÖZÜM:
        tabbar.items?.forEach { item in
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        }
    }
}
