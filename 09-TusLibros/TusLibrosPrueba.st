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
	instanceVariableNames: 'testObjectsFactory debitBehavior lastCreditCartID'
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

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:03:41'!
test01CannotCreateCartIfTheUserIDIsInvalid

|rest |

rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.

	self
		should: [ rest createCart: 'Trudis' withPassword: self defaultPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
		 ]



! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:11:41'!
test02CannotCreateCartIfThePasswordIsInvalid

	|rest |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.

	self
		should: [ rest createCart:  self defaultUser withPassword: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.

			 ]



! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:03:41'!
test03CreateCartIfBothUserAndPasswordAreCorrect

	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.
	cartID:=rest createCart: self defaultUser  withPassword: self defaultPassword .
	
	self assert: cartID isInteger.
	self assert: (rest listCart: cartID)isEmpty. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:03:41'!
test04CannotAddToCartNotCreatedByThisInterface

	|rest |

	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.
	
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

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:03:41'!
test05CartsCreatedShouldHaveDifferentIDs

	|rest cartID cartID2|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.

	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	cartID2:= rest createCart: 'Caro'  withPassword: 2 .

	self assert: (rest listCart: cartID)isEmpty. 
	self assert: (rest listCart: cartID2)isEmpty. 	 
	self deny: (cartID = cartID2 ). 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:27:00'!
test06CannotAddToCartABookNotSoldByTheEditorial
	
	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	
	self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemNotSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cart invalidItemErrorMessage.
				self assert: (rest listCart: cartID)isEmpty. 
		]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:05:38'!
test07CannotAddToCartNonPositiveNumberOfBooks
	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	
	self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 0 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cart invalidQuantityErrorMessage."preguntar si pueden ser errores de cart o tenemos que cambiar los errores de cart para que reporten a rest"
			self assert: (rest listCart: cartID)isEmpty. 
			 ]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:07:33'!
test08AddingBooksToCartAddsToTheLists
	|rest cartID|

	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

	rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore.

	self assert:( (rest listCart: cartID ) at: 1) equals: (testObjectsFactory itemSellByTheStore asString) ."Vamos a tener que agregar un assert de totalPurchases luego"

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 02:02:54'!
test08bAddingMoreThanOneBookToCartAddsToTheLists
	
	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore2.
	self assert: ((rest listCart: cartID ) at: 1) equals: (testObjectsFactory itemSellByTheStore asString).
	self assert: ((rest listCart: cartID ) at: 3) equals: (testObjectsFactory itemSellByTheStore asString).
	self assert: ((rest listCart: cartID ) at: 5) equals: (testObjectsFactory itemSellByTheStore2 asString).
	self assert:( (rest listCart: cartID ) size = 6).
	
	self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 02:55:43'!
test09CannotCheckOutEmptyCart

	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

	self
		should:[rest checkout: cartID withCreditCart: testObjectsFactory notExpiredDate thatExpires: testObjectsFactory  today throught: self  andIsOwnedBy: self defaultUser]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage .
				self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .
	]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 03:05:42'!
test10CanNotCheckoutWithAnExpiredCreditCart

	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

	self
		should:[rest checkout: cartID withCreditCart: testObjectsFactory expiredDate thatExpires: testObjectsFactory  expiredDate throught: self andIsOwnedBy: self defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .
	]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 03:07:31'!
test11CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	|rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

	self
		should:[rest checkout: cartID withCreditCart: testObjectsFactory notExpiredCreditCard thatExpires: testObjectsFactory   notExpiredDate throught: self andIsOwnedBy: self defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .	 
	]. 
	 "Es el cliente Id = nombre del dueño de tarjeta, en parametro?....debo fijarme que quien hace el checkout sea quien creo el carrito? No creo que tenga que fijarme que sea el dueño de la tarjeta, solo asumir que lo es."! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 04:32:07'!
test12DoingCheckOutRegistersTheSell

	|creditCard rest cartID debitedAmout debitedCreditCard total |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	creditCard:=  testObjectsFactory notExpiredCreditCard .
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total:= rest checkout: cartID withCreditCart: 50 thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .

	"self assert: debitedCreditCard = creditCard. "
	self assert: debitedAmout = total.
	self deny: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 03:09:04'!
test13CannotAddTOCartAfterDoingCheckOut
"Estos tests son necesarios dependiendo si el carrito puede ser reutilizado luego de hacer checkOut, Si son reutilizables hay que reever lo que hace listPurchases"
	|creditCard rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	creditCard:=  testObjectsFactory notExpiredCreditCard .	
	rest checkout: cartID withCreditCart: creditCard thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .

	self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotUseCheckedOutCartErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 04:32:32'!
test14CannotShowPurchasesWIthUSerOfPasswordInvalid

	|creditCard rest cartID debitedAmout debitedCreditCard total |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	creditCard:=  testObjectsFactory notExpiredCreditCard .
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total:= rest checkout: cartID withCreditCart: creditCard thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .

"self assert: debitedCreditCard = creditCard." 
	self assert: debitedAmout = total.
	self
		should: [ rest listPurchases: 'Trudis' with: self defaultPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
	].
	self
		should: [ rest listPurchases: 'Trudis' with: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
	].
	self deny: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 03:09:31'!
test15CannotCheckoutCartTwice

	|creditCard rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	creditCard:=  testObjectsFactory notExpiredCreditCard .	
	rest checkout: cartID withCreditCart: creditCard thatExpires: testObjectsFactory notExpiredDate throught: self andIsOwnedBy: self defaultUser .
	
	self
		should: [ rest checkout: cartID withCreditCart: creditCard thatExpires: testObjectsFactory  today throught: self andIsOwnedBy: self defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotUseCheckedOutCartErrorMessage.
	]. ! !


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


!Cart methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 17:45:52'!
list
	
	^items copy.! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'AAAM 11/26/2018 03:28:20'!
createSale

	^ Sale of: total and: cart 
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
	instanceVariableNames: 'expiration owner identification'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CreditCard methodsFor: 'testing' stamp: 'AAAM 12/1/2018 04:08:19'!
isExpiredOn: aDate 
	
	^expiration start < (Month  month: aDate monthIndex year: aDate yearNumber)  start! !


!CreditCard methodsFor: 'initialization' stamp: 'AAAM 12/1/2018 02:36:40'!
initializeExpiringOn: aMonth withOwner: anOwner andID: anID .
	expiration := aMonth. 
	owner:= anOwner .
	identification:= anID .
	"assert validCartID"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibrosPrueba!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AAAM 12/1/2018 02:22:29'!
expiringOn: aMonth withOwner: anOwner andID: anID
	
	^self new initializeExpiringOn: aMonth withOwner: anOwner andID: anID .! !


!classDefinition: #RestInternalInterface category: #TusLibrosPrueba!
Object subclass: #RestInternalInterface
	instanceVariableNames: 'authentification carts lastCartID catalog sales cartsUsers checkedOutCarts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/24/2018 22:25:09'!
autentify: aClientID with: aPassword

(authentification  keys includes: aClientID ) ifFalse:[^ self error: self class  canNotCreateCartWIthInvalidOwner ].

(authentification  at: aClientID)  = aPassword ifFalse:[^self error: self class canNotCreateCartWIthInvalidOwner ].

! !

!RestInternalInterface methodsFor: 'creating' stamp: 'z 11/26/2018 17:55:10'!
createCart: aClientID withPassword: aPassword

	self autentify: aClientID  with: aPassword.	
	lastCartID := lastCartID  +1.
	carts at: lastCartID put:( Cart acceptingItemsOf:catalog ).	
	cartsUsers at: lastCartID  put: aClientID .
	^lastCartID .! !

!RestInternalInterface methodsFor: 'creating' stamp: 'z 11/26/2018 18:00:36'!
initializeWith: anListofUsersAndPassword and: aCatalog

	authentification := anListofUsersAndPassword .
	catalog := aCatalog.
	carts := Dictionary new.
	sales:= OrderedCollection  new.
	checkedOutCarts:=  OrderedCollection  new.
	cartsUsers:= Dictionary new.
	lastCartID:= 0.
	

! !


!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 17:51:54'!
addtoCart: aCartID thisNumberOfCopies: aNumber ofThisBook: aBook 
	
	self assertCartHasNotBeenCheckedOut: aCartID .
	
	^(carts at: aCartID ifAbsent:[^self error: self class cannotAddToInvalidCartErrorMessage] ) add: aNumber of: aBook .
	! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 11/26/2018 04:55:48'!
assertCartHasNotBeenCheckedOut:aCartID


(checkedOutCarts includes: aCartID ) ifTrue:[^self error: self class cannotUseCheckedOutCartErrorMessage]! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 02:58:07'!
checkout: aCartID withCreditCart: aCreditCardID thatExpires: aDateAndTime throught: aMerchantProcessor andIsOwnedBy: aUserID

	|cart total  cashier creditCard|
	self assertCartHasNotBeenCheckedOut: aCartID.
	
	cart:=  (carts at: aCartID ).
	creditCard:= CreditCard expiringOn: aDateAndTime withOwner: aUserID andID: aCreditCardID .
	cashier:= Cashier toCheckout: cart charging: creditCard throught: aMerchantProcessor on: DateAndTime now registeringOn: sales.
	total:=cashier checkOut.  
	checkedOutCarts add: aCartID.
	^total.
	
	! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 02:02:12'!
listCart: aCartID

	|currentCart list| 
	currentCart := carts   at:  aCartID  ifAbsent:[^self error: self class cannotListsInvalidCartErrorMessage ].
	list:= OrderedCollection new.
	"list := currentCart list. do"
	currentCart  list do:[:itemName| list add: itemName. list add: (currentCart occurrencesOf: itemName)].
	
	^list.! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 01:57:21'!
listPurchases: anClientId with: aPassword 

	|list cartIDs cartWithCheckOut salesTotal cartsIDofCheckoutCarts|
	self autentify: anClientId  with: aPassword.	
	cartIDs:= cartsUsers keys select:[:users| (cartsUsers at: users) = anClientId ].
	cartsIDofCheckoutCarts :=checkedOutCarts select:[:ids| cartIDs includes: ids ]. 
	cartWithCheckOut := carts values select:[:elem|  cartsIDofCheckoutCarts  includes: elem ].
	
	list:= OrderedCollection new.
	
	cartsIDofCheckoutCarts do:[:idOfCheckedCarts| list addAll: (self listCart: idOfCheckedCarts )].
	
	list isEmpty ifFalse: [
	salesTotal:=cartWithCheckOut inject: 0 into:[:subtotal :sales| subtotal + sales total] .
	list addLast: salesTotal asString.
	].

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

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/26/2018 04:49:23'!
cannotUseCheckedOutCartErrorMessage
^'already checked out that cart'! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:03:41'!
newWithUsers: anListofUsersAndPassword andProducts: aCatalog
^self new initializeWith: anListofUsersAndPassword and: aCatalog.! !


!classDefinition: #Sale category: #TusLibrosPrueba!
Object subclass: #Sale
	instanceVariableNames: 'total saleCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'AAAM 11/26/2018 03:30:15'!
initializeTotal: aTotal and: aCart

	total := aTotal .
	saleCart := aCart .
	! !


!Sale methodsFor: 'as yet unclassified' stamp: 'AAAM 11/26/2018 03:24:31'!
showCart
	^saleCart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibrosPrueba!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AAAM 11/26/2018 03:29:32'!
of: aTotal and: aCart

	"should assert total is not negative or 0!!"
	"message de arriba creo que es de la catedra. El metodo original era of: solo, cambie para que funcione"
	^self new initializeTotal: aTotal and: aCart .! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/1/2018 04:28:13'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredDate withOwner: 'Bob' andID: 50.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/1/2018 02:55:20'!
expiredDate
	
	^Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/1/2018 04:27:59'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredDate withOwner: 'Bob' andID: 50.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/1/2018 04:01:00'!
notExpiredDate
	
	^Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AAAM 11/25/2018 19:16:31'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
