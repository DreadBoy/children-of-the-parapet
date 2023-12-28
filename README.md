# Children of the Parapet

## Plan

- [x] Player character
	- [x] model
	- [x] controller (move + attack)
		- [x] dash
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
- [x] Simple level
	- [x] teach movement
	- [ ] ~teach powers/pickups~
	- [x] teach dash (can be done by destroying barrier / gate)
	- [x] implement camera movement
	- [x] enter arena
- [x] Arena
	- [x] fight
	- [x] boss health bar
	- [x] game over screen in case of hit (one-hit death)
	- [x] game over screen in case of success
	- [x] end screen with link to survey
- [x] main menu
	- [x] with warning about survey at the end
	
- [ ] Improvements
	- [ ] Screen shake in dash hit
	- [ ] Sound effects
- [x] online survey


## Modeling, animating

Create model in Asset Forge, export with Godot preset.  
~From imported model, create new inherited scene and name it `<name_of_model>_animated.tscn`.~  
In animated scene, add AnimationPlayer and create animations. Set one animation as "Autoplay on load".  
Add AnimationTree, set Tree root as AnimationNodeStateMachine. Assign AnimationPlayer.
Start animating. Create animation tree and set all connections.
Toggle Active property.
