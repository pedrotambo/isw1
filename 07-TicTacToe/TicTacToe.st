!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game fila1col1 fila1col2 fila1col3 fila2col1 fila2col2 fila2col3 fila3col1 fila3col2 fila3col3'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:11:37'!
test01EmptyGameboard
	
	self assert: game isEmpty.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:11:49'!
test02CanMarkX

	game markWithXAt: 1 @ 1.
	
	self assert: 1 equals: game XsCount.
	self assert: (game XsHasAMarkIn: 1 @ 1).
	self assert: 0 equals: game OsCount.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:11:56'!
test03CanMarkO

	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	
	self assert: 1 equals: game XsCount.
	self assert: (game XsHasAMarkIn: 1 @ 1).
	self assert: 1 equals: game OsCount.
	self assert: (game OsHasAMarkIn: 2 @ 2).! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:12:00'!
test04XCanNotMarkTwice

	game markWithXAt: 1 @ 1.
	
	self should: [ game markWithXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assert: 1 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: 0 equals: game OsCount. ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:12:06'!
test05OCanNotMarkTwice

	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	
	self should: [ game markWithOAt: 3 @ 3 ]
		 raise: Error - MessageNotUnderstood
		 withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assert: 1 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: 1 equals: game OsCount.
			self assert: (game OsHasAMarkIn: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:12:11'!
test06XCanNotMarkPositionMarkedByX

	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	
	self should: [ game markWithXAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 1 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: 1 equals: game OsCount.
			self assert: (game OsHasAMarkIn: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:12:29'!
test07XCanNotMarkPositionMarkedByO

	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	
	self should: [ game markWithXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 1 equals: game XsCount .
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: 1 equals: game OsCount .
			self assert: (game OsHasAMarkIn: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 13:12:34'!
test08OCanNotMarkPositionMarkedByX

	game markWithXAt: 1 @ 1.
	
	self should: [ game markWithOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 1 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: 0 equals: game OsCount. ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 15:13:52'!
test09OCanNotMarkPositionMarkedByO

	self markAllPositionsOf: {1@1. 2@2. 3@3}.
	
	self should: [ game markWithOAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 2 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: (game XsHasAMarkIn: 3 @ 3).
			self assert: 1 equals: game OsCount.
			self assert: (game OsHasAMarkIn: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 15:09:43'!
test10NoWinner

	self markAllPositionsOf: {1@1. 2@1. 2@2. 3@3}.
	
	self deny: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 15:09:27'!
test11XHasWonInFirstRow

	self markAllPositionsOf: {1@1. 2@1. 1@2. 3@3. 1@3}.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 15:09:01'!
test12XHasWonInSecondRow

	self markAllPositionsOf: {2@1. 1@1. 2@2. 3@1. 2@3}.

	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 15:08:41'!
test13XHasWonInThirdRow

	self markAllPositionsOf: {3@1. 1@1. 3@2. 2@1. 3@3}.

	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 15:08:11'!
test14XHasWonInFirstColumn

	self markAllPositionsOf: {1@1. 2@2. 2@1. 3@3. 3@1}.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 14:49:00'!
test15XHasWonInDownDiagonal

	self markAllPositionsOf: {1@1. 2@1. 2@2. 2@3. 3@3}.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 14:48:40'!
test16XHasWonInUpDiagonal

	self markAllPositionsOf: {3@1. 2@1. 2@2. 1@2. 1@3}.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 14:48:18'!
test17OHasWonInFirstRow

	self markAllPositionsOf: {3@1. 1@1. 2@2. 1@2. 3@3. 1@3}.
	
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 14:47:50'!
test18OCanNotPlayWhenGameIsOver

	self markAllPositionsOf: {1@1. 2@1. 1@2. 3@1. 1@3}.

	self should: [ game markWithOAt: 3 @ 3 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game OsCount.
			self assert: (game OsHasAMarkIn: 2 @ 1).
			self assert: (game OsHasAMarkIn: 3 @ 1)].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 14:47:23'!
test19XCanNotPlayWhenGameIsOver

	self markAllPositionsOf: {2@2. 1@1. 2@1. 1@2. 3@1. 1@3}.
	
	self should: [ game markWithXAt: 3 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 2 @ 2).
			self assert: (game XsHasAMarkIn: 2 @ 1).
			self assert: (game XsHasAMarkIn: 3 @ 1)].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 14:46:43'!
test20TiedGame

	self markAllPositionsOf: {2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3}.

	self assert: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 14:45:50'!
test21WhenThereIsAWinnerGameIsNotTied

	self markAllPositionsOf: { 2@2 .1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assert: game isOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.! !


!TicTacToeTest methodsFor: 'support' stamp: 'PFT 5/31/2018 14:38:52'!
markAllPositionsOf: aCollectionOfMarks
	aCollectionOfMarks do: [ :mark |
		game isXTurn
			ifTrue: [ game markWithXAt: mark ]
			ifFalse: [ game markWithOAt: mark ]
	]! !

!TicTacToeTest methodsFor: 'support' stamp: 'PFT 5/31/2018 14:44:50'!
setUp

	game := TicTacToe new.
! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state os xs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'PFT 5/31/2018 13:27:47'!
initialize
	xs _ Set new.
	os _ Set new.
	state _ TicTacToeIsXTurn for: self.! !


!TicTacToe methodsFor: 'testing' stamp: 'LR 5/31/2018 02:27:31'!
OsCount

	^ os size! !

!TicTacToe methodsFor: 'testing' stamp: 'LR 5/31/2018 02:29:04'!
OsHasAMarkIn: aPosition

	^ os includes: aPosition ! !

!TicTacToe methodsFor: 'testing' stamp: 'LR 5/31/2018 02:27:39'!
XsCount

	^ xs size! !

!TicTacToe methodsFor: 'testing' stamp: 'LR 5/31/2018 02:28:57'!
XsHasAMarkIn: aPosition

	^ xs includes: aPosition ! !

!TicTacToe methodsFor: 'testing' stamp: 'LR 5/31/2018 02:13:14'!
isEmpty

	^ xs isEmpty and: [os isEmpty]! !


!TicTacToe methodsFor: 'private' stamp: 'jg 5/22/2018 12:51:23'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!TicTacToe methodsFor: 'private' stamp: 'LR 5/31/2018 02:08:59'!
hasCompletedDiagonalDown: positions
	
	^ (1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]
	
	! !

!TicTacToe methodsFor: 'private' stamp: 'LR 5/31/2018 02:09:44'!
hasCompletedDiagonalUp: positions
	
	^ (1 to: 3) allSatisfy: [ :n | positions includes: n@n ]
	
	! !

!TicTacToe methodsFor: 'private' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'private' stamp: 'LR 5/31/2018 02:07:25'!
hasWon: positions

	^ (self hasCompletedRow: positions) or: [
		(self hasCompletedColumn: positions) or: [
			(self hasCompletedDiagonalUp: positions) or:  [
				(self hasCompletedDiagonalDown: positions)]]].! !

!TicTacToe methodsFor: 'private' stamp: 'LR 5/31/2018 01:51:42'!
ifPositionIsAlreadyTakenRaiseError: aPosition

	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	! !

!TicTacToe methodsFor: 'private' stamp: 'PFT 5/31/2018 13:26:21'!
updateGameState
	state _ TicTacToeState stateFor: self.! !


!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 17:59:35'!
hasPlayerOWon

	^ self hasWon: os! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 17:59:47'!
hasPlayerXWon

	^ self hasWon: xs! !

!TicTacToe methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:32:40'!
isONextTurn
	^ state isOPlayingNext.! !

!TicTacToe methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:39:30'!
isOTurn
	^ state isOPlaying.! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 18:23:45'!
isOver
	
	^ self hasPlayerXWon or: [self hasPlayerOWon or: [self isTied]]! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 17:44:21'!
isTied

	^ xs size = 5 and: [os size = 4 and: [ self hasPlayerXWon not ]].! !

!TicTacToe methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:33:02'!
isXNextTurn
	^ state isXPlayingNext.! !

!TicTacToe methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:39:42'!
isXTurn
	^ state isXPlaying.! !


!TicTacToe methodsFor: 'game interact' stamp: 'LR 5/31/2018 01:55:02'!
markWhenOIsPlayingAt: aPosition

	os add: aPosition.
	
	self updateGameState! !

!TicTacToe methodsFor: 'game interact' stamp: 'LR 5/31/2018 01:54:55'!
markWhenXIsPlayingAt: aPosition

	xs add: aPosition.
	
	self updateGameState! !

!TicTacToe methodsFor: 'game interact' stamp: 'LR 5/31/2018 01:52:51'!
markWithOAt: aPosition
	
	self ifPositionIsAlreadyTakenRaiseError: aPosition.
	
	state markWithOAt: aPosition.
	
	! !

!TicTacToe methodsFor: 'game interact' stamp: 'LR 5/31/2018 01:52:36'!
markWithXAt: aPosition
	
	self ifPositionIsAlreadyTakenRaiseError: aPosition.
	
	state markWithXAt: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'error messages' stamp: 'LR 5/30/2018 19:07:57'!
canNotPlayWhenGameIsOverErrorMessage
	
	^ 'Can not play when game is over'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'LR 5/30/2018 19:08:01'!
notOTurnErrorMessage

	^ 'Not O turn'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'LR 5/30/2018 19:08:04'!
notXTurnErrorMessage

	^ 'Not X turn'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'LR 5/30/2018 19:08:09'!
positionTakenErrorMessage
	
	^ 'Position taken'! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'tictactoe'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'initialization' stamp: 'LR 5/31/2018 01:47:38'!
initializeWith: aTicTacToe

	tictactoe := aTicTacToe! !


!TicTacToeState methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:33:59'!
isOPlaying

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'game info' stamp: 'LR 5/31/2018 02:05:16'!
isOPlayingNext

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:34:01'!
isXPlaying

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'game info' stamp: 'LR 5/31/2018 02:05:19'!
isXPlayingNext

	self subclassResponsibility ! !


!TicTacToeState methodsFor: 'game interact' stamp: 'LR 5/31/2018 01:29:48'!
markWithOAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'game interact' stamp: 'LR 5/31/2018 01:29:45'!
markWithXAt: aPosition

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'state selection' stamp: 'PFT 5/28/2018 21:28:41'!
canHandle: aTicTacToe

	^ self subclassResponsibility ! !

!TicTacToeState class methodsFor: 'state selection' stamp: 'PFT 5/31/2018 13:28:09'!
stateFor: aTicTacToe
	
	^ (self subclasses detect: [ :aTicTacToeStateClass | aTicTacToeStateClass canHandle: aTicTacToe ]) for: aTicTacToe.! !


!TicTacToeState class methodsFor: 'instance creation' stamp: 'PFT 5/31/2018 13:28:17'!
for: aTicTacToe

	^ self new initializeWith: aTicTacToe.! !


!classDefinition: #TicTacToeFinished category: #TicTacToe!
TicTacToeState subclass: #TicTacToeFinished
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeFinished methodsFor: 'game info' stamp: 'LR 5/31/2018 02:04:59'!
isOPlayingNext

	^ false! !

!TicTacToeFinished methodsFor: 'game info' stamp: 'LR 5/31/2018 02:05:02'!
isXPlayingNext

	^ false! !


!TicTacToeFinished methodsFor: 'game interact' stamp: 'LR 5/30/2018 18:07:28'!
markWithOAt: aPosition

	self error: tictactoe class canNotPlayWhenGameIsOverErrorMessage
! !

!TicTacToeFinished methodsFor: 'game interact' stamp: 'LR 5/30/2018 18:07:32'!
markWithXAt: aPosition

	self error: tictactoe class canNotPlayWhenGameIsOverErrorMessage
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeFinished class' category: #TicTacToe!
TicTacToeFinished class
	instanceVariableNames: ''!

!TicTacToeFinished class methodsFor: 'state selection' stamp: 'LR 5/31/2018 01:26:51'!
canHandle: aTicTacToe

	^ aTicTacToe isOver ! !


!classDefinition: #TicTacToeIsOTurn category: #TicTacToe!
TicTacToeState subclass: #TicTacToeIsOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeIsOTurn methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:37:37'!
isOPlaying

	^ true! !

!TicTacToeIsOTurn methodsFor: 'game info' stamp: 'LR 5/31/2018 02:04:31'!
isOPlayingNext

	^ false! !

!TicTacToeIsOTurn methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:37:44'!
isXPlaying

	^ false! !

!TicTacToeIsOTurn methodsFor: 'game info' stamp: 'LR 5/31/2018 02:04:23'!
isXPlayingNext

	^ true! !


!TicTacToeIsOTurn methodsFor: 'game interact' stamp: 'PFT 5/28/2018 21:46:24'!
markWithOAt: aPosition

	tictactoe markWhenOIsPlayingAt: aPosition

	
! !

!TicTacToeIsOTurn methodsFor: 'game interact' stamp: 'LR 5/30/2018 17:07:10'!
markWithXAt: aPosition

	self error: tictactoe class notXTurnErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeIsOTurn class' category: #TicTacToe!
TicTacToeIsOTurn class
	instanceVariableNames: ''!

!TicTacToeIsOTurn class methodsFor: 'state selection' stamp: 'PFT 5/31/2018 13:49:05'!
canHandle: aTicTacToe

	^ aTicTacToe isOver not and: [ aTicTacToe isOTurn not ].! !


!classDefinition: #TicTacToeIsXTurn category: #TicTacToe!
TicTacToeState subclass: #TicTacToeIsXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeIsXTurn methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:34:18'!
isOPlaying
	
	^ false! !

!TicTacToeIsXTurn methodsFor: 'game info' stamp: 'LR 5/31/2018 02:04:41'!
isOPlayingNext

	^ true! !

!TicTacToeIsXTurn methodsFor: 'game info' stamp: 'PFT 5/31/2018 13:34:24'!
isXPlaying
	
	^ true! !

!TicTacToeIsXTurn methodsFor: 'game info' stamp: 'LR 5/31/2018 02:04:48'!
isXPlayingNext

	^ false! !


!TicTacToeIsXTurn methodsFor: 'game interact' stamp: 'LR 5/30/2018 17:06:53'!
markWithOAt: aPosition

	self error: tictactoe class notOTurnErrorMessage

	
! !

!TicTacToeIsXTurn methodsFor: 'game interact' stamp: 'PFT 5/28/2018 21:31:03'!
markWithXAt: aPosition

	tictactoe markWhenXIsPlayingAt: aPosition

	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeIsXTurn class' category: #TicTacToe!
TicTacToeIsXTurn class
	instanceVariableNames: ''!

!TicTacToeIsXTurn class methodsFor: 'state selection' stamp: 'PFT 5/31/2018 13:48:56'!
canHandle: aTicTacToe

	^ aTicTacToe isOver not and: [ aTicTacToe isXTurn not ].! !
