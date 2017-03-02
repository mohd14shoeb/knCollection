//
//  ImageSlideShowIntention.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class knImageSlideShow: NSObject, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var indicatorPageControl: UIPageControl!
    
    func loadImagesToSlideShow(_ images:[String]) {
        scrollView.delegate = self
        for i in 0 ..< images.count {
            let imageSlide = formatSlide(images[i], slideIndex: i)
            scrollView.addSubview(imageSlide)
        }
        formatPageControl(images.count)
        formatScrollView(images.count)
    }
    
    fileprivate func formatSlide(_ imagesName: String, slideIndex: Int) -> UIImageView {
        let imageSource = UIImage(named: imagesName)
        let imageView = UIImageView(image: imageSource)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        // Set size and position for image slide.
        var frame = scrollView.frame
        frame.origin.x = CGFloat(slideIndex) * scrollView.frame.width
        imageView.frame = frame
        return imageView
    }

    fileprivate func formatPageControl(_ pageCount: Int) {
        indicatorPageControl.backgroundColor = UIColor.black
        indicatorPageControl.numberOfPages = pageCount
    }

    fileprivate func formatScrollView(_ pageCount: Int) {
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(pageCount), height: scrollView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        indicatorPageControl.currentPage = page
    }
}
