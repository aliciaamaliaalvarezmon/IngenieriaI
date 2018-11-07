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


!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:59:12'!
isAValidPositionToPlayARock: aPoint

			
	^(self isWithinBorders: aPoint) and: (self ThereIsNotAnotherRockInThatPosition: aPoint).
		! !

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:18:27'!
moveStoneO: aPoint to: aPoint2 

	^self state moveStoneO: aPoint to: aPoint2.


! !

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 04:01:32'!
moveStoneOInOTurn: aPoint to: aPoint2.

	self isAValidPositionToPlayARock: aPoint2.
	
	(Ostones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Ostones add: aPoint2.
	Ostones remove: aPoint.
	
	^ self PlayerOHasNotWon.! !

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:18:13'!
moveStoneX: aPoint to: aPoint2 

	^self state moveStoneX: aPoint to: aPoint2.
! !

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 04:01:01'!
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

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:57:17'!
putStoneO: aPoint 



	
	^self state putStoneO: aPoint.
	

! !

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 04:00:35'!
putStoneOWhenIsOTurn: aPoint

			
	self isAValidPositionToPlayARock: aPoint.
		
	Ostones  add: aPoint.
	
	^self PlayerOHasNotWon.
! !

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 03:57:30'!
putStoneX: aPoint 
	


	^self state putStoneO: aPoint.
! !

!TerniLapilli methodsFor: 'puttingStones' stamp: 'AAAM 11/7/2018 04:09:05'!
putStoneXWhenIsXTurn: aPoint

		
	self isAValidPositionToPlayARock: aPoint.
	
	Xstones  add: aPoint.
	
	^self PlayerXHasNotWon.
	"self  checksBeforePlayerXPlays: aPoint.
	Xstones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].

	Xstones add: aPoint.
	
	^ self PlayerXHasNotWon."
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

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:25:39'!
moveStoneO: aPoint to: aPoint2 

^self movingStoneBeforePuttingThemAll! !

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:25:34'!
moveStoneX: aPoint to: aPoint2 

^self movingStoneBeforePuttingThemAll! !

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

!TerniAgregandoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:52:15'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni not hasAWinner ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) < 6].! !


!classDefinition: #TerniAgregandoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniAgregandoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:47:23'!
moveStoneO: aPoint to: aPoint2 

^self movingStoneBeforePuttingThemAll! !

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:47:20'!
moveStoneX: aPoint to: aPoint2 

^self movingStoneBeforePuttingThemAll! !

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

!TerniAgregandoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:52:09'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni not hasAWinner ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) < 6].! !


!classDefinition: #TerniMoviendoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniMoviendoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniMoviendoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:37:27'!
moveStoneO: aPoint to: aPoint2 

 ^terni moveStoneOInOTurn: aPoint to: aPoint2.! !

!TerniMoviendoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:36:47'!
moveStoneX: aPoint to: aPoint2 

 ^terni movingStoneXInOTurn! !

!TerniMoviendoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:06:52'!
putStoneO: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniMoviendoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:06:52'!
putStoneX: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniMoviendoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:16'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniMoviendoO class' category: #'TerniLapilli-Ejercicio'!
TerniMoviendoO class
	instanceVariableNames: ''!

!TerniMoviendoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:51:49'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni not hasAWinner ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) = 6].! !


!classDefinition: #TerniMoviendoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniMoviendoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniMoviendoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:44:22'!
moveStoneO: aPoint to: aPoint2 

 ^terni movingStoneOInXTurn! !

!TerniMoviendoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:38:03'!
moveStoneX: aPoint to: aPoint2 

 ^terni moveStoneXInXTurn: aPoint to: aPoint2.! !

!TerniMoviendoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:06:53'!
putStoneO: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniMoviendoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:06:52'!
putStoneX: aPoint

 ^terni putStonesAfterPuttingThemAll! !

!TerniMoviendoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:22'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniMoviendoX class' category: #'TerniLapilli-Ejercicio'!
TerniMoviendoX class
	instanceVariableNames: ''!

!TerniMoviendoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 03:52:02'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni not hasAWinner]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) = 6].! !


!classDefinition: #TerniTerminadoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniTerminadoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:51:00'!
moveStoneO: aPoint to: aPoint2 

^self playStonesAfterGameHasEnded! !

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:50:39'!
moveStoneX: aPoint to: aPoint2 

^self playStonesAfterGameHasEnded! !

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

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:32:51'!
moveStoneO: aPoint to: aPoint2 

^self playStonesAfterGameHasEnded! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:32:57'!
moveStoneX: aPoint to: aPoint2 

^self playStonesAfterGameHasEnded! !

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
