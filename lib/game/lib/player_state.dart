part of game;

class PlayerState extends Node {
  PlayerState(this._sheetUI, this._sheetGame, this._gameState) {
    // Score display
    _spriteBackgroundScore = new Sprite(_sheetUI["heart.png"]);
    _spriteBackgroundScore.pivot = new Offset(1.0, 0.0);
    _spriteBackgroundScore.scale = 0.35;
    _spriteBackgroundScore.position = new Offset(24.0, 10.0);
    addChild(_spriteBackgroundScore);

    _scoreDisplay = new ScoreDisplay(_sheetUI);
    _scoreDisplay.position = new Offset(20.0, 10.0);
    _scoreDisplay.scale = 1.15;
    _spriteBackgroundScore.addChild(_scoreDisplay);

    // Coin display
    _spriteBackgroundCoins = new Sprite(_sheetUI["star.png"]); 
    _spriteBackgroundCoins.pivot = new Offset(1.0, 0.0);
    _spriteBackgroundCoins.scale = 0.65;
    _spriteBackgroundCoins.position = new Offset(85.0, 30.0);
    addChild(_spriteBackgroundCoins);

    _coinDisplay = new ScoreDisplay(_sheetUI);
    _coinDisplay.position = new Offset(60.0, 50.0);
    _coinDisplay.scale = 0.65;
    _spriteBackgroundCoins.addChild(_coinDisplay);

    laserLevel = _gameState.laserLevel;
  }

  final SpriteSheet _sheetUI;
  final SpriteSheet _sheetGame;
  final PersistantGameState _gameState;

  int laserLevel = 0;

  static const double normalScrollSpeed = 2.0;

  double scrollSpeed = normalScrollSpeed;

  double _scrollSpeedTarget = normalScrollSpeed;

  Sprite _spriteBackgroundScore;
  ScoreDisplay _scoreDisplay;
  Sprite _spriteBackgroundCoins;
  ScoreDisplay _coinDisplay;

  int get score => _scoreDisplay.score;

  set score(int score) {
    _scoreDisplay.score = score;
    flashBackgroundSprite(_spriteBackgroundScore);
  }

  int get coins => _coinDisplay.score;

  void addGoldCoin(GoldCoin c) {
    // Animate coin to the top of the screen        
    print('adding gold coin...');
    Offset startPos = convertPointFromNode(Offset.zero, c);
    Offset finalPos = new Offset(30.0, 30.0);
    Offset middlePos = new Offset((startPos.dx + finalPos.dx) / 2.0 + 50.0,
      (startPos.dy + finalPos.dy) / 2.0);

    List<Offset> path = <Offset>[startPos, middlePos, finalPos];

    Sprite sprite = new Sprite(_sheetGame["coin_gold.png"]);
    sprite.scale = 0.7;

    MotionSpline spline = new MotionSpline((Offset a) { sprite.position = a; }, path, 0.5);
    spline.tension = 0.25;
    MotionTween rotate = new MotionTween<double>((a) { sprite.rotation = a; }, 0.0, 360.0, 0.5);
    MotionTween scale = new MotionTween<double>((a) { sprite.scale = a; }, 0.7, 1.2, 0.5);
    MotionGroup group = new MotionGroup(<Motion>[spline, rotate, scale]);
    sprite.motions.run(new MotionSequence(<Motion>[
      group,
      new MotionRemoveNode(sprite),
      new MotionCallFunction(() {
        _coinDisplay.score += 5;
        flashBackgroundSprite(_spriteBackgroundCoins);
      })
    ]));
    print('coin score = ${_coinDisplay.score}');
    addChild(sprite);
  }

  void addSilverCoin(SilverCoin c) {
    // Animate coin to the top of the screen
        print('adding silver coin...');
    Offset startPos = convertPointFromNode(Offset.zero, c);
    Offset finalPos = new Offset(30.0, 30.0);
    Offset middlePos = new Offset((startPos.dx + finalPos.dx) / 2.0 + 50.0,
        (startPos.dy + finalPos.dy) / 2.0);

    List<Offset> path = <Offset>[startPos, middlePos, finalPos];

    Sprite sprite = new Sprite(_sheetGame["coin_silver.png"]);
    sprite.scale = 0.7;

    MotionSpline spline = new MotionSpline((Offset a) {
      sprite.position = a;
    }, path, 0.5);
    spline.tension = 0.25;
    MotionTween rotate = new MotionTween<double>((a) {
      sprite.rotation = a;
    }, 0.0, 360.0, 0.5);
    MotionTween scale = new MotionTween<double>((a) {
      sprite.scale = a;
    }, 0.7, 1.2, 0.5);
    MotionGroup group = new MotionGroup(<Motion>[spline, rotate, scale]);
    sprite.motions.run(new MotionSequence(<Motion>[
      group,
      new MotionRemoveNode(sprite),
      new MotionCallFunction(() {
        _coinDisplay.score += 3;
        flashBackgroundSprite(_spriteBackgroundCoins);
      })
    ]));
    print('coin score = ${_coinDisplay.score}');
    addChild(sprite);
  }

  void addBronzeCoin(BronzeCoin c) {
    // Animate coin to the top of the screen
    print('adding bronze coin...');
    Offset startPos = convertPointFromNode(Offset.zero, c);
    Offset finalPos = new Offset(30.0, 30.0);
    Offset middlePos = new Offset((startPos.dx + finalPos.dx) / 2.0 + 50.0,
        (startPos.dy + finalPos.dy) / 2.0);

    List<Offset> path = <Offset>[startPos, middlePos, finalPos];

    Sprite sprite = new Sprite(_sheetGame["coin_bronze.png"]);
    sprite.scale = 0.7;

    MotionSpline spline = new MotionSpline((Offset a) {
      sprite.position = a;
    }, path, 0.5);
    spline.tension = 0.25;
    MotionTween rotate = new MotionTween<double>((a) {
      sprite.rotation = a;
    }, 0.0, 360.0, 0.5);
    MotionTween scale = new MotionTween<double>((a) {
      sprite.scale = a;
    }, 0.7, 1.2, 0.5);
    MotionGroup group = new MotionGroup(<Motion>[spline, rotate, scale]);
    sprite.motions.run(new MotionSequence(<Motion>[
      group,
      new MotionRemoveNode(sprite),
      new MotionCallFunction(() {
        _coinDisplay.score += 1;
        flashBackgroundSprite(_spriteBackgroundCoins);
      })
    ]));
    print('coin score = ${_coinDisplay.score}');
    addChild(sprite);
  }

  void flashBackgroundSprite(Sprite sprite) {
    sprite.motions.stopAll();
    MotionTween flash = new MotionTween<Color>(
      (a) { sprite.colorOverlay = a; },
      new Color(0x66ccfff0),
      new Color(0x00ccfff0),
      0.3);
    sprite.motions.run(flash);
  }
}

class ScoreDisplay extends Node {
  ScoreDisplay(this._sheetUI);

  int _score = 0;

  int get score => _score;

  set score(int score) {
    _score = score;
    _dirtyScore = true;
  }
  

  SpriteSheet _sheetUI;

  bool _dirtyScore = true;

  void update(double dt) {
    if (_dirtyScore) {
      removeAllChildren();
      String scoreStr = _score.toString();
      double xPos = -37.0;
      for (int i = scoreStr.length - 1; i >= 0; i--) {
        print(score);
        print("scoreStr = $scoreStr");
        String numStr = scoreStr.substring(i, i + 1);
        print("numStr = $numStr");
        Sprite numSprite = new Sprite(_sheetUI["$numStr.png"]);
        numSprite.position = new Offset( xPos , 0.0);
        addChild(numSprite);
        xPos -= 37.0;
      }
      _dirtyScore = false;
    }
  }
}











// part of game;

// class PlayerState extends Node {
//   PlayerState(this._sheetUI, this._sheetGame, this._gameState) {
//     // Score display
//     // _spriteBackgroundScore = new Sprite(_sheetUI["btn_play.png"]);
//     // _spriteBackgroundScore.pivot = new Offset(1.0, 0.0);
//     // _spriteBackgroundScore.scale = 0.35;
//     // _spriteBackgroundScore.position = new Offset(440.0, 10.0);
//     // addChild(_spriteBackgroundScore);

//     _scoreDisplay = new ScoreDisplay(_sheetUI);
//     _scoreDisplay.position = new Offset(449.0, 49.0);
//     // _spriteBackgroundScore.addChild(_scoreDisplay);

//     // Coin display
//     // _spriteBackgroundCoins = new Sprite(_sheetUI["btn_exit.png"]);
//     // _spriteBackgroundCoins.pivot = new Offset(1.0, 0.0);
//     // _spriteBackgroundCoins.scale = 0.35;
//     // _spriteBackgroundCoins.position = new Offset(105.0, 10.0);
//     // addChild(_spriteBackgroundCoins);

//     // _coinDisplay = new ScoreDisplay(_sheetUI);
//     // _coinDisplay.position = new Offset(252.0, 49.0);
//     // _spriteBackgroundCoins.addChild(_coinDisplay);

//     // laserLevel = _gameState.laserLevel;
//   }

//   final SpriteSheet _sheetUI;
//   final SpriteSheet _sheetGame;
//   final PersistantGameState _gameState;

//   int laserLevel = 0;

//   static const double normalScrollSpeed = 2.0;

//   double scrollSpeed = normalScrollSpeed;

//   double _scrollSpeedTarget = normalScrollSpeed;

//   EnemyBoss boss;

//   // Sprite _spriteBackgroundScore;
//   ScoreDisplay _scoreDisplay;
//   Sprite _spriteBackgroundCoins;
//   ScoreDisplay _coinDisplay;

//   int get score => _scoreDisplay.score;

//   set score(int score) {
//     _scoreDisplay.score = score;
//     // flashBackgroundSprite(_spriteBackgroundScore);
//   }

//   int get coins => _coinDisplay.score;

//   void addCoin(Coin c) {
//     // Animate coin to the top of the screen
//     Offset startPos = convertPointFromNode(Offset.zero, c);
//     Offset finalPos = new Offset(30.0, 30.0);
//     Offset middlePos = new Offset((startPos.dx + finalPos.dx) / 2.0 + 50.0,
//         (startPos.dy + finalPos.dy) / 2.0);

//     List<Offset> path = <Offset>[startPos, middlePos, finalPos];

//     Sprite sprite = new Sprite(_sheetGame["coin.png"]);
//     sprite.scale = 0.7;

//     MotionSpline spline = new MotionSpline((Offset a) {
//       sprite.position = a;
//     }, path, 0.5);
//     spline.tension = 0.25;
//     MotionTween rotate = new MotionTween<double>((a) {
//       sprite.rotation = a;
//     }, 0.0, 360.0, 0.5);
//     MotionTween scale = new MotionTween<double>((a) {
//       sprite.scale = a;
//     }, 0.7, 1.2, 0.5);
//     MotionGroup group = new MotionGroup(<Motion>[spline, rotate, scale]);
//     sprite.motions.run(new MotionSequence(<Motion>[
//       group,
//       new MotionRemoveNode(sprite),
//       new MotionCallFunction(() {
//         _coinDisplay.score += 1;
//         flashBackgroundSprite(_spriteBackgroundCoins);
//       })
//     ]));

//     addChild(sprite);
//   }

//   // void activatePowerUp(PowerUpType type) {
//   //   if (type == PowerUpType.shield) {
//   //     _shieldFrames += _gameState.powerUpFrames(type);
//   //   } else if (type == PowerUpType.sideLaser) {
//   //     _sideLaserFrames += _gameState.powerUpFrames(type);
//   //   } else if (type == PowerUpType.speedLaser) {
//   //     _speedLaserFrames += _gameState.powerUpFrames(type);
//   //   } else if (type == PowerUpType.speedBoost) {
//   //     _speedBoostFrames += _gameState.powerUpFrames(type);
//   //     _shieldFrames += _gameState.powerUpFrames(type) + 60;
//   //   }
//   // }

//   // int _shieldFrames = 0;
//   // bool get shieldActive => _shieldFrames > 0 || _speedBoostFrames > 0;
//   // bool get shieldDeactivating =>
//   //     math.max(_shieldFrames, _speedBoostFrames) > 0 &&
//   //     math.max(_shieldFrames, _speedBoostFrames) < 60;

//   // int _sideLaserFrames = 0;
//   // bool get sideLaserActive => _sideLaserFrames > 0;

//   // int _speedLaserFrames = 0;
//   // bool get speedLaserActive => _speedLaserFrames > 0;

//   // int _speedBoostFrames = 0;
//   // bool get speedBoostActive => _speedBoostFrames > 0;

//   void flashBackgroundSprite(Sprite sprite) {
//     sprite.motions.stopAll();
//     MotionTween flash = new MotionTween<Color>((a) {
//       sprite.colorOverlay = a;
//     }, new Color(0x66ccfff0), new Color(0x66ccfff0), 0.3);
//     sprite.motions.run(flash);
//   }

//   // void update(double dt) {
//   //   if (_shieldFrames > 0) _shieldFrames--;
//   //   if (_sideLaserFrames > 0) _sideLaserFrames--;
//   //   if (_speedLaserFrames > 0) _speedLaserFrames--;
//   //   if (_speedBoostFrames > 0) _speedBoostFrames--;

//   //   // Update speed
//   //   if (boss != null) {
//   //     Offset globalBossPos = boss.convertPointToBoxSpace(Offset.zero);
//   //     if (globalBossPos.dy > (_gameSizeHeight - 400.0))
//   //       _scrollSpeedTarget = 0.0;
//   //     else
//   //       _scrollSpeedTarget = normalScrollSpeed;
//   //   } else {
//   //     if (speedBoostActive)
//   //       _scrollSpeedTarget = normalScrollSpeed * 6.0;
//   //     else
//   //       _scrollSpeedTarget = normalScrollSpeed;
//   //   }

//   //   scrollSpeed = GameMath.filter(scrollSpeed, _scrollSpeedTarget, 0.1);
//   // }
// }

// class ScoreDisplay extends Node {
//   ScoreDisplay(this._sheetUI);

//   int _score = 0;

//   int get score => _score;

//   set score(int score) {
//     _score = score;
//     _dirtyScore = true;
//   }

//   SpriteSheet _sheetUI;

//   bool _dirtyScore = true;

//   void update(double dt) {
//     if (_dirtyScore) {
//       removeAllChildren();

//       String scoreStr = _score.toString();
//       double xPos = -37.0;
//       // print('HEREEEEE ${scoreStr}');
//       // for (int i = scoreStr.length - 1; i >= 0; i--) {
//       //   print(i);
//       //     print(scoreStr.substring(i, i + 1));
//       //   String numStr = scoreStr.substring(i, i + 1);
//         Sprite numSprite = new Sprite(_sheetUI["btn_exit.png"]);
//         numSprite.position = new Offset(xPos, 0.0);
//         addChild(numSprite);
//         xPos -= 37.0;
//       // }
//       _dirtyScore = false;
//     }
//   }
// }


// // class ScoreDisplay extends Node {
// //   ScoreDisplay(this._sheetUI);

// //   int _score = 0;

// //   int get score => _score;

// //   set score(int score) {
// //     _score = score;
// //     _dirtyScore = true;
// //   }

// //   SpriteSheet _sheetUI;

// //   bool _dirtyScore = true;

// //   void update(double dt) {
// //     if (_dirtyScore) {
// //       //remove current number of hearts
// //       // add score[0] number of hearts
// //       removeAllChildren();
// //       for (int i = _score - 1; i <= 0 ; i--) {
// //         Sprite numSprite = new Sprite(_sheetUI["heart.png"]);
// //               numSprite.position = new Offset(_score +.0, _score + .0);
// //          addChild(numSprite);
// //       }
// //       ;
// //       _dirtyScore = false;
// //       // print('SCORE EQUALS -> ${_score}');
// //       // String scoreStr = _score.toString();
// //       // print(_score /10);
// //       // double newNum = _score /10;
// //       // double xPos = -37.0;
// //       // for (int i = scoreStr.length - 1; i >= 0; i--) {
// //       //   print(i);
// //       // String numStr = scoreStr.substring(i, i + 1);
// //       // Sprite numSprite = new Sprite(_sheetUI["heart.png"]);
// //       // numSprite.position = new Offset(xPos, _score + .0);
// //       // removeChild(numSprite);
// //       //   Text(scoreStr);
// //       //   addChild(numSprite);
// //       //   xPos -= 37.0;
// //       // }
// //     }
// //   }
// // }


