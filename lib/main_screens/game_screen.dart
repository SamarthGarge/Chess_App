import 'package:flutter/material.dart';
import 'package:flutter_chess/constants.dart';
import 'package:flutter_chess/helper/helper_methods.dart';
import 'package:flutter_chess/helper/uci_commands.dart';
import 'package:flutter_chess/providers/game_provider.dart';
import 'package:flutter_chess/service/assets_manager.dart';
import 'package:provider/provider.dart';
import 'package:squares/squares.dart';
import 'package:stockfish/stockfish.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Stockfish stockfish;

  @override
  void initState() {
    stockfish = Stockfish();
    final gameProvider = context.read<GameProvider>();
    gameProvider.resetGame(newGame: false);

    if (mounted) {
      letOtherPlayerPlayFirst();
    }
    super.initState();
  }

  @override
  void dispose() {
    stockfish.dispose();
    super.dispose();
  }

  void letOtherPlayerPlayFirst() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final gameProvider = context.read<GameProvider>();
      if (gameProvider.state.state == PlayState.theirTurn &&
          !gameProvider.aiThinking) {
        gameProvider.setAiThinking(true);

        // wait until stockfish is ready
        await waitUntilReady();

        // get the current position of the board and sent to stockfish
        stockfish.stdin =
            '${UciCommands.position} ${gameProvider.getPositionFen()}';

        // set stockfish level
        stockfish.stdin =
            '${UciCommands.goMoveTime} ${gameProvider.gameLevel * 1000}';

        stockfish.stdout.listen((event) {
          if (event.contains(UciCommands.bestMove)) {
            final bestMove = event.split(' ')[1];
            gameProvider.makeStringMove(bestMove);
            gameProvider.setAiThinking(false);

            gameProvider.setSquaresState().whenComplete(() {
              if (gameProvider.player == Squares.white) {
                // check if we can play whitesTimer
                if (gameProvider.playWhitesTimer) {
                  // pause timer for black
                  gameProvider.pauseBlacksTimer();

                  startTimer(isWhiteTimer: true, onNewGame: () {});

                  gameProvider.setPlayWhitesTimer(value: false);
                }
              } else {
                if (gameProvider.playBlacksTimer) {
                  // pause timer for white
                  gameProvider.pauseWhitesTimer();

                  startTimer(isWhiteTimer: false, onNewGame: () {});

                  gameProvider.setPlayBlacksTimer(value: false);
                }
              }
            });
          }
        });
      }
    });
  }

  void _onMove(Move move) async {
    final gameProvider = context.read<GameProvider>();
    bool result = gameProvider.makeSquaresMove(move);
    if (result) {
      gameProvider.setSquaresState().whenComplete(() {
        if (gameProvider.player == Squares.white) {
          // pause timer for white
          gameProvider.pauseWhitesTimer();

          startTimer(
            isWhiteTimer: false,
            onNewGame: () {},
          );
          // set whites bool flag to true so that we don't run this code again until true
          gameProvider.setPlayWhitesTimer(value: true);
        } else {
          // pause timer for black
          gameProvider.pauseBlacksTimer();

          startTimer(
            isWhiteTimer: true,
            onNewGame: () {},
          );
          // set blacks bool flag to true so that we don't run this code again until true
          gameProvider.setPlayBlacksTimer(value: true);
        }
      });
    }

    if (gameProvider.state.state == PlayState.theirTurn &&
        !gameProvider.aiThinking) {
      gameProvider.setAiThinking(true);

      // wait until stockfish is ready
      await waitUntilReady();

      // get the current position of the board and sent to stockfish
      stockfish.stdin =
          '${UciCommands.position} ${gameProvider.getPositionFen()}';

      // set stockfish level
      stockfish.stdin =
          '${UciCommands.goMoveTime} ${gameProvider.gameLevel * 1000}';

      stockfish.stdout.listen((event) {
        if (event.contains(UciCommands.bestMove)) {
          final bestMove = event.split(' ')[1];
          gameProvider.makeStringMove(bestMove);
          gameProvider.setAiThinking(false);

          gameProvider.setSquaresState().whenComplete(() {
            if (gameProvider.player == Squares.white) {
              // check if we can play whitesTimer
              if (gameProvider.playWhitesTimer) {
                // pause timer for black
                gameProvider.pauseBlacksTimer();

                startTimer(isWhiteTimer: true, onNewGame: () {});

                gameProvider.setPlayWhitesTimer(value: false);
              }
            } else {
              if (gameProvider.playBlacksTimer) {
                // pause timer for white
                gameProvider.pauseWhitesTimer();

                startTimer(isWhiteTimer: false, onNewGame: () {});

                gameProvider.setPlayBlacksTimer(value: false);
              }
            }
          });
        }
      });

      // await Future.delayed(
      //     Duration(milliseconds: Random().nextInt(4750) + 250));
      // gameProvider.game.makeRandomMove();
      // gameProvider.setAiThinking(false);
      // gameProvider.setSquaresState().whenComplete(() {
      //   if (gameProvider.player == Squares.white) {
      //     // pause timer for black
      //     gameProvider.pauseBlacksTimer();

      //     startTimer(isWhiteTimer: true, onNewGame: () {});
      //   } else {
      //     // pause timer for white
      //     gameProvider.pauseWhitesTimer();

      //     startTimer(isWhiteTimer: false, onNewGame: () {});
      //   }
      // });
    }

    await Future.delayed(const Duration(seconds: 1));
    // listen if its game over
    checkGameOverListener();
  }

  Future<void> waitUntilReady() async {
    while (stockfish.state.value != StockfishState.ready) {
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void checkGameOverListener() {
    final gameProvider = context.read<GameProvider>();
    gameProvider.gameOverListener(
      context: context,
      stockfish: stockfish,
      onNewGame: () {
        // start new game
      },
    );
  }

  void startTimer({
    required bool isWhiteTimer,
    required Function onNewGame,
  }) {
    final gameProvider = context.read<GameProvider>();
    if (isWhiteTimer) {
      // start timer for white
      gameProvider.startWhitesTimer(
        context: context,
        stockfish: stockfish,
        onNewGame: onNewGame,
      );
    } else {
      // start timer for black
      gameProvider.startBlacksTimer(
        context: context,
        stockfish: stockfish,
        onNewGame: onNewGame,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) async {
        if (didpop) return;
        bool? leave = await _showExitConfirmDialog(context);
        if (leave != null && leave) {
          stockfish.stdin = UciCommands.stop;
          await Future.delayed(const Duration(milliseconds: 200))
              .whenComplete(() {
            // if the user confirm, navigate to home screen
            Navigator.pushNamedAndRemoveUntil(
                context, Constants.homeScreen, (route) => false);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     // TODO show dialog if sure
          //     Navigator.pop(context);
          //   },
          // ),
          backgroundColor: Colors.blue,
          title: const Text(
            'Flutter Chess',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                gameProvider.resetGame(newGame: false);
              },
              icon: const Icon(Icons.start, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                gameProvider.flipTheBoard();
              },
              icon: const Icon(Icons.rotate_left, color: Colors.white),
            ),
          ],
        ),
        body: Consumer<GameProvider>(
          builder: (context, gameProvider, child) {
            String whitesTimer = getTimerToDisplay(
              gameProvider: gameProvider,
              isUser: true,
            );

            String blacksTimer =
                getTimerToDisplay(gameProvider: gameProvider, isUser: false);
            return Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Opponent's data
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(AssetsManager.stockfishIcon),
                  ),
                  title: const Text('Stockfish'),
                  subtitle: const Text('Rating: 3000'),
                  trailing: Text(
                    blacksTimer,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BoardController(
                    state: gameProvider.flipBoard
                        ? gameProvider.state.board.flipped()
                        : gameProvider.state.board,
                    playState: gameProvider.state.state,
                    pieceSet: PieceSet.merida(),
                    theme: BoardTheme.brown,
                    moves: gameProvider.state.moves,
                    onMove: _onMove,
                    onPremove: _onMove,
                    markerTheme: MarkerTheme(
                      empty: MarkerTheme.dot,
                      piece: MarkerTheme.corners(),
                    ),
                    promotionBehaviour: PromotionBehaviour.autoPremove,
                  ),
                ),

                // Our data
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(AssetsManager.userIcon),
                  ),
                  title: const Text('User3015'),
                  subtitle: const Text('Rating: 1200'),
                  trailing: Text(
                    whitesTimer,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool?> _showExitConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Leave Game?',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Are you sure to leave this game?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
