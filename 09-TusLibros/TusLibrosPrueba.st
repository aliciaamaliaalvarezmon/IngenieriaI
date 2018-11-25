!classDefinition: #CartTest category: #TusLibrosPrueba!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibrosPrueba!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'AAAM 11/22/2018 19:51:32'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard .
	! !


!classDefinition: #RestInternalInterfaceTest category: #TusLibrosPrueba!
TestCase subclass: #RestInternalInterfaceTest
	instanceVariableNames: 'testObjectsFactory authentificationBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/22/2018 20:51:51'!
autenticityOf: aClientID  with: aPassword.

^authentificationBehavior value: aClientID value: aPassword .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 01:26:49'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:09:11'!
defaultPassword

^'1'! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/24/2018 22:09:27'!
defaultUser 

^'Bob'! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:46:51'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/24/2018 23:44:32'!
itemSellByTheStore
	
	^ 'validBook'! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 01:32:16'!
itemSellByTheStorePrice
^10
! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:09:04'!
registeredUsersDefault

|dic|

dic := Dictionary new.
dic at: self defaultUser put: self defaultPassword.
dic at:  'Caro' put: 2.
^dic

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 01:27:19'!
test01CannotCreateCartIfTheUserIDIsInvalid

|rest |

rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: self defaultCatalog .


	self
		should: [ rest createCart: 'Trudis' withPassword: self defaultPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
			self
			should: [  rest listCart:  -1]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anotherError | 
				self assert: anotherError messageText = RestInternalInterface cannotListsInvalidCartErrorMessage.			
				 ]. 
			 ]



! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:24:26'!
test02CannotCreateCartIfThePasswordIsInvalid

|rest |

rest:= RestInternalInterface newWith: self registeredUsersDefault.


	self
		should: [ rest createCart:  self defaultUser withPassword: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
			self
			should: [  rest listCart:  -1]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anotherError | 
				self assert: anotherError messageText = RestInternalInterface cannotListsInvalidCartErrorMessage.			
				 ]. 
			 ]



! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/24/2018 22:28:38'!
test03CreateCartIfBothUserAndPasswordAreCorrect

|rest cartID|



rest:= RestInternalInterface newWith: self registeredUsersDefault .

cartID:=rest createCart: self defaultUser  withPassword: self defaultPassword .


	self assert: cartID isInteger.
	self assert: (rest listCart: cartID)isEmpty. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 01:34:28'!
test04CannotAddToCartNotCreatedByThisInterface

|rest " cartID"|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault  AndProducts: self defaultCatalog .

"cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword ."



		self
		should: [  rest addtoCart: -1 thisNumberOfCopies: 1 ofThisBook: self itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotAddToInvalidCartErrorMessage.
			self
			should: [  rest listCart:  -1]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anotherError | 
				self assert: anotherError messageText = RestInternalInterface cannotListsInvalidCartErrorMessage.			
				 ]. 
	 
			 ]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:12:05'!
test05CartsCreatedShouldHaveDifferentIDs

|rest cartID cartID2|



rest:= RestInternalInterface newWith: self registeredUsersDefault .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
cartID2:= rest createCart: 'Caro'  withPassword: 2 .


self assert: (rest listCart: cartID)isEmpty. 
self assert: (rest listCart: cartID2)isEmpty. 	 
self deny: (cartID = cartID2 ). 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 01:31:19'!
test06CannotAddToCartABookNOtSoldByTheEditorial
|rest cartID|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault  AndProducts: self defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .



		self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: self itemNotSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotAddToCartInvalidBookErrorMessage. 
			
			 ]. 
	 

! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibrosPrueba!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibrosPrueba!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibrosPrueba!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibrosPrueba!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibrosPrueba!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestInternalInterface category: #TusLibrosPrueba!
Object subclass: #RestInternalInterface
	instanceVariableNames: 'authentification carts lastCartID catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/24/2018 22:25:09'!
autentify: aClientID with: aPassword

(authentification  keys includes: aClientID ) ifFalse:[^ self error: self class  canNotCreateCartWIthInvalidOwner ].

(authentification  at: aClientID)  = aPassword ifFalse:[^self error: self class canNotCreateCartWIthInvalidOwner ].

! !

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/25/2018 00:52:26'!
createCart: aClientID withPassword: aPassword

	self autentify: aClientID  with: aPassword.	
	lastCartID := lastCartID  +1.
	carts at: lastCartID put:( Cart acceptingItemsOf:catalog ) .
	^lastCartID .! !

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/25/2018 00:53:25'!
initializeWith: anAuthotificationApp

	authentification := anAuthotificationApp .
	catalog :=Dictionary new.
	carts := Dictionary new.
	lastCartID:= 0.

! !

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/25/2018 01:29:22'!
initializeWith: anListofUsersAndPassword and: aCatalog 

	authentification := anListofUsersAndPassword .
	catalog := aCatalog .
	carts := Dictionary new.
	lastCartID:= 0.

! !


!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 01:36:56'!
addtoCart: aCartID thisNumberOfCopies: aNumber ofThisBook: aBook 
	
	(catalog keys includes: aBook) ifFalse: [^self error: self class cannotAddToCartInvalidBookErrorMessage ].
	(carts at: aCartID ifAbsent:[^self error: self class cannotAddToInvalidCartErrorMessage] ) add: aBook.! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:27:36'!
listCart: aCartID 
	carts  at:  aCartID  ifAbsent:[^self error: self class cannotListsInvalidCartErrorMessage ].
	^OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInternalInterface class' category: #TusLibrosPrueba!
RestInternalInterface class
	instanceVariableNames: ''!

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/22/2018 20:30:07'!
canNotCreateCartWIthInvalidOwner
	^'No es el usuario o contraseña valido'! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:48:43'!
cannotAddToCartInvalidBookErrorMessage
^'cannot add to cart invalid book'! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/24/2018 23:52:54'!
cannotAddToInvalidCartErrorMessage

^'this cart is not valid to the interface'! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:18:32'!
cannotListsInvalidCartErrorMessage

^'Cannot list a cart not  created by this interface'! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/22/2018 20:47:08'!
newWith: anAuthotificationApp

^self new initializeWith: anAuthotificationApp! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 01:28:51'!
newWithUsers: anListofUsersAndPassword  AndProducts: aCatalog
^self new initializeWith: anListofUsersAndPassword and: aCatalog ! !


!classDefinition: #Sale category: #TusLibrosPrueba!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibrosPrueba!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibrosPrueba!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
