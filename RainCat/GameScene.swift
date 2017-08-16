//
//  GameScene.swift
//  RainCat
//
//  Created by Volodimir Moskaliuk on 8/16/17.
//
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	private var lastUpdateTime : TimeInterval = 0
	
	override func sceneDidLoad() {
		self.lastUpdateTime = 0
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}
	
	override func update(_ currentTime: TimeInterval) {
		if(self.lastUpdateTime == 0) {
			self.lastUpdateTime = currentTime
		}
		
		let dt = currentTime - self.lastUpdateTime
		self.lastUpdateTime = currentTime
	}
	
}
