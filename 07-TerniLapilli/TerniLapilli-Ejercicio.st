!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'Ostones Xstones turn hasEnded'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 21:34:02'!
OStonesinPlay
	
	^ Ostones  size! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 19:40:32'!
PlayerFormedACoulmnWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions x = (triadOfStones at: 1) x ]) = 3
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 19:45:55'!
PlayerFormedADownDiagonalWithTheRocks: triadOfStones
	
^(triadOfStones count: [:positions| (positions = (1@3)) or:[positions = (2@2) or:[ positions = (3@1)]] ]) = 3
	
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 19:40:05'!
PlayerFormedAFileWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions y = (triadOfStones at: 1) y ]) = 3
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 19:43:18'!
PlayerFormedAnUpDiagonalWithTheRocks: triadOfStones
	
	^(triadOfStones count: [:positions| positions x = positions y ]) = 3
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 20:08:08'!
PlayerOHasNotWon

	(self PlayerFormedAFileWithTheRocks: Ostones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedACoulmnWithTheRocks: Ostones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedAnUpDiagonalWithTheRocks: Ostones ) ifTrue:[ ^self playerWon: $O].
	(self PlayerFormedADownDiagonalWithTheRocks: Ostones ) ifTrue:[  ^self playerWon: $O].	
	^turn:= $X! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 20:08:04'!
PlayerXHasNotWon

	(self PlayerFormedAFileWithTheRocks: Xstones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedACoulmnWithTheRocks: Xstones ) ifTrue:[  ^self playerWon: $O ].
	(self PlayerFormedAnUpDiagonalWithTheRocks: Xstones ) ifTrue:[ ^self playerWon: $O].
	(self PlayerFormedADownDiagonalWithTheRocks: Xstones ) ifTrue:[  ^self playerWon: $O].	
	^turn:= $O! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:15:09'!
ThereIsNotAnotherRockInThatPosition: aPoint 

|stones|

stones:= OrderedCollection  new.
stones addAll:  Ostones.
stones addAll: Xstones.
	(stones  includes: aPoint)
		  ifTrue:	[^self error: self class PlayerCannotPutAStoneWhereThereIsOneErrorMessage ]
		  ifFalse:   [^true].
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 23:35:23'!
ThereisAn0StoneIn: aPoint 
	 ^Ostones  includes: aPoint ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 22:39:19'!
ThereisAnXStoneIn: aPoint 
	
	^Xstones includes: aPoint. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 21:26:48'!
XStonesinPlay
	
	^Xstones size! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/4/2018 00:12:52'!
XstonesHas: aPoint 
	^ Xstones includes: aPoint .! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:49:17'!
hasAWinner
	^ hasEnded.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 02:08:37'!
isMyTurn: aString.
	
	turn = aString ifFalse:[	^self error: self class PlayerCannotPlayOutOfTurnErrorMessage ].
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 23:31:53'!
isWithinBorders: aPoint.

	
	((aPoint x between:  1 and: 3) and: (aPoint y between: 1 and:3) )ifFalse:[^self error: self class PlayerCannotPlayOutOfBordersErrorMessage ].   
	
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/4/2018 02:18:31'!
moveStoneO: aPoint to: aPoint2 

	hasEnded ifTrue:[^self error: self class CannotPlayIfGameHasEndedErrorMessage ].
	Ostones size < 3 ifTrue:[^ self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage ] .
	(Ostones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	(Ostones includes: aPoint2) ifTrue:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	(Xstones includes: aPoint2) ifTrue:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	Ostones add: aPoint2.
	Ostones remove: aPoint.
	
	^ self PlayerOHasNotWon.
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/4/2018 02:18:20'!
moveStoneX: aPoint to: aPoint2 

	hasEnded ifTrue:[^self error: self class CannotPlayIfGameHasEndedErrorMessage ].
	Xstones size < 3 ifTrue:[^ self error: self class CannotMoveStoneUntilAllArePlayedErrorMessage ] .
	(Xstones includes: aPoint) ifFalse:[^self error: self class PlayerCannotMoveFromInvalidPosition ].
	((aPoint dist: aPoint2) = 1) ifFalse:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	(Ostones includes: aPoint2) ifTrue:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	(Xstones includes: aPoint2) ifTrue:[^self error: self  class PlayerCannotMoveToInvalidPosition ].
	Xstones add: aPoint2.
	Xstones remove: aPoint.
	
	^ self PlayerXHasNotWon.
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:48:34'!
newGame

Xstones := OrderedCollection new.
Ostones := OrderedCollection  new.

turn:= $X.
hasEnded:= false.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 23:32:30'!
playStone0: aPoint 

	hasEnded ifTrue:[^self error: self class CannotPlayIfGameHasEndedErrorMessage ].
	self isMyTurn: $O.
	self isWithinBorders: aPoint.
	self ThereIsNotAnotherRockInThatPosition: aPoint .
	Ostones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].
	Ostones  add: aPoint.
	
	^self PlayerOHasNotWon.

! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/4/2018 02:17:30'!
playStoneX: aPoint 
	
	hasEnded ifTrue:[^self error: self class CannotPlayIfGameHasEndedErrorMessage ].
	self isMyTurn: $X.	
	self isWithinBorders: aPoint.
	self ThereIsNotAnotherRockInThatPosition: aPoint .
	Xstones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].

	Xstones add: aPoint.
	
	^ self PlayerXHasNotWon.
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 19:24:24'!
playerWon: aPlayer

	hasEnded := true. 
	^turn
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 20:15:47'!
winner

self hasAWinner ifFalse:[^self error: self class CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage ].
^ turn! !

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

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 23:22:37'!
PlayerCannotPlayOutOfBordersErrorMessage
	^'Position out of borders'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 01:44:57'!
PlayerCannotPlayOutOfTurnErrorMessage
	 ^'Player cannot play because is not her/his turn'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 04:13:18'!
PlayerCannotPutAStoneWhereThereIsOneErrorMessage
^'There is another rock in that position'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 04:23:58'!
PlayerCannotPutMoreThanThreeStonesErrorMessage
 ^'Player has not more rocks'! !


!TerniLapilli class methodsFor: 'initialization' stamp: 'AAAM 11/2/2018 21:33:30'!
new

^ self basicNew newGame.! !
