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
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
          scrollView.contentSize = CGSize(width: 375, height: 1400)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
