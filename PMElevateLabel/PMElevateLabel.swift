//
//  PMElevateLabel.swift
//  PMElevateLabel
//
//  Created by Taku Inoue on 2016/05/17.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import UIKit

class PMElevateLabel: UIView {

    //MARK: - Properties
    //MARK: Public
    var duration : NSTimeInterval = 1.0

    //MARK: Private
    private var currentValue : Int = 0
    private var primaryLabel : UILabel!
    private var secondaryLabel : UILabel!

    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.masksToBounds = true

        primaryLabel = self.label(CGRectMake(0, 0, frame.width, frame.height))
        self.addSubview(primaryLabel)

        secondaryLabel = self.label(CGRectMake(0, 0, frame.width, frame.height))
        self.addSubview(secondaryLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public method
    func setValue(value : Int, animated : Bool) {
        if self.currentValue == value {
            return
        }

        self.primaryLabel.text = "\(self.currentValue)"
        self.secondaryLabel.text = "\(value)"

        let destOffset = (self.currentValue > value) ? -self.frame.height : self.frame.height

        self.primaryLabel.setOrigin(.zero)
        self.secondaryLabel.setOrigin(CGPointMake(0, destOffset))

        UIView.animateWithDuration((animated) ? self.duration : 0.0, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
            self.primaryLabel.setOrigin(CGPointMake(0, -destOffset))
            self.secondaryLabel.setOrigin(.zero)
            }, completion: { _ in })

        self.currentValue = value
    }

    //MARK: - Private method
    private func label(frame : CGRect) -> UILabel {
        let label = UILabel(frame: frame)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(50)
        return label
    }
}

extension UIView {
    func setOrigin(origin : CGPoint) {
        var rect = self.frame
        rect.origin = origin
        self.frame = rect
    }
}
