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


!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/3/2018 19:40:32'!
PlayerFormedACoulmnWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions x = (triadOfStones at: 1) x ]) = 3
! !

!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/3/2018 19:45:55'!
PlayerFormedADownDiagonalWithTheRocks: triadOfStones
	
^(triadOfStones count: [:positions| (positions = (1@3)) or:[positions = (2@2) or:[ positions = (3@1)]] ]) = 3
	
! !

!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/5/2018 20:09:43'!
PlayerFormedARowWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions y = (triadOfStones at: 1) y ]) = 3
! !

!TerniLapilli methodsFor: 'formsToWin' stamp: 'AAAM 11/3/2018 19:43:18'!
PlayerFormedAnUpDiagonalWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions x = positions y ]) = 3
! !


!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/7/2018 04:48:24'!
PlayerOHasNotWon

	 ((self PlayerFormedARowWithTheRocks: Ostones )
	 or:(self PlayerFormedACoulmnWithTheRocks: Ostones )
	 or:(self PlayerFormedAnUpDiagonalWithTheRocks: Ostones )
	 or:(self PlayerFormedADownDiagonalWithTheRocks: Ostones ))	
	 ifTrue:[  ^self playerWon].	
	^turn:= $X! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/7/2018 04:47:58'!
PlayerXHasNotWon

	 ((self PlayerFormedARowWithTheRocks: Xstones )
	 or:(self PlayerFormedACoulmnWithTheRocks: Xstones )
	 or:(self PlayerFormedAnUpDiagonalWithTheRocks: Xstones )
	 or:(self PlayerFormedADownDiagonalWithTheRocks: Xstones ))	
	 ifTrue:[  ^self playerWon].	
	^turn:= $O! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/3/2018 04:49:17'!
hasAWinner
	^ hasEnded.! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/7/2018 03:44:43'!
playerWon

	hasEnded := true. 
	^turn
! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/7/2018 03:46:37'!
winner

^self state winner
! !


!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/2/2018 21:34:02'!
OStonesinPlay
	
	^ Ostones  size! !

!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/2/2018 23:35:23'!
ThereisAn0StoneIn: aPoint 
	 ^Ostones  includes: aPoint ! !

!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/2/2018 22:39:19'!
ThereisAnXStoneIn: aPoint 
	
	^Xstones includes: aPoint. ! !

!TerniLapilli methodsFor: 'stonesStatus' stamp: 'AAAM 11/2/2018 21:26:48'!
XStonesinPlay
	
	^Xstones size! !


!TerniLapilli methodsFor: 'PrerequisitesToPlayorMoveAStone' stamp: 'AAAM 11/5/2018 03:00:39'!
ThereIsNotAnotherRockInThatPosition: aPoint 

|stones|

stones:= OrderedCollection  new.
stones addAll:  Ostones.
stones addAll: Xstones.
	(stones  includes: aPoint)
		  ifTrue:	[^self error: self class PlayerCannotPlayAStoneWhereThereIsOneErrorMessage ]
		  ifFalse:   [^true].
! !

!TerniLapilli methodsFor: 'PrerequisitesToPlayorMoveAStone' stamp: 'AAAM 11/7/2018 03:59:30'!
isWithinBorders: aPoint.

	
	((aPoint x between:  1 and: 3) and: (aPoint y between: 1 and:3) )ifFalse:[^self error: self class PlayerCannotPlayOutOfBordersErrorMessage ].   
	^true
! !


!TerniLapilli methodsFor: 'testing' stamp: 'AAAM 11/5/2018 21:00:52'!
state

	^TerniLapilliStates for: self.! !

!TerniLapilli methodsFor: 'testing' stamp: 'AAAM 11/5/2018 20:49:58'!
turn

	^turn.! !


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:47:02'!
AskingForWinnerOnAnUnfinishedGame

^self error: self class CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:46:06'!
movingStoneBeforePuttingThemAll

^self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:45:20'!
movingStoneOInXTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:36:47'!
movingStoneXInOTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:52:25'!
playStonesAfterGameHasEnded

self error: self class CannotPlayIfGameHasEndedErrorMessage ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:08:42'!
putStoneOWhenIsXTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:08:22'!
putStoneXWhenIsOTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:06:52'!
putStonesAfterPuttingThemAll

^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage! !


!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 03:59:12'!
isAValidPositionToPlayARock: aPoint

			
	^(self isWithinBorders: aPoint) and: (self ThereIsNotAnotherRockInThatPosition: aPoint).
		! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 03:18:27'!
moveStoneO: aPoint to: aPoint2 

	^self state moveStoneO: aPoint to: aPoint2.


! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 04:01:32'!
moveStoneOInOTurn: aPoint to: aPoint2.

	self isAValidPositionToPlayARock: aPoint2.
	
	(Ostones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Ostones add: aPoint2.
	Ostones remove: aPoint.
	
	^ self PlayerOHasNotWon.! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 03:18:13'!
moveStoneX: aPoint to: aPoint2 

	^self state moveStoneX: aPoint to: aPoint2.
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 04:01:01'!
moveStoneXInXTurn: aPoint to: aPoint2.

	self isAValidPositionToPlayARock: aPoint2.
	
	(Xstones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Xstones add: aPoint2.
	Xstones remove: aPoint.
	
	^ self PlayerXHasNotWon.
	"self checksBeforePlayerXPlays: aPoint2.
	Xstones size < 3 ifTrue:[^ self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage ] .
	(Xstones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Xstones add: aPoint2.
	Xstones remove: aPoint.
	
	^ self PlayerXHasNotWon."
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 03:57:17'!
putStoneO: aPoint 



	
	^self state putStoneO: aPoint.
	

! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 04:00:35'!
putStoneOWhenIsOTurn: aPoint

			
	self isAValidPositionToPlayARock: aPoint.
		
	Ostones  add: aPoint.
	
	^self PlayerOHasNotWon.
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 15:06:39'!
putStoneX: aPoint 
	


	^self state putStoneX: aPoint.
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/7/2018 04:09:05'!
putStoneXWhenIsXTurn: aPoint

		
	self isAValidPositionToPlayARock: aPoint.
	
	Xstones  add: aPoint.
	
	^self PlayerXHasNotWon.
	"self  checksBeforePlayerXPlays: aPoint.
	Xstones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].

	Xstones add: aPoint.
	
	^ self PlayerXHasNotWon."
! !

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

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:37:29'!
initializeFor: aTerni

	terni := aTerni.! !

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:24:38'!
moveStoneO: aPoint to: aPoint2 

self subclassResponsibility.! !

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:24:41'!
moveStoneX: aPoint to: aPoint2 

self subclassResponsibility.! !

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
putStoneO: aPoint

	self subclassResponsibility .! !

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:21'!
putStoneX: aPoint

	self subclassResponsibility .! !

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:36:31'!
winner

self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliStates class' category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates class
	instanceVariableNames: ''!

!TerniLapilliStates class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:35:45'!
for: aTerni
	
	^ self subclasses 
		detect: [:aStateClass | aStateClass isFor: aTerni ]
		ifFound: [:aStateClass | aStateClass newFor: aTerni ]
		ifNone: [ self error: 'No state for terni' ]! !

!TerniLapilliStates class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:36:21'!
isFor: aTerni

	^self subclassResponsibility .! !

!TerniLapilliStates class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:37:03'!
newFor: aTerni
	
	^self new initializeFor: aTerni ! !


!classDefinition: #TerniAgregandoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniAgregandoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:44:31'!
moveStoneO: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:44:37'!
moveStoneX: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:07:34'!
putStoneO: aPoint

 ^terni putStoneOWhenIsOTurn: aPoint! !

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:08:22'!
putStoneX: aPoint

 ^terni putStoneXWhenIsOTurn! !

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:00'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniAgregandoO class' category: #'TerniLapilli-Ejercicio'!
TerniAgregandoO class
	instanceVariableNames: ''!

!TerniAgregandoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:05:12'!
isFor: aTerni

	^((aTerni turn = $O) and: [ aTerni hasAWinner not ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) < 6].! !


!classDefinition: #TerniAgregandoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniAgregandoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:44:25'!
moveStoneO: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:44:20'!
moveStoneX: aPoint to: aPoint2 

^terni movingStoneBeforePuttingThemAll! !

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:08:42'!
putStoneO: aPoint

 ^terni putStoneOWhenIsXTurn! !

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:08:06'!
putStoneX: aPoint

^terni putStoneXWhenIsXTurn: aPoint! !

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:11'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniAgregandoX class' category: #'TerniLapilli-Ejercicio'!
TerniAgregandoX class
	instanceVariableNames: ''!

!TerniAgregandoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:05:22'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni hasAWinner not ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) < 6].! !


!classDefinition: #TerniJugandoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniJugandoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:41:42'!
moveStoneO: aPoint to: aPoint2 

 ^terni moveStoneOInOTurn: aPoint to: aPoint2.! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:43:58'!
moveStoneX: aPoint to: aPoint2 

 ^terni movingStoneXInOTurn! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:40:33'!
putStoneO: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:33:01'!
putStoneX: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:16'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniJugandoO class' category: #'TerniLapilli-Ejercicio'!
TerniJugandoO class
	instanceVariableNames: ''!

!TerniJugandoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:05:50'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni hasAWinner not ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) = 6].! !


!classDefinition: #TerniJugandoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniJugandoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:44:22'!
moveStoneO: aPoint to: aPoint2 

 ^terni movingStoneOInXTurn! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:41:27'!
moveStoneX: aPoint to: aPoint2 

 ^terni moveStoneXInXTurn: aPoint to: aPoint2.! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:40:26'!
putStoneO: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:33:09'!
putStoneX: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:22'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniJugandoX class' category: #'TerniLapilli-Ejercicio'!
TerniJugandoX class
	instanceVariableNames: ''!

!TerniJugandoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:05:45'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni hasAWinner not ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) = 6].! !


!classDefinition: #TerniTerminadoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniTerminadoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:46:03'!
moveStoneO: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:46:09'!
moveStoneX: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
putStoneO: aPoint

 ^terni playStonesAfterGameHasEnded
! !

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:21'!
putStoneX: aPoint

 ^terni playStonesAfterGameHasEnded! !

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:47:38'!
winner

^terni playerWon! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniTerminadoO class' category: #'TerniLapilli-Ejercicio'!
TerniTerminadoO class
	instanceVariableNames: ''!

!TerniTerminadoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:52:29'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni  hasAWinner ]) ! !


!classDefinition: #TerniTerminadoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniTerminadoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:45:56'!
moveStoneO: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:45:51'!
moveStoneX: aPoint to: aPoint2 

^terni playStonesAfterGameHasEnded! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:32:41'!
putStoneO: aPoint

 ^terni playStonesAfterGameHasEnded! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:32:47'!
putStoneX: aPoint

 ^terni playStonesAfterGameHasEnded! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:47:32'!
winner

^terni playerWon ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniTerminadoX class' category: #'TerniLapilli-Ejercicio'!
TerniTerminadoX class
	instanceVariableNames: ''!

!TerniTerminadoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:52:42'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni  hasAWinner ]) ! !
