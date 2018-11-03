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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/2/2018 22:41:00'!
test02

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.

self assert: terni XStonesinPlay = 1.
self assert: terni OStonesinPlay = 0.
self assert: (terni ThereisAnXStoneIn: 1@1 ).! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 00:37:39'!
test03

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 1@2.

self assert: terni XStonesinPlay = 1.
self assert: terni OStonesinPlay = 1.
self assert: (terni ThereisAnXStoneIn: 1@1 ).
self assert: (terni ThereisAn0StoneIn: 1@2 ).! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 03:31:02'!
test04PlayerOShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 1@2.


self shouldFail: [terni playStone0: 1@3. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:03:23'!
test05PlayerXShouldNotPlayOutsideTurn

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.



self shouldFail: [terni playStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:21:04'!
test06

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 1@2.


self shouldFail: [terni playStoneX: 1@2. ] withDescription: TerniLapilli  PlayerCannotPutAStoneWhereThereIsOneErrorMessage . 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:14:21'!
test07

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 1@2.


self shouldFail: [terni playStoneX: 1@1. ] withDescription: TerniLapilli  PlayerCannotPutAStoneWhereThereIsOneErrorMessage . 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 04:20:35'!
test08

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 1@2.
terni playStoneX: 1@3.
terni playStone0: 2@2.
terni playStoneX: 3@3.
terni playStone0: 2@1.
self shouldFail: [terni playStoneX: 3@2. ] withDescription: TerniLapilli  PlayerCannotPutMoreThanThreeStonesErrorMessage. 


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 18:47:36'!
test09PlayerWInsWIthAFIle

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 1@2.
terni playStoneX: 2@1.
terni playStone0: 2@2.
terni playStoneX: 3@1.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 18:50:13'!
test10PlayerWInsWIthAColunm

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 2@1.
terni playStoneX: 1@2.
terni playStone0: 2@2.
terni playStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 18:54:55'!
test11PlayerWInsWIthAnUpDiagonal

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 2@1.
terni playStoneX: 2@2.
terni playStone0: 2@3.
terni playStoneX: 3@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.


! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 18:56:13'!
test12PlayerWInsWIthAnDownDiagonal

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStone0: 2@1.
terni playStoneX: 2@2.
terni playStone0: 2@3.
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 20:20:25'!
test14CannotPlayIfGameHasEnded

|terni|

terni:= TerniLapilli new.

terni playStoneX: 3@1.
terni playStone0: 2@1.
terni playStoneX: 2@2.
terni playStone0: 2@3.
terni playStoneX: 1@3.


self assert: terni hasAWinner.
self assert: terni winner = $X.
self shouldFail: [terni playStone0: 1@1] withDescription: TerniLapilli  CannotPlayIfGameHasEndedErrorMessage. 

! !


!classDefinition: #NameOfSubclass category: #'TerniLapilli-Tests'!
Object subclass: #NameOfSubclass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!
