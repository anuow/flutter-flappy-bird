import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  /*

  INIT BIRD

  */

  // initialize bird positions and size
  Bird()
    : super(
        position: Vector2(birdStartX, birdStartY),
        size: Vector2(birdWidth, birdHeight),
      );

  // physical world properties
  double velocity = 0;

  /*

  LOAD

  */

  @override
  Future<void> onLoad() async {
    // load bird sprite
    sprite = await Sprite.load('bird.png');

    // add collision box
    add(RectangleHitbox());
  }

  /*

  JUMP/FLAP

  */

  void flap() {
    velocity = jumpStrength;
  }

  /*

  UPDATE -> called every frame

  */

  @override
  void update(double dt) {
    // apply gravity
    velocity += gravity * dt;

    // update position based on velocity
    position.y += velocity * dt;
  }

  /* COLLISION HANDLING */

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // check if the bird collides with the ground
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    // check if the bird collides with a pipe
    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
