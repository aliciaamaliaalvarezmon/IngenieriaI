!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'AAAM 9/22/2018 18:05:12'!
inTheCustomerBookWhitoutActiveClients: anCustomerBook shouldStateThisNumberOfCustomers: aState


	self assert: 0 equals: anCustomerBook numberOfActiveCustomers.
	self assert: aState equals: anCustomerBook numberOfSuspendedCustomers.
	self assert: aState equals: anCustomerBook numberOfCustomers.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'na 9/20/2018 21:09:42'!
should: aBlock notTakeMoreThanMiliseconds: aLimit  

| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aLimit ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'na 9/20/2018 21:53:08'!
should: aBlock throwsError: anError asserting: assertBlock

[aBlock value.
self fail.] 
	on: anError 
	do: assertBlock! !

!CustomerBookTest methodsFor: 'testing' stamp: 'na 9/20/2018 21:12:47'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self should: [customerBook addCustomerNamed: 'John Lennon'.] notTakeMoreThanMiliseconds: (50 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'na 9/20/2018 21:14:59'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'.] notTakeMoreThanMiliseconds: (100 * millisecond).
	  
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'na 9/20/2018 21:56:43'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self should: [ customerBook addCustomerNamed: ''.] throwsError: Error asserting:  [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AAAM 9/22/2018 01:08:43'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [ customerBook removeCustomerNamed: 'paul'.] throwsError: NotFound asserting:  [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AAAM 9/22/2018 18:05:30'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney .
	
	self inTheCustomerBookWhitoutActiveClients: customerBook shouldStateThisNumberOfCustomers: 1.

	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AAAM 9/22/2018 18:05:47'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self inTheCustomerBookWhitoutActiveClients: customerBook shouldStateThisNumberOfCustomers: 0.

	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AAAM 9/22/2018 04:38:23'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self theSuspentionShouldFail: customerBook withCustomer: 'Paul McCartney'.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AAAM 9/22/2018 04:43:07'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	
	self theSuspentionShouldFail: customerBook withCustomer: 'John Lennon'.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AAAM 9/22/2018 04:43:33'!
theSuspentionShouldFail: anCustomerBook withCustomer: aName.

	self should:[ anCustomerBook suspendCustomerNamed: aName. ]
		throwsError: CantSuspend 
		asserting: [ :anError | 
			self assert: anCustomerBook numberOfCustomers = 1.
			self assert: (anCustomerBook includesCustomerNamed: 'John Lennon') ]
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers suspended'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:28'!
includesCustomerNamed: aName

	^(customers includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:38'!
isEmpty
	
	^customers isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NicolasRinaldi 9/16/2018 21:55:33'!
initialize

	super initialize.
	customers := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'HAW 9/19/2018 08:41:11'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((customers includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:57'!
numberOfActiveCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NicolasRinaldi 9/16/2018 22:01:43'!
numberOfCustomers
	
	^customers size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AAAM 9/24/2018 13:56:38'!
removeCustomerNamed: aName 
 
	| cantClientes |
	
	cantClientes := self numberOfCustomers.
	customers remove: aName ifAbsent: [].
	suspended remove: aName ifAbsent: [].
	cantClientes = self numberOfCustomers ifFalse: [^aName].
	
	^NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:27:55'!
suspendCustomerNamed: aName 
	
	(customers includes: aName) ifFalse: [^CantSuspend signal].
	
	customers remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
