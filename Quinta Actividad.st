!classDefinition: #I category: #'Quinta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta Actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 18:36:46'!
* unNumeroDePeano

 ^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 22:03:11'!
- unNumeroDePeano

	self error: 'No se puede restar un numero menor a un numero mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 20:27:05'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue:[^self].
	
	^self error: ' No se puede dividir por algo mayor a I y que de entero'! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 21:57:39'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue:[^false].
	
	^true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/10/2018 00:11:31'!
<= unNumeroDePeano

	(unNumeroDePeano = self) ifTrue:[^true].
	(self < unNumeroDePeano) ifTrue:[^true].
	
	^false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 19:14:18'!
* unNumeroDePeano

^ (self + ((unNumeroDePeano prev) * self ))! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:47:13'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 22:01:57'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/10/2018 00:21:59'!
/ unNumeroDePeano

	(unNumeroDePeano <= self) ifFalse:[self error: 'No se puede dividir por un numero mayor'  ].
	^(unNumeroDePeano vecesDivideA: self).
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/10/2018 00:15:45'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^((self prev) < (unNumeroDePeano prev)).! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/10/2018 00:11:07'!
<= unNumeroDePeano

	(unNumeroDePeano = self) ifTrue:[^true].
	(self < unNumeroDePeano) ifTrue:[^true].
	
	^false.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/10/2018 00:32:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:10'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:49:14'!
prev

	^prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:32'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 22:15:25'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/10/2018 00:27:12'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	((unNumeroDePeano - self) < self) ifTrue:[^I].	
	^(I +(self vecesDivideA: (unNumeroDePeano - self))).! !

II initializeAfterFileIn!