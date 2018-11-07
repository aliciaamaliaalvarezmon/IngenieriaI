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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:03:53'!
test01ThereAreNotStonesInPlayAtTheStartOfTheGame

|terni|

terni:= TerniLapilli new.

self assert: terni XStonesinPlay =0 .
self assert: terni OStonesinPlay =0.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:21'!
test02PlayingAStonePutsItInTheBoard

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.

self assert: terni XStonesinPlay = 1.
self assert: terni OStonesinPlay = 0.
self assert: (terni ThereisAnXStoneIn: 1@1 ).! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test03BothPlayersCanPlayStonesInTheBoard

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.

self assert: terni XStonesinPlay = 1.
self assert: terni OStonesinPlay = 1.
self assert: (terni ThereisAnXStoneIn: 1@1 ).
self assert: (terni ThereisAn0StoneIn: 1@2 ).! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test04PlayerOShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.


self shouldFail: [terni putStoneO: 1@3. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 
self deny: (terni ThereisAn0StoneIn: 1@3).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:21'!
test05PlayerXShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.



self shouldFail: [terni putStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 
self deny: (terni ThereisAnXStoneIn: 1@2).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test06PlayersCannotPlayStonesWhereIsPlacedAnOpponentStone

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.


self shouldFail: [terni putStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage . 
self deny: (terni ThereisAnXStoneIn: 1@2).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test07PlayersCannotPlayStonnesWhereTheyHadPlayedOtherStone

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.


self shouldFail: [terni putStoneX: 1@1. ] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage . 
self assert: terni XStonesinPlay = 1.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test08PlayerCannotPlayMoreThanThreeStones

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.
terni putStoneO: 2@1.

self shouldFail: [terni putStoneX: 3@2. ] withDescription: TerniLapilli  PlayerCannotPutMoreThanThreeStonesErrorMessage. 
self deny: (terni ThereisAnXStoneIn: 3@2).


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:34:07'!
test09aPlayerWInsWIthFirstRow

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 2@1.
terni putStoneO: 2@2.
terni putStoneX: 3@1.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:34:51'!
test09bPlayerWInsWIthSecondRow

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@2.
terni putStoneO: 1@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 3@2.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:35:28'!
test09cPlayerWInsWIthThirdRow

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@3.
terni putStoneO: 1@1.
terni putStoneX: 2@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test10PlayerWInsWIthAColunm

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 2@1.
terni putStoneX: 1@2.
terni putStoneO: 2@2.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:35:55'!
test10aPlayerWInsWIthFirstColunm

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 2@1.
terni putStoneX: 1@2.
terni putStoneO: 2@2.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:36:17'!
test10bPlayerWInsWIthSecondColunm

|terni|

terni:= TerniLapilli new.

terni putStoneX: 2@1.
terni putStoneO: 1@1.
terni putStoneX: 2@2.
terni putStoneO: 3@2.
terni putStoneX: 2@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 15:36:38'!
test10cPlayerWInsWIthThirdColunm

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 1@1.
terni putStoneX: 3@2.
terni putStoneO: 2@2.
terni putStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test11PlayerWInsWIthAnUpDiagonal

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test12PlayerWInsWIthAnDownDiagonal

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:21'!
test13CannotAskWinnerIfGameHasNotEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.


self deny: terni hasAWinner.
self shouldFail: [terni winner ] withDescription: TerniLapilli  CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test14CannotPlayIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.
self shouldFail: [terni putStoneO: 1@1] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 

! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:21'!
test14aCannotPlayOutofBorders

|terni|

terni:= TerniLapilli new.

self shouldFail: [terni putStoneX: 3@4] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage. 

! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test15MoveStonesDoesNotChangeTheNumerOfStonesInTheBoard

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.
terni putStoneO: 2@1.
terni moveStoneX: 3@3 to: 3@2.

self assert: terni  XStonesinPlay  = 3.
self assert: (terni ThereisAnXStoneIn: 3@2).
self deny: (terni ThereisAnXStoneIn: 3@3)


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test16CannotMoveStonesUntilAllTheStonesArePlayed

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.

self shouldFail:[terni moveStoneX: 1@3 to: 2@3.] withDescription: TerniLapilli CannotMoveStoneUntilAllArePlayedErrorMessage.




! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test17PlayerCannotMoveFromPositionsWHereHeDoesNotHaveRocksPlaced

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.
terni putStoneO: 2@1.
self shouldFail:[terni moveStoneX: 3@2 to: 3@1.] withDescription: TerniLapilli  PlayerCannotMoveFromInvalidPosition.



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test18PlayerCannotMoveRockMoreThanOneSpace

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.
terni putStoneO: 2@1.
self shouldFail:[terni moveStoneX: 3@3 to: 3@1.] withDescription: TerniLapilli  PlayerCannotMoveToInvalidPosition.



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test19PlayerCannotMoveWhereThereIsAnRockFromAnotherPlayer

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.
terni putStoneO: 2@1.
self shouldFail:[terni moveStoneX: 1@1 to: 1@2.] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage .



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test20PlayerCannotMoveWhereThereIsAnRockFromThePlayer

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@3.
terni putStoneX: 1@2.
terni putStoneO: 2@2.
terni putStoneX: 3@2.
terni putStoneO: 2@1.
self shouldFail:[terni moveStoneX: 1@1 to: 1@2.] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage.



! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test21PlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.
self shouldFail: [terni moveStoneX: 1@3 to: 1@2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test22WinnerPlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.
self shouldFail: [terni moveStoneX: 1@3 to: 1@2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test23LoserPlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.

terni moveStoneX: 1@2  to: 1@3. 

self assert: terni hasAWinner .
self assert: terni winner = $X.
self shouldFail: [terni moveStoneO: 3@3 to: 3@2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test24PlayerMovesWithinBorders

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.



self shouldFail: [terni moveStoneX: 3@1 to: 4@1] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/7/2018 02:31:38'!
test25PlayerMovesWithinTurn

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.



self shouldFail: [terni moveStoneO: 3@3 to: 3@2] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. .


! !
