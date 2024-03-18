# Children of the Parapet

## Plan

### Phase 2

- [ ] figure out how to make sound effects
- [ ] screen shake on damage taken
- [ ] freeze frame on damage dealt
- [ ] simple enemy
	- [x] leapstone
		- leaping ~frog~ stone
		- moves by leaping, will leap onto player to attack
	- [x] pathfinding towards player
		- [x] will start only when in aggro range
		- [x] will stop if out of aggro range
	- [ ] camera will zoom out to show all/most enemies that are aggroed
	- [ ] destroyable items?
		- piles of stones -> leapstone emerges
- [ ] boss
	- something connected with jumping/leaping
	- reward is jump ability
- [ ] Green 1st level
	- [x] sketch layout, mark enemies
	- [x] recolor Mars assets to green/gray
	- [x] create vegetation, rocks
	- [x] create asset kit in Godot, don't forget colliders
	- [ ] iterate on level, it's too narrow to avoid enemies completely
	- [ ] add 2nd (semi-hidden) path that leads to pocket level and ambush
		- [ ] think of reward...
			- extra life? - no HP is implemented yet...
			- just chill music and chill animation? - need to do animation :(
			- extra emoji? - need to do animation, too. But it will also tie into future kill/action streaks

### Phase 3

- [ ] Hit points
	- low number of hit points
	- maybe each split in half, will recover if nothing hits you again in short window of time?
	- "extra point" at 0 HP
- [ ] Kill streak / action streak
	- each kill and combo will increase streak
	- no gameplay effect, just louder percussion (music), more zoomed in camera and a bit longer freeze frame
	- lost if damage taken or a bit longer without any action
- [ ] simple enemies
	- [ ] woodshield - SCRAPED, it slows down gameplay. Next monster should have ground smash ability.
		- wooden stump with a shield
		- fast shield-on animation
		- cooldown before starting to shield-off
		- slow-ish shield-off, then it can start walking/turning again
		- player will need to bait shield and kite around
	- [ ] destroyable items?
		- tree stump -> woodshield emerges

### Phase 1

- [x] Player character
	- [x] model
	- [x] controller (move + attack)
		- [x] dash
	- [x] animation
		- [x] dash + hit animation
- [x] Boss
	- [x] concept / attack gimmick
		- huge club, slow attack
		- if doesn't connect after being hit X times, unleash spin attack (rage animation)
	- [x] model
	- [x] logic (movement + that single attack)
	- [x] animation
		- [x] move
		- [x] club attack
		- [ ] ~spin attack~
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
Create scene with same name and instantiate model inside it. Enable Editable children.  
Add AnimationPlayer and create animations.  
Add AnimationTree, set Tree root as AnimationNodeStateMachine. Assign AnimationPlayer.  
Create animation tree and set all connections.  
Toggle Active property.  

## Terrain, GridMap

1. Export every single tile from Asset Forge, Choose Godot preset and *Export selection only*
2. Import all tiles into new scene, leave them at (0,0,0). 
3. On each tile:
	1. set as local
	2. move new MeshInstance3D to correct position
	3. rename MeshInstance3D to same name as parent
	4. above 3D view, select Mesh -> Create Trimesh Static Body
	5. (optional) select Mesh -> Create Single Convex Collision Sibling
	6. (optional) move parent to desired location, location inside GridMap is determined by location of MeshInstance3D
4. Select root node and Scene -> Export As... -> MeshLibrary...
5. Choose Apply MeshInstance Transforms
6. In level scene, create new GridMap node, assign Mesh Library and change Cell -> Size
