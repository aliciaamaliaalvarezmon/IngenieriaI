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


!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/5/2018 20:09:43'!
PlayerOHasNotWon

	(self PlayerFormedARowWithTheRocks: Ostones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedACoulmnWithTheRocks: Ostones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedAnUpDiagonalWithTheRocks: Ostones ) ifTrue:[ ^self playerWon: $O].
	(self PlayerFormedADownDiagonalWithTheRocks: Ostones ) ifTrue:[  ^self playerWon: $O].	
	^turn:= $X! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/5/2018 20:09:43'!
PlayerXHasNotWon

	(self PlayerFormedARowWithTheRocks: Xstones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedACoulmnWithTheRocks: Xstones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedAnUpDiagonalWithTheRocks: Xstones ) ifTrue:[ ^self playerWon: $O].
	(self PlayerFormedADownDiagonalWithTheRocks: Xstones ) ifTrue:[  ^self playerWon: $O].	
	^turn:= $O! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/3/2018 04:49:17'!
hasAWinner
	^ hasEnded.! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/3/2018 19:24:24'!
playerWon: aPlayer

	hasEnded := true. 
	^turn
! !

!TerniLapilli methodsFor: 'checkingIfPlayerWon' stamp: 'AAAM 11/5/2018 02:27:27'!
winner

hasEnded ifFalse:[^self error: self class CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage ].
^ turn! !


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


!TerniLapilli methodsFor: 'PrerequisitesToPlayorMoveAStone' stamp: 'AAAM 11/5/2018 03:44:23'!
GameHasNotEnded

^hasEnded ifTrue:[^self error: self class CannotPlayIfGameHasEndedErrorMessage ].! !

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

!TerniLapilli methodsFor: 'PrerequisitesToPlayorMoveAStone' stamp: 'AAAM 11/3/2018 02:08:37'!
isMyTurn: aString.
	
	turn = aString ifFalse:[	^self error: self class PlayerCannotPlayOutOfTurnErrorMessage ].
	! !

!TerniLapilli methodsFor: 'PrerequisitesToPlayorMoveAStone' stamp: 'AAAM 11/3/2018 23:31:53'!
isWithinBorders: aPoint.

	
	((aPoint x between:  1 and: 3) and: (aPoint y between: 1 and:3) )ifFalse:[^self error: self class PlayerCannotPlayOutOfBordersErrorMessage ].   
	
! !


!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/5/2018 04:13:09'!
checksBeforePlayerOPlays: aPoint.



	self GameHasNotEnded.
	self isMyTurn: $O.	
	self isWithinBorders: aPoint.
	self ThereIsNotAnotherRockInThatPosition: aPoint.

! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/5/2018 04:13:00'!
checksBeforePlayerXPlays: aPoint.



	self GameHasNotEnded.
	self isMyTurn: $X.	
	self isWithinBorders: aPoint.
	self ThereIsNotAnotherRockInThatPosition: aPoint.

! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/5/2018 04:14:11'!
moveStoneO: aPoint to: aPoint2 

	
	self checksBeforePlayerOPlays: aPoint2.
	Ostones size < 3 ifTrue:[^ self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage ] .
	(Ostones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Ostones add: aPoint2.
	Ostones remove: aPoint.
	
	^ self PlayerOHasNotWon.
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/5/2018 04:13:47'!
moveStoneX: aPoint to: aPoint2 


	self checksBeforePlayerXPlays: aPoint2.
	Xstones size < 3 ifTrue:[^ self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage ] .
	(Xstones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	
	Xstones add: aPoint2.
	Xstones remove: aPoint.
	
	^ self PlayerXHasNotWon.
! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/5/2018 20:58:23'!
playStoneO: aPoint 

	^self state putStoneO: aPoint.
	
	"self checksBeforePlayerOPlays: aPoint.
	Ostones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].
	
	Ostones  add: aPoint.
	
	^self PlayerOHasNotWon."

! !

!TerniLapilli methodsFor: 'playingStones' stamp: 'AAAM 11/5/2018 04:16:58'!
playStoneX: aPoint 
	
	self  checksBeforePlayerXPlays: aPoint.
	Xstones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].

	Xstones add: aPoint.
	
	^ self PlayerXHasNotWon.
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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:52:49'!
OWon

^$O! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:52:44'!
XWon

^$X! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:46:06'!
movingStoneBeforePuttingThemAll

^self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:45:20'!
movingStoneOInXTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:42:07'!
movingStoneXOnOTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:40:36'!
playStoneOWhenIsXTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:40:28'!
playStoneXWhenIsOTurn

^self error: self class PlayerCannotPlayOutOfTurnErrorMessage! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:52:25'!
playStonesAfterGameHasEnded

self error: self class CannotPlayIfGameHasEndedErrorMessage ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:48:42'!
playStonesAfterPuttingThemAll

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

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:12:18'!
playStoneO: aPoint

	self subclassResponsibility .! !

!TerniLapilliStates methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:20:26'!
playStoneX: aPoint

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

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:23:14'!
playStoneO: aPoint

 ^terni playStoneO: aPoint! !

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:23:47'!
playStoneX: aPoint

 ^terni playStoneXWhenIsOTurn! !

!TerniAgregandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:00'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniAgregandoO class' category: #'TerniLapilli-Ejercicio'!
TerniAgregandoO class
	instanceVariableNames: ''!

!TerniAgregandoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:49:38'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni GameHasNotEnded ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) < 6].! !


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

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:23:34'!
playStoneO: aPoint

 ^terni playStoneOWhenIsXTurn! !

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:22:50'!
playStoneX: aPoint

^terni playStoneX: aPoint! !

!TerniAgregandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:11'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniAgregandoX class' category: #'TerniLapilli-Ejercicio'!
TerniAgregandoX class
	instanceVariableNames: ''!

!TerniAgregandoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:50:22'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni GameHasNotEnded ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) < 6].! !


!classDefinition: #TerniJugandoO category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniJugandoO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:34:27'!
moveStoneO: aPoint to: aPoint2 

 ^terni moveStoneO: aPoint to: aPoint2.! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:43:15'!
moveStoneX: aPoint to: aPoint2 

 ^terni movingStoneXOnOTurn! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:18:45'!
playStoneO: aPoint

 ^terni playStonesAfterPuttingThemAll! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:22:05'!
playStoneX: aPoint

 ^terni playStonesAfterPuttingThemAll! !

!TerniJugandoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:16'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniJugandoO class' category: #'TerniLapilli-Ejercicio'!
TerniJugandoO class
	instanceVariableNames: ''!

!TerniJugandoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:50:37'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni GameHasNotEnded ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) = 6].! !


!classDefinition: #TerniJugandoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniJugandoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:44:22'!
moveStoneO: aPoint to: aPoint2 

 ^terni movingStoneOInXTurn! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:34:47'!
moveStoneX: aPoint to: aPoint2 

 ^terni moveStoneX: aPoint to: aPoint2.! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:18:56'!
playStoneO: aPoint

 ^terni playStonesAfterPuttingThemAll! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:22:10'!
playStoneX: aPoint

 ^terni playStonesAfterPuttingThemAll! !

!TerniJugandoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:22'!
winner

^terni AskingForWinnerOnAnUnfinishedGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniJugandoX class' category: #'TerniLapilli-Ejercicio'!
TerniJugandoX class
	instanceVariableNames: ''!

!TerniJugandoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:50:50'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni GameHasNotEnded ]) and: [(aTerni OStonesinPlay + aTerni XStonesinPlay) = 6].! !


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

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:49:32'!
playStoneO: aPoint

 ^terni playStonesAfterGameHasEnded
! !

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:49:40'!
playStoneX: aPoint

 ^terni playStonesAfterGameHasEnded! !

!TerniTerminadoO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:44'!
winner

^terni OWon! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniTerminadoO class' category: #'TerniLapilli-Ejercicio'!
TerniTerminadoO class
	instanceVariableNames: ''!

!TerniTerminadoO class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:05:23'!
isFor: aTerni

	^((aTerni turn = $O) and: [aTerni not GameHasNotEnded ]) ! !


!classDefinition: #TerniTerminadoX category: #'TerniLapilli-Ejercicio'!
TerniLapilliStates subclass: #TerniTerminadoX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:26:31'!
moveStoneO: aPoint to: aPoint2 

^self movingStoneAfterGameEnded! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:26:27'!
moveStoneX: aPoint to: aPoint2 

^self movingStoneAfterGameEnded! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:18:08'!
playStoneO: aPoint

 ^terni playStonesWhenGameFInished! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:21:18'!
playStoneX: aPoint

 ^terni playStonesWhenGameFInished! !

!TerniTerminadoX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:37:59'!
winner

^terni XWon ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniTerminadoX class' category: #'TerniLapilli-Ejercicio'!
TerniTerminadoX class
	instanceVariableNames: ''!

!TerniTerminadoX class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/6/2018 16:05:40'!
isFor: aTerni

	^((aTerni turn = $X) and: [aTerni not GameHasNotEnded ]) ! !
