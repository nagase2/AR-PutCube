//
//  ViewController.swift
//  ARkit-experiment-1
//
//  Created by Nagase on 2018/12/30.
//  Copyright © 2018 Nagase Denki. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //debug用に現在のポジションを表示
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        //この記述でデバイスが現在の位置をトラッキングできるようになる。
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func add(_ sender: Any) {
        print("button is pressed")
        //起動時の軸となるノード
        let node = SCNNode()
        //specfy the size of the box
        node.geometry = SCNBox(width:0.1, height:0.5, length:0.1, chamferRadius:0)
        //boxの色を指定
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        //specify position (unit is meter)
        node.position = SCNVector3(0,0,-0.3)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    

}

