import 'dart:math';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  /* 
Update -> every second 
We will continuously spwn new pipes
*/

  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    //generate new pipe at given interval
    pipeSpawnTimer += dt;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0; // reset timer
      spawnPipe();
    }
  }

  /* Spawn New Pipe */

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    /* Calculate random height for pipes */

    //max possible height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    // height of bottom pipe -> randomly select between min and max
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    //height of top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    /* Create Bottom Pipe */

    final bottomPipe = Pipe(
      // postion
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      // size
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    ); //pipe

    /* Create Top Pipe */

    final topPipe = Pipe(
      // position
      Vector2(gameRef.size.x, 0),
      // size
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    ); //pipe

    // add pipes to the game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
