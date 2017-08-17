//
//  FoodSprite.swift
//  RainCat
//
//  Created by Volodimir Moskaliuk on 8/17/17.
//
//

import SpriteKit

public class FoodSprite : SKSpriteNode {
	public static func newInstance() -> FoodSprite {
		let foodDish = FoodSprite(imageNamed: "food_dish")
		
		foodDish.physicsBody = SKPhysicsBody(rectangleOf: foodDish.size)
		foodDish.physicsBody?.categoryBitMask = FoodCategory
		foodDish.physicsBody?.contactTestBitMask = WorldFrameCategory | RainDropCategory | CatCategory
		foodDish.zPosition = 3
		
		return foodDish
	}
}
