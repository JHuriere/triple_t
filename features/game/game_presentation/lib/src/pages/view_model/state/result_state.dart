sealed class ResultState {
  final bool showOverlay;
  const ResultState({this.showOverlay = false});
}

class InitialResultState extends ResultState {
  const InitialResultState() : super(showOverlay: false);
}

class WinnerResultState extends ResultState {
  const WinnerResultState({
    required this.winningLine,
    required this.winner,
    super.showOverlay = false,
  });

  final List<int> winningLine;
  final String winner;
  
  WinnerResultState copyWith({bool? showOverlay}) {
    return WinnerResultState(
      winningLine: winningLine,
      winner: winner,
      showOverlay: showOverlay ?? this.showOverlay,
    );
  }
}

class DrawResultState extends ResultState {
  const DrawResultState({super.showOverlay = false});
}

class NoResultState extends ResultState {
  const NoResultState() : super(showOverlay: false);
}
