!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'Ostones Xstones turn hasEnded'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'initializing' stamp: 'AAAM 11/3/2018 04:48:34'!
newGame

Xstones := OrderedCollection new.
Ostones := OrderedCollection  new.

turn:= $X.
hasEnded:= false.! !


!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/8/2018 14:15:31'!
playerFormedACoulmnWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions x = (triadOfStones at: 1) x ]) = 3
! !

!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/8/2018 14:17:01'!
playerFormedADownDiagonalWithTheRocks: triadOfStones
	
^(triadOfStones count: [:positions| (positions = (1@3)) or:[positions = (2@2) or:[ positions = (3@1)]] ]) = 3
	
! !

!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/8/2018 14:16:42'!
playerFormedARowWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions y = (triadOfStones at: 1) y ]) = 3
! !

!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/8/2018 14:16:00'!
playerFormedAnUpDiagonalWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions x = positions y ]) = 3
! !


!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 14:49:18'!
aPlayerHasWon

	hasEnded := true. 
	^turn
! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 14:52:45'!
hasAPlayerWon: aStoneCollection

	^((self playerFormedARowWithTheRocks: aStoneCollection )
	 or:(self playerFormedACoulmnWithTheRocks: aStoneCollection )
	 or:(self playerFormedAnUpDiagonalWithTheRocks: aStoneCollection )
	 or:(self playerFormedADownDiagonalWithTheRocks: aStoneCollection ))	
! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 14:52:45'!
playerOHasNotWon

	(self hasAPlayerWon: Ostones) ifTrue:[  ^self aPlayerHasWon].	
	^turn:= $X! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 14:48:55'!
playerOWon

^self state playerOWon
! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 15:07:53'!
playerOWonWhenEndsWithPlayerO

^true! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 15:07:40'!
playerOWonWhenEndsWithPlayerX

^false! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 14:52:45'!
playerXHasNotWon

	(self hasAPlayerWon: Xstones) ifTrue:[  ^self aPlayerHasWon].	
	^turn:= $O! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 14:48:46'!
playerXWon

^self state playerXWon
! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 15:08:01'!
playerXWonWhenEndsWithPlayerO

^false! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/8/2018 15:08:14'!
playerXWonWhenEndsWithPlayerX

^true! !


!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/8/2018 14:23:39'!
stonesOInPlay
	
	^ Ostones  size! !

!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/8/2018 14:23:59'!
stonesXInPlay
	
	^Xstones size! !

!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/8/2018 14:24:38'!
thereIsAnOStoneIn: aPoint 
	 ^Ostones  includes: aPoint ! !

!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/8/2018 14:24:15'!
thereIsAnXStoneIn: aPoint 
	
	^Xstones includes: aPoint. ! !


!TerniLapilli methodsFor: 'PrerequisitesToPlayorMoveAStone' stamp: 'AAAM 11/7/2018 03:59:30'!
isWithinBorders: aPoint.

	
	((aPoint x between:  1 and: 3) and: (aPoint y between: 1 and:3) )ifFalse:[^self error: self class PlayerCannotPlayOutOfBordersErrorMessage ].   
	^true
! !

!TerniLapilli methodsFor: 'PrerequisitesToPlayorMoveAStone' stamp: 'AAAM 11/8/2018 14:14:58'!
thereIsNotAnotherRockInThatPosition: aPoint 

|stones|

stones:= OrderedCollection  new.
stones addAll:  Ostones.
stones addAll: Xstones.
	(stones  includes: aPoint)
		  ifTrue:	[^self error: self class PlayerCannotPlayAStoneWhereThereIsOneErrorMessage ]
		  ifFalse:   [^true].
! !


!TerniLapilli methodsFor: 'gameStates' stamp: 'AAAM 11/3/2018 04:49:17'!
hasAWinner
	^ hasEnded.! !

!TerniLapilli methodsFor: 'gameStates' stamp: 'AAAM 11/5/2018 21:00:52'!
state

	^TerniLapilliStates for: self.! !

!TerniLapilli methodsFor: 'gameStates' stamp: 'AAAM 11/5/2018 20:49:58'!
turn

	^turn.! !


!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/8/2018 14:25:26'!
askingForWinnerOnAnUnfinishedGame

^self error: self class CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage! !

!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/6/2018 16:46:06'!
movingStoneBeforePuttingThemAll

^self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage! !

!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/6/2018 16:45:20'!
movingStoneOInXTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/7/2018 02:36:47'!
movingStoneXInOTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/6/2018 16:52:25'!
playStonesAfterGameHasEnded

self error: self class CannotPlayIfGameHasEndedErrorMessage ! !

!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/7/2018 03:08:42'!
putStoneOWhenIsXTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/7/2018 03:08:22'!
putStoneXWhenIsOTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'error handling' stamp: 'AAAM 11/7/2018 03:06:52'!
putStonesAfterPuttingThemAll

^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage! !


!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/8/2018 14:14:58'!
isAValidPositionToPlayARock: aPoint

			
	^(self isWithinBorders: aPoint) and: (self thereIsNotAnotherRockInThatPosition: aPoint).
		! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 03:18:27'!
moveStoneO: aPoint to: aPoint2 

	^self state moveStoneO: aPoint to: aPoint2.


! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/8/2018 14:22:46'!
moveStoneOInOTurn: aPoint to: aPoint2.

	self isAValidPositionToPlayARock: aPoint2.
	
	(Ostones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Ostones add: aPoint2.
	Ostones remove: aPoint.
	
	^ self playerOHasNotWon.! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 03:18:13'!
moveStoneX: aPoint to: aPoint2 

	^self state moveStoneX: aPoint to: aPoint2.
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/8/2018 14:22:30'!
moveStoneXInXTurn: aPoint to: aPoint2.

	self isAValidPositionToPlayARock: aPoint2.
	
	(Xstones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Xstones add: aPoint2.
	Xstones remove: aPoint.
	
	^ self playerXHasNotWon.
	! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 03:57:17'!
putStoneO: aPoint 



	
	^self state putStoneO: aPoint.
	

! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/8/2018 14:22:46'!
putStoneOWhenIsOTurn: aPoint

			
	self isAValidPositionToPlayARock: aPoint.
		
	Ostones  add: aPoint.
	
	^self playerOHasNotWon
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 15:06:39'!
putStoneX: aPoint 
	


	^self state putStoneX: aPoint.
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/8/2018 14:22:30'!
putStoneXWhenIsXTurn: aPoint

		
	self isAValidPositionToPlayARock: aPoint.
	
	Xstones  add: aPoint.
	
	^self playerXHasNotWon.
	
! !


!TerniLapilli methodsFor: 'checkingIfItIsThePlayerTurn' stamp: 'AAAM 11/8/2018 15:34:41'!
isOTurn

^turn = $O! !

!TerniLapilli methodsFor: 'checkingIfItIsThePlayerTurn' stamp: 'AAAM 11/8/2018 15:34:34'!
isXTurn

^turn = $X! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 20:14:56'!
CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage
	^ 'There is not winner because the game has not ended yet'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/4/2018 00:17:46'!
CannotMoveStoneUntilAllArePlayedErrorMessage
	^'Cannot move stones until all are played in the board'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 20:21:31'!
CannotPlayIfGameHasEndedErrorMessage
	^'This game has ended, so you cannot play'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/4/2018 00:52:31'!
PlayerCannotMoveFromInvalidPosition
	^'There is not a player stone in that position '! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/4/2018 01:39:42'!
PlayerCannotMoveToInvalidPosition
	^'It is no a valid position to move this rock'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/5/2018 03:00:39'!
PlayerCannotPlayAStoneWhereThereIsOneErrorMessage
^'There is another rock in that position'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 23:22:37'!
PlayerCannotPlayOutOfBordersErrorMessage
	^'Position out of borders'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 01:44:57'!
PlayerCannotPlayOutOfTurnErrorMessage
	 ^'Player cannot play because is not her/his turn'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 04:23:58'!
PlayerCannotPutMoreThanThreeStonesErrorMessage
 ^'Player has not more rocks'! !


!TerniLapilli class methodsFor: 'initialization' stamp: 'AAAM 11/2/2018 21:33:30'!
new

^ self basicNew newGame.! !


!classDefinition: #TerniLapilliStates category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilliStates
	instanceVariableNames: 'terni'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliStates methodsFor: 'initializing' stamp: 'AAAM 11/5/2018 20:37:29'!
initializeFor: aTerni

	terni := aTerni.! !


!TerniLapilliStates methodsFor: 'movingStones' stamp: 'AAAM 11/6/2018 16:24:38'!
moveStoneO: aPoint to: aPoint2 

self subclassResponsibility.! !

!TerniLapilliStates methodsFor: 'movingStones' stamp: 'AAAM 11/6/2018 16:24:41'!
moveStoneX: aPoint to: aPoint2 

self subclassResponsibility.! !


!TerniLapilliStates methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 02:31:38'!
putStoneO: aPoint

	self subclassResponsibility .! !

!TerniLapilliStates methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 02:31:21'!
putStoneX: aPoint

	self subclassResponsibility .! !


!TerniLapilliStates methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:54:32'!
playerOWon

self subclassResponsibility ! !

!TerniLapilliStates methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:54:27'!
playerXWon

self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliStates class' category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates class
	instanceVariableNames: ''!

!TerniLapilliStates class methodsFor: 'instance creation' stamp: 'AAAM 11/5/2018 20:35:45'!
for: aTerni
	
	^ self subclasses 
		detect: [:aStateClass | aStateClass isFor: aTerni ]
		ifFound: [:aStateClass | aStateClass newFor: aTerni ]
		ifNone: [ self error: 'No state for terni' ]! !

!TerniLapilliStates class methodsFor: 'instance creation' stamp: 'AAAM 11/5/2018 20:36:21'!
isFor: aTerni

	^self subclassResponsibility .! !

!TerniLapilliStates class methodsFor: 'instance creation' stamp: 'AAAM 11/5/2018 20:37:03'!
newFor: aTerni
	
	^self new initializeFor: aTerni ! !


!classDefinition: #TerniAgregandoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniAgregandoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniAgregandoO methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:44:31'!
moveStoneO: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !

!TerniAgregandoO methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:44:37'!
moveStoneX: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !


!TerniAgregandoO methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:07:34'!
putStoneO: aPoint

 ^terni putStoneOWhenIsOTurn: aPoint! !

!TerniAgregandoO methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:08:22'!
putStoneX: aPoint

 ^terni putStoneXWhenIsOTurn! !


!TerniAgregandoO methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:55:00'!
playerOWon

^terni askingForWinnerOnAnUnfinishedGame
! !

!TerniAgregandoO methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:54:56'!
playerXWon

^terni askingForWinnerOnAnUnfinishedGame
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniAgregandoO class' category: #'TerniLapilli-Ejercicio'!
TerniAgregandoO class
	instanceVariableNames: ''!

!TerniAgregandoO class methodsFor: 'instance creation' stamp: 'AAAM 11/8/2018 14:23:59'!
isFor: aTerni

	^((aTerni turn = $O) and: [ aTerni hasAWinner not ]) and: [(aTerni stonesOInPlay + aTerni stonesXInPlay) < 6].! !


!classDefinition: #TerniAgregandoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniAgregandoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniAgregandoX methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:44:25'!
moveStoneO: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !

!TerniAgregandoX methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:44:20'!
moveStoneX: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !


!TerniAgregandoX methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:08:42'!
putStoneO: aPoint

 ^terni putStoneOWhenIsXTurn! !

!TerniAgregandoX methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:08:06'!
putStoneX: aPoint

^terni putStoneXWhenIsXTurn: aPoint! !


!TerniAgregandoX methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:55:24'!
playerOWon

^terni askingForWinnerOnAnUnfinishedGame! !

!TerniAgregandoX methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:55:20'!
playerXWon

^terni askingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniAgregandoX class' category: #'TerniLapilli-Ejercicio'!
TerniAgregandoX class
	instanceVariableNames: ''!

!TerniAgregandoX class methodsFor: 'instance creation' stamp: 'AAAM 11/8/2018 14:23:59'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni hasAWinner not ]) and: [(aTerni stonesOInPlay + aTerni stonesXInPlay) < 6].! !


!classDefinition: #TerniJugandoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniJugandoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniJugandoO methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:41:42'!
moveStoneO: aPoint to: aPoint2 

 ^terni moveStoneOInOTurn: aPoint to: aPoint2.! !

!TerniJugandoO methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:43:58'!
moveStoneX: aPoint to: aPoint2 

 ^terni movingStoneXInOTurn! !


!TerniJugandoO methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 15:40:33'!
putStoneO: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniJugandoO methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 15:33:01'!
putStoneX: aPoint

 ^terni putStonesAfterPuttingThemAll! !


!TerniJugandoO methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:55:46'!
playerOWon
^terni askingForWinnerOnAnUnfinishedGame! !

!TerniJugandoO methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:55:42'!
playerXWon
^terni askingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniJugandoO class' category: #'TerniLapilli-Ejercicio'!
TerniJugandoO class
	instanceVariableNames: ''!

!TerniJugandoO class methodsFor: 'instance creation' stamp: 'AAAM 11/8/2018 14:23:59'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni hasAWinner not ]) and: [(aTerni stonesOInPlay + aTerni stonesXInPlay) = 6].! !


!classDefinition: #TerniJugandoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniJugandoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniJugandoX methodsFor: 'movingStones' stamp: 'AAAM 11/6/2018 16:44:22'!
moveStoneO: aPoint to: aPoint2 

 ^terni movingStoneOInXTurn! !

!TerniJugandoX methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:41:27'!
moveStoneX: aPoint to: aPoint2 

 ^terni moveStoneXInXTurn: aPoint to: aPoint2.! !


!TerniJugandoX methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 15:40:26'!
putStoneO: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniJugandoX methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 15:33:09'!
putStoneX: aPoint

 ^terni putStonesAfterPuttingThemAll! !


!TerniJugandoX methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:57:03'!
playerOWon
^terni askingForWinnerOnAnUnfinishedGame! !

!TerniJugandoX methodsFor: 'winner' stamp: 'AAAM 11/8/2018 14:56:59'!
playerXWon
^terni askingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniJugandoX class' category: #'TerniLapilli-Ejercicio'!
TerniJugandoX class
	instanceVariableNames: ''!

!TerniJugandoX class methodsFor: 'instance creation' stamp: 'AAAM 11/8/2018 14:23:59'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni hasAWinner not ]) and: [(aTerni stonesOInPlay + aTerni stonesXInPlay) = 6].! !


!classDefinition: #TerniTerminadoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniTerminadoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniTerminadoO methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:46:03'!
moveStoneO: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !

!TerniTerminadoO methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:46:09'!
moveStoneX: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !


!TerniTerminadoO methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 02:31:38'!
putStoneO: aPoint

 ^terni playStonesAfterGameHasEnded
! !

!TerniTerminadoO methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 02:31:21'!
putStoneX: aPoint

 ^terni playStonesAfterGameHasEnded! !


!TerniTerminadoO methodsFor: 'winner' stamp: 'AAAM 11/8/2018 15:05:04'!
playerOWon

^terni playerOWonWhenEndsWithPlayerO! !

!TerniTerminadoO methodsFor: 'winner' stamp: 'AAAM 11/8/2018 15:04:38'!
playerXWon

^terni playerXWonWhenEndsWithPlayerO! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniTerminadoO class' category: #'TerniLapilli-Ejercicio'!
TerniTerminadoO class
	instanceVariableNames: ''!

!TerniTerminadoO class methodsFor: 'instance creation' stamp: 'AAAM 11/7/2018 03:52:29'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni  hasAWinner ]) ! !


!classDefinition: #TerniTerminadoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniTerminadoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniTerminadoX methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:45:56'!
moveStoneO: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !

!TerniTerminadoX methodsFor: 'movingStones' stamp: 'AAAM 11/7/2018 15:45:51'!
moveStoneX: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !


!TerniTerminadoX methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 02:32:41'!
putStoneO: aPoint

 ^terni playStonesAfterGameHasEnded! !

!TerniTerminadoX methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 02:32:47'!
putStoneX: aPoint

 ^terni playStonesAfterGameHasEnded! !


!TerniTerminadoX methodsFor: 'winner' stamp: 'AAAM 11/8/2018 15:05:43'!
playerOWon

^terni playerOWonWhenEndsWithPlayerX! !

!TerniTerminadoX methodsFor: 'winner' stamp: 'AAAM 11/8/2018 15:05:30'!
playerXWon

^terni playerXWonWhenEndsWithPlayerX! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniTerminadoX class' category: #'TerniLapilli-Ejercicio'!
TerniTerminadoX class
	instanceVariableNames: ''!

!TerniTerminadoX class methodsFor: 'instance creation' stamp: 'AAAM 11/7/2018 03:52:42'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni  hasAWinner ]) ! !
