//
//  ViewController.swift
//  Canvas Lab
//
//  Created by Martynas Kausas on 3/2/16.
//  Copyright © 2016 Marty Kausas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayOpenCenter: CGPoint!
    var trayClosedCenter: CGPoint!
    
    @IBOutlet var trayPanGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet var trayTapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayOpenCenter = trayView.center
        trayClosedCenter = CGPoint(x: trayView.center.x, y: trayView.center.y + 200)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var trayOpen = true
    @IBAction func onTrayTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        NSLog("tapped")

        moveTray(trayOpen ? trayClosedCenter : trayOpenCenter)
        
        trayOpen = !trayOpen

        
    }
    
    
    @IBAction func onTrayPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let point = panGestureRecognizer.locationInView(view)
        
        let translation = panGestureRecognizer.translationInView(view)
        
        switch panGestureRecognizer.state {
            case UIGestureRecognizerState.Began:
                print("Gesture began at: \(point)")
                trayOriginalCenter = point
                break
                
            case UIGestureRecognizerState.Changed:
                print("Gesture changed at: \(point)")
                trayView.center = CGPoint(x: trayView.center.x, y: trayOriginalCenter.y + translation.y)
                print(trayView.frame.width)
                break
                
            case UIGestureRecognizerState.Ended:
                print("Gesture ended at: \(point)")
                let velocity = panGestureRecognizer.velocityInView(view)
                
                if velocity.y > 0 {
                    moveTray(trayClosedCenter)
                } else {
                    moveTray(trayOpenCenter)
                }
                break
                
                
            default:
                break
        }
    }
    
    var newlyCreatedFace: UIImageView!
    var originalSmileyCenter: CGPoint!
    @IBAction func onSmileyPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        NSLog("panning")
        

        let translation = panGestureRecognizer.translationInView(view)

        
        
        
        switch panGestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            print("Gesture began at: ")
            let imageView = panGestureRecognizer.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            view.addSubview(newlyCreatedFace)
            
            originalSmileyCenter = CGPoint(x: imageView.center.x, y: imageView.center.y + trayView.frame.origin.y)

            newlyCreatedFace.center = originalSmileyCenter
            
            
            break
            
        case UIGestureRecognizerState.Changed:
            print("Gesture changed at:")
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            newlyCreatedFace.center = CGPoint(x: originalSmileyCenter.x + translation.x, y: originalSmileyCenter.y + translation.y)


            break
            
            
        default:
            break
        }

    }
    
    func moveTray(centerPoint: CGPoint) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            
                self.trayView.center = centerPoint
            
        }, completion: nil)
    }

}

