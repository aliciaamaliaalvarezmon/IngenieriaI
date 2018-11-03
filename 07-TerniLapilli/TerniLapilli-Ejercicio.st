!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'Ostones Xstones turn hasEnded winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 21:34:02'!
OStonesinPlay
	
	^ Ostones  size! !

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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:49:17'!
hasAWinner
	^ hasEnded.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 02:08:37'!
isMyTurn: aString.
	
	turn = aString ifFalse:[	^self error: self class PlayerCannotPlayOutOfTurnErrorMessage ].
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:48:34'!
newGame

Xstones := OrderedCollection new.
Ostones := OrderedCollection  new.

turn:= $X.
hasEnded:= false.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 05:23:52'!
playStone0: aPoint 

	self isMyTurn: $O.
	self ThereIsNotAnotherRockInThatPosition: aPoint .
	Ostones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].
	Ostones  add: aPoint.
	((Ostones count: [:positions| positions y = (Ostones at: 1) y ]) = 3) ifTrue:[ hasEnded := true. winner := $X].
	
	turn:= $X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 05:23:22'!
playStoneX: aPoint 
	
	self isMyTurn: $X.
	self ThereIsNotAnotherRockInThatPosition: aPoint .
	Xstones size < 3 ifFalse:[^self error: self class PlayerCannotPutMoreThanThreeStonesErrorMessage ].

	Xstones add: aPoint.
	
	((Xstones count: [:positions| positions y = (Xstones at: 1) y ]) = 3) ifTrue:[ hasEnded := true. winner := $X].
	
	turn:= $O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 05:03:14'!
winner

^ winner ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

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
