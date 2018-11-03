!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'Ostones Xstones turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 21:34:02'!
OStonesinPlay
	
	^ Ostones  size! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 23:35:23'!
ThereisAn0StoneIn: aPoint 
	 ^Ostones  includes: aPoint ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 22:39:19'!
ThereisAnXStoneIn: aPoint 
	
	^Xstones includes: aPoint. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 21:26:48'!
XStonesinPlay
	
	^Xstones size! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 02:06:52'!
isMyTurn: aString.
	
	turn = aString 	ifFalse:[	^self error: self class PlayerCannotPlayOutOfTurnErrorMessage ].
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 01:53:31'!
newGame

Xstones := OrderedCollection new.
Ostones := OrderedCollection  new.

turn:= $X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 02:06:01'!
playStone0: aPoint 

	self isMyTurn: turn.

	Ostones  add: aPoint.
	turn:= $X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 02:05:57'!
playStoneX: aPoint 
	
	self isMyTurn: turn.
	
	Xstones add: aPoint.
	
	turn:= $O.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 21:33:30'!
new

^ self basicNew newGame.! !


!TerniLapilli class methodsFor: 'error handling' stamp: 'AAAM 11/3/2018 01:44:57'!
PlayerCannotPlayOutOfTurnErrorMessage
	 ^'Player cannot play because is not her/his turn'! !
