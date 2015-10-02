//
//  mailboxViewController.swift
//  Mailbox
//
//  Created by Claw on 9/30/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit

class mailboxViewController: UIViewController {

    @IBOutlet weak var mailScrollView: UIScrollView!

    @IBOutlet weak var singleMessageUIView: UIImageView!
    
    var msgOriginalCenter: CGPoint!
    var initialMsgCenter: CGPoint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
          mailScrollView.contentSize = CGSize(width: 375, height: 1400)
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
          singleMessageUIView.addGestureRecognizer(panGestureRecognizer)
        initialMsgCenter = singleMessageUIView.center

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            msgOriginalCenter = singleMessageUIView.center
            print("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            // check to see if message is being dragged to the left.
            
            
            
            singleMessageUIView.center = CGPoint(x: msgOriginalCenter.x + translation.x, y: msgOriginalCenter.y)
            print("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            // check to see if message was moved left or right more than 60 pixels
            
            if ((singleMessageUIView.center.x > initialMsgCenter.x - 60) && (singleMessageUIView.center.x < initialMsgCenter.x)) || ((singleMessageUIView.center.x < initialMsgCenter.x + 60) && (singleMessageUIView.center.x > initialMsgCenter.x)){
                //snap the message back
                UIView.animateWithDuration(0.4, animations: {
                    self.singleMessageUIView.center.x = self.initialMsgCenter.x
                        print("Gesture ended at: \(point)")
                })
            }
        }
    
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
