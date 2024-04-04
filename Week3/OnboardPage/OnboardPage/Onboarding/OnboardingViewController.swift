//
//  OnboardingViewController.swift
//  OnboardPage
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pages: [OnboardingModel] = []
    var currentPage = 0 {
            didSet {
                pageControl.currentPage = currentPage
                if currentPage == pages.count - 1 {
                    nextButton.setTitle("Get Started", for: .normal)
                } else {
                    nextButton.setTitle("Next", for: .normal)
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pages = [
            OnboardingModel(image: UIImage(systemName: "play.house")!, title: "FirstPage", description: "First Page Description"),
            OnboardingModel(image: UIImage(systemName: "homepodmini")!, title: "Second Page", description: "Second Page Description."),
            OnboardingModel(image: UIImage(systemName: "house")!, title: "Third Page", description: "Third Page Description")
                ]
                pageControl.numberOfPages = pages.count
        collectionView.contentSize = CGSize(width: 50, height: 100)
            }
        
    @IBAction func nextButtonDidTap(_ sender: Any) {
        if currentPage == pages.count - 1 {
            if let controller = storyboard?.instantiateViewController(identifier: "LoginView") as? LoginViewController {
                controller.modalPresentationStyle = .fullScreen
                controller.modalTransitionStyle = .coverVertical
                present(controller, animated: true, completion: nil)
            }
        } else {
            self.collectionView.isPagingEnabled = false // ios 14 scrollToItem bugı için çözüm
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.isPagingEnabled = true // ios 14 scrollToItem bugı için çözüm
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(pages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
