//
//  MailboxViewController.swift
//  MailboxDemo
//
//  Created by Hollins, Richie on 4/13/16.
//  Time Spent: 4/13/16 1:00PM – 3:30PM, 9:30PM - 11:00PM
//  More Time: 4/15/16 2:00PM - 3:00 PM
//  Copyright © 2016 Hollins, Richie. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var bigScrollView: UIScrollView!
    
    @IBOutlet weak var messageHolder: UIView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var theFeed: UIImageView!
    @IBOutlet weak var theMainPage: UIView!
    @IBOutlet weak var theMenu: UIImageView!
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var rescheduleViewHolder: UIView!
    
    @IBOutlet weak var laterTodayView: UIView!
    @IBOutlet weak var thisEveningView: UIView!
    @IBOutlet weak var tomorrowView: UIView!
    @IBOutlet weak var thisWeekendView: UIView!
    @IBOutlet weak var nextWeekView: UIView!
    @IBOutlet weak var inAMonthView: UIView!
    @IBOutlet weak var somedayView: UIView!
    @IBOutlet weak var desktopView: UIView!
    @IBOutlet weak var pickDateView: UIView!
    
    var messageInitialCenter: CGPoint!
    var laterIconInitialCenter: CGPoint!
    var archiveIconInitialCenter: CGPoint!
    var feedInitialCenter: CGPoint!
    
    var menuIsShowing: Bool!
  
    let greyColor = UIColor(red: 204/255, green: 205/255, blue: 210/255, alpha: 1.0)
    let yellowColor = UIColor(red: 251/255, green: 211/255, blue: 13/255, alpha: 1.0)
    let brownColor = UIColor(red: 175/255, green: 143/255, blue: 9/255, alpha: 1.0)
    let greenColor = UIColor(red: 125/255, green: 206/255, blue: 73/255, alpha: 1.0)
    let redColor = UIColor(red: 219/255, green: 86/255, blue: 33/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        archiveIcon.alpha = 0.3
        laterIcon.alpha = 0.3
        
        bigScrollView.contentSize = CGSize(width: 320, height: 1380)
        
        messageInitialCenter = messageImageView.center
        laterIconInitialCenter = laterIcon.center
        archiveIconInitialCenter = archiveIcon.center
        feedInitialCenter = theFeed.center
        
        menuIsShowing = false
        
        /*var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        theMainPage.addGestureRecognizer(edgeGesture)*/
    }
    
    

    @IBAction func didPanOnMessageImageView(sender: UIPanGestureRecognizer) {
        //let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        //let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageImageView.center.x = messageInitialCenter.x + translation.x
            if translation.x <= -60 && translation.x >= -240 {
                self.laterIcon.center.x = self.laterIconInitialCenter.x + translation.x + 60
                self.laterIcon.alpha = 1
                self.archiveIcon.alpha = 0
                self.laterIcon.image = UIImage(named: "later_icon")
                self.messageHolder.backgroundColor = yellowColor
            } else if translation.x < -240 {
                self.laterIcon.center.x = self.laterIconInitialCenter.x + translation.x + 60
                self.laterIcon.alpha = 1
                self.laterIcon.image = UIImage(named: "list_icon")
                self.messageHolder.backgroundColor = brownColor
            } else if translation.x >= 60 && translation.x <= 240 {
                self.archiveIcon.center.x = self.archiveIconInitialCenter.x + translation.x - 60
                self.archiveIcon.alpha = 1
                self.laterIcon.alpha = 0
                self.archiveIcon.image = UIImage(named: "archive_icon")
                self.messageHolder.backgroundColor = greenColor
            } else if translation.x > 240 {
                self.archiveIcon.center.x = self.archiveIconInitialCenter.x + translation.x - 60
                self.archiveIcon.alpha = 1
                self.archiveIcon.image = UIImage(named: "delete_icon")
                self.messageHolder.backgroundColor = redColor
            } else {
                self.archiveIcon.alpha = 0.3
                self.laterIcon.alpha = 0.3
                self.messageHolder.backgroundColor = greyColor
            }
        } else if sender.state == UIGestureRecognizerState.Ended {
            if translation.x <= -60 && translation.x >= -240 {
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.messageImageView.center.x = self.messageInitialCenter.x - 320
                    self.laterIcon.alpha = 0
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                            self.rescheduleViewHolder.alpha = 1
                            self.showThemCircles()
                            }, completion: { (Bool) -> Void in
                                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
                        })
                })
            } else if translation.x < -240 {
                UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.messageImageView.center.x = self.messageInitialCenter.x - 320
                    self.laterIcon.alpha = 0
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                            self.listView.alpha = 1
                            }, completion: { (Bool) -> Void in
                                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
                        })
                })
            } else if translation.x >= 60 && translation.x <= 240 {
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.messageImageView.center.x = self.messageInitialCenter.x + 320
                    self.archiveIcon.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.hideThenRevealAgain()
                })
            } else if translation.x > 240 {
                UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.messageImageView.center.x = self.messageInitialCenter.x + 320
                    self.archiveIcon.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.hideThenRevealAgain()
                })
            } else {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 15, options: [], animations: { () -> Void in
                    self.messageImageView.center.x = self.messageInitialCenter.x
                    }, completion: { (Bool) -> Void in
                        //code
                })
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.messageHolder.backgroundColor = self.greyColor
                    self.laterIcon.image = UIImage(named: "later_icon")
                    self.archiveIcon.image = UIImage(named: "archive_icon")
                    self.laterIcon.alpha = 0.3
                    self.archiveIcon.alpha = 0.3
                })
            }
        }
    }
    
    
    
    @IBAction func didTapListOption(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.listView.alpha = 0
            }) { (Bool) -> Void in
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
                self.hideThenRevealAgain()
        }
    }
    
    
    
    @IBAction func didTapRescheduleListOption(sender: AnyObject) {
        hideThemCircles()
        UIView.animateWithDuration(0.2, delay: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.rescheduleViewHolder.alpha = 0
            }) { (Bool) -> Void in
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
                self.hideThenRevealAgain()
        }
    }
    
    
    
    @IBAction func didTapHamburger(sender: AnyObject) {
        if menuIsShowing == false {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.theMenu.frame.origin.x = 0
                self.theMainPage.frame.origin.x = 284
                }) { (Bool) -> Void in
                    self.menuIsShowing = true
            }
        } else {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.theMenu.frame.origin.x = -80
                self.theMainPage.frame.origin.x = 0
                }) { (Bool) -> Void in
                    self.menuIsShowing = false
            }
        }
    }

    
    
    
    @IBAction func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            theMainPage.frame.origin.x = translation.x
            theMenu.frame.origin.x = -80 + translation.x / 3.5
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.theMenu.frame.origin.x = 0
                    self.theMainPage.frame.origin.x = 284
                    }) { (Bool) -> Void in
                        self.menuIsShowing = true
                }
            } else {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.theMenu.frame.origin.x = -80
                    self.theMainPage.frame.origin.x = 0
                    }) { (Bool) -> Void in
                        self.menuIsShowing = false
                }
            }
        }
    }
    
    
    
    @IBAction func onMainPagePan(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        sender.delegate = self
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            if menuIsShowing == true {
                theMainPage.frame.origin.x = translation.x + 284
                theMenu.frame.origin.x = translation.x / 3.5
            }
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 && menuIsShowing == true {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.theMenu.frame.origin.x = 0
                    self.theMainPage.frame.origin.x = 284
                    }) { (Bool) -> Void in
                        self.menuIsShowing = true
                }
            } else if velocity.x < 0 && menuIsShowing == true {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.theMenu.frame.origin.x = -80
                    self.theMainPage.frame.origin.x = 0
                    }) { (Bool) -> Void in
                        self.menuIsShowing = false
                }
            }
        }
    }
    
    
    
    
    func showThemCircles() {
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.laterTodayView.alpha = 1
            self.laterTodayView.center.y = 166.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.025, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.thisEveningView.alpha = 1
            self.thisEveningView.center.y = 166.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.05, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.tomorrowView.alpha = 1
            self.tomorrowView.center.y = 166.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.075, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.thisWeekendView.alpha = 1
            self.thisWeekendView.center.y = 287
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nextWeekView.alpha = 1
            self.nextWeekView.center.y = 287
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.125, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.inAMonthView.alpha = 1
            self.inAMonthView.center.y = 287
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.15, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.somedayView.alpha = 1
            self.somedayView.center.y = 406.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.175, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.desktopView.alpha = 1
            self.desktopView.center.y = 406.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.pickDateView.alpha = 1
            self.pickDateView.center.y = 406.5
            }) { (Bool) -> Void in
        }
    }
    
    
    func hideThemCircles() {
        UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.laterTodayView.alpha = 0
            self.laterTodayView.center.y = 316.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.175, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.thisEveningView.alpha = 0
            self.thisEveningView.center.y = 316.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.15, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.tomorrowView.alpha = 0
            self.tomorrowView.center.y = 316.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.125, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.thisWeekendView.alpha = 0
            self.thisWeekendView.center.y = 437
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.nextWeekView.alpha = 0
            self.nextWeekView.center.y = 437
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.075, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.inAMonthView.alpha = 0
            self.inAMonthView.center.y = 437
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.05, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.somedayView.alpha = 0
            self.somedayView.center.y = 556.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0.025, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.desktopView.alpha = 0
            self.desktopView.center.y = 556.5
            }) { (Bool) -> Void in
        }
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.pickDateView.alpha = 0
            self.pickDateView.center.y = 556.5
            }) { (Bool) -> Void in
        }
    }
    
    
    func hideThenRevealAgain() {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.theFeed.center.y = self.feedInitialCenter.y - 86
            }, completion: { (Bool) -> Void in
                self.messageHolder.backgroundColor = UIColor(red: 204/255, green: 205/255, blue: 210/255, alpha: 1.0)
                self.messageImageView.center.x = self.messageInitialCenter.x
                self.archiveIcon.image = UIImage(named: "archive_icon")
                self.laterIcon.image = UIImage(named: "later_icon")
                self.archiveIcon.alpha = 0.3
                self.laterIcon.alpha = 0.3
                self.archiveIcon.center.x = self.archiveIconInitialCenter.x
                self.laterIcon.center.x = self.laterIconInitialCenter.x
                UIView.animateWithDuration(0.3, delay: 2.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.theFeed.center.y = self.feedInitialCenter.y
                    }, completion: { (Bool) -> Void in
                        
                })
        })
    }
    
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
