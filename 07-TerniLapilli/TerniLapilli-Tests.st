!classDefinition: #TerniLapilliTests category: #'TerniLapilli-Tests'!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:23:59'!
test01ThereAreNotStonesInPlayAtTheStartOfTheGame

|terni|

terni:= TerniLapilli new.

self assert: terni stonesXInPlay =0 .
self assert: terni stonesOInPlay =0.! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:24:15'!
test02PlayingAStonePutsItInTheBoard

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.

self assert: terni stonesXInPlay = 1.
self assert: terni stonesOInPlay = 0.
self assert: (terni thereIsAnXStoneIn: 1@1 ).! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:24:38'!
test03BothPlayersCanPlayStonesInTheBoard

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.

self assert: terni stonesXInPlay = 1.
self assert: terni stonesOInPlay = 1.
self assert: (terni thereIsAnXStoneIn: 1@1 ).
self assert: (terni thereIsAnOStoneIn: 1@2 ).! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:24:38'!
test04PlayerOShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.


self shouldFail: [terni putStoneO: 1@3. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 
self deny: (terni thereIsAnOStoneIn: 1@3).


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:24:15'!
test05PlayerXShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.



self shouldFail: [terni putStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 
self deny: (terni thereIsAnXStoneIn: 1@2).


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:24:16'!
test06PlayersCannotPlayStonesWhereIsPlacedAnOpponentStone

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.


self shouldFail: [terni putStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage . 
self deny: (terni thereIsAnXStoneIn: 1@2).


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:23:59'!
test07PlayersCannotPlayStonnesWhereTheyHadPlayedOtherStone

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.


self shouldFail: [terni putStoneX: 1@1. ] withDescription: TerniLapilli  PlayerCannotPlayAStoneWhereThereIsOneErrorMessage . 
self assert: terni stonesXInPlay = 1.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:24:16'!
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
self deny: (terni thereIsAnXStoneIn: 3@2).


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:10:20'!
test09aPlayerWInsWIthFirstRow

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 2@1.
terni putStoneO: 2@2.
terni putStoneX: 3@1.


self assert: terni hasAWinner.
self assert: terni playerXWon


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:10:40'!
test09bPlayerWInsWIthSecondRow

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@2.
terni putStoneO: 1@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 3@2.


self assert: terni hasAWinner.
self assert: terni playerXWon.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:10:49'!
test09cPlayerWInsWIthThirdRow

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@3.
terni putStoneO: 1@1.
terni putStoneX: 2@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni playerXWon.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:11:01'!
test10aPlayerWInsWIthFirstColunm

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 2@1.
terni putStoneX: 1@2.
terni putStoneO: 2@2.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni  playerXWon.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:11:12'!
test10bPlayerWInsWIthSecondColunm

|terni|

terni:= TerniLapilli new.

terni putStoneX: 2@1.
terni putStoneO: 1@1.
terni putStoneX: 2@2.
terni putStoneO: 3@2.
terni putStoneX: 2@3.


self assert: terni hasAWinner.
self assert: terni  playerXWon.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:11:21'!
test10cPlayerWInsWIthThirdColunm

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 1@1.
terni putStoneX: 3@2.
terni putStoneO: 2@2.
terni putStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni playerXWon.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:11:26'!
test11PlayerWInsWIthAnUpDiagonal

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni playerXWon.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:11:33'!
test12PlayerWInsWIthAnDownDiagonal

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni playerXWon.


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:12:20'!
test13CannotAskWinnerIfGameHasNotEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.


self deny: terni hasAWinner.
self shouldFail: [terni playerXWon ] withDescription: TerniLapilli  CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage. 
self shouldFail: [terni playerOWon ] withDescription: TerniLapilli  CannotAskForWinnerOnAnGameThatHasNotEndedErrorMessage. 

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:12:39'!
test14CannotPlayIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni playerXWon.
self shouldFail: [terni putStoneO: 1@1] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:41:08'!
test14aCannotPlayOutofBordersByExceedingRows

|terni|

terni:= TerniLapilli new.

self shouldFail: [terni putStoneX: 3@4] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage. 
self deny: (terni thereIsAnXStoneIn: 3@4)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:42:37'!
test14bCannotPlayOutofBordersByLoweringRows

|terni|

terni:= TerniLapilli new.

self shouldFail: [terni putStoneX: 3@0] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage. 
self deny: (terni thereIsAnXStoneIn: 3@0)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:43:03'!
test14cCannotPlayOutofBordersByLoweringColumns

|terni|

terni:= TerniLapilli new.

self shouldFail: [terni putStoneX: 0@2] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage. 
self deny: (terni thereIsAnXStoneIn: 0@2)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:43:37'!
test14dCannotPlayOutofBordersByExceedingColumns

|terni|

terni:= TerniLapilli new.

self shouldFail: [terni putStoneX: 4@1] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage. 
self deny: (terni thereIsAnXStoneIn: 4@1)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:44:08'!
test14eCannotPlayOutofBorders

|terni|

terni:= TerniLapilli new.

self shouldFail: [terni putStoneX: 0@5] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage. 
self deny: (terni thereIsAnXStoneIn: 0@5)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 14:24:15'!
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

self assert: terni  stonesXInPlay  = 3.
self assert: (terni thereIsAnXStoneIn: 3@2).
self deny: (terni thereIsAnXStoneIn: 3@3)


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:16:33'!
test16CannotMoveStonesUntilAllTheStonesArePlayed

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.

self shouldFail:[terni moveStoneX: 1@3 to: 2@3.] withDescription: TerniLapilli CannotMoveStoneUntilAllArePlayedErrorMessage.
self assert: (terni thereIsAnXStoneIn: 1@3).
self deny:(terni thereIsAnXStoneIn: 2@3)


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:18:07'!
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
self deny: (terni thereIsAnXStoneIn: 3@2).
self deny: (terni thereIsAnXStoneIn: 3@1)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:19:10'!
test18PlayerCannotMoveRockMoreThanOneSpace

|terni|

terni:= TerniLapilli new.

terni putStoneX: 1@1.
terni putStoneO: 1@2.
terni putStoneX: 1@3.
terni putStoneO: 2@2.
terni putStoneX: 3@3.
terni putStoneO: 2@1.

self deny: terni hasAWinner .
self shouldFail:[terni moveStoneX: 3@3 to: 3@1.] withDescription: TerniLapilli  PlayerCannotMoveToInvalidPosition.
self assert: (terni thereIsAnXStoneIn: 3@3).
self deny: (terni thereIsAnXStoneIn: 3@1)


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:20:18'!
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
self assert: (terni thereIsAnXStoneIn: 1@1).
self deny: (terni thereIsAnXStoneIn: 1@2).
self assert: (terni thereIsAnOStoneIn: 1@2).

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:21:09'!
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

self assert: (terni thereIsAnXStoneIn: 1@1).
self assert: (terni thereIsAnXStoneIn: 1@2).

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:24:44'!
test21PlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni playerXWon.
self shouldFail: [terni moveStoneO: 2@1 to: 1@1] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 
self assert: (terni thereIsAnOStoneIn: 2@1).
self deny: (terni thereIsAnOStoneIn: 1@1)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:30:50'!
test22WinnerPlayerCannotMoveIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 3@3.
terni putStoneO: 1@1.

terni moveStoneX: 2@2  to: 3@2. 

self assert: terni hasAWinner.
self assert: terni playerXWon.
self shouldFail: [terni moveStoneX: 3@2 to:2 @2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 
self assert: (terni thereIsAnXStoneIn: 3@2).
self deny: (terni thereIsAnXStoneIn: 2@2)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:31:40'!
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
self assert: terni playerXWon.
self shouldFail: [terni moveStoneO: 3@3 to: 3@2] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 
self assert: (terni thereIsAnOStoneIn: 3@3).
self deny: (terni thereIsAnOStoneIn: 3@2)


! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:46:42'!
test24aPlayerCannotMoveOutsideBordersByExceedingRows

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.



self shouldFail: [terni moveStoneX: 3@1 to: 1@5] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage.
self assert: (terni thereIsAnXStoneIn: 3@1).
self deny: (terni thereIsAnXStoneIn: 1@5)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:57:28'!
test24bPlayerCannotMoveOutsideBordersByExceedingColumns

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.

terni moveStoneX: 2@2 to: 3@2.

self shouldFail: [terni moveStoneO: 3@3 to: 5@1] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage.
self assert: (terni thereIsAnOStoneIn: 3@3).
self deny: (terni thereIsAnOStoneIn: 5@1)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:53:22'!
test24cPlayerCannotMoveOutsideBordersByLoweringRows

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.

terni moveStoneX: 2@2 to: 3@2.

self shouldFail: [terni moveStoneO: 2@1 to: 2@0] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage.
self assert: (terni thereIsAnOStoneIn: 2@1).
self deny: (terni thereIsAnOStoneIn: 2@0)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:53:16'!
test24dPlayerCannotMoveOutsideBordersByLoweringColumns

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@1.
terni putStoneO: 3@3.

.

self shouldFail: [terni moveStoneX: 1@1 to: 0@1] withDescription: TerniLapilli  PlayerCannotPlayOutOfBordersErrorMessage.
self assert: (terni thereIsAnXStoneIn: 1@1).
self deny: (terni thereIsAnXStoneIn: 0@1)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:57:16'!
test25PlayerXMovesWithinTurn

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.



self shouldFail: [terni moveStoneO: 3@3 to: 3@2] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. .
self assert: terni isXTurn.
self assert: (terni thereIsAnOStoneIn: 3@3).
self deny: (terni thereIsAnOStoneIn: 3@2)

! !

!TerniLapilliTests methodsFor: 'testing' stamp: 'AAAM 11/8/2018 15:57:11'!
test26PlayerOMovesWithinTurn

|terni|

terni:= TerniLapilli new.

terni putStoneX: 3@1.
terni putStoneO: 2@1.
terni putStoneX: 2@2.
terni putStoneO: 2@3.
terni putStoneX: 1@2.
terni putStoneO: 3@3.

terni moveStoneX: 1@2 to: 1@1.

self shouldFail: [terni moveStoneX: 1@1 to: 1@2] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. .
self assert: terni isOTurn.
self assert: (terni thereIsAnXStoneIn: 1@1).
self deny: (terni thereIsAnXStoneIn: 1@2)

! !


!TerniLapilliTests methodsFor: 'stringErrorComparer-private' stamp: 'AAAM 11/3/2018 01:51:17'!
shouldFail: aBlockClosure withDescription: aFailureDescription 

	| failedAsExpected |
	
	failedAsExpected := false.
	aBlockClosure
		on: Error - MessageNotUnderstood 
		do: [ :anError | failedAsExpected	:= anError messageText = aFailureDescription ].
		
	failedAsExpected ifFalse: [ Error signal: 'Expected to fail but did not fail' ]! !
