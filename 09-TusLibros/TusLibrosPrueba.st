!classDefinition: #TusLibrosOnlineTest category: #TusLibrosPrueba!
TestCase subclass: #TusLibrosOnlineTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!


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

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'AAAM 11/21/2018 07:36:01'!
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
			self assert: cashier sells isEmpty.
			]
			! !

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'n 11/21/2018 09:17:13'!
test04CanNotCheckOutIfTheCreditCardIsExpires
	
	
	|date cart cashier creditCard|
	
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

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'n 11/21/2018 09:15:50'!
test05CannotCheckOutIfTheCreditCardIDIsInvalid
	
	
	| date cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createCreditCard: 'Cosme Fulanito' and: 0 thatexpires: self createValidDate withCredit: 5000.
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

!TusLibrosOnlineTest methodsFor: 'cashierTest' stamp: 'n 11/21/2018 09:14:13'!
test08CannotCheckOutIfTheCreditCardHasnoCredit
	
	
	|res date cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createCreditCard: 'Cosme Fulanito' and: 2 thatexpires: self createValidDate withCredit: 0.
	date := self createValidDate.
	
	cart add: 5 of: self itemSellByTheStore.
	
	 
	res:= cashier checkOut: cart with: creditCard attheDate: date.

		self assert: cashier sells isEmpty.
		self assert: res = 'error'.
		
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

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/21/2018 07:19:13'!
createCreditCard: aName  and: aId thatexpires: anExpirationDate withCredit: aCredit
	
	^CreditCard createWithAClientName: aName and: aId thatExpires: anExpirationDate withCredit: aCredit. ! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/21/2018 07:10:04'!
createInvalidDate
	
	|vencimiento|
	vencimiento :=GregorianMonthOfYear year: (GregorianYear number:2022) month: GregorianMonth september. 
	
	^vencimiento! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'z 11/20/2018 15:40:18'!
createMerchantProcessor

	^MerchantProcessor create.! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/21/2018 07:09:58'!
createValidDate
	
	|vencimiento|
	vencimiento :=GregorianMonthOfYear year: (GregorianYear number:2019) month: GregorianMonth september. 
	
	^vencimiento! !

!TusLibrosOnlineTest methodsFor: 'support' stamp: 'AAAM 11/21/2018 07:17:14'!
createdefaultCreditCard
	
	^CreditCard  createWithAClientName: 'Nicanor Del Campo'  and: 5 thatExpires: ( GregorianMonthOfYear year: (GregorianYear number:2020) month: GregorianMonth september) withCredit: 5000.! !

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


!classDefinition: #Cart category: #TusLibrosPrueba!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

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

!classDefinition: 'Cart class' category: #TusLibrosPrueba!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibrosPrueba!
Object subclass: #Cashier
	instanceVariableNames: 'ventasRegistro merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:15:04'!
canDoTheCheckOutWith: aCart and: aCreditCard
	
	|res|

	res:= merchantProcessor processSellWith: aCreditCard and: (self totalCount: aCart).
	
	res = 'OK' ifTrue: [ventasRegistro add: (aCart itemsSold).].
	^res! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 09:56:34'!
cartInvalid

	^self error: self class invalidCartErrorMessage.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:36:40'!
checkOut: aCart with: aCreditCard attheDate: aDateofExpiration

	^(CheckOutState for: aCart with: aCreditCard attheDate: aDateofExpiration from: self) value.
	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 09:56:06'!
creditCardInvalid

	self error: self class invalidCreditCardErrorMessage.! !

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

!classDefinition: 'Cashier class' category: #TusLibrosPrueba!
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


!classDefinition: #CheckOutState category: #TusLibrosPrueba!
Object subclass: #CheckOutState
	instanceVariableNames: 'cashier cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CheckOutState methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:19:11'!
initializeWith: aCashier and: aCreditCard and: aCart

	cashier := aCashier.
	cart := aCart.
	creditCard := aCreditCard.! !

!CheckOutState methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 09:52:25'!
value

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckOutState class' category: #TusLibrosPrueba!
CheckOutState class
	instanceVariableNames: ''!

!CheckOutState class methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:40:13'!
for: aCart with: aCreditCard  attheDate: aDate from: aCashier
	|subClass|
	subClass := self allSubclasses detect: [:aSubClass | aSubClass isFor: aCart and: aCreditCard atthedate: aDate].
	^subClass new initializeWith: aCashier and: aCreditCard and: aCart.	! !

!CheckOutState class methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:27:44'!
isFor: aCart and: aCreditCard atthedate: aDate

	^self subclassResponsibility.! !


!classDefinition: #CanDoTheCheckOut category: #TusLibrosPrueba!
CheckOutState subclass: #CanDoTheCheckOut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CanDoTheCheckOut methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:37:15'!
value
	
	^cashier canDoTheCheckOutWith: cart and: creditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CanDoTheCheckOut class' category: #TusLibrosPrueba!
CanDoTheCheckOut class
	instanceVariableNames: ''!

!CanDoTheCheckOut class methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:28:18'!
isFor: aCart and: aCreditCard atthedate: aDate

	^(aCart isEmpty not) and: [aCreditCard isValid: aDate].! !


!classDefinition: #TheCartIsInvalid category: #TusLibrosPrueba!
CheckOutState subclass: #TheCartIsInvalid
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!TheCartIsInvalid methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:37:07'!
value

	^cashier cartInvalid! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TheCartIsInvalid class' category: #TusLibrosPrueba!
TheCartIsInvalid class
	instanceVariableNames: ''!

!TheCartIsInvalid class methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:28:36'!
isFor: aCart and: aCreditCard atthedate: aDate

	^aCart isEmpty! !


!classDefinition: #TheCreditCartIsInvalid category: #TusLibrosPrueba!
CheckOutState subclass: #TheCreditCartIsInvalid
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!TheCreditCartIsInvalid methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:37:21'!
value

	^cashier creditCardInvalid! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TheCreditCartIsInvalid class' category: #TusLibrosPrueba!
TheCreditCartIsInvalid class
	instanceVariableNames: ''!

!TheCreditCartIsInvalid class methodsFor: 'as yet unclassified' stamp: 'n 11/21/2018 10:28:50'!
isFor: aCart and: aCreditCard atthedate: aDate

	^(aCreditCard isValid: aDate) not! !


!classDefinition: #CreditCard category: #TusLibrosPrueba!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate clientName credit identificartion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AAAM 11/21/2018 07:25:19'!
credit

^ credit! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AAAM 11/21/2018 07:12:01'!
initializeWithAClientName: aName and: anID thatExpires: aExpirationDate withCredit: aNumber

	clientName := aName.
	expirationDate := aExpirationDate .
	credit := aNumber.
	identificartion := anID .! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AAAM 11/21/2018 07:42:18'!
isValid: aDateOfExpiration

^ (aDateOfExpiration <= expirationDate ) and: (identificartion > 0).! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AAAM 11/21/2018 07:32:17'!
reducirSaldo: aTotalAmount 

credit := credit  - aTotalAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibrosPrueba!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/21/2018 07:16:35'!
createWithAClientName: aName and: anID thatExpires: aExpirationDate withCredit: aNumber.

 ^(self new) initializeWithAClientName: aName and: anID thatExpires: aExpirationDate withCredit: aNumber.  ! !


!classDefinition: #MerchantProcessor category: #TusLibrosPrueba!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'historial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 15:39:53'!
initialize


historial := OrderedCollection new! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'AAAM 11/18/2018 19:40:50'!
isEmpty


^historial isEmpty 
! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'AAAM 11/21/2018 07:35:11'!
processSellWith: aCreditCard and: aTotalAmount

|res|

(aCreditCard  credit < aTotalAmount) ifTrue:[ res:= 'error'] ifFalse:[res:= 'OK'. aCreditCard reducirSaldo: aTotalAmount ].

historial add: res.
^res! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibrosPrueba!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'z 11/20/2018 15:39:42'!
create

^self new initialize.! !
