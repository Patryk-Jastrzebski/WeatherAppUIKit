//
//  XibView.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import UIKit

class XibView: UIView {
    private var xibConstraints: [NSLayoutConstraint]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    private func commonInit() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let objects = nib.instantiate(withOwner: self, options: nil)
        var xibView: UIView?
        for view in objects {
            if let childView = view as? UIView {
                xibView = childView
                break
            }
        }
        
        if let xibViewSet = xibView {
            xibViewSet.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(xibViewSet)
            xibViewSet.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            xibViewSet.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            xibViewSet.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            xibViewSet.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
}
