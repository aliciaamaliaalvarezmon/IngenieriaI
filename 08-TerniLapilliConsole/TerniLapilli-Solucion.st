!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Solucion'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!TerniLapilliTest methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:51:39'!
assertCanNotMarkAt: aPosition
	self assertCanNotMarkUsing: [ game putXAt: aPosition ].
	self assertCanNotMarkUsing: [ game putOAt: aPosition ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 20:12:53'!
assertCanNotMarkUsing: aMarkingClosure
	self
		should: aMarkingClosure 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionOutsideBoardErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{}
				andOOn:
					{} ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:53:12'!
assertGameIsNotOver
	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:20:23'!
assertGameIsOver
	self assert: game isOver.
	self deny: game isPlayingX.
	self deny: game isPlayingO.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:59:35'!
assertIsPlayingO
	self assert: game isPlayingO.
	self deny: game isPlayingX.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:52:33'!
assertIsPlayingX
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:56:00'!
assertOIsMarkedOn: oPositions
	self
		assert: oPositions size
		equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:38:50'!
assertOWon
	self assertGameIsOver.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:50:53'!
assertXIsMarkedOn: xPositions
	self
		assert: xPositions size
		equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:48:39'!
assertXIsMarkedOn: xPositions andOOn: oPositions
	self assertXIsMarkedOn: xPositions .
	self assertOIsMarkedOn: oPositions .! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:20:00'!
assertXWon
	self assertGameIsOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !


!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 07:25:01'!
functionalException
	^ Error - MessageNotUnderstood.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:31:31'!
test01aGameStartsWithAnEmptyBoardAndPlayingX

	game _ TerniLapilli new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:33:14'!
test01bGameStartsWithAnEmptyBoardButOCanNotPlayFirst
	
	| oPosition |
	
	game _ TerniLapilli new.
	oPosition _ 2@2.
	
	self should: [ game putOAt: oPosition]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage 
				equals: anError messageText.
			self deny: (game isTaken: oPosition) ].			
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:54:38'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{}.
	self assertIsPlayingO.
	
	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:04:28'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{2 @ 2}.
	self assertIsPlayingX.	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:07:30'!
test04CanNotMarkWithXWhenLastMarkWasX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notXTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:09:21'!
test05CanNotMarkWithOWhenLastMarkWasO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putOAt: 3 @ 3 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:11:07'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 1 @ 1. ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:13:58'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:16:06'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putOAt: 1 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:18:11'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 3 @ 3.
	self
		should: [ game putOAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1. 3 @ 3}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/8/2018 13:11:55'!
test10AssertThereIsNotWinner
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 2.
	
	self assertGameIsNotOver ! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:22:01'!
test11XWinsWhenCompletesRowNumber1
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self assertXWon.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:30:21'!
test12XWinsWhenCompletesRowNumber2
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.
	self assertXWon.

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:31:38'!
test13XWinsWhenCompletesRowNumber3
	
	game _ TerniLapilli new.

	game putXAt: 3 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 3 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:35:10'!
test14XWinsWhenCompletesAColumn
	
	game _ TerniLapilli new.

	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 3.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:36:18'!
test15XWinsWhenCompletesDiagonalGoingDown
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 3.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:37:09'!
test16XWinsWhenCompletesDiagonalGoingUp
	game _ TerniLapilli new.

	game putXAt: 1 @ 3.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:38:20'!
test17OWinsWhenCompletesARow
	
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 1 @ 3.
	self assertOWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 09:24:09'!
test18OCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self
		should: [ game putOAt: 3 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self assertOIsMarkedOn:
				{2 @ 1. 3 @ 1} ].
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:18'!
test19XCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.

	self 
		should: [ game  putXAt: 2 @ 3 ] 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 1. 2 @ 2. 2@3}
			 ]
		! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:30'!
test20XCanNotPlaceMoreThanThreePieces
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 2 @ 3.
	self
		should: [ game putXAt: 3 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli playerXHasPlacedThreePieces
				equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 2. 2 @ 1. 3 @ 1} ].
			
			! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test21XCanSlideWhenAllXPiecesWerePlaced
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 2 @ 3.
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	
	self assertXIsMarkedOn: {1 @ 2. 1 @ 3. 2 @ 1}.
	self assertIsPlayingO.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test22OCanSlideWhenAllOPiecesWerePlaced
	
	game _ TerniLapilli new.
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.


	self assertXIsMarkedOn: {1 @ 2. 2 @ 1. 1 @ 3}.
	self assertOIsMarkedOn: {2 @ 2. 3 @ 1. 2 @ 3}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test23CanNotSlideWithXToAnAlreadyMarkedPositionWithX

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 1@2 to: 1@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test24CanNotSlideWithXToAnAlreadyMarkedPositionWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 2@1 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test25CanNotSlideWithOToAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 2@2. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test26CanNotSlideWithOToAnAlreadyMarkedPositionWithX
	
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test27XWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.
	game slideXFrom: 1@2 to: 2@2.
					
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test28OWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self assertOWon.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test29XCanNotSlideWhenOWon
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self 
		should: [ game slideXFrom: 3@1 to: 3@2. ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2.     3@1. 1@3}
				andOOn:
					{2@1. 2@2. 2@3}  ]
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30OCanNotSlideWhenXWon
	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	game slideOFrom: 3 @ 1 to: 2 @ 2.
	game slideXFrom: 2 @ 1 to: 3 @ 1.
	game slideOFrom: 2 @ 2 to: 3 @ 3.
	game slideXFrom: 1 @ 2 to: 2 @ 2.
	
	self should: [game slideOFrom: 1 @ 1 to: 2 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError | self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
		self assertXIsMarkedOn:
					{2@2.     3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test30_01CanNotSlideXToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	self 
		should: [game slideXFrom: 1 @ 3 to: 0 @ 3]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertXIsMarkedOn: { 2@2. 2@1. 1@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30_02CanNotSlideOToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 1 @ 3 to: 1@ 2.
	self 
		should: [ game slideOFrom: 1@1 to: 0@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertOIsMarkedOn: { 1@1. 3@1. 2@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test31DifferenceBetweenPositionsShouldNotBeGreaterThanOneWhenSliding
	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.

	self 
		should: [ game slideXFrom: 3@1 to: 3@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@1}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test32OnlyPermittedXSlidingsBetweenAdjacentsPositions

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.	
					
		self 
		should: [ game slideXFrom: 1@2 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3}   ]
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test33OnlyPermittedOSlidingsBetweenAdjacentsPositions
game _ TerniLapilli new.	

	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.
	
	game slideXFrom: 3@1 to: 3@2.

	self 
		should: [ game slideOFrom: 2@3 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@2}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 20:34:51'!
test34CanNotMarkOutsideBoard
	game _ TerniLapilli new.
	#(0 4 ) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test35CanNotSlideWithXFromAPositionMarkedWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
			
	self 
		should: [ game slideXFrom: 3@1 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test36CanNotSlideWithOFromAPositionMarkedWithX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.

	game slideXFrom: 2@2 to: 1@2.
			
	self 
		should: [ game slideOFrom: 2@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:16'!
test37CanNotSlideXWhenPutingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerXHasPiecesToPlace.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:30'!
test38CanNotSlideOWhenPuttingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerOHasPiecesToPlace.
			self assertOIsMarkedOn: { 1@1 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:49'!
test39CanNotSlideXWhenPlayingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notXTurnErrorMessage.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:50:01'!
test40CanNotSlideOWhenPlayingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notOTurnErrorMessage.
			self assertOIsMarkedOn: { 1@1 } ]
	! !


!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/10/2018 21:54:18'!
testConsole00

	| console|
	game := TerniLapilli  new.
	
	console := TerniLapilliConsole on: game.  

	console:= ReadStream on:   console lines  contents.
	self assert: console atEnd.
	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/10/2018 22:32:27'!
testConsole01

	| xPosition  console|
	game := TerniLapilli  new.
	xPosition := 2@2.
	
	game putXAt: 	xPosition.

	console:= ReadStream on:   game log contents. 

	.
	
	self assert:'X marcó en 2@2' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert: console atEnd.
	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/10/2018 19:35:59'!
testConsole02

	| console|
	game := TerniLapilli  new.
	
	game putXAt: 	2@2.
	game putOAt: 1@1.

	console:= ReadStream on:   game log contents.
	self assert:'X marcó en 2@2' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@1' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert: console atEnd.
	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/10/2018 20:25:16'!
testConsole03

	| console|
	game := TerniLapilli  new.
	
	game putXAt: 	2@2.
	game putOAt: 1@1.
	game putXAt: 	1@3.
	game putOAt: 1@2.
	game putXAt: 	3@1.


	console:= ReadStream on:   game log contents.
	self assert:'X marcó en 2@2' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@1' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 1@3' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@2' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 3@1' equals: console nextLine.
	self assert:'Estado: Juego terminado - ¡Ganó X!!' equals: console nextLine.
	self assert: console atEnd.
	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/10/2018 20:27:03'!
testConsole04

	| console|
	game := TerniLapilli  new.
	
	game putXAt: 	2@2.
	game putOAt: 1@1.
	game putXAt: 	3@3.
	game putOAt: 1@2.
	game putXAt: 	3@2.
	game putOAt: 1@3.

	console:= ReadStream on:   game log contents.
	self assert:'X marcó en 2@2' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@1' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 3@3' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@2' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 3@2' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@3' equals: console nextLine.
	self assert:'Estado: Juego terminado - ¡Ganó O!!' equals: console nextLine.
	self assert: console atEnd.
	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/10/2018 20:52:56'!
testConsole05

	| console|
	game := TerniLapilli  new.
	
	game putXAt: 	2@2.
	game putOAt: 1@1.
	game putXAt: 	1@3.
	game putOAt: 3@1.
	game putXAt: 	2@1.
	game putOAt: 2@3.
	
	game slideXFrom: 1@3  to: 1@2.
	game slideOFrom:  3@1 to: 3@2.
	game slideXFrom:  2@2 to: 3@3. 


	console:= ReadStream on:   game log contents.
	self assert:'X marcó en 2@2' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@1' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 1@3' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 3@1' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 2@1' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 2@3' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X deslizó hasta 1@2 desde 1@3' equals: console nextLine.	
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O deslizó hasta 3@2 desde 3@1' equals: console nextLine.	
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X deslizó hasta 3@3 desde 2@2' equals: console nextLine.	
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert: console atEnd.
	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/10/2018 21:40:11'!
testConsole06

	| console|
	game := TerniLapilli  new.
	
	game putXAt: 	2@2.
	game putOAt: 1@1.
	game putXAt: 	1@3.
	game putOAt: 3@1.
	game putXAt: 	2@1.
	game putOAt: 3@3.
	
	game slideXFrom: 1@3  to: 2@3.
	


	console:= ReadStream on:   game log contents.
	self assert:'X marcó en 2@2' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 1@1' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 1@3' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 3@1' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X marcó en 2@1' equals: console nextLine.
	self assert:'Estado: Jugando O' equals: console nextLine.
	self assert:'O marcó en 3@3' equals: console nextLine.
	self assert:'Estado: Jugando X' equals: console nextLine.
	self assert:'X deslizó hasta 2@3 desde 1@3' equals: console nextLine.	
	self assert:'Estado: Juego terminado - ¡Ganó X!!' equals: console nextLine.
	self assert: console atEnd.
	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 02:51:52'!
testView01

	| view scene|
	game := TerniLapilli  new.
	
	view := TerniLapilliView newWith: game.
	
	scene := ReadStream on: view showScene contents.
	self assert: '' equals: scene nextLine.
	self assert: ' | | ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | | ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | | ' equals: scene nextLine.
	self assert: 'Playing X' equals: scene nextLine.
	self assert: scene  atEnd.


	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 03:56:58'!
testView02

	| scene|
	game := TerniLapilli  new.
	
	
	game putXAt: 	2@2.
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: ' | | ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |X| ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | | ' equals: scene nextLine.
	self assert: 'Playing O' equals: scene nextLine.
	self assert: scene  atEnd.


	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 04:05:03'!
testView03

	| scene|
	game := TerniLapilli  new.
	
	
	game putXAt: 	2@2.
	game putOAt:  3@1.
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: ' | |O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |X| ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | | ' equals: scene nextLine.
	self assert: 'Playing X' equals: scene nextLine.
	self assert: scene  atEnd.


	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 04:06:36'!
testView04

	| scene|
	game := TerniLapilli  new.
	
	
	game putXAt: 	2@2.
	game putOAt:  3@1.
	game putXAt: 1@1.
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X| |O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |X| ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | | ' equals: scene nextLine.
	self assert: 'Playing O' equals: scene nextLine.
	self assert: scene  atEnd.


	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 04:08:36'!
testView05

	| scene|
	game := TerniLapilli  new.
	
	
	game putXAt: 	2@2.
	game putOAt:  3@1.
	game putXAt: 1@1.
	game putOAt:  2@1.
	game putXAt: 3@3.

	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X|O|O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |X| ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | |X' equals: scene nextLine.
	self assert: 'X Won!!' equals: scene nextLine.
	self assert: scene  atEnd.


	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 05:25:43'!
testView06

	| scene|
	game := TerniLapilli  new.
	
	
	game putXAt: 	2@2.
	game putOAt:  3@1.
	game putXAt: 1@1.
	game putOAt:  2@1.
	game putXAt: 3@2.
	game putOAt: 3@3.
	
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X|O|O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |X|X' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | |O' equals: scene nextLine.
	self assert: 'Playing X' equals: scene nextLine.
	self assert: scene  atEnd.

	game slideXFrom: 2@2 to: 1@2. 
	
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X|O|O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: 'X| |X' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | |O' equals: scene nextLine.
	self assert: 'Playing O' equals: scene nextLine.
	self assert: scene  atEnd.


	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 05:29:46'!
testView07

	| scene|
	game := TerniLapilli  new.
	
	
	game putXAt: 	2@2.
	game putOAt:  3@1.
	game putXAt: 1@1.
	game putOAt:  2@1.
	game putXAt: 3@2.
	game putOAt: 3@3.
	
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X|O|O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |X|X' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | |O' equals: scene nextLine.
	self assert: 'Playing X' equals: scene nextLine.
	self assert: scene  atEnd.

	game slideXFrom: 2@2 to: 1@2. 
	game slideOFrom: 3@3 to: 2@3.
	 
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X|O|O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: 'X| |X' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |O| ' equals: scene nextLine.
	self assert: 'Playing X' equals: scene nextLine.
	self assert: scene  atEnd.
	
	game slideXFrom: 1@1 to: 2@2. 
	
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: ' |O|O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: 'X|X|X' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |O| ' equals: scene nextLine.
	self assert: 'X Won!!' equals: scene nextLine.
	self assert: scene  atEnd.


	! !

!TerniLapilliTest methodsFor: 'testingConsole&View' stamp: 'AAAM 11/11/2018 05:39:22'!
testView08

	| scene|
	game := TerniLapilli  new.
	
	
	game putXAt: 	2@2.
	game putOAt:  3@1.
	game putXAt: 1@1.
	game putOAt:  2@1.
	game putXAt: 3@2.
	game putOAt: 3@3.
	
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X|O|O' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |X|X' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' | |O' equals: scene nextLine.
	self assert: 'Playing X' equals: scene nextLine.
	self assert: scene  atEnd.

	game slideXFrom: 2@2 to: 1@2. 
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 1@2 to: 1@3.
	game slideOFrom: 3@3 to: 2@3.
	  
	scene := ReadStream on: game showView contents.
	self assert: '' equals: scene nextLine.
	self assert: 'X|O| ' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: ' |O|X' equals: scene nextLine.
	self assert: '-----' equals: scene nextLine.
	self assert: 'X|O| ' equals: scene nextLine.
	self assert: 'O Won!!' equals: scene nextLine.
	self assert: scene  atEnd.
	
	


	! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Solucion'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state playerOPositions playerXPositions console lastPlay view'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:39'!
assertAllPiecesOPlaced

	(self playerOPositions size = 3 ) ifFalse: [ self error: self class playerOHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:20'!
assertAllPiecesXPlaced

	(self playerXPositions size = 3 ) ifFalse: [ self error: self class playerXHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 10:47:35'!
assertIsInBoardBounds: aPosition

	(self isInBoardBounds: aPosition) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:55:12'!
assertIsLegalMovementFrom: aPosition to: anotherPosition

	(self moveLegalFrom: aPosition to: anotherPosition) ifFalse: [ self error: self class illegalMovement ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:31:24'!
assertThereIsAnOPieceIn: aPosition

	(self playerOPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:30:17'!
assertThereIsAnXPieceIn: aPosition

	(self playerXPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !


!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:30'!
has: positions threeOf: aPositionComponent

	^positions size >= 3 and: [ (positions collect: aPositionComponent) asBag contents values includes: 3 ]
	! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:20'!
hasCompletedColumn: positions

	^ self has: positions threeOf: [ :aPosition | aPosition y ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:36'!
hasCompletedRow: positions
	
	^ self has: positions threeOf: [ :aPosition | aPosition x ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:47'!
hasDownDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ (4-n) ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:59'!
hasUpDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ n ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:16:26'!
hasWin: positions

	^ (self hasCompletedRow: positions) 
		or: [ (self hasCompletedColumn: positions) 
		or: [ (self hasUpDiagonal: positions) 
		or: [ self hasDownDiagonal: positions ]]].! !


!TerniLapilli methodsFor: 'initialization' stamp: 'AAAM 11/11/2018 02:19:10'!
initialize

	playerXPositions := OrderedCollection new.
	playerOPositions := OrderedCollection new.
	state := PlacingX new initializeFor: self.
	console:= WriteStream on: String new.
 	view := TerniLapilliView newWith: self
! !


!TerniLapilli methodsFor: 'marking board' stamp: 'JG 11/6/2018 20:34:26'!
putOAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putOAt: aPosition! !

!TerniLapilli methodsFor: 'marking board' stamp: 'JG 11/6/2018 20:34:12'!
putXAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putXAt: aPosition! !


!TerniLapilli methodsFor: 'marking board - private' stamp: 'AAAM 11/11/2018 02:08:31'!
changeStateAfterAdding: aPosition to: positions  

	positions add: aPosition.
	state := TerniLapilliState for: self.
	
	
	"aca va el update de los observadores"
	! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'AAAM 11/11/2018 02:26:24'!
putOWhenPlacingOAt: aPosition

	self playerOHasPiecesToPlace.
	self assertIsFree: aPosition.

	self changeStateAfterAdding: aPosition to: playerOPositions.
	
	console nextPutAll: 'O marcó en ', aPosition asString. 
	console newLine.
	self hasPlayerOWon ifTrue:[console nextPutAll:'Estado: Juego terminado - ¡Ganó O!!']
	ifFalse:[console nextPutAll:'Estado: Jugando X'].
	console newLine.
	

	self hasPlayerOWon ifTrue:[view actualizeOnFinishedGameWith: aPosition by: $O ]
						   ifFalse:[view actualizeOnUnfinishedGameWith: aPosition by: $O  ].
	
	! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:41'!
putOWhenPlacingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:08:31'!
putOWhenSlidingOAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:11'!
putOWhenSlidingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:23'!
putXWhenPlacingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'AAAM 11/11/2018 03:59:34'!
putXWhenPlacingXAt: aPosition

	self playerXHasPiecesToPlace.
	self assertIsFree: aPosition.

	
	self changeStateAfterAdding: aPosition to: playerXPositions.

	
	console nextPutAll: 'X marcó en ', aPosition asString. 
	console newLine.
	self hasPlayerXWon ifTrue:[console nextPutAll:'Estado: Juego terminado - ¡Ganó X!!']
	ifFalse:[console nextPutAll:'Estado: Jugando O'].	
	console newLine.
	
	self hasPlayerXWon ifTrue:[view := view actualizeOnFinishedGameWith: aPosition by: $X ]
						   ifFalse:[view := view actualizeOnUnfinishedGameWith: aPosition by: $X ].
	! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:49'!
putXWhenSlidingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 11:59:44'!
putXWhenSlidingXAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !


!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:58:58'!
playerOHasPiecesToPlace

	 self playerOPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !

!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:59:05'!
playerXHasPiecesToPlace

	 self playerXPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !


!TerniLapilli methodsFor: 'positions' stamp: 'HAW 11/8/2018 10:49:00'!
moveLegalFrom: aPosition to: anotherPosition
	
	^ (self is: aPosition adjacentTo: anotherPosition) and: [ self isInBoardBounds: anotherPosition ]! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TerniLapilli methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:39'!
slideOFrom: aPosition to: anotherPosition

	self assertThereIsAnOPieceIn: aPosition.
	state slideOFrom: aPosition to: anotherPosition! !

!TerniLapilli methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:21'!
slideXFrom: aPosition to: anotherPosition

	self assertThereIsAnXPieceIn: aPosition.
	state slideXFrom: aPosition to: anotherPosition! !


!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:41:03'!
slideOWhenPlacingOFrom: aPosition to: anotherPosition

	self error: self class playerOHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:46:55'!
slideOWhenPlayingXFrom: aPosition to: anotherPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'AAAM 11/11/2018 04:55:25'!
slideOWhenSlidingOFrom: aPosition to: anotherPosition
	
	self assertIsFree: anotherPosition .
	self assertIsLegalMovementFrom: aPosition to: anotherPosition.
	
	playerOPositions remove: aPosition.
	self changeStateAfterAdding: anotherPosition to: playerOPositions.
	
	
	console nextPutAll: 'O deslizó hasta ', anotherPosition asString, ' desde ', aPosition asString. 
	console newLine.
	self hasPlayerOWon ifTrue:[console nextPutAll:'Estado: Juego terminado - ¡Ganó O!!']
	ifFalse:[console nextPutAll:'Estado: Jugando X'].
	console newLine.
	
	self hasPlayerOWon ifTrue:[view actualizeOnFinishedGameMovingTo: anotherPosition  from: aPosition  by: $O ]
						   ifFalse:[view actualizeOnUnfinishedGameMovingTo: anotherPosition  from: aPosition  by: $O  ].! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:16:01'!
slideXWhenPlacingXFrom: aPosition to: anotherPosition

	self error: self class playerXHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:44:53'!
slideXWhenPlayingOFrom: aPosition to: anotherPosition

	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'AAAM 11/11/2018 05:09:07'!
slideXWhenSlidingXFrom: aPosition to: anotherPosition
	
	self assertIsFree: anotherPosition .
	self assertIsLegalMovementFrom: aPosition to: anotherPosition.
	
	playerXPositions remove: aPosition.
	self changeStateAfterAdding: anotherPosition to: playerXPositions.
	
	
	console nextPutAll: 'X deslizó hasta ', anotherPosition asString, ' desde ',aPosition asString. 
	console newLine.
	self hasPlayerXWon ifTrue:[console nextPutAll:'Estado: Juego terminado - ¡Ganó X!!']
	ifFalse:[console nextPutAll:'Estado: Jugando O'].
	console newLine.
	
		self hasPlayerXWon ifTrue:[view actualizeOnFinishedGameMovingTo: anotherPosition  from: aPosition  by: $X ]
						   ifFalse:[view actualizeOnUnfinishedGameMovingTo: anotherPosition  from: aPosition  by: $X  ].! !


!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
does: aNumber distanceOneTo: anotherNumber

	^ (aNumber - anotherNumber) abs < 2 ! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 11:30:51'!
hasXMorePiecesToPlace
	
	^playerXPositions size < 3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
is: aPosition adjacentTo: anotherPosition

	^ (self does: aPosition x distanceOneTo: anotherPosition x) and: [ self does: aPosition y distanceOneTo: anotherPosition y ]
	! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 10:47:53'!
isInBoardBounds: aPosition

	^aPosition between: 1@1 and: 3@3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 5/31/2018 00:16:45'!
isTaken: aPosition

	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 11:56:45'!
hasPlayerOWon

	^self hasWin: playerOPositions ! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 11:56:55'!
hasPlayerXWon
	
	^self hasWin: playerXPositions ! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !


!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:19:47'!
isPlacingX
	
	^state isPlacingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:16'!
isSlidingX
	
	^state isSlidingX! !


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 02:09:24'!
lastPlay
 ^ lastPlay . "Hay que implementar"! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/10/2018 19:14:41'!
log
	 
	
	^console copy! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 03:56:09'!
showView

^ view showScene ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AAAM 11/10/2018 22:13:41'!
unVisitador: aVisitator
	
	state  accept: aVisitator .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Solucion'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 11:12:02'!
eachPlayerOnlyHasThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 11/8/2018 09:55:12'!
illegalMovement
	
	^'Movement is not legal'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:08'!
playerOHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:02:06'!
playerOHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:16'!
playerXHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:01:23'!
playerXHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:21:33'!
playersCanOnlySlideTheirOwnPieces

	^ 'Players can only slide their own pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 20:07:12'!
positionOutsideBoardErrorMessage
	^ 'Position is outside board'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TerniLapilliConsole category: #'TerniLapilli-Solucion'!
Object subclass: #TerniLapilliConsole
	instanceVariableNames: 'game console'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'AAAM 11/10/2018 22:34:21'!
lines

	
	"game unVisitador: self."

	^console! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'AAAM 11/10/2018 22:24:06'!
newInitialize: aTerniLapilli.

game:= aTerniLapilli.
console := WriteStream on: String new.! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'AAAM 11/10/2018 22:22:46'!
visitAGameOverState: aPlacingState! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:53:07'!
visitAPlacingOState: aLastPlay

console nextPutAll: aLastPlay.
console newLine.
console nextPutAll: 'Estado: Jugando X'.
console newLine .! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:51:24'!
visitAPlacingXState: aLastPlay

console nextPutAll: aLastPlay.
console newLine.
console nextPutAll: 'Estado: Jugando O'.
console newLine .! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:52:22'!
visitASlidingOState: aLastPlay

console nextPutAll: aLastPlay.
console newLine.
console nextPutAll: 'Estado: Jugando X'.
console newLine .! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:53:51'!
visitASlidingXState: aLastPlay

console nextPutAll: aLastPlay.
console newLine.
console nextPutAll: 'Estado: Jugando O'.
console newLine .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsole class' category: #'TerniLapilli-Solucion'!
TerniLapilliConsole class
	instanceVariableNames: ''!

!TerniLapilliConsole class methodsFor: 'class initialization' stamp: 'AAAM 11/10/2018 21:56:30'!
on: aTerniLapilli

	^self new newInitialize: aTerniLapilli.
	! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Solucion'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:16'!
areAllXsOnTheBoard
	
	^false! !

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:10'!
isOver
	
	^false! !


!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:06:17'!
isPlacingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:15:12'!
isPlayingO
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:14:00'!
isPlayingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:36'!
isSlidingX
	
	^false! !


!TerniLapilliState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:03:55'!
putOAt: aPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:04:00'!
putXAt: aPosition
	
	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPosition
	
	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !


!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'AAAM 11/10/2018 22:16:27'!
accept: unVisitor.

self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'TerniLapilli-Solucion'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'HAW 11/8/2018 11:21:36'!
for: aTerniLapilli 

	| stateClass |
	
	stateClass := self allSubclasses detect: [:anStateClass | anStateClass isFor: aTerniLapilli ].	
	^stateClass new initializeFor: aTerniLapilli ! !


!TerniLapilliState class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:21:46'!
isFor: aTerniLapilli 

	^self subclassResponsibility ! !


!classDefinition: #GameOverState category: #'TerniLapilli-Solucion'!
TerniLapilliState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:15:43'!
isOver

	^ true.! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:08:57'!
putOAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:09:02'!
putXAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !


!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !


!GameOverState methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:46:07'!
accept: aVisitor

game lastPlay.

 ^aVisitor visitAGameOverState: game lastPlay.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOverState class' category: #'TerniLapilli-Solucion'!
GameOverState class
	instanceVariableNames: ''!

!GameOverState class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 12:02:20'!
isFor: aTerniLapilli 

	^ aTerniLapilli hasPlayerXWon or: [ aTerniLapilli hasPlayerOWon ]! !


!classDefinition: #PlayingO category: #'TerniLapilli-Solucion'!
TerniLapilliState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !


!PlayingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlayingOFrom: aPosition to: anotherPostion .! !


!PlayingO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 00:13:41'!
accept: unVisitor.

self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingO class' category: #'TerniLapilli-Solucion'!
PlayingO class
	instanceVariableNames: ''!

!PlayingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:23:04'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingO category: #'TerniLapilli-Solucion'!
PlayingO subclass: #PlacingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:10:45'!
putOAt: aPosition

	game putOWhenPlacingOAt: aPosition ! !

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:05:38'!
putXAt: aPosition

	game putXWhenPlacingOAt: aPosition ! !


!PlacingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game slideOWhenPlacingOFrom: aPosition to: anotherPostion .! !


!PlacingO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:46:23'!
accept: aVisitor

game lastPlay.

 ^aVisitor visitAGameOverState: game lastPlay.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingO class' category: #'TerniLapilli-Solucion'!
PlacingO class
	instanceVariableNames: ''!

!PlacingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 12:07:43'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlacingX and: [ aTerniLapilli hasPlayerXWon not ] ! !


!classDefinition: #SlidingO category: #'TerniLapilli-Solucion'!
PlayingO subclass: #SlidingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:11:14'!
putOAt: aPosition

	game putOWhenSlidingOAt: aPosition ! !

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:04:38'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenSlidingOFrom: aPosition to: anotherPostion .! !


!SlidingO methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 12:04:38'!
areAllXsOnTheBoard
	
	^true! !


!SlidingO methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:46:51'!
accept: aVisitor

game lastPlay.

 ^aVisitor visitAGameOverState: game lastPlay.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingO class' category: #'TerniLapilli-Solucion'!
SlidingO class
	instanceVariableNames: ''!

!SlidingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:57:15'!
isFor: aTerniLapilli 

	^aTerniLapilli isSlidingX and: [ aTerniLapilli hasPlayerXWon not ]! !


!classDefinition: #PlayingX category: #'TerniLapilli-Solucion'!
TerniLapilliState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenPlayingXFrom: aPosition to: anotherPostion .! !


!PlayingX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 00:13:47'!
accept: unVisitor.

self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingX class' category: #'TerniLapilli-Solucion'!
PlayingX class
	instanceVariableNames: ''!

!PlayingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:25:23'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingX category: #'TerniLapilli-Solucion'!
PlayingX subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!PlacingX methodsFor: 'marking board' stamp: 'AAAM 11/11/2018 01:48:07'!
accept:aVisitor

game lastPlay.

 ^aVisitor visitAGameOverState: game lastPlay.

	! !

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:52:28'!
putOAt: aPosition

	game putOWhenPlacingXAt: aPosition ! !

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 11:58:08'!
putXAt: aPosition

	game putXWhenPlacingXAt: aPosition ! !


!PlacingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlacingXFrom: aPosition to: anotherPostion .! !


!PlacingX methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:06:28'!
isPlacingX

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingX class' category: #'TerniLapilli-Solucion'!
PlacingX class
	instanceVariableNames: ''!

!PlacingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:25:47'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace]! !


!classDefinition: #SlidingX category: #'TerniLapilli-Solucion'!
PlayingX subclass: #SlidingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 14:51:46'!
putOAt: aPosition

	game putOWhenSlidingXAt: aPosition ! !

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:00:12'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion
 
	game slideXWhenSlidingXFrom: aPosition to: anotherPostion .! !


!SlidingX methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 11:30:43'!
areAllXsOnTheBoard
	
	^true! !


!SlidingX methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:47'!
isSlidingX

	^true! !


!SlidingX methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 01:48:14'!
accept: aVisitor

 game lastPlay.

 ^aVisitor visitAGameOverState: game lastPlay.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingX class' category: #'TerniLapilli-Solucion'!
SlidingX class
	instanceVariableNames: ''!

!SlidingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:57:36'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace not and: [ aTerniLapilli hasPlayerOWon not ]]! !


!classDefinition: #TerniLapilliView category: #'TerniLapilli-Solucion'!
Object subclass: #TerniLapilliView
	instanceVariableNames: 'game scene lines1 lines2 lines3'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Solucion'!

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 05:32:34'!
actualizeOnFinishedGameMovingTo: anotherPosition  from: aPosition  by: aPlayer

|indexFrom indexTo|
 indexFrom := aPosition x + (aPosition x -1).
 indexTo := anotherPosition x + (anotherPosition x -1).
aPosition y= 1 ifTrue:[ lines1 at:  indexFrom put: $ . ] . 
aPosition y= 2 ifTrue:[ lines2 at:  indexFrom put: $  .] .
aPosition y= 3 ifTrue:[ lines3 at:  indexFrom put: $  .] .

anotherPosition y = 1ifTrue:[ lines1 at:  indexTo put: aPlayer. ] . 
anotherPosition y = 2ifTrue:[ lines2 at:  indexTo put: aPlayer. ] . 
anotherPosition y = 3ifTrue:[ lines3 at:  indexTo put: aPlayer. ] . 



self setSceneFinished: aPlayer.

 ^self! !

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 04:11:49'!
actualizeOnFinishedGameWith: aPosition by: aPlayer


|index|
 index := aPosition x + (aPosition x -1).

aPosition y= 1 ifTrue:[ lines1 at:  index put: aPlayer ] . 
aPosition y= 2 ifTrue:[ lines2 at:  index put: aPlayer ] .
aPosition y= 3 ifTrue:[ lines3 at:  index put: aPlayer ] .

 self setSceneFinished: aPlayer.

 ^self


! !

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 05:23:54'!
actualizeOnUnfinishedGameMovingTo: anotherPosition  from: aPosition  by: aPlayer


|indexFrom indexTo|
 indexFrom := aPosition x + (aPosition x -1).
 indexTo := anotherPosition x + (anotherPosition x -1).
aPosition y= 1 ifTrue:[ lines1 at:  indexFrom put: $ . ] . 
aPosition y= 2 ifTrue:[ lines2 at:  indexFrom put: $  .] .
aPosition y= 3 ifTrue:[ lines3 at:  indexFrom put: $  .] .

anotherPosition y = 1ifTrue:[ lines1 at:  indexTo put: aPlayer. ] . 
anotherPosition y = 2ifTrue:[ lines2 at:  indexTo put: aPlayer. ] . 
anotherPosition y = 3ifTrue:[ lines3 at:  indexTo put: aPlayer. ] . 


aPlayer = $X ifTrue:[self setSceneUnfinished: $O] ifFalse:[ self setSceneUnfinished: $X].

^self ! !

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 04:01:01'!
actualizeOnUnfinishedGameWith: aPosition by: aPlayer

|index|
 index := aPosition x + (aPosition x -1).

aPosition y= 1 ifTrue:[ lines1 at:  index put: aPlayer ] . 
aPosition y= 2 ifTrue:[ lines2 at:  index put: aPlayer ] .
aPosition y= 3 ifTrue:[ lines3 at:  index put: aPlayer ] .

aPlayer = $X ifTrue:[self setSceneUnfinished: $O] ifFalse:[ self setSceneUnfinished: $X].

^self ! !

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 03:00:10'!
newInitialize: aGame

game:= aGame.
lines1 := OrderedCollection new.
lines1 addAllLast: ' | | '.
lines2 := OrderedCollection new.
lines2 addAllLast: ' | | '.
lines3 := OrderedCollection new.
lines3 addAllLast: ' | | '.

self setSceneUnfinished: $X.

! !

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 03:01:39'!
setSceneFinished: aPlayer

scene := WriteStream  on: String new.
scene newLine.
scene nextPutAll: lines1 contents.
scene newLine.
scene nextPutAll: '-----'. 
scene newLine.
scene nextPutAll: lines2 contents. 
scene newLine.
scene nextPutAll: '-----'. 
scene newLine.
scene nextPutAll: lines3 contents.
scene newLine.
scene nextPutAll: (aPlayer asString), ' Won!!'
! !

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 03:03:29'!
setSceneUnfinished: aPlayer

scene := WriteStream  on: String new.
scene newLine.
scene nextPutAll: lines1 contents.
scene newLine.
scene nextPutAll: '-----'. 
scene newLine.
scene nextPutAll: lines2 contents. 
scene newLine.
scene nextPutAll: '-----'. 
scene newLine.
scene nextPutAll: lines3 contents.
scene newLine.
scene nextPutAll: 'Playing ', aPlayer asString
! !

!TerniLapilliView methodsFor: 'as yet unclassified' stamp: 'AAAM 11/11/2018 03:02:13'!
showScene



^scene! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliView class' category: #'TerniLapilli-Solucion'!
TerniLapilliView class
	instanceVariableNames: ''!

!TerniLapilliView class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/10/2018 23:05:33'!
newWith: aGame

^ self new newInitialize: aGame! !
