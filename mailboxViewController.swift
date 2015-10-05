//
//  mailboxViewController.swift
//  Mailbox
//
//  Created by Claw on 9/30/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit

class mailboxViewController: UIViewController {

    @IBOutlet weak var primaryMailView: UIView!
    
    @IBOutlet weak var mailScrollView: UIScrollView!

    @IBOutlet weak var singleMessageUIView: UIImageView!
    
    @IBOutlet weak var latericonUIImageView: UIImageView!
    
    @IBOutlet weak var rescheduleImageView: UIImageView!
    
    @IBOutlet weak var listImageView: UIImageView!
    
    @IBOutlet weak var listiconImageView: UIImageView!
    
    @IBOutlet weak var archiveiconImageView: UIImageView!
    
    @IBOutlet weak var mailfeedImageView: UIImageView!
    
    @IBOutlet weak var msgcontainerVIew: UIView!
    
    @IBOutlet weak var deleteiconImageView: UIImageView!
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    var initialMsgCenter: CGPoint!
    var msgOriginalCenter: CGPoint!

    var initialcontainerCenter: CGPoint!
    var initialmailfeedCenter: CGPoint!
    
    var initialLaterCenter: CGPoint!
    var laterOriginalCenter: CGPoint!
    

    var initialarchiveCenter: CGPoint!
    var archiveOriginalCenter: CGPoint!

    var initiallistCenter: CGPoint!
    
    var initialdeleteCenter: CGPoint!
    var deleteOriginalCenter: CGPoint!
    
    var menuOriginalCenter:CGPoint!

    var initialprimarymailCenter: CGPoint!
    var primarymailOriginalCenter:CGPoint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailScrollView.contentSize = CGSize(width: 375, height: 1400)
        menuImageView.alpha = 1
        
        //setup the pan gesture recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        singleMessageUIView.addGestureRecognizer(panGestureRecognizer)

        //setup the list tap gesture recognizer
        let listtapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onListTap:")
        listtapGestureRecognizer.numberOfTapsRequired = 1;
        listImageView.userInteractionEnabled = true
        listImageView.addGestureRecognizer(listtapGestureRecognizer)

        //setup the reschedule tap gesture recognizer
        let reschedtapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onReschedTap:")
        reschedtapGestureRecognizer.numberOfTapsRequired = 1;
        rescheduleImageView.userInteractionEnabled = true
        rescheduleImageView.addGestureRecognizer(reschedtapGestureRecognizer)
        
        //setup the menu tap gesture recognizer
        let menutapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onMenuTap:")
        menutapGestureRecognizer.numberOfTapsRequired = 1;
        menuImageView.userInteractionEnabled = true
        menuImageView.addGestureRecognizer(menutapGestureRecognizer)
        
        //set initial values for msg and later icon
        initialMsgCenter = singleMessageUIView.center
        initialLaterCenter = latericonUIImageView.center
        initialcontainerCenter = msgcontainerVIew.center
        initialmailfeedCenter = mailfeedImageView.center
        initiallistCenter = listiconImageView.center
        initialarchiveCenter = archiveiconImageView.center
        initialdeleteCenter = deleteiconImageView.center
        initialprimarymailCenter = primaryMailView.center
        
        //Add Screen Edge Gesture Recgonizer
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        primaryMailView.addGestureRecognizer(edgeGesture)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onEdgePan(panGestureRecognizer: UIPanGestureRecognizer) {
        print("Panning the edge!")
        let point = panGestureRecognizer.locationInView(view)
        let velocity = panGestureRecognizer.velocityInView(view)
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            primarymailOriginalCenter = primaryMailView.center
        }
        else if panGestureRecognizer.state == UIGestureRecognizerState.Changed{
            primaryMailView.center.x = primarymailOriginalCenter.x + translation.x
        
        }
        else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                 UIView.animateWithDuration(0.5, animations:{
                    self.primaryMailView.center.x = self.initialprimarymailCenter.x + 375
                 })
            }
                else if velocity.x < 0 {
                UIView.animateWithDuration(0.5, animations:{
                    self.primaryMailView.center.x = self.initialprimarymailCenter.x
                })
            }
            
        }
    }
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(view)
        let velocity = panGestureRecognizer.velocityInView(view)
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            iconlocationReset()
            msgOriginalCenter = singleMessageUIView.center
            laterOriginalCenter = latericonUIImageView.center
            archiveOriginalCenter = archiveiconImageView.center
            deleteOriginalCenter = deleteiconImageView.center
            
            if velocity.x < 0 {
                latericonUIImageView.alpha = 0.25
            }
            
            if velocity.x > 0 {
                archiveiconImageView.alpha = 0.25
            }
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            // move the message and show that we tracked it
            singleMessageUIView.center = CGPoint(x: msgOriginalCenter.x + translation.x, y: msgOriginalCenter.y)

            // check to see if message is between 0 and 60 pixels to the left
            if (singleMessageUIView.center.x < initialMsgCenter.x) && (singleMessageUIView.center.x > initialMsgCenter.x - 60){
                UIView.animateWithDuration(0.5, animations:{
                        self.latericonUIImageView.alpha = 1
                })
            }

                // check to see if message is being dragged to the left between 60 and 260 pixels
            else if (singleMessageUIView.center.x < initialMsgCenter.x - 61) && (singleMessageUIView.center.x > initialMsgCenter.x - 260){

                UIView.animateWithDuration(0.5, animations:{
                self.msgcontainerVIew.backgroundColor = .yellowColor()
                })
                self.latericonUIImageView.center.x = laterOriginalCenter.x + translation.x + 60

            }
                // check to see if message is being dragged to the left more than 260 pixels
            else if (singleMessageUIView.center.x < initialMsgCenter.x - 261){
                UIView.animateWithDuration(0.3, animations:{
                    self.msgcontainerVIew.backgroundColor = .brownColor()
                })
                self.listiconImageView.alpha = 1
                self.latericonUIImageView.alpha = 0
                self.listiconImageView.center.x = self.laterOriginalCenter.x + translation.x + 60

            }
            else if (singleMessageUIView.center.x > initialMsgCenter.x) && (singleMessageUIView.center.x < initialMsgCenter.x + 60){
                UIView.animateWithDuration(0.5, animations:{
                    self.archiveiconImageView.alpha = 1
                })
            }
            
                // check to see if message is being dragged to the right between 60 and 260 pixels
            else if (singleMessageUIView.center.x > initialMsgCenter.x + 61) && (singleMessageUIView.center.x < initialMsgCenter.x + 260){
                
                UIView.animateWithDuration(0.5, animations:{
                    self.msgcontainerVIew.backgroundColor = .greenColor()
                })
                self.archiveiconImageView.center.x = archiveOriginalCenter.x + translation.x - 60
                
            }
                // check to see if message is being dragged to the right more than 260 pixels
            else if (singleMessageUIView.center.x > initialMsgCenter.x + 261){
                UIView.animateWithDuration(0.3, animations:{
                    self.msgcontainerVIew.backgroundColor = .redColor()
                    
                })
                  self.archiveiconImageView.alpha = 0
                self.deleteiconImageView.center.x = self.archiveOriginalCenter.x + translation.x - 60
                self.deleteiconImageView.alpha = 1
            }

            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            // check to see if message was moved left or right more than 60 pixels
            
            if ((singleMessageUIView.center.x > initialMsgCenter.x - 60) && (singleMessageUIView.center.x < initialMsgCenter.x)) || ((singleMessageUIView.center.x < initialMsgCenter.x + 60) && (singleMessageUIView.center.x > initialMsgCenter.x)){
                //snap the message back
                UIView.animateWithDuration(0.4, animations: {
                    self.singleMessageUIView.center.x = self.initialMsgCenter.x
                    self.msgcontainerVIew.backgroundColor = .grayColor()
                })
            }
                // check to see ended between 61 and 260 pixels to the left
            else if (singleMessageUIView.center.x < initialMsgCenter.x - 61) && (singleMessageUIView.center.x > initialMsgCenter.x - 260){
                //show reschedule image
                UIView.animateWithDuration(0.5, animations:{
                    self.rescheduleImageView.alpha = 1
                })
                // check to see ended more than 260 pixels to the left
            }
            else if (singleMessageUIView.center.x < initialMsgCenter.x - 261) {
                //show list image
                UIView.animateWithDuration(0.5, animations:{
                    self.listImageView.alpha = 1
                    })
                }
        
            else if (singleMessageUIView.center.x > initialMsgCenter.x + 61){
            //complete the animation to the right
                    swiperightReset()
            }
            // check to see ended more than 260 pixels to the left
            }
    }
    
    func onMenuTap(menutapGestureRecognizer: UITapGestureRecognizer){
        print("tapped on menu")
        UIView.animateWithDuration(0.5, animations:{
            self.primaryMailView.center.x = self.initialprimarymailCenter.x
        })
    }
    
    func onListTap(listtapGestureRecognizer: UITapGestureRecognizer) {
       swipeleftReset()
    }
    
    func onReschedTap(reschedtapGestureRecognizer: UITapGestureRecognizer) {
        swipeleftReset()
    }
    
    func swipeleftReset (){
        //  set the icons and the lists to hide
        self.archiveiconImageView.alpha = 0
        self.listiconImageView.alpha = 0
        self.latericonUIImageView.alpha = 0
        self.rescheduleImageView.alpha = 0
        self.listImageView.alpha = 0
        self.deleteiconImageView.alpha = 0
        
        // move the message all the way left
        UIView.animateWithDuration(0.4, animations: {
            self.singleMessageUIView.center.x = self.initialMsgCenter.x - 375
        })
        
        delay(0.3){
            self.movefeedup()
        }
    }
    
    func swiperightReset (){
        //  set the icons and the lists to hide
        self.archiveiconImageView.alpha = 0
        self.listiconImageView.alpha = 0
        self.latericonUIImageView.alpha = 0
        self.rescheduleImageView.alpha = 0
        self.listImageView.alpha = 0
        self.deleteiconImageView.alpha = 0
        
        // move the message all the way right
        UIView.animateWithDuration(0.4, animations: {
            self.singleMessageUIView.center.x = self.initialMsgCenter.x + 375
        })
        
        delay(0.3){
            self.movefeedup()
        }

    }
    
    func movefeedup (){
    
        // hide the container and then move the mailfeed up
        UIView.animateWithDuration(0.4, animations: {
            self.msgcontainerVIew.alpha = 0
            self.mailfeedImageView.center.y = self.initialmailfeedCenter.y - 90
        })
        
        delay (1){
            // move container into correct position and then move the feed back down
            self.singleMessageUIView.center = self.initialMsgCenter
            self.msgcontainerVIew.alpha = 1
            self.mailfeedImageView.center.y = self.initialmailfeedCenter.y
        }
        
    }
    
    func iconlocationReset (){
        latericonUIImageView.center = initialLaterCenter
        listiconImageView.center = initiallistCenter
        archiveiconImageView.center = initialarchiveCenter

        self.latericonUIImageView.alpha = 0
        self.archiveiconImageView.alpha = 0
        self.msgcontainerVIew.backgroundColor = .grayColor()
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

