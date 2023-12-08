# Children of the Parapet

## Plan

- [x] Player character
	- [x] model
	- [x] controller (move + attack)
		- [ ] dash
	- [x] animation
		- [x] dash + hit animation
- [ ] Boss
	- [x] concept / attack gimmick
		- huge club, slow attack
		- if doesn't connect after being hit X times, unleash spin attack (rage animation)
	- [x] model
	- [x] logic (movement + that single attack)
	- [ ] animation
		- [x] move
		- [x] club attack
		- [ ] spin attack
- [ ] Simple level
	- [ ] teach movement
	- [ ] teach powers/pickups
	- [ ] teach dash (can be done by destroying barrier / gate)
	- [ ] implement camera movement
	- [ ] enter arena
- [ ] Arena
	- [ ] fight
	- [ ] boss health bar
	- [ ] game over screen in case of hit (one-hit death)
	- [ ] game over screen in case of success
	- [ ] end screen with link to survey
- [ ] online survey
- [ ] main menu
	- [ ] with warning about survey at the end


## Modeling, animating

Create model in Asset Forge, export with Godot preset.  
~From imported model, create new inherited scene and name it `<name_of_model>_animated.tscn`.~  
In animated scene, add AnimationPlayer and create animations. Set one animation as "Autoplay on load".  
Add AnimationTree, set Tree root as AnimationNodeStateMachine. Assign AnimationPlayer.
Start animating. Create animation tree and set all connections.
Toggle Active property.
