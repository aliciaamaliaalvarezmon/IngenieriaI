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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/3/2018 01:49:34'!
test04

|terni|

terni:= TerniLapilli new.

terni playStoneX: 1@1.
terni playStone0: 1@2.


self shouldFail: [terni playStone0: 1@3. ] withDescription: TerniLapilli  PlayerCannotPlayOutOfTurnErrorMessage. 


! !


!classDefinition: #NameOfSubclass category: #'TerniLapilli-Tests'!
Object subclass: #NameOfSubclass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!
