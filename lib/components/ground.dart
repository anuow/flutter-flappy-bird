import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks{
  //init 
  Ground() : super();

  /* LOAD */

  
  @override
  Future<void> onLoad() async {
    // set size & position
    size = Vector2(2 * gameRef.size.x, groundHeight); 
    position = Vector2(0, gameRef.size.y - groundHeight);

    // load ground sprite
    sprite = await Sprite.load('ground.png');

    // add collision box
    add(RectangleHitbox());


  }
    
    /* UPDATE -> every second */

  @override
  void update(double dt) {
    // move ground to the left
    position.x -= groundSpeed * dt; // speed of ground movement
    // reset position when half of it goes off screen
    if (position.x + size.x / 2 < 0) {
      position.x = 0; // reset to the right side of the screen
    }

      
  }
  
}