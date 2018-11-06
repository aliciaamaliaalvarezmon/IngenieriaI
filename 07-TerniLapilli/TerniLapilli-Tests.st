!classDefinition: #TerniLapilliTests category: #'TerniLapilli-Tests'!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 01:51:17'!
shouldFail: aBlockClosure withDescription: aFailureDescription 

	| failedAsExpected |
	
	failedAsExpected := false.
	aBlockClosure
		on: Error - MessageNotUnderstood 
		do: [ :anError | failedAsExpected	:= anError messageText = aFailureDescription ].
		
	failedAsExpected ifFalse: [ Error signal: 'Expected to fail but did not fail' ]! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 22:40:06'!
test01ThereAreNotStonesInPlayAtTheStartOfTheGame

|terni|

terni:= TerniLapilli new.

self assert: terni XStonesinPlay = 0.
self assert: terni OStonesinPlay = 0.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 03:03:00'!
test02PlayingAStonePutsItInTheBoard

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.

self assert: terni XStonesinPlay = 1.
self assert: terni OStonesinPlay = 0.
self assert: (terni ThereisAnXStoneIn: 1@1 ).! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test03BothPlayersCanPlayStonesInTheBoard

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.

self assert: terni XStonesinPlay = 1.
self assert: terni OStonesinPlay = 1.
self assert: (terni ThereisAnXStoneIn: 1@1 ).
self assert: (terni ThereisAn0StoneIn: 1@2 ).! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:05:07'!
test04PlayerOShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.


self shouldFail: [terni playStoneO: 1@3. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 
self deny: (terni ThereisAn0StoneIn: 1@3).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:05:39'!
test05PlayerXShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.



self shouldFail: [terni playStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 
self deny: (terni ThereisAnXStoneIn: 1@2).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:05:52'!
test06PlayersCannotPlayStonesWhereIsPlacedAnOpponentStone

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.


self shouldFail: [terni playStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage . 
self deny: (terni ThereisAnXStoneIn: 1@2).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:07:26'!
test07PlayersCannotPlayStonnesWhereTheyHadPlayedOtherStone

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.


self shouldFail: [terni playStoneX: 1@1. ] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage . 
self assert: terni XStonesinPlay = 1.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:08:05'!
test08PlayerCannotPlayMoreThanThreeStones

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.
terni playStoneX: 1@3.
terni playStoneO: 2@2.
terni playStoneX: 3@3.
terni playStoneO: 2@1.

self shouldFail: [terni playStoneX: 3@2. ] withDescription: TerniLapilli  PlayerCannotPutMoreThanThreeStonesErrorMessage. 
self deny: (terni ThereisAnXStoneIn: 3@2).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 20:08:24'!
test09PlayerWInsWIthARow

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.
terni playStoneX: 2@1.
terni playStoneO: 2@2.
terni playStoneX: 3@1.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test10PlayerWInsWIthAColunm

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 2@1.
terni playStoneX: 1@2.
terni playStoneO: 2@2.
terni playStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test11PlayerWInsWIthAnUpDiagonal

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test12PlayerWInsWIthAnDownDiagonal

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 20:12:22'!
test13CannotAskWinnerIfGameHasNotEnded

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.


self deny: terni hasAWinner.
self shouldFail: [terni winner ] withDescription: TerniLapilli  CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test14CannotPlayIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.
self shouldFail: [terni playStoneO: 1@1] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 

! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/4/2018 02:05:16'!
test14aCannotPlayOutofBorders

|terni|

terni:= TerniLapilli new.

self shouldFail: [terni playStoneX: 3@4] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage. 

! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test15MoveStonesDoesNotChangeTheNumerOfStonesInTheBoard

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.
terni playStoneX: 1@3.
terni playStoneO: 2@2.
terni playStoneX: 3@3.
terni playStoneO: 2@1.
terni moveStoneX: 3@3 to: 3@2.

self assert: terni  XStonesinPlay  = 3.
self assert: (terni ThereisAnXStoneIn: 3@2).
self deny: (terni ThereisAnXStoneIn: 3@3)


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test16CannotMoveStonesUntilAllTheStonesArePlayed

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.
terni playStoneX: 1@3.
terni playStoneO: 2@2.

self shouldFail:[terni moveStoneX: 1@3 to: 2@3.] withDescription: TerniLapilli CannotMoveStoneUntilAllArePlayedErrorMessage.




! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test17PlayerCannotMoveFromPositionsWHereHeDoesNotHaveRocksPlaced

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.
terni playStoneX: 1@3.
terni playStoneO: 2@2.
terni playStoneX: 3@3.
terni playStoneO: 2@1.
self shouldFail:[terni moveStoneX: 3@2 to: 3@1.] withDescription: TerniLapilli  PlayerCannotMoveFromInvalidPosition.



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test18PlayerCannotMoveRockMoreThanOneSpace

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.
terni playStoneX: 1@3.
terni playStoneO: 2@2.
terni playStoneX: 3@3.
terni playStoneO: 2@1.
self shouldFail:[terni moveStoneX: 3@3 to: 3@1.] withDescription: TerniLapilli  PlayerCannotMoveToInvalidPosition.



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test19PlayerCannotMoveWhereThereIsAnRockFromAnotherPlayer

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@2.
terni playStoneX: 1@3.
terni playStoneO: 2@2.
terni playStoneX: 3@3.
terni playStoneO: 2@1.
self shouldFail:[terni moveStoneX: 1@1 to: 1@2.] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage .



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test20PlayerCannotMoveWhereThereIsAnRockFromThePlayer

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStoneO: 1@3.
terni playStoneX: 1@2.
terni playStoneO: 2@2.
terni playStoneX: 3@2.
terni playStoneO: 2@1.
self shouldFail:[terni moveStoneX: 1@1 to: 1@2.] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage.



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test21PlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.
self shouldFail: [terni moveStoneX: 1@3 to: 1@2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test22WinnerPlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.
self shouldFail: [terni moveStoneX: 1@3 to: 1@2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test23LoserPlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 1@2.
terni playStoneO: 3@3.

terni moveStoneX: 1@2  to: 1@3. 

self assert: terni hasAWinner .
self assert: terni winner = $X.
self shouldFail: [terni moveStoneO: 3@3 to: 3@2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test24PlayerMovesWithinBorders

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 1@2.
terni playStoneO: 3@3.



self shouldFail: [terni moveStoneX: 3@1 to: 4@1] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/5/2018 04:15:09'!
test25PlayerMovesWithinTurn

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStoneO: 2@1.
terni playStoneX: 2@2.
terni playStoneO: 2@3.
terni playStoneX: 1@2.
terni playStoneO: 3@3.



self shouldFail: [terni moveStoneO: 3@3 to: 3@2] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. .


! !
