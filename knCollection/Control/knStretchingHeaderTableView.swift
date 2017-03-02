//
//  knStretchingTableHeaderView.swift
//  StretchyHeaderAnimation
//
//  Created by Ky Nguyen on 9/14/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class knStretchingHeaderTableView : UITableView {
    
    fileprivate var tableHeaderHeight: CGFloat = 200
    fileprivate var headerView : UIView?
    
    fileprivate func prepareHeaderView() {
        headerView = tableHeaderView
        tableHeaderView = nil
        
        guard let headerView = headerView else { return }
        addSubview(headerView)
        
        contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        stretchHeaderView()
    }
    
    func stretchHeaderView() {
        if headerView == nil {
            prepareHeaderView()
        }
        
        var headerRect = CGRect(x: 0, y: -tableHeaderHeight, width: bounds.width, height: tableHeaderHeight)
        if contentOffset.y < -tableHeaderHeight {
            headerRect.origin.y = contentOffset.y
            headerRect.size.height = -contentOffset.y
        }
        
        headerView?.frame = headerRect
    }
}

class knStretchingTableHeaderViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: knStretchingHeaderTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.stretchHeaderView()
    }
}
