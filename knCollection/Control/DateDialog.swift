//
//  DateDialog.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/28/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

protocol fxDateDialogDelegate: class {
    
    func didSelectDate(date: Date)
    
    func didCancelSelection()
}




class fxDateDialog: UIView {
    
    private override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    weak var delegate: fxDateDialogDelegate?
    
    static let center = fxDateDialog()
    
    lazy var backgroundView: UIView = { [weak self] in
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
        view.isUserInteractionEnabled = true
        return view
        
        }() /* backgroundView */
    
    let datePicker: UIDatePicker = {
        
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    let messageBoxView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }() /* messageBoxView */
    
    func setupView() {
        
        let titleLabel: UILabel = {
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = fxFont.font(name: .Texta_Medium, size: fxSize.medium)
            label.textColor = .white
            label.backgroundColor = fxColor.fx_119_203_189
            label.text = "SET APPOINTMENT"
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        let setButton: UIButton = {
            
            let title = "SET APPOINTMENT!"
            let color = fxColor.fx_127
            
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(title, for: .normal)
            button.setTitleColor(color, for: .normal)
            button.titleLabel?.font = fxFont.font(name: .Texta_Medium, size: fxSize.medium)
            
            let separator = UIView()
            separator.translatesAutoresizingMaskIntoConstraints = false
            separator.height(1)
            separator.backgroundColor = fxColor.fx_119_203_189
            
            button.addSubview(separator)
            separator.horizontal(toView: button)
            separator.top(toView: button)
            
            return button
            
        }()
        setButton.addTarget(self, action: #selector(handleSetAppointment), for: .touchUpInside)
        
        messageBoxView.addSubview(titleLabel)
        messageBoxView.addSubview(datePicker)
        messageBoxView.addSubview(setButton)
        
        
        titleLabel.horizontal(toView: messageBoxView)
        datePicker.horizontal(toView: messageBoxView)
        setButton.horizontal(toView: messageBoxView)
        
        messageBoxView.addConstraints(withFormat: "V:|[v0(40)][v1(166)][v2(44)]|", views: titleLabel, datePicker, setButton)
        
    }
    
    func handleSetAppointment() {
        close()
        delegate?.didSelectDate(date: datePicker.date)
    }
    
    func handleCancel() {
        close()
        delegate?.didCancelSelection()
    }
    
    weak var parentView: UIView?
    
    func show(in view: UIView) {
        
        setupView()
        
        parentView = view
        
        view.addSubview(backgroundView)
        view.addSubview(messageBoxView)
        
        backgroundView.vertical(toView: view)
        backgroundView.horizontal(toView: view)
        
        messageBoxView.horizontal(toView: view, constant: 24)
        messageBoxView.centerY(toView: view, constant: -32)
        
        messageBoxView.layer.opacity = 0
        messageBoxView.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIViewAnimationOptions(),
            animations: { [weak self] in
                
                self?.backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
                self?.messageBoxView.layer.opacity = 1
                self?.messageBoxView.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
        
    }
    
    func close() {
        
        let currentTransform = messageBoxView.layer.transform
        
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + Double.pi * 270 / 180), 0, 0, 0)
        
        messageBoxView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        messageBoxView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIViewAnimationOptions(),
            animations: { [weak self] in
                
                self?.backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self?.messageBoxView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self?.messageBoxView.layer.opacity = 0
                
            }, completion: { [weak self] (finished: Bool) in
                
                self?.backgroundView.removeFromSuperview()
                self?.messageBoxView.removeFromSuperview()
                self?.parentView = nil
                
        })
    }
}


























