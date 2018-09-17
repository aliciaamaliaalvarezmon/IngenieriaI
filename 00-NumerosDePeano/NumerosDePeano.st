!classDefinition: #I category: #NumerosDePeano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #NumerosDePeano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 18:36:46'!
* unNumeroDePeano

 ^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:41:05'!
- unNumeroDePeano

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:26:08'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue:[^self].
	
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/9/2018 21:57:39'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue:[^false].
	
	^true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/10/2018 00:11:31'!
<= unNumeroDePeano

	(unNumeroDePeano = self) ifTrue:[^true].
	(self < unNumeroDePeano) ifTrue:[^true].
	
	^false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 18:30:37'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'estas tratando de dividir por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 18:31:56'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'no hay numeros negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:54:04'!
esRestadoA: unNumeroDePeano

^ unNumeroDePeano previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 13:02:31'!
vecesDivideA: unNumeroDePeano

^unNumeroDePeano ! !


!classDefinition: #II category: #NumerosDePeano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #NumerosDePeano!
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

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:35:25'!
/ unNumeroDePeano

	unNumeroDePeano <= self ifFalse:[self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor. ].
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

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 18:30:19'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

^'estas tratando de dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:48:45'!
esRestadoA: unNumeroDePeano

	
	^ unNumeroDePeano previous - self previous 
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/17/2018 12:34:09'!
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


!classDefinition: #III category: #NumerosDePeano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #NumerosDePeano!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
* unNumeroDePeano

^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
/ unNumeroDePeano

	unNumeroDePeano <= self ifFalse:[self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor. ].
	^unNumeroDePeano vecesDivideA: self.
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^self previous < unNumeroDePeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
<= unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^true].
	self < unNumeroDePeano ifTrue:[^true].
	
	^false.
! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 18:29:34'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
 
^'estas tratando de dividir por un numero mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
esRestadoA: unNumeroDePeano

	
	^ unNumeroDePeano previous - self previous 
	
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/17/2018 12:34:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
previous

	^prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!III class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:21'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano - self < self ifTrue:[^I].	
	^I +(self vecesDivideA: unNumeroDePeano - self).! !


!classDefinition: #IIII category: #NumerosDePeano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #NumerosDePeano!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
* unNumeroDePeano

^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
- unNumeroDePeano

	^ unNumeroDePeano esRestadoA: self.
	
	
	

	 
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
/ unNumeroDePeano

	unNumeroDePeano <= self ifFalse:[self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor. ].
	^unNumeroDePeano vecesDivideA: self.
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[^false].
	unNumeroDePeano = self ifTrue:[^false].	
	^self previous < unNumeroDePeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
<= unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^true].
	self < unNumeroDePeano ifTrue:[^true].
	
	^false.
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 18:29:58'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

^'estas tratando de dividir por un numero mayor'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
esRestadoA: unNumeroDePeano

	
	^ unNumeroDePeano previous - self previous 
	
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/17/2018 12:34:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
previous

	^prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	]
 ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AAAM 9/15/2018 15:49:25'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano - self < self ifTrue:[^I].	
	^I +(self vecesDivideA: unNumeroDePeano - self).! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!