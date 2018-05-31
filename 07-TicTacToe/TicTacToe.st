!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:16:38'!
test01EmptyGameboard
	| game |
	game _ TicTacToe new.
	
	self assert: game isEmpty.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:31:17'!
test02CanMarkX
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	
	self assert: 1 equals: game XsCount.
	self assert: (game XsHasAMarkIn: 1 @ 1).
	self assert: 0 equals: game OsCount.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:32:05'!
test03CanMarkO
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	
	self assert: 1 equals: game XsCount.
	self assert: (game XsHasAMarkIn: 1 @ 1).
	self assert: 1 equals: game OsCount.
	self assert: (game OsHasAMarkIn: 2 @ 2).! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:32:45'!
test04XCanNotMarkTwice
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	
	self should: [ game markWithXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assert: 1 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: 0 equals: game OsCount. ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:33:21'!
test05OCanNotMarkTwice
	| game |
	game _ TicTacToe new.
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

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:33:42'!
test06XCanNotMarkPositionMarkedByX
	| game |
	game _ TicTacToe new.
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

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:34:01'!
test07XCanNotMarkPositionMarkedByO
	| game |
	game _ TicTacToe new.
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

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:34:33'!
test08OCanNotMarkPositionMarkedByX
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	
	self should: [ game markWithOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 1 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: 0 equals: game OsCount. ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:34:58'!
test09OCanNotMarkPositionMarkedByO
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	game markWithXAt: 3 @ 3.
	
	self should: [ game markWithOAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 2 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 1 @ 1).
			self assert: (game XsHasAMarkIn: 3 @ 3).
			self assert: 1 equals: game OsCount.
			self assert: (game OsHasAMarkIn: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:11'!
test10NoWinner
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 3 @ 3.
	
	self deny: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:13'!
test11XHasWonInFirstRow
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 1 @ 3.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:16'!
test12XHasWonInSecondRow
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 3.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:19'!
test13XHasWonInThirdRow
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 3 @ 3.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:23'!
test14XHasWonInFirstColumn
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 3 @ 1.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:26'!
test15XHasWonInDownDiagonal
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 3 @ 3.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:29'!
test16XHasWonInUpDiagonal
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 1 @ 3.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:17:32'!
test17OHasWonInFirstRow
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 1 @ 3.
	
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:35:26'!
test18OCanNotPlayWhenGameIsOver
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 1 @ 3.
	
	self should: [ game markWithOAt: 3 @ 3 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game OsCount.
			self assert: (game OsHasAMarkIn: 2 @ 1).
			self assert: (game OsHasAMarkIn: 3 @ 1)].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/31/2018 02:35:52'!
test19XCanNotPlayWhenGameIsOver
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 3.
	
	self should: [ game markWithXAt: 3 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game XsCount.
			self assert: (game XsHasAMarkIn: 2 @ 2).
			self assert: (game XsHasAMarkIn: 2 @ 1).
			self assert: (game XsHasAMarkIn: 3 @ 1)].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/30/2018 18:26:06'!
test20TiedGame
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 2.
	game markWithXAt: 3 @ 3.
	
	self assert: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'LR 5/30/2018 18:26:36'!
test21WhenThereIsAWinnerGameIsNotTied
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 3 @ 3.
	
	self assert: game isOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state os xs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'estos deberian volar' stamp: 'LR 5/30/2018 17:53:27'!
Os

	^ os copy.! !

!TicTacToe methodsFor: 'estos deberian volar' stamp: 'LR 5/30/2018 17:53:23'!
Xs

	^ xs copy.! !


!TicTacToe methodsFor: 'initialization' stamp: 'LR 5/31/2018 01:57:35'!
initialize

	xs _ Set new.
	os _ Set new.
	
	state _ TicTacToeIsXTurn newWith: self.! !


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

!TicTacToe methodsFor: 'private' stamp: 'LR 5/31/2018 01:54:32'!
updateGameState

	state := TicTacToeState for: self! !


!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 17:59:35'!
hasPlayerOWon

	^ self hasWon: os! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 17:59:47'!
hasPlayerXWon

	^ self hasWon: xs! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/31/2018 02:03:55'!
isOTurn

	^ state isOPlayingNext! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 18:23:45'!
isOver
	
	^ self hasPlayerXWon or: [self hasPlayerOWon or: [self isTied]]! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/30/2018 17:44:21'!
isTied

	^ xs size = 5 and: [os size = 4 and: [ self hasPlayerXWon not ]].! !

!TicTacToe methodsFor: 'game info' stamp: 'LR 5/31/2018 02:03:39'!
isXTurn

	^ state isXPlayingNext! !


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

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'LR 5/30/2018 19:07:57'!
canNotPlayWhenGameIsOverErrorMessage
	
	^ 'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'LR 5/30/2018 19:08:01'!
notOTurnErrorMessage

	^ 'Not O turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'LR 5/30/2018 19:08:04'!
notXTurnErrorMessage

	^ 'Not X turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'LR 5/30/2018 19:08:09'!
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


!TicTacToeState methodsFor: 'game info' stamp: 'LR 5/31/2018 02:05:16'!
isOPlayingNext

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

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'PFT 5/28/2018 21:28:41'!
canHandle: aTicTacToe

	^ self subclassResponsibility ! !

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'LR 5/31/2018 01:32:12'!
for: aTicTacToe

	^ (self subclasses detect: [:aTicTacToeStateClass | aTicTacToeStateClass canHandle: aTicTacToe ]) newWith: aTicTacToe! !

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'LR 5/31/2018 01:34:18'!
newWith: aTicTacToe

	^ self new initializeWith: aTicTacToe 

	! !


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

!TicTacToeFinished class methodsFor: 'as yet unclassified' stamp: 'LR 5/31/2018 01:26:51'!
canHandle: aTicTacToe

	^ aTicTacToe isOver ! !


!classDefinition: #TicTacToeIsOTurn category: #TicTacToe!
TicTacToeState subclass: #TicTacToeIsOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeIsOTurn methodsFor: 'game info' stamp: 'LR 5/31/2018 02:04:31'!
isOPlayingNext

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

!TicTacToeIsOTurn class methodsFor: 'as yet unclassified' stamp: 'LR 5/31/2018 01:59:03'!
canHandle: aTicTacToe

	^ (aTicTacToe isOver not) and: [aTicTacToe isOTurn]! !


!classDefinition: #TicTacToeIsXTurn category: #TicTacToe!
TicTacToeState subclass: #TicTacToeIsXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeIsXTurn methodsFor: 'game info' stamp: 'LR 5/31/2018 02:04:41'!
isOPlayingNext

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

!TicTacToeIsXTurn class methodsFor: 'as yet unclassified' stamp: 'LR 5/31/2018 01:58:26'!
canHandle: aTicTacToe

	^ (aTicTacToe isOver not) and: [aTicTacToe isXTurn]! !
