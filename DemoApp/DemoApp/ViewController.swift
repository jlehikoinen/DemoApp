//
//  ViewController.swift
//  DemoApp
//
//  Created by Janne Lehikoinen on 23/11/2017.
//  Copyright © 2017 Janne Lehikoinen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // UI stuff here =>>>
    
    @IBOutlet weak var osLabel: NSTextField!
    @IBOutlet var cliOutput: NSTextView!
    
    @IBAction func showConnectionsButtonPushed(_ sender: Any) {
        
        var chainedCommandResult: String?
        
        // 1
        // Create example command line interface commands that needs to be run chained / piped
        let netstatCommand = CliCommand(launchPath: "/usr/sbin/netstat", arguments: ["-an"])
        // let netstatCommand = CliCommand(launchPath: "/bin/ls", arguments: ["-la"])
        
        let grepCommand = CliCommand(launchPath: "/usr/bin/grep", arguments: ["ESTABLISHED"])
        // let grepCommand = CliCommand(launchPath: "/usr/bin/grep", arguments: ["Documents"])
        
        // Prepare cli command runner
        let chainedCommand = TaskHelper(commands: [netstatCommand, grepCommand])
        // let chainedCommand = TaskHelper(commands: [netstatCommand])
        
        // Execute command
        do {
            chainedCommandResult = try chainedCommand.execute()
        }
        catch _ {
            NSLog("Failed to execute command")
        }
        
        // Print to Debug area
        print(chainedCommandResult!)
        
        // Add result to UI
        cliOutput.string = chainedCommandResult!
        
    }
    
    func getOsVersion() {
        
        // 1
        // Command line (sw_vers)
        var chainedCommandResult: String?
        let swversCommand = CliCommand(launchPath: "/usr/bin/sw_vers", arguments: ["-productVersion"])
        let chainedCommand = TaskHelper(commands: [swversCommand])
        
        // Execute command
        do {
            chainedCommandResult = try chainedCommand.execute()
        }
        catch _ {
            NSLog("Failed to execute command")
        }
        
        // Print to Debug area
        print(chainedCommandResult!)
        
        // 2
        // Cocoa
        let osVersion = ProcessInfo.processInfo.operatingSystemVersionString
        let osVersionPieces = ProcessInfo.processInfo.operatingSystemVersion
        let osVersionPiecesString = "\(osVersionPieces.majorVersion).\(osVersionPieces.minorVersion).\(osVersionPieces.patchVersion)"
        
        // Print to Debug area
        print(osVersionPiecesString)
        print(osVersion)
 
        // Add info to UI label
        osLabel.stringValue = osVersion
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Put OS version to UI label when app launches
        getOsVersion()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

