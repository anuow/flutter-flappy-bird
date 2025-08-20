import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  // determine if the pipe is top or bototom
  final bool isTopPipe;

  // score
  bool score = false;

  // init
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
    : super(position: position, size: size);

  /*  LOAD */

  @override
  Future<void> onLoad() async {
    // Load pipe sprite
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    // Add collision box
    add(RectangleHitbox());
  }

  /*  UPDATE */

  @override
  void update(double dt) {
    // scroll pipe to the left
    position.x -= groundSpeed * dt; // speed of pipe movement

    //check if the pipe has passed the bird
    if (!score && position.x + size.x < gameRef.bird.position.x) {
      score = true;

      // only increment for top pipe
      if (isTopPipe) {
        gameRef.incrementScore(); // increment score in the game
      }
    }

    // remove pipe if it goes off screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
