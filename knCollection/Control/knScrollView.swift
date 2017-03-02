//
//  knScrollView.swift
//  kynguyenCodebase
//
//  Created by Ky Nguyen on 9/29/16.
//  Copyright © 2016 kynguyen. All rights reserved.
//

import UIKit

class knScrollView: knViewBase, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        if shouldLoadMore(scrollView) {
            perform(#selector(loadMore), with: nil, afterDelay: 0.25)
        }
    }
    
    fileprivate func shouldLoadMore(_ scrollView: UIScrollView) -> Bool {
        let scrollviewHeight = scrollView.frame.height
        let contentHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        return scrollOffset + scrollviewHeight + 10 > contentHeight
    }
    
    func loadMore() {
        
    }
}


