import 'package:flame/components.dart';

class Background extends SpriteComponent {
  //init background position and size (accept size as a parameter to know device size)
  Background(Vector2 size) : super(position: Vector2(0, 0), size: size);

  @override
  Future<void> onLoad() async {
    // load background sprite

    sprite = await Sprite.load('background.png');
  }
}
