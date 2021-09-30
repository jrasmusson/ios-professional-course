//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by jrasmusson on 2021-09-28.
//

import UIKit

class OnboardingContainerViewController: UIPageViewController {

    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
            
    var previousIndex = 0
    let nextButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension OnboardingContainerViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        // add the individual viewControllers to the pageViewController
        let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")
        let page2 = OnboardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
        let page3 = OnboardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com.")

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        // Page
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 2)
        ])
    }
}

// MARK: - Actions
extension OnboardingContainerViewController {
    
    // How we change page when pageControl tapped. Can only skip ahead on page at a time.
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let newIndex = sender.currentPage
                
        // compare with previous to set direction
        let direction: UIPageViewController.NavigationDirection
        if previousIndex < newIndex {
            direction = .forward
        } else {
            direction = .reverse
        }
        setViewControllers([pages[sender.currentPage]], direction: direction, animated: true, completion: nil)
        
        previousIndex = newIndex
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        let currentIndex = pageControl.currentPage
        
        if currentIndex >= 0 {
            // next
        }
        
        if currentIndex == pages.count - 1 {
            // ignore
        }
        setViewControllers([pages[pageControl.currentPage + 1]], direction: .forward, animated: true, completion: nil)
        pageControl.currentPage += 1
    }
}

// MARK: - DataSources
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Get the currentIndex from the view controller currently being displayed
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        previousIndex = currentIndex
        
        if currentIndex == 0 {
            return nil                      // Stay on first page
        } else {
            return pages[currentIndex - 1]  // Go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        previousIndex = currentIndex
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // Go next
        } else {
            return nil                      // Stay on last page
        }
    }
}

// MARK: - Delegates

extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
