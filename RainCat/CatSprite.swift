//
//  CatSprite.swift
//  RainCat
//
//  Created by Volodimir Moskaliuk on 8/17/17.
//
//

import SpriteKit

public class CatSprite : SKSpriteNode {
	
	private let movementSpeed : CGFloat = 100
	private let walkingActionKey = "action_walking"
	private let walkFrames = [
		SKTexture(imageNamed: "cat_one"),
		SKTexture(imageNamed: "cat_two")
	]
	
	private var timeSinceLastHit : TimeInterval = 2
	private let maxFailTime : TimeInterval = 2
	
	public static func newInstance() -> CatSprite {
		let catSprite = CatSprite(imageNamed: "cat_one")
		
		catSprite.zPosition = 3
		catSprite.physicsBody = SKPhysicsBody(circleOfRadius: catSprite.size.width / 2)
		catSprite.physicsBody?.categoryBitMask = CatCategory
		catSprite.physicsBody?.contactTestBitMask = RainDropCategory | WorldFrameCategory
		
		return catSprite
	}
	
	public func update(deltaTime: TimeInterval, foodLocation: CGPoint) {
		timeSinceLastHit += deltaTime
		if timeSinceLastHit >= maxFailTime {

			if zRotation != 0 && action(forKey: "action_rotate") == nil {
				run(SKAction.rotate(toAngle: 0, duration: 0.25), withKey: "action_rotate")
			}

			if action(forKey: walkingActionKey) == nil {
				let walkingAction = SKAction.repeatForever(SKAction.animate(with: walkFrames, timePerFrame: 0.1))
				run(walkingAction, withKey: walkingActionKey)
			}
			
			if foodLocation.x < position.x {
				//left
				position.x -= movementSpeed * CGFloat(deltaTime)
				xScale = -1
			}
			else {
				//right
				position.x += movementSpeed * CGFloat(deltaTime)
				xScale = 1
			}
			physicsBody?.angularVelocity = 0
			
		}
	}
	
	public func hitByRain() {
		timeSinceLastHit = 0
		removeAction(forKey: walkingActionKey)
	}
}
