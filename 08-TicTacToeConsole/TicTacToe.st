!classDefinition: #ObserversTest category: #TicTacToe!
TestCase subclass: #ObserversTest
	instanceVariableNames: 'console game viewmode gameboardView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!ObserversTest methodsFor: 'testing' stamp: 'PFT 5/31/2018 20:08:42'!
test01ConsoleIsEmptyWhenGameIsEmpty
	
	self assert: console lines isEmpty.! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:39:37'!
test02ConsoleCanLogXMark

	game markWithXAt: 2@2.
	
	self assert: console hasLines: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:38:10'!
test03ConsoleCanLogOMark

	
	game markWithXAt: 2@2.
	game markWithOAt: 1@2.
	
	self assert: console hasLines: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 1@2'.
		'Estado: Jugando X'
	}.	
	! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:38:19'!
test04ConsoleCanLogXMarkAgain

	game markAll: {2@2. 1@2. 3@3}.
	
	self assert: console hasLines: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 1@2'.
		'Estado: Jugando X'.
		'X marcó en 3@3'.
		'Estado: Jugando O'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:38:25'!
test05ConsoleCanLogXWin

	game markAll: {2@2. 1@1. 1@3. 1@2. 3@1}.
	
	self assert: console hasLines: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 1@1'.
		'Estado: Jugando X'.
		'X marcó en 1@3'.
		'Estado: Jugando O'.
		'O marcó en 1@2'.
		'Estado: Jugando X'.
		'X marcó en 3@1'.
		'Estado: Juego Terminado - Ganó X!!'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:38:35'!
test06ConsoleCanLogOWin

	game markAll: {2@2. 3@1. 1@2. 3@2. 2@3. 3@3}.
	
	self assert: console hasLines: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 3@1'.
		'Estado: Jugando X'.
		'X marcó en 1@2'.
		'Estado: Jugando O'.
		'O marcó en 3@2'.
		'Estado: Jugando X'.
		'X marcó en 2@3'.
		'Estado: Jugando O'.
		'O marcó en 3@3'.
		'Estado: Juego Terminado - Ganó O!!'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:38:43'!
test07ConsoleCanLogTiedGame
	
	game markAll: {1@2. 1@1. 2@1. 1@3. 2@2. 2@3. 3@1. 3@2. 3@3}.
	
	self assert: console hasLines: {
		'X marcó en 1@2'.
		'Estado: Jugando O'.
		'O marcó en 1@1'.
		'Estado: Jugando X'.
		'X marcó en 2@1'.
		'Estado: Jugando O'.
		'O marcó en 1@3'.
		'Estado: Jugando X'.
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 2@3'.
		'Estado: Jugando X'.
		'X marcó en 3@1'.
		'Estado: Jugando O'.
		'O marcó en 3@2'.
		'Estado: Jugando X'.
		'X marcó en 3@3'.
		'Estado: Juego empatado'.
	}
	
	! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:29:07'!
test08GameboardViewEmptyBoard
		
	self assert: gameboardView hasLines:{
		' | | '.
		'-----'.
		' | | '.
		'-----'.
		' | | '.
		'Jugando X'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:30:09'!
test09GameboardViewCanLogXMark
	game markWithXAt: 2 @ 2.
	
	self assert: gameboardView hasLines: {
		' | | '.
		'-----'.
		' |X| '.
		'-----'.
		' | | '.
		'Jugando O'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:31:28'!
test10GameboardViewCanLogGameNotOver
	game markAll:
		{2 @ 2. 1 @ 1. 1 @ 2. 1 @ 3. 2 @ 1. 3 @ 2. 3 @ 1. 2 @ 3}.
	
	self assert: gameboardView hasLines: {
		'O|X|O'.
		'-----'.
		'X|X|O'.
		'-----'.
		'X|O| '.
		'Jugando X'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:32:20'!
test11GameboardViewCanLogXWin
	game markAll:
		{2 @ 2. 1 @ 1. 1 @ 2. 1 @ 3. 2 @ 1. 3 @ 2. 2 @ 3}.
	
	self assert: gameboardView hasLines: {
		'O|X|O'. 
		'-----'.
		'X|X|X'.
		'-----'.
		' |O| '.
		'Ganó X!!'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:33:01'!
test12GameboardViewCanLogOWin
	game markAll:
		{3 @ 1. 1 @ 1. 2 @ 1. 1 @ 2. 2 @ 2. 3 @ 2. 3 @ 3. 1 @ 3}.
	
	self assert: gameboardView hasLines: {
		'O|O|O'.
		'-----'.
		'X|X| '.
		'-----'.
		'X|O|X'.
		'Ganó O!!'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:33:45'!
test13GameboardViewCanLogTiedGame
	game markAll:
		{3 @ 1. 1 @ 1. 2 @ 1. 1 @ 3. 2 @ 2. 3 @ 2. 3 @ 3. 2 @ 3. 1 @ 2}.
	
	self assert: gameboardView hasLines: {
		'O|X|O'.
		'-----'.
		'X|X|O'.
		'-----'.
		'X|O|X'.
		'Juego empatado'.
	}! !

!ObserversTest methodsFor: 'testing' stamp: 'PFT 6/4/2018 14:37:48'!
test14ConsoleAndGameboardViewWorkAtTheSameTime
	game markAll:
		{3 @ 1. 1 @ 1. 2 @ 1. 1 @ 3. 2 @ 2. 3 @ 2. 3 @ 3. 2 @ 3. 1 @ 2}.
	
	self assert: gameboardView hasLines: {
		'O|X|O'.
		'-----'.
		'X|X|O'.
		'-----'.
		'X|O|X'.
		'Juego empatado'.
	}.
	
	self assert: console hasLines: {
		'X marcó en 3@1'.
		'Estado: Jugando O'.
		'O marcó en 1@1'.
		'Estado: Jugando X'.
		'X marcó en 2@1'.
		'Estado: Jugando O'.
		'O marcó en 1@3'.
		'Estado: Jugando X'.
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 3@2'.
		'Estado: Jugando X'.
		'X marcó en 3@3'.
		'Estado: Jugando O'.
		'O marcó en 2@3'.
		'Estado: Jugando X'.
		'X marcó en 1@2'.
		'Estado: Juego empatado'.
	}! !


!ObserversTest methodsFor: 'support' stamp: 'PFT 6/4/2018 14:28:55'!
assert: anObserver hasLines: aCollectionOfExpectedLines
	1
		to: anObserver lines size
		do: [ :i |
			self
				assert: (aCollectionOfExpectedLines at: i)
				equals: (anObserver lines at: i) ].! !

!ObserversTest methodsFor: 'support' stamp: 'PFT 6/4/2018 14:27:21'!
setUp
	game _ TicTacToe new.
	console _ Console for: game.
	gameboardView _ GameboardView for: game.! !


!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions observers lastMove'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'PFT 5/31/2018 20:42:12'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	observers := OrderedCollection new.! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:30:17'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithOAt: aPosition.! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:24:49'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithXAt: aPosition.! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:41:25'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self
	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'PFT 5/31/2018 21:31:27'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition. lastMove := aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.
		
	self notifyAll! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'PFT 5/31/2018 21:31:16'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition. lastMove := aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.
		
	self notifyAll! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'PFT 5/31/2018 20:48:05'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState. ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:30:13'!
lastMove
	^lastMove! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:28:38'!
notify: aTicTacToeObserver
	state update: aTicTacToeObserver.! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:29:05'!
notifyAll
	observers do: [ :observer | 	self notify: observer ].! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 02:10:27'!
subscribe: anObserver
	observers add: anObserver.! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 04:22:56'!
unSubscribe: anObserver
	observers remove: anObserver.! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:34:49'!
updateWhenGameIsTied: aTicTacToeObserver
	^ aTicTacToeObserver updateWhenGameIsTied! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:35:08'!
updateWhenOHasWon: aTicTacToeObserver
	^ aTicTacToeObserver updateWhenOHasWon! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:35:23'!
updateWhenPlayingO: aTicTacToeObserver
	^ aTicTacToeObserver updateWhenPlayingO! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:35:36'!
updateWhenPlayingX: aTicTacToeObserver
	^ aTicTacToeObserver updateWhenPlayingX! !

!TicTacToe methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:35:50'!
updateWhenXHasWon: aTicTacToeObserver
	^ aTicTacToeObserver updateWhenXHasWon! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeObservers category: #TicTacToe!
Object subclass: #TicTacToeObservers
	instanceVariableNames: 'game lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:53'!
addOMove
	self subclassResponsibility ! !

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:50'!
addXMove
	self subclassResponsibility ! !

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:46'!
lines
	self subclassResponsibility ! !

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:23'!
updateWhenGameIsTied
	self subclassResponsibility ! !

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:29'!
updateWhenOHasWon
	self subclassResponsibility ! !

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:35'!
updateWhenPlayingO
	self subclassResponsibility ! !

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:38'!
updateWhenPlayingX
	self subclassResponsibility ! !

!TicTacToeObservers methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:51:42'!
updateWhenXHasWon
	self subclassResponsibility ! !


!TicTacToeObservers methodsFor: 'initialization' stamp: 'PFT 6/4/2018 13:47:53'!
initializeWith: aTicTacToe
	game _ aTicTacToe.
	game subscribe: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeObservers class' category: #TicTacToe!
TicTacToeObservers class
	instanceVariableNames: ''!

!TicTacToeObservers class methodsFor: 'instance creation' stamp: 'PFT 6/4/2018 13:48:32'!
for: aTicTacToe

	^self new initializeWith: aTicTacToe! !


!classDefinition: #Console category: #TicTacToe!
TicTacToeObservers subclass: #Console
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!Console methodsFor: 'observing' stamp: 'PFT 6/4/2018 01:52:52'!
addOMove
	lines add: 'O marcó en ' , game lastMove x asString , '@' , game lastMove y asString.! !

!Console methodsFor: 'observing' stamp: 'PFT 6/4/2018 01:52:40'!
addXMove
	lines add: 'X marcó en ' , game lastMove x asString , '@' , game lastMove y asString.! !

!Console methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:32:57'!
updateWhenGameIsTied
	self addXMove.
	lines add: 'Estado: Juego empatado'.! !

!Console methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:33:06'!
updateWhenOHasWon
	self addOMove.
	lines add: 'Estado: Juego Terminado - Ganó O!!'.! !

!Console methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:33:12'!
updateWhenPlayingO
	self addXMove.
	lines add: 'Estado: Jugando O'.! !

!Console methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:33:17'!
updateWhenPlayingX
	self addOMove.
	lines add: 'Estado: Jugando X'.! !

!Console methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:34:18'!
updateWhenXHasWon
	self addXMove.
	lines add: 'Estado: Juego Terminado - Ganó X!!'.! !


!Console methodsFor: 'initialization' stamp: 'PFT 6/4/2018 13:53:14'!
initializeWith: aTicTacToe

	super initializeWith: aTicTacToe.
	lines _ OrderedCollection new.! !


!Console methodsFor: 'accesing' stamp: 'PFT 6/4/2018 13:52:59'!
lines
	^lines! !


!classDefinition: #GameboardView category: #TicTacToe!
TicTacToeObservers subclass: #GameboardView
	instanceVariableNames: 'board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 01:52:52'!
addOMove
	board
		i: game lastMove x
		j: game lastMove y
		put: 'O'.! !

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 01:52:40'!
addXMove
	board
		i: game lastMove x
		j: game lastMove y
		put: 'X'.! !

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 04:14:03'!
updateLines
	| newLines |
	newLines _ OrderedCollection new.
	1
		to: board height
		do: [ :i |
			newLines add: (board i: i j: 1) , '|' , (board i: i j: 2) , '|' , (board i: i j: 3). 
				i < 3 ifTrue: [ newLines add: '-----' ]
	].
	lines _ newLines
! !

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:33:30'!
updateWhenGameIsTied
	self addXMove.
	self updateLines.
	lines add: 'Juego empatado'.! !

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:33:37'!
updateWhenOHasWon
	self addOMove.
	self updateLines.
	lines add: 'Ganó O!!'.! !

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:33:42'!
updateWhenPlayingO
	self addXMove.
	self updateLines.
	lines add: 'Jugando O'.! !

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:33:47'!
updateWhenPlayingX
	self addOMove.
	self updateLines.
	lines add: 'Jugando X'.! !

!GameboardView methodsFor: 'observing' stamp: 'PFT 6/4/2018 13:34:04'!
updateWhenXHasWon
	self addXMove.
	self updateLines.
	lines add: 'Ganó X!!'.! !


!GameboardView methodsFor: 'initialization' stamp: 'PFT 6/4/2018 01:42:59'!
initializeBoard

	board := Array2D width: 3 height: 3.
	1 to: 3 do: [:i |
		1 to: 3 do: [:j |
			board i: i j: j put: ' '
		]
	
	]! !

!GameboardView methodsFor: 'initialization' stamp: 'PFT 6/4/2018 01:31:39'!
initializeLines

	lines := OrderedCollection new.
	
	1 to: board height do: [:i |
		lines add: ' | | '.
		(i < 3) ifTrue: [ lines add: '-----'.] ifFalse: [lines add: 'Jugando X']
	].! !

!GameboardView methodsFor: 'initialization' stamp: 'PFT 6/4/2018 13:50:23'!
initializeWith: aTicTacToe

	super initializeWith: aTicTacToe.
	self initializeBoard.
	self initializeLines.! !


!GameboardView methodsFor: 'accesing' stamp: 'PFT 6/4/2018 01:39:21'!
lines
	^lines! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!GameTied methodsFor: 'observing' stamp: 'PFT 6/4/2018 04:29:05'!
update: aTicTacToeObserver
	^ game updateWhenGameIsTied: aTicTacToeObserver! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!PlayerOWon methodsFor: 'observing' stamp: 'PFT 6/4/2018 04:28:49'!
update: aTicTacToeObserver
	^ game updateWhenOHasWon: aTicTacToeObserver! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!PlayerXWon methodsFor: 'observing' stamp: 'PFT 6/4/2018 04:28:36'!
update: aTicTacToeObserver
	^ game updateWhenXHasWon: aTicTacToeObserver! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!PlayingO methodsFor: 'observing' stamp: 'PFT 6/4/2018 04:28:19'!
update: aTicTacToeObserver
	^ game updateWhenPlayingO: aTicTacToeObserver.! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !


!PlayingX methodsFor: 'observing' stamp: 'PFT 6/4/2018 04:27:59'!
update: aTicTacToeObserver
	^ game updateWhenPlayingX: aTicTacToeObserver.! !
