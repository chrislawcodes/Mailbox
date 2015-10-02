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
    
    @IBOutlet weak var laterUIImageView: UIImageView!
    
    @IBOutlet weak var containerMessageView: UIView!
    
    @IBOutlet weak var rescheduleImageView: UIImageView!
    
    var initialMsgCenter: CGPoint!
    var msgOriginalCenter: CGPoint!
    
    var initialLaterCenter: CGPoint!
    var laterOriginalCenter: CGPoint!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
          mailScrollView.contentSize = CGSize(width: 375, height: 1400)
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
          singleMessageUIView.addGestureRecognizer(panGestureRecognizer)

        initialMsgCenter = singleMessageUIView.center
        initialLaterCenter = laterUIImageView.center
        laterUIImageView.alpha = 0.25

        
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
            laterOriginalCenter = laterUIImageView.center
            print("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            // move the message and show that we tracked it
            singleMessageUIView.center = CGPoint(x: msgOriginalCenter.x + translation.x, y: msgOriginalCenter.y)
            print("Gesture changed at: \(point)")

            // check to see if message is between 0 and 60 pixels
            if (singleMessageUIView.center.x < initialMsgCenter.x) && (singleMessageUIView.center.x > initialMsgCenter.x - 60){
                // make icon opaque
                UIView.animateWithDuration(0.5, animations:{
                    self.laterUIImageView.alpha = 1

                    })
                
                print("I'm in between 0 and 60")
                
            }

                // check to see if message is being dragged to the left between 60 and 260 pixels
            else if (singleMessageUIView.center.x < initialMsgCenter.x - 61) && (singleMessageUIView.center.x > initialMsgCenter.x - 260){
                // move icon with the view & make background Yellow
                print("I'm between 61 and 260")
                UIView.animateWithDuration(0.5, animations:{
                self.containerMessageView.backgroundColor = .yellowColor()
                })
                self.laterUIImageView.center.x = laterOriginalCenter.x + translation.x + 60

            }

            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            // check to see if message was moved left or right more than 60 pixels
            
            if ((singleMessageUIView.center.x > initialMsgCenter.x - 60) && (singleMessageUIView.center.x < initialMsgCenter.x)) || ((singleMessageUIView.center.x < initialMsgCenter.x + 60) && (singleMessageUIView.center.x > initialMsgCenter.x)){
                //snap the message back
                UIView.animateWithDuration(0.4, animations: {
                    self.singleMessageUIView.center.x = self.initialMsgCenter.x
                    self.containerMessageView.backgroundColor = .grayColor()
                    self.laterUIImageView.alpha = 0.25
                    print("Gesture ended at: \(point)")
                })
            }
                // check to see if between 61 and 260 pixels
                else if (singleMessageUIView.center.x < initialMsgCenter.x - 61) && (singleMessageUIView.center.x > initialMsgCenter.x - 260){
                    UIView.animateWithDuration(0.5, animations:{
                        self.rescheduleImageView.alpha = 1
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
