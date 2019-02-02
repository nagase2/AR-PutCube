//
//  ViewController.swift
//  ARkit-experiment-1
//
//  Created by Nagase on 2018/12/30.
//  Copyright © 2018 Nagase Denki. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController ,ARSCNViewDelegate{
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //debug用に現在のポジションを表示
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        //この記述でデバイスが現在の位置をトラッキングできるようになる。
        self.sceneView.session.run(configuration)
        //ライティングのための要素を自動的に追加する。
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /**
     サンプルメソッド
     - parameter sender: パラメータの書き方
     - throws: 例外処理の書き方
     - returns: 戻り値の書き方
     */
    @IBAction func add(_ sender: Any) {
        print("button is pressed")
        //起動時の軸となるノード
        let node = SCNNode()
        //specfy the size of the box chamerRediousは角の丸めの値。
        node.geometry = SCNBox(width:0.1, height:0.1, length:0.1, chamferRadius:0.03)
        
        //ライトを追加
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        //boxの色を指定
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //specify position (unit is meter)
        node.position = SCNVector3(x,y,z)
        
        //現在の位置を取得
        let pov = self.sceneView.pointOfView
        let position = pov?.position
        print(position)
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
        
    }
    
    /*
    * セッションをリセットする。
    */
    func restartSession(){
        print("restat session")
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    //ランダム値を取得する
    func randomNumbers(firstNum: CGFloat, secondNum:CGFloat)->CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else { return }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        //let currentPositionOfCamera = orientation + location
        print(location)
    }
    
//    static func +(lhv:SCNVector3, rhv:SCNVector3) -> SCNVector3 {
//        return SCNVector3(lhv.x + rhv.x, lhv.y + rhv.y, lhv.z + rhv.z)
//    }

}

