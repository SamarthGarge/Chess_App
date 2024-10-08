import 'package:flutter_chess/constants.dart';
import 'package:squares/squares.dart';

class GameModel {
  String gameId;
  String gameCreatorUid;
  String userId;
  String positionFen;
  String winnerId;
  String whitesTime;
  String blacksTime;
  String whitesCurrentMove;
  String blacksCurrentMove;
  String boardState;
  String playState;
  bool isWhitesTurn;
  bool isGameOver;
  int squareState;
  List<Move> moves;

  GameModel({
    required this.gameId,
    required this.gameCreatorUid,
    required this.userId,
    required this.positionFen,
    required this.winnerId,
    required this.whitesTime,
    required this.blacksTime,
    required this.whitesCurrentMove,
    required this.blacksCurrentMove,
    required this.boardState,
    required this.playState,
    required this.isWhitesTurn,
    required this.isGameOver,
    required this.squareState,
    required this.moves,
  });

  Map<String, dynamic> toMap() {
    return {
      Constants.gameId: gameId,
      Constants.gameCreatorUid: gameCreatorUid,
      Constants.userId: userId,
      Constants.positionFen: positionFen,
      Constants.winnerId: winnerId,
      Constants.whitesTime: whitesTime,
      Constants.blacksTime: blacksTime,
      Constants.whitesCurrentMove: whitesCurrentMove,
      Constants.blacksCurrentMove: blacksCurrentMove,
      Constants.boardState: boardState,
      Constants.playState: playState,
      Constants.isWhitesTurn: isWhitesTurn,
      Constants.isGameOver: isGameOver,
      Constants.squareState: squareState,
      Constants.moves: moves,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      gameId: map[Constants.gameId] ?? '',
      gameCreatorUid: map[Constants.gameCreatorUid] ?? '',
      userId: map[Constants.userId] ?? '',
      positionFen: map[Constants.positionFen] ?? '',
      winnerId: map[Constants.winnerId] ?? '',
      whitesTime: map[Constants.whitesTime] ?? '',
      blacksTime: map[Constants.blacksTime] ?? '',
      whitesCurrentMove: map[Constants.whitesCurrentMove] ?? '',
      blacksCurrentMove: map[Constants.blacksCurrentMove] ?? '',
      boardState: map[Constants.boardState] ?? '',
      playState: map[Constants.playState] ?? '',
      isWhitesTurn: map[Constants.isWhitesTurn] ?? '',
      isGameOver: map[Constants.isGameOver] ?? '',
      squareState: map[Constants.squareState] ?? '',
      moves: List<Move>.from(map[Constants.moves] ?? []),
    );
  }
}
