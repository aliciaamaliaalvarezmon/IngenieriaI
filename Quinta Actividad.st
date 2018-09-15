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

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:41:07'!
- unNumeroDePeano

	^self error: 'No se puede restar un numero menor a un numero mayor o igual'! !

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

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 12:39:30'!
esRestadoA: unNumeroDePeano

	^ unNumeroDePeano previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:02:31'!
vecesDivideA: unNumeroDePeano

^unNumeroDePeano ! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 12:56:26'!
* unNumeroDePeano

^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 12:39:31'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:37:26'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 11:41:45'!
/ unNumeroDePeano

	unNumeroDePeano <= self ifFalse:[self error: 'No se puede dividir por un numero mayor'  ].
	^unNumeroDePeano vecesDivideA: self.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 12:39:31'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^self previous < unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 11:44:41'!
<= unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^true].
	self < unNumeroDePeano ifTrue:[^true].
	
	^false.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 12:39:30'!
esRestadoA: unNumeroDePeano

	^ self previous esRestadoA: unNumeroDePeano previous
	

	! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:07:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:10'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:32'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 12:39:30'!
previous

	^prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 22:15:25'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 11:46:21'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano - self < self ifTrue:[^I].	
	^I +(self vecesDivideA: unNumeroDePeano - self).! !


!classDefinition: #III category: #'Quinta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta Actividad'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
* unNumeroDePeano

^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
/ unNumeroDePeano

	unNumeroDePeano <= self ifFalse:[self error: 'No se puede dividir por un numero mayor'  ].
	^unNumeroDePeano vecesDivideA: self.
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^self previous < unNumeroDePeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
<= unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^true].
	self < unNumeroDePeano ifTrue:[^true].
	
	^false.
! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
esRestadoA: unNumeroDePeano

	^ self previous esRestadoA: unNumeroDePeano previous
	

	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:07:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
previous

	^prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano - self < self ifTrue:[^I].	
	^I +(self vecesDivideA: unNumeroDePeano - self).! !


!classDefinition: #IIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta Actividad'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
* unNumeroDePeano

^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
/ unNumeroDePeano

	unNumeroDePeano <= self ifFalse:[self error: 'No se puede dividir por un numero mayor'  ].
	^unNumeroDePeano vecesDivideA: self.
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^self previous < unNumeroDePeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
<= unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^true].
	self < unNumeroDePeano ifTrue:[^true].
	
	^false.
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
esRestadoA: unNumeroDePeano

	^ self previous esRestadoA: unNumeroDePeano previous
	

	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:07:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
previous

	^prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:03:47'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano - self < self ifTrue:[^I].	
	^I +(self vecesDivideA: unNumeroDePeano - self).! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!