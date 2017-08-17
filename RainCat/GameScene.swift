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
	private var raindropSpawnRate : TimeInterval = 0.2
	private let random = GKARC4RandomSource()
	private let umbrella = UmbrellaSprite.newInstance()
	private let reinDropTexture = SKTexture(imageNamed: "rain_drop")
	private var cat : CatSprite!
	
	override func sceneDidLoad() {
		
		self.lastUpdateTime = 0
		
		var worldFrame = frame
		worldFrame.origin.x -= 100
		worldFrame.origin.y -= 100
		worldFrame.size.height += 200
		worldFrame.size.width += 200
		
		self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
		self.physicsWorld.contactDelegate = self
		self.physicsBody?.categoryBitMask = WorldFrameCategory
		
		
		let floorNode = SKShapeNode(rectOf: CGSize(width: size.width, height: 5))
		floorNode.position = CGPoint(x: size.width / 2, y: 25)
		floorNode.fillColor = SKColor.red
		
		floorNode.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -size.width / 2, y: 0), to: CGPoint(x: size.width, y: 0))
		floorNode.physicsBody?.categoryBitMask = FloorCategory
		floorNode.physicsBody?.contactTestBitMask = RainDropCategory
		
		addChild(floorNode)
		
		umbrella.updatePosition(point: CGPoint(x: frame.midX, y: frame.midY))
		
		addChild(umbrella);
		
		spawnCat();
		
		let background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = 0
		addChild(background)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touchPoint = touches.first?.location(in: self)
		
		if let point = touchPoint {
			umbrella.setDestination(destination: point)
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touchPoint = touches.first?.location(in: self)
		
		if let point = touchPoint {
			umbrella.setDestination(destination: point)
		}
	}
	
	override func update(_ currentTime: TimeInterval) {
		
		if(self.lastUpdateTime == 0) {
			self.lastUpdateTime = currentTime
		}
		
		let dt = currentTime - self.lastUpdateTime
		self.lastUpdateTime = currentTime
		
		umbrella.update(deltaTime: dt)
		
		currentRainDropSpawnTime += dt
		
		if(currentRainDropSpawnTime > raindropSpawnRate) {
			currentRainDropSpawnTime = 0
			spawnRaindrop()
		}
	}
	
	func spawnRaindrop() {
		let rainDrop = SKSpriteNode(texture: reinDropTexture)
		rainDrop.position = CGPoint(x: size.width / 2, y: size.height / 2)
		rainDrop.zPosition = 2
		
		rainDrop.physicsBody = SKPhysicsBody(rectangleOf: rainDrop.size)
		rainDrop.physicsBody?.categoryBitMask = RainDropCategory
		rainDrop.physicsBody?.contactTestBitMask = WorldFrameCategory
		
		let randomPosition = abs(CGFloat(random.nextInt()).truncatingRemainder(dividingBy: size.width))
		rainDrop.position = CGPoint(x: randomPosition, y: size.height)
		
		addChild(rainDrop)
	}
	
	func spawnCat() {
		if let currentCat = cat, children.contains(currentCat) {
			cat.removeFromParent()
			cat.removeAllActions()
			cat.physicsBody = nil
		}
		
		cat = CatSprite.newInstance()
		cat.position = CGPoint(x: umbrella.position.x, y: umbrella.position.y - 15)
		addChild(cat)
	}
}

extension GameScene : SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		if(contact.bodyA.categoryBitMask == RainDropCategory) {
			contact.bodyA.node?.physicsBody?.collisionBitMask = 0
		} else if (contact.bodyB.categoryBitMask == RainDropCategory) {
			contact.bodyB.node?.physicsBody?.collisionBitMask = 0
		}
		
		if contact.bodyA.categoryBitMask == CatCategory || contact.bodyB.categoryBitMask == CatCategory {
			handleCatCollision(contact: contact)
			return
		}
		
		if contact.bodyA.categoryBitMask == WorldFrameCategory {
			contact.bodyB.node?.removeFromParent()
			contact.bodyB.node?.physicsBody = nil
			contact.bodyB.node?.removeAllActions()
		} else if contact.bodyB.categoryBitMask == WorldFrameCategory {
			contact.bodyA.node?.removeFromParent()
			contact.bodyA.node?.physicsBody = nil
			contact.bodyA.node?.removeAllActions()
		}
	}
	
	func handleCatCollision(contact: SKPhysicsContact) {
		var otherBody : SKPhysicsBody
		
		if(contact.bodyA.categoryBitMask == CatCategory) {
			otherBody = contact.bodyB
		} else {
			otherBody = contact.bodyA
		}
		
		switch otherBody.categoryBitMask {
		case RainDropCategory:
			print("rain hit cat")
		case WorldFrameCategory:
			spawnCat()
		default:
			print("something hit cat")
		}
	}
}
