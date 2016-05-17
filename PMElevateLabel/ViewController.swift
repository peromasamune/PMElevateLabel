//
//  ViewController.swift
//  PMElevateLabel
//
//  Created by Taku Inoue on 2016/05/17.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    //MARK: Public

    //MARK: Private
    private var elevateLabel : PMElevateLabel!
    private var animationStartTime : CFTimeInterval?

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        elevateLabel = PMElevateLabel(frame: CGRectMake(0, 0, 100, 100))
        elevateLabel.center = CGPointMake(self.view.frame.width / 2, self.view.frame.height / 2)
        elevateLabel.layer.borderColor = UIColor.blueColor().CGColor
        elevateLabel.layer.borderWidth = 1.0
        self.view.addSubview(elevateLabel)

        let startButton = UIButton(type: .System)
        startButton.frame = CGRectMake(0, 0, 100, 40)
        startButton.center = CGPointMake(self.view.frame.width / 2, self.view.frame.height / 2 + 100)
        startButton.setTitle("Start", forState: .Normal)
        startButton.addTarget(self, action: "startButtonDidPush:", forControlEvents: .TouchUpInside)
        self.view.addSubview(startButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private method
    private func startAnimation() {
        let displayLink = CADisplayLink(target: self, selector: "updateDisplayLink:")
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)

        self.animationStartTime = CACurrentMediaTime()
    }

    //MARK: - Button event
    @objc func startButtonDidPush(sender : AnyObject?) {
        self.startAnimation()
    }

    //MARK: - CADislayLink handler
    @objc private func updateDisplayLink(displayLink : CADisplayLink) {
        guard let animTime = self.animationStartTime else {
            displayLink.invalidate()
            return
        }

        let elapsedTime = displayLink.timestamp - animTime
        if elapsedTime >= 30 {
            displayLink.invalidate()
        }

        elevateLabel.setValue(Int(elapsedTime), animated: true)
    }
}

