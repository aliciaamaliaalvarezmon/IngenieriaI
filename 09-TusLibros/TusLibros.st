!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'AAAM 11/18/2018 01:46:27'!
test09CanNotCheckOutEmpthyCart

	|date  cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	
	
	self 
		should: [cashier doesCheckOut: cart with: creditCard attheDate: date  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier class  invalidCartErrorMessage.
			self assert: cashier noRegistroVentas ]

	! !

!CartTest methodsFor: 'tests' stamp: 'AAAM 11/15/2018 20:45:57'!
test10CheckOutSumSHouldEqualCartTotal

	| cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	
	cart add: 5 of: self itemSellByTheStore.
	
	self assert: (cashier totalCount: cart) = 50.
	! !

!CartTest methodsFor: 'tests' stamp: 'AAAM 11/18/2018 03:25:40'!
test11CanNotCheckOutIfTheTargetIsInvalid
	
	
	|date cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createInvalidCreditCard.
	date := self createValidDate.
	cart add: 5 of: self itemSellByTheStore.
	
	
	self 
	should: [cashier doesCheckOut: cart with: creditCard attheDate: date  ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = cashier class  invalidCreditCardErrorMessage.
		self assert: cashier noRegistroVentas.
		"self assert: noSeHizoElCheckOut"
		]
! !

!CartTest methodsFor: 'tests' stamp: 'AAAM 11/18/2018 03:21:56'!
test12CheckingOutRegistersTheSell
	
	
	|date cart cashier creditCard reception |
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createValidCreditCard.
	date := self createValidDate.
	
	cart add: 5 of: self itemSellByTheStore.
	
	reception:=cashier doesCheckOut: cart with: creditCard attheDate: date.
	 
	self assert: reception = 'OK'.
	self deny: cashier noRegistroVentas.
	
	
	! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'AAAM 11/15/2018 20:36:39'!
createCashier

^Cashier new


	
	! !

!CartTest methodsFor: 'support' stamp: 'AAAM 11/18/2018 01:21:34'!
createInvalidCreditCard
	
	|vencimiento|
	vencimiento :=GregorianMonthOfYear year: (GregorianYear number:2000) month: GregorianMonth september. 
	
	^vencimiento! !

!CartTest methodsFor: 'support' stamp: 'AAAM 11/18/2018 03:16:13'!
createValidCreditCard
	
	|vencimiento|
	vencimiento :=GregorianMonthOfYear year: (GregorianYear number:2021) month: GregorianMonth september. 
	
	^vencimiento! !

!CartTest methodsFor: 'support' stamp: 'AAAM 11/18/2018 03:15:23'!
createValidDate
	
	|vencimiento|
	vencimiento :=GregorianMonthOfYear year: (GregorianYear number:2020) month: GregorianMonth september. 
	
	^vencimiento! !

!CartTest methodsFor: 'support' stamp: 'AAAM 11/15/2018 20:33:07'!
defaultCatalog
	
	|dic|
	dic := Dictionary new.
	dic at:  self itemSellByTheStore put: 10.
	dic at:  self item2SellByTheStore put: 20.
	
	^dic! !

!CartTest methodsFor: 'support' stamp: 'AAAM 11/15/2018 19:18:43'!
item2SellByTheStore
	
	^ 'validBook2'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'AAAM 11/15/2018 20:47:22'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'AAAM 11/15/2018 20:30:21'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.	
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'AAAM 11/15/2018 19:09:56'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'AAAM 11/15/2018 20:43:42'!
precio: anElement

	^catalog at: anElement.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'AAAM 11/15/2018 20:47:58'!
recorreElementos

	|acum|
	acum := 0.
	items do: [:anElement | acum := acum + (self precio: anElement )].
	^acum.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'ventasRegistro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'AAAM 11/18/2018 03:23:42'!
doesCheckOut: aCart with: aCreditCard attheDate: aDateofExpiration
	aCart isEmpty ifTrue:[^ self error: self class invalidCartErrorMessage.].
	(self isExpired: aCreditCard With: aDateofExpiration )  ifTrue:[^self error: self class invalidCreditCardErrorMessage].

	ventasRegistro  add: aCart.
	^ 'OK'! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AAAM 11/15/2018 20:35:32'!
initialize

	ventasRegistro:= OrderedCollection new.

	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AAAM 11/18/2018 03:14:35'!
isExpired: aCreditCard With: aDateofExpiration

	^ aCreditCard < aDateofExpiration.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AAAM 11/15/2018 20:39:30'!
noRegistroVentas

^ventasRegistro  isEmpty .! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AAAM 11/15/2018 20:44:54'!
totalCount: aCart
	
	^aCart recorreElementos.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error handling' stamp: 'AAAM 11/15/2018 18:37:45'!
invalidCartErrorMessage
	^'cannot check out invalid cart'! !

!Cashier class methodsFor: 'error handling' stamp: 'AAAM 11/18/2018 01:59:02'!
invalidCreditCardErrorMessage
	^'The credit card has expirated'! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/15/2018 19:26:56'!
invalidProductErrorMessage
	^'No esta listado el precio del producto'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/15/2018 20:40:40'!
new

	^self basicNew initialize.! !
