!classDefinition: #TusLibrosOnlineTest category: #TusLibros!
TestCase subclass: #TusLibrosOnlineTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'z 11/20/2018 19:02:47'!
test01ANewCashierDoNotHaveSells

	|cashier|
	
	cashier := self createCashier.
	
	self assert: cashier sells isEmpty.! !

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'z 11/20/2018 16:33:43'!
test02CashierTotalCountOfProductsPricesIsEqualToCartTotalSum

	| cart cashier|
	
	cart := self createCart.
	cashier := self createCashier.
	
	cart add: 5 of: self itemSellByTheStore.
	
	self assert: (cashier totalCount: cart) = (cart totalSumOfProductsPricesInTheCart).! !

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'z 11/20/2018 19:02:47'!
test03CanNotCheckOutEmptyCart

	| date  cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	date := self createValidDate.
	creditCard := self createdefaultCreditCard.
	
	self 
		should: [cashier checkOut: cart with: creditCard attheDate: date]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier class  invalidCartErrorMessage.
			self assert: cashier sells isEmpty.]
			! !

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'z 11/20/2018 19:02:47'!
test04CanNotCheckOutIfTheCreditCardIsInvalid
	
	
	| date cart cashier creditCard|
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createdefaultCreditCard .
	date := self createInvalidDate.
	cart add: 5 of: self itemSellByTheStore.
	
	self 
	should: [cashier checkOut: cart with: creditCard attheDate: date]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = cashier class  invalidCreditCardErrorMessage.
		self assert: cashier sells isEmpty.
		]! !

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'z 11/20/2018 19:02:47'!
test05CannotCheckOutIfTarjetIDIsInvalid
	
	
	| date cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createCreditCard: 'Cosme Fulanito' thatexpires: self createValidDate withCredit: 5000.
	date := self createValidDate.
	
	cart add: 5 of: self itemSellByTheStore.
	
	self 
	should: [ cashier checkOut: cart with: creditCard attheDate: date]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = cashier class  invalidCreditCardErrorMessage.
		self assert: cashier sells isEmpty.
		]
! !

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'n 11/21/2018 01:22:48'!
test06CheckingOutRegistersTheSell
	
	
	|date cart cashier creditCard reception|
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createdefaultCreditCard .
	date := self createValidDate.
	
	cart add: 5 of: self itemSellByTheStore.
	
	reception:=cashier checkOut: cart with: creditCard attheDate: date.
	 
	self assert: reception = 'OK'.
	self assert: (cashier sells at: 1) = 'validBook 10 5'.
	self deny: cashier sells isEmpty.
	
	! !

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'n 11/21/2018 01:32:10'!
test07ACashierCanRememberSells
	
	|date cart1 cart2 cart3 cashier creditCard reception1 reception2 reception3|
	
	cart1 := self createCart.
	cashier := self createCashier.
	creditCard := self createdefaultCreditCard .
	date := self createValidDate.
	
	cart1 add: 5 of: self itemSellByTheStore.
	 
	cart2 := self createCart.
	cart2 add: 5 of: self itemSellByTheStore.
	
	cart3 := self createCart.
	cart3 add: 5 of: self itemSellByTheStore.
	
	reception1:=cashier checkOut: cart1 with: creditCard attheDate: date.
	reception2:=cashier checkOut: cart2 with: creditCard attheDate: date.
	reception3:=cashier checkOut: cart3 with: creditCard attheDate: date.
	
	self assert: reception1 = 'OK'.
	self assert: reception2 = 'OK'.
	self assert: reception3 = 'OK'.
	
	self assert: cashier sells size = 3.
	self assert: (cashier sells at: 1) = 'validBook 10 5'.
	self assert: (cashier sells at: 2) = 'validBook 10 5'.
	self assert: (cashier sells at: 3) = 'validBook 10 5'.
	self deny: cashier sells isEmpty.
	
		! !


!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!TusLibrosOnlineTest methodsFor: 'cartTests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!TusLibrosOnlineTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'z 11/20/2018 15:40:46'!
createCashier

^Cashier to: (MerchantProcessor create).


	
	! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'z 11/20/2018 18:46:45'!
createCreditCard: aName thatexpires: anExpirationDate withCredit: aCredit
	
	^CreditCard createWithAClientName: aName thatExpires: anExpirationDate withCredit: aCredit. ! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/18/2018 18:48:17'!
createInvalidDate
	
	|vencimiento|
	vencimiento :=GregorianMonthOfYear year: (GregorianYear number:2022) month: GregorianMonth september. 
	
	^vencimiento! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'z 11/20/2018 15:40:18'!
createMerchantProcessor

	^MerchantProcessor create.! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/18/2018 18:44:51'!
createValidDate
	
	|vencimiento|
	vencimiento :=GregorianMonthOfYear year: (GregorianYear number:2019) month: GregorianMonth september. 
	
	^vencimiento! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'z 11/20/2018 18:45:24'!
createdefaultCreditCard
	
	^CreditCard  createWithAClientName: 'Nicanor Del Campo' thatExpires: ( GregorianMonthOfYear year: (GregorianYear number:2020) month: GregorianMonth september) withCredit: 5000.! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/15/2018 20:33:07'!
defaultCatalog
	
	|dic|
	dic := Dictionary new.
	dic at:  self itemSellByTheStore put: 10.
	dic at:  self item2SellByTheStore put: 20.
	
	^dic! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/15/2018 19:18:43'!
item2SellByTheStore
	
	^ 'validBook2'! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
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


!Cart methodsFor: 'initialization' stamp: 'n 11/21/2018 01:09:31'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.	
	items := Dictionary new.! !


!Cart methodsFor: 'queries' stamp: 'n 11/21/2018 01:28:33'!
occurrencesOf: anItem

	^items at: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'n 11/21/2018 01:27:35'!
includes: anItem

	^items includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'n 11/21/2018 01:26:49'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items at: anItem ifPresent: [items at: anItem put: ((items at: anItem) + aQuantity)] ifAbsent: [items at: anItem put: aQuantity]. ! !


!Cart methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 01:22:32'!
itemsSold
	
	|string|
	string := String new.
	(items keys) do: [:anElement | string := string , (anElement asString, ' ', (self price: anElement) asString, ' ', (items at: anElement) asString)].
	^string! !

!Cart methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 19:02:21'!
price: anElement

	^catalog at: anElement.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 01:20:14'!
totalSumOfProductsPricesInTheCart

	|acum|
	acum := 0.
	(items keys) do: [:anElement | acum := acum + (self price: anElement )].
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
	instanceVariableNames: 'ventasRegistro merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 21:18:53'!
checkOut: aCart with: aCreditCard attheDate: aDateofExpiration
	
	aCart isEmpty ifTrue:[^ self error: self class invalidCartErrorMessage.].
	(aCreditCard isValid: aDateofExpiration )  ifFalse:[^self error: self class invalidCreditCardErrorMessage].

	ventasRegistro add: (aCart itemsSold).
	^ merchantProcessor processSellWith: aCreditCard and: (self totalCount: aCart).! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 21:18:23'!
initializeWith: aMerchantProcessor

	ventasRegistro:= OrderedCollection new.
	merchantProcessor := aMerchantProcessor.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AAAM 11/18/2018 03:14:35'!
isExpired: aCreditCard With: aDateofExpiration

	^ aCreditCard < aDateofExpiration.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 01:06:24'!
sells

	^ventasRegistro copy.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 12:04:17'!
totalCount: aCart
	
	^aCart totalSumOfProductsPricesInTheCart.
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

!Cashier class methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 15:33:16'!
to: aMerchantProcessor

	^self new initializeWith: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate clientName credit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 18:45:44'!
initializeWithAClientName: aName thatExpires: aExpirationDate withCredit: aNumber

	clientName := aName.
	expirationDate := aExpirationDate .
	credit := aNumber.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 18:29:40'!
isValid: aDateOfExpiration

^ (aDateOfExpiration < expirationDate ) and: (credit > 0).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 18:45:44'!
createWithAClientName: aName thatExpires: aExpirationDate withCredit: aNumber.

 ^(self new) initializeWithAClientName: aName thatExpires: aExpirationDate withCredit: aNumber.  ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/18/2018 16:44:34'!
with:  anId thatExpires:  aDateOfExpiration

 ^self new intializeWith: anId thatExpires: aDateOfExpiration ! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'historial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 15:39:53'!
initialize


historial := OrderedCollection new! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'AAAM 11/18/2018 19:40:50'!
isEmpty


^historial isEmpty 
! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'AAAM 11/18/2018 19:40:09'!
processSellWith: aCreditCard and: aTotalAmount

|res|
res:= 'OK'.
historial add: res.
^res! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibros!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 15:39:42'!
create

^self new initialize.! !
