//
//  GameViewController.swift
//  RainCat
//
//  Created by Volodimir Moskaliuk on 8/16/17.
//
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let scene = GameScene(size: view.frame.size)
		
		SoundManager.sharedInstance.startPlaying()
		
		// Present the scene
		if let view = self.view as! SKView? {
			view.presentScene(scene)
			
			view.ignoresSiblingOrder = true
			
			view.showsFPS = true
			view.showsNodeCount = true
			
			view.showsPhysics = true
		}
	}
	
	override var shouldAutorotate: Bool {
		return true
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if UIDevice.current.userInterfaceIdiom == .phone {
			return .allButUpsideDown
		} else {
			return .all
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
}
