//
//  VCLoggingViewController.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 01/10/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import UIKit

class VCLoggingViewController: UIViewController
{
    private struct LogGlobals {
        var prefix = ""
        var instanceCounts = [String:Int]()
        var lastLogTime = Date()
        var indentationInterval: TimeInterval = 1
        var indentationString = "__"
    }
    
    private static var logGlobals = LogGlobals()
    
    private static func logPrefix(for loggingName: String) -> String {
        if logGlobals.lastLogTime.timeIntervalSinceNow < -logGlobals.indentationInterval {
            logGlobals.prefix += logGlobals.indentationString
            print("")
        }
        logGlobals.lastLogTime = Date()
        return logGlobals.prefix + loggingName
    }
    
    private static func bumpInstanceCount(for loggingName: String) -> Int {
        logGlobals.instanceCounts[loggingName] = (logGlobals.instanceCounts[loggingName] ?? 0) + 1
        return logGlobals.instanceCounts[loggingName]!
    }
    
    private var instanceCount: Int!
    
    //this var will use a string to identify your view controller on the console or the name of the class you are in
    var vclLoggingName: String {
        //this is how you get a string which is the name of the class or struct you are in
        return String(describing: type(of: self))
    }
    
    private func logVCL(_ msg: String) {
        if instanceCount == nil {
            instanceCount =  VCLoggingViewController.bumpInstanceCount(for: vclLoggingName)
        }
        print("\(VCLoggingViewController.logPrefix(for: vclLoggingName))(\(instanceCount!)) \(msg)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logVCL("init(coder:) - created via InterfaceBuilder ")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logVCL("init(nibName:bundle:) - create in code")
    }
    
    deinit {
        logVCL("left the heap")
    }
    
    override func awakeFromNib() {
        logVCL("awakeFromNib()")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logVCL("viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logVCL("viewWillAppear(animated = \(animated))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logVCL("viewDidAppear(animated = \(animated))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVCL("viewWillDisappear(animated = \(animated))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logVCL("viewDidDisappear(animated = \(animated))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logVCL("didReceiveMemoryWarning()")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVCL("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVCL("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        logVCL("viewWillTransition(to: \(size), with: coordinator)")
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.logVCL("begin animate(alongsideTransition:completion:)")
        }, completion: { context -> Void in
            self.logVCL("end animate(alongsideTransition:completion:)")
        })
    }
    
}
