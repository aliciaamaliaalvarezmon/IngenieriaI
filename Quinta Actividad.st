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

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:36:13'!
esRestadoA: unNumeroDePeano

	^ unNumeroDePeano prev! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:37:26'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:40:03'!
esRestadoA: unNumeroDePeano

	^ self prev esRestadoA: unNumeroDePeano prev
	

	! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:50:29'!
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

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
* unNumeroDePeano

^ (self + ((unNumeroDePeano prev) * self ))! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
/ unNumeroDePeano

	(unNumeroDePeano <= self) ifFalse:[self error: 'No se puede dividir por un numero mayor'  ].
	^(unNumeroDePeano vecesDivideA: self).
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^((self prev) < (unNumeroDePeano prev)).! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
<= unNumeroDePeano

	(unNumeroDePeano = self) ifTrue:[^true].
	(self < unNumeroDePeano) ifTrue:[^true].
	
	^false.
! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
esRestadoA: unNumeroDePeano

	^ self prev esRestadoA: unNumeroDePeano prev
	

	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:50:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
prev

	^prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:01'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	((unNumeroDePeano - self) < self) ifTrue:[^I].	
	^(I +(self vecesDivideA: (unNumeroDePeano - self))).! !


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

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
* unNumeroDePeano

^ (self + ((unNumeroDePeano prev) * self ))! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
/ unNumeroDePeano

	(unNumeroDePeano <= self) ifFalse:[self error: 'No se puede dividir por un numero mayor'  ].
	^(unNumeroDePeano vecesDivideA: self).
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^((self prev) < (unNumeroDePeano prev)).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
<= unNumeroDePeano

	(unNumeroDePeano = self) ifTrue:[^true].
	(self < unNumeroDePeano) ifTrue:[^true].
	
	^false.
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
esRestadoA: unNumeroDePeano

	^ self prev esRestadoA: unNumeroDePeano prev
	

	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:50:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
prev

	^prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 05:49:06'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	((unNumeroDePeano - self) < self) ifTrue:[^I].	
	^(I +(self vecesDivideA: (unNumeroDePeano - self))).! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!