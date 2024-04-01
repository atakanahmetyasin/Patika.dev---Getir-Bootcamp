//
//  PageViewController.swift
//  Getir-Basic-Components
//
//  Created by Kerim Çağlar on 30.03.2024.
//

import UIKit

//HW: UIViewcontroller yaşam döngüsünü araştırınız. Örneklerle birer cümle yazınız. loadView
// CEVAP: Bu proje içerisindeki Controller grubunun içinde ViewController.swift dosyasında cevapladım.
// HW: didSet ve willSet kavramlarını araştırınız Key-Value-Observing KVO
// Cevap: willSet bir property değişmeden hemen önce çağrılır. didSet ise değiştikten hemen sonra çağrılır.
/* Örnek:
   var name: String = "Ahmet" {
 willSet {
     print("The name will be changed from \(name) to the \(newValue)")
 }
 didSet {
     print("The name is changed to the \(name) from \(oldValue)")
 }
}

name = "Mehmet"

   } */

class PageViewController: UIViewController {
    
    var controllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        controllers.append(vc1)
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .yellow
        controllers.append(vc2)
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        controllers.append(vc3)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageVC()
    }
    
    
    private func pageVC() {
        guard let first = controllers.first else { return }
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first], direction: .forward, animated: true)
        present(vc, animated: true)
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        
        let previous = index - 1
        
        return controllers[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else { return nil}
        
        let next = index + 1
        
        return controllers[next]
    }
    
}


// HW: Onboarding page with pagecontrol (PageViewController & CollectionView)
// Otomatik geçişi de deneyebilirsiniz.
// event -> Süt, yumurta -> checkout -> kupon kodu .. ?? (Marketing ekipleri) push
// Firebase, Insider vs gibi event toplama işleri yapılabilir.
// Kampanya banner, üzerinden satış sayısı, cirosu takibi
// Crashclytic !
// deeplink www.getir.com.tr/gunluk?yumurta
// Push notification , local notification ???
