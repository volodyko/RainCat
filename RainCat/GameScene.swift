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
	private var currentRainDropSpawnTime : TimeInterval = 0
	private var raindropSpawnRate : TimeInterval = 0.5
	private let random = GKARC4RandomSource()
	
	override func sceneDidLoad() {
		self.lastUpdateTime = 0
		
		let floorNode = SKShapeNode(rectOf: CGSize(width: size.width, height: 5))
		floorNode.position = CGPoint(x: size.width / 2, y: 50)
		floorNode.fillColor = SKColor.red
		
		floorNode.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -size.width / 2, y: 0), to: CGPoint(x: size.width, y: 0))
		
		addChild(floorNode)
		
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
		
		currentRainDropSpawnTime += dt
		
		if(currentRainDropSpawnTime > raindropSpawnRate) {
			currentRainDropSpawnTime = 0
			spawnRaindrop()
		}
	}
	
	func spawnRaindrop() {
		let rainDrop = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
		rainDrop.position = CGPoint(x: size.width / 2, y: size.height / 2)
		rainDrop.fillColor = SKColor.blue
		
		rainDrop.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
		
		let randomPosition = abs(CGFloat(random.nextInt()).truncatingRemainder(dividingBy: size.width))
		rainDrop.position = CGPoint(x: randomPosition, y: size.height)
		
		addChild(rainDrop)

	}
	
}
