!classDefinition: #CartTest category: #TusLibrosPrueba!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'AAAM 11/25/2018 04:07:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class  invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'AAAM 11/25/2018 04:06:51'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'AAAM 11/25/2018 04:07:50'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
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
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 20:05:24'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:09:11'!
defaultPassword

^'1'! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/24/2018 22:09:27'!
defaultUser 

^'Bob'! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:09:04'!
registeredUsersDefault

|dic|

dic := Dictionary new.
dic at: self defaultUser put: self defaultPassword.
dic at:  'Caro' put: 2.
^dic

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 20:03:43'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]
	! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:17:57'!
test01CannotCreateCartIfTheUserIDIsInvalid

|rest |

rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .


	self
		should: [ rest createCart: 'Trudis' withPassword: self defaultPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
	
			 ]



! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:18:20'!
test02CannotCreateCartIfThePasswordIsInvalid

|rest |

rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .


	self
		should: [ rest createCart:  self defaultUser withPassword: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.

			 ]



! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:18:32'!
test03CreateCartIfBothUserAndPasswordAreCorrect

|rest cartID|


rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:=rest createCart: self defaultUser  withPassword: self defaultPassword .


	self assert: cartID isInteger.
	self assert: (rest listCart: cartID)isEmpty. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:19:13'!
test04CannotAddToCartNotCreatedByThisInterface

|rest " cartID"|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

"cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword ."



		self
		should: [  rest addtoCart: 1 thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotAddToInvalidCartErrorMessage.
			self
			should: [  rest listCart: 1]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anotherError | 
				self assert: anotherError messageText = RestInternalInterface cannotListsInvalidCartErrorMessage.			
				 ]. 
	 
			 ]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:19:36'!
test05CartsCreatedShouldHaveDifferentIDs

|rest cartID cartID2|


rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
cartID2:= rest createCart: 'Caro'  withPassword: 2 .


self assert: (rest listCart: cartID)isEmpty. 
self assert: (rest listCart: cartID2)isEmpty. 	 
self deny: (cartID = cartID2 ). 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:20:04'!
test06CannotAddToCartABookNotSoldByTheEditorial
|rest cartID|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .



		self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemNotSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cart invalidItemErrorMessage.
				self assert: (rest listCart: cartID)isEmpty. 

	 
			 ]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:20:17'!
test07CannotAddToCartNonPositiveNumberOfBooks
|rest cartID|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .



		self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 0 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cart invalidQuantityErrorMessage."preguntar si pueden ser errores de cart o tenemos que cambiar los errores de cart para que reporten a rest"
			self assert: (rest listCart: cartID)isEmpty. 
			 ]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:20:39'!
test08AddingBooksToCartAddsToTheLists
|rest cartID|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore.

	self assert:( (rest listCart: cartID ) includes: (testObjectsFactory itemSellByTheStore asString, ' ' , 1 asString) )."Vamos a tener que agregar un assert de totalPurchases luego"

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 19:21:14'!
test08bAddingMoreThanOneBookToCartAddsToTheLists
|rest cartID|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .
cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore2.
	self assert:( (rest listCart: cartID ) includes: (testObjectsFactory itemSellByTheStore asString, ' ' , 2 asString) )."Vamos a tener que agregar un assert de totalPurchases luego"
	self assert:( (rest listCart: cartID ) includes: (testObjectsFactory itemSellByTheStore2 asString, ' ' , 1 asString) ).
	self assert:( (rest listCart: cartID ) size =2).! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 20:07:14'!
test09CannotCheckOutEmptyCart
|rest cartID|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .


self
should:[rest checkout: cartID withCreditCart: testObjectsFactory notExpiredCreditCard thatExpires: testObjectsFactory  today throught: self  andIsOwnedBy: self defaultUser ]
raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage .
				

	 
			 ]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 20:06:37'!
test10CanNotCheckoutWithAnExpiredCreditCart

|rest cartID|



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
self
should:[rest checkout: cartID withCreditCart: testObjectsFactory expiredCreditCard thatExpires: testObjectsFactory  today throught: self andIsOwnedBy: self defaultUser ]
raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage
	.
				

	 
			 ]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 20:08:47'!
test11CashierDoesNotSaleWhenTheCreditCardHasNoCredit

|rest cartID |



rest:= RestInternalInterface newWithUsers: self registeredUsersDefault AndProducts: testObjectsFactory defaultCatalog .

cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].


rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
self
should:[rest checkout: cartID withCreditCart: testObjectsFactory notExpiredCreditCard thatExpires: testObjectsFactory  today throught: self andIsOwnedBy: self defaultUser ]
raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.	 
			 ]. 
	 ! !


!classDefinition: #Cart category: #TusLibrosPrueba!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Cart methodsFor: 'assertions' stamp: 'AAAM 11/25/2018 04:07:39'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'AAAM 11/25/2018 04:06:44'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


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

!Cart class methodsFor: 'instance creation' stamp: 'AAAM 11/25/2018 04:05:56'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'instance creation' stamp: 'AAAM 11/25/2018 04:06:11'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


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

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/25/2018 05:22:10'!
createCart: aClientID withPassword: aPassword

	self autentify: aClientID  with: aPassword.	
	lastCartID := lastCartID  +1.
	carts at: lastCartID put:( Cart acceptingItemsOf:catalog ).	
	^lastCartID .! !

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/25/2018 05:22:22'!
initializeWith: anAuthotificationApp

	authentification := anAuthotificationApp .
	catalog :=Dictionary new.
	carts := Dictionary new.
	lastCartID:= 0.

! !

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/25/2018 05:19:01'!
initializeWith: anListofUsersAndPassword and: aCatalog 

	authentification := anListofUsersAndPassword .
	catalog := aCatalog .
	carts := Dictionary new.
	
	lastCartID:= 0.

! !


!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 05:12:55'!
addtoCart: aCartID thisNumberOfCopies: aNumber ofThisBook: aBook 
	
	"(catalog keys includes: aBook) ifFalse: [^self error: self class cannotAddToCartInvalidBookErrorMessage ]."
	(carts at: aCartID ifAbsent:[^self error: self class cannotAddToInvalidCartErrorMessage] ) add: aNumber of: aBook .
	! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 20:05:10'!
checkout: aCartID withCreditCart: aCreditCard thatExpires: aDateAndTime throught: aMerchantProcessor andIsOwnedBy: aString 

	|cart sales cashier|
	cart:=  (carts at: aCartID ).
	sales:= OrderedCollection  new.
	
	cashier:= Cashier toCheckout: cart charging: aCreditCard throught: aMerchantProcessor on: aDateAndTime registeringOn: sales.
	
	^cashier checkOut.! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 05:37:13'!
listCart: aCartID

	|currentCart list| 
	currentCart := carts   at:  aCartID  ifAbsent:[^self error: self class cannotListsInvalidCartErrorMessage ].
	list:= OrderedCollection new.
	catalog keys do:[:elem| (currentCart includes: elem )ifTrue:[ list add: elem asString, ' ', (currentCart occurrencesOf: elem) asString ]].
	^list.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInternalInterface class' category: #TusLibrosPrueba!
RestInternalInterface class
	instanceVariableNames: ''!

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/22/2018 20:30:07'!
canNotCreateCartWIthInvalidOwner
	^'No es el usuario o contraseña valido'! !

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
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'AAAM 11/25/2018 05:12:42'!
initializeTotal: aTotal

	total := aTotal .
	items:= OrderedCollection new."items es algo nuev mio"! !

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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AAAM 11/25/2018 19:16:45'!
itemSellByTheStore2Price
	
	^100! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AAAM 11/25/2018 19:17:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self itemSellByTheStore2 put: self itemSellByTheStore2Price;
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


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AAAM 11/25/2018 19:16:31'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
