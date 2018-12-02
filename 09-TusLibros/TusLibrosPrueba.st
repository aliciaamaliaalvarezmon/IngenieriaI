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

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:14:05'!
invalidCreditCartID


	
	^'000000000000001'! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 11/25/2018 00:09:04'!
registeredUsersDefault

|dic|

dic := Dictionary new.
dic at: self defaultUser put: self defaultPassword.
dic at:  'Caro' put: 2.
^dic

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:13:27'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	
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

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 21:13:43'!
test04CannotAddToCartNotCreatedByThisInterface

	|rest |

	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.
	
	self
		should: [  rest addtoCart: 1 thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotAddToInvalidCartErrorMessage.
			
	]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 21:13:32'!
test04bCannotListCartNotCreatedByThisInterface

	|rest |

	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog.
	
	self
		should: [  rest listCart: 1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anotherError | 
			self assert: anotherError messageText = RestInternalInterface cannotListsInvalidCartErrorMessage.			
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

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 22:12:24'!
test08bAddingMoreThanOneBookToCartAddsToTheLists
	
	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore2.
	self assert: ((rest listCart: cartID ) at: 1) equals: (testObjectsFactory itemSellByTheStore asString).
	self assert: ((rest listCart: cartID ) at: 2) equals: 2.
	self assert: ((rest listCart: cartID ) at: 3) equals: (testObjectsFactory itemSellByTheStore2 asString).
	self assert: ((rest listCart: cartID ) at: 4) equals: 1.
	self assert:( (rest listCart: cartID ) size = 4).
	
	self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:17:03'!
test09CannotCheckOutEmptyCart

	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

	self
		should:[rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  today throught: self  andIsOwnedBy: self defaultUser]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage .
				self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .
	]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:16:53'!
test10CanNotCheckoutWithAnExpiredCreditCart

	|rest cartID|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

	self
		should:[rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  expiredDate throught: self andIsOwnedBy: self defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .
	]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:16:44'!
test11CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	|rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .

	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

	self
		should:[rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory   notExpiredDate throught: self andIsOwnedBy: self defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .	 
	]. 
! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:16:28'!
test12DoingCheckOutRegistersTheSell

	|creditCard rest cartID debitedAmout debitedCreditCard total |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	creditCard:=  testObjectsFactory notExpiredCreditCard .
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total:= rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .

	"self assert: debitedCreditCard = creditCard. "
	self assert: debitedAmout = total.
	self deny: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:16:15'!
test13CannotAddTOCartAfterDoingCheckOut
"Estos tests son necesarios dependiendo si el carrito puede ser reutilizado luego de hacer checkOut, Si son reutilizables hay que reever lo que hace listPurchases"
	| rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
.	
	rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .

	self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotUseCheckedOutCartErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:16:08'!
test14CannotShowPurchasesWIthUSerOfPasswordInvalid

	| rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	
	 rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .


	self
		should: [ rest listPurchases: 'Trudis' with: self defaultPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
	].
	self
		should: [ rest listPurchases: self defaultUser with: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
	].
	self deny: (rest listPurchases: self defaultUser with: self defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:30:17'!
test15CannotCheckoutCartTwice

	| rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
		
	rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory notExpiredDate throught: self andIsOwnedBy: self defaultUser .
	
	self
		should: [ rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  today throught: self andIsOwnedBy: self defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotUseCheckedOutCartErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:15:15'!
test16CannotCheckoutCartAfter30MinutesHavePassed
	| rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
		
	rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory notExpiredDate throught: self andIsOwnedBy: self defaultUser .
! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:15:06'!
test17CannotCheckoutCartNotCreatedByUser
	| rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	.	

self
		should: [ rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  today throught: self andIsOwnedBy: 'Maria' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotUseCartsOfOthersErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:52:56'!
test18ShowPurchasesShowsCorrectValues
	
	|purchases rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	 rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .


purchases:= rest listPurchases: self defaultUser with: self defaultPassword.
self deny: purchases  isEmpty .
self assert: purchases elements size = 1.
self assert: (purchases ocurrencesOf: testObjectsFactory itemSellByTheStore ) =4.
self assert: purchases total = (testObjectsFactory itemSellByTheStorePrice *4) .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:22:17'!
test19CannotCheckOutWithInvalidId
	
	| rest cartID |
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	
	self
		should: [ rest checkout: cartID withCreditCart: self invalidCreditCartID thatExpires: testObjectsFactory notExpiredDate  throught: self andIsOwnedBy: self defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = CreditCard cannotCreateWithInvalidTargetIDErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:58:22'!
test20ShowPurchasesCollectsSalesOfMultipleCarts
	
	|purchases rest cartID cartID2|
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog .
	cartID:= rest createCart: self defaultUser  withPassword: self defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	 rest checkout: cartID withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .

cartID2:= rest createCart: self defaultUser  withPassword: self defaultPassword.
rest addtoCart: cartID2 thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

purchases:= rest listPurchases: self defaultUser with: self defaultPassword.
self deny: purchases  isEmpty .
self assert: purchases elements size = 1.
self assert: (purchases ocurrencesOf: testObjectsFactory itemSellByTheStore ) =4.
self assert: purchases total = (testObjectsFactory itemSellByTheStorePrice *4) .

rest checkout: cartID2 withCreditCart: self validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: self defaultUser .

purchases:= rest listPurchases: self defaultUser with: self defaultPassword.
self deny: purchases  isEmpty .
self assert: purchases elements size = 1.
self assert: (purchases ocurrencesOf: testObjectsFactory itemSellByTheStore ) =6.
self assert: purchases total = (testObjectsFactory itemSellByTheStorePrice *6) .! !

!RestInternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:13:50'!
validCreditCartID


	
	^'0000000000000001'! !


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


!Cart methodsFor: 'initialization' stamp: 'AAAM 12/1/2018 21:50:56'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'AAAM 12/1/2018 21:53:22'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'AAAM 12/1/2018 21:52:59'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'AAAM 12/1/2018 21:52:34'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	items add: anItem withOccurrences: aQuantity.

! !


!Cart methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 22:11:32'!
list
	
	^items contents keys copy.! !

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


!classDefinition: #CartSession category: #TusLibrosPrueba!
Object subclass: #CartSession
	instanceVariableNames: 'cart cartID sessionOwner checkedOut restInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!CartSession methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 23:11:20'!
addtoCartThisNumberOfCopies: aNumber ofThisBook: aBook.

self assertCartHasNotBeenCheckedOut: sessionOwner .

cart add: aNumber of: aBook .! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 23:02:44'!
assertCartHasNotBeenCheckedOut: aCartID.

checkedOut  ifTrue:[^restInterface cartHasAlreadyBeenCheckedOut ]! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 00:51:20'!
assertTheClientOwnsTheCart: aUserID .

(sessionOwner  = aUserID )ifFalse:[^restInterface cartHasNotBeenCreatedByOwner]! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 01:32:09'!
checkOut: aCartID withCreditCard: aCreditCardID  thatExpires: aDateAndTime throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales

	|creditCard cashier total sale|
	self assertCartHasNotBeenCheckedOut: aCartID.
	self assertTheClientOwnsTheCart: aUserID .
	
	sale:= OrderedCollection  new.
	creditCard:= CreditCard expiringOn: aDateAndTime withOwner: aUserID andID: aCreditCardID .
	cashier:= Cashier toCheckout: cart charging: creditCard throught: aMerchantProcessor on: DateAndTime now registeringOn: sales.
	
	
	total:=cashier checkOut.  
	checkedOut:= true.
	^total.
	! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 00:45:04'!
initializeCartSession: aCart with: anCartID andOwner: anOwnerID by:aRestInterface

cart := aCart .
cartID := anCartID .
sessionOwner := anOwnerID.
checkedOut := false .
restInterface := aRestInterface .! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 22:00:09'!
listCart

|itemlist|

	itemlist:= OrderedCollection new.
	
	cart list do:[:itemName| itemlist add: itemName. itemlist add: (cart occurrencesOf: itemName)].
	
	^itemlist.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibrosPrueba!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 22:57:22'!
createCartSession: aCart withID: anCartID andOwner: anOwnerID byInterface: aRest

^self new initializeCartSession: aCart with: anCartID andOwner: anOwnerID by: aRest .! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'AAAM 12/2/2018 03:50:24'!
createSale

	^ Sale of: creditCard owner and: (Ticket of: cart ) 
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AAAM 12/2/2018 04:10:40'!
registerSale

|custumerSales|
	custumerSales:= salesBook detect:[:sale| sale isCustomer: creditCard owner ]ifNone:[salesBook add: self createSale. ^self ].
	
	custumerSales addToTicket: cart! !


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


!CreditCard methodsFor: 'initialization' stamp: 'AAAM 12/2/2018 05:23:45'!
initializeExpiringOn: aMonth withOwner: anOwner andID: anID .

self assertValidID: anID.
	expiration := aMonth. 
	owner:= anOwner .
	identification:= anID .
	"assert validCartID"! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:28:38'!
assertValidID: anID.

(anID size = 16 and: anID  asInteger  > 0) ifFalse:[^self error: self class cannotCreateWithInvalidTargetIDErrorMessage]! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 01:35:06'!
identity

^identification ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 01:34:41'!
owner

^owner ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibrosPrueba!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AAAM 12/2/2018 05:23:16'!
cannotCreateWithInvalidTargetIDErrorMessage

^'The ID is invalid'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'AAAM 12/1/2018 02:22:29'!
expiringOn: aMonth withOwner: anOwner andID: anID
	
	^self new initializeExpiringOn: aMonth withOwner: anOwner andID: anID .! !


!classDefinition: #ManualClock category: #TusLibrosPrueba!
Object subclass: #ManualClock
	instanceVariableNames: 'clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!ManualClock methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 19:35:48'!
initializeClock: anStartDateAndTime

clock:= anStartDateAndTime .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #TusLibrosPrueba!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 19:34:55'!
initialization: anStartMoment

^self new initializeClock: anStartMoment .! !


!classDefinition: #RestInternalInterface category: #TusLibrosPrueba!
Object subclass: #RestInternalInterface
	instanceVariableNames: 'authentification cartsSessions lastCartID catalog sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 11/24/2018 22:25:09'!
autentify: aClientID with: aPassword

(authentification  keys includes: aClientID ) ifFalse:[^ self error: self class  canNotCreateCartWIthInvalidOwner ].

(authentification  at: aClientID)  = aPassword ifFalse:[^self error: self class canNotCreateCartWIthInvalidOwner ].

! !

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 12/1/2018 22:58:00'!
createCart: aClientID withPassword: aPassword

	self autentify: aClientID  with: aPassword.	
	lastCartID := lastCartID  +1.
	cartsSessions at: lastCartID  put:(CartSession createCartSession: (Cart acceptingItemsOf: catalog) withID: lastCartID andOwner: aClientID byInterface: self ).
	^lastCartID .! !

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 12/1/2018 23:40:04'!
initializeWith: anListofUsersAndPassword and: aCatalog

	authentification := anListofUsersAndPassword .
	catalog := aCatalog.

	sales:= OrderedCollection  new.
	
	cartsSessions:= Dictionary  new.
	
	lastCartID:= 0.
	

! !


!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 23:11:32'!
addtoCart: aCartID thisNumberOfCopies: aNumber ofThisBook: aBook 
	
	
	
	^(cartsSessions at: aCartID ifAbsent:[^self error: self class cannotAddToInvalidCartErrorMessage] ) addtoCartThisNumberOfCopies: aNumber ofThisBook: aBook.
	! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 23:03:09'!
cartHasAlreadyBeenCheckedOut

^ self error: self class cannotUseCheckedOutCartErrorMessage! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 00:52:05'!
cartHasNotBeenCreatedByOwner

^ self error: self class cannotUseCartsOfOthersErrorMessage! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 01:31:33'!
checkout: aCartID withCreditCart: aCreditCardID thatExpires: aDateAndTime throught: aMerchantProcessor andIsOwnedBy: aUserID

	|session |
	
	
	session := cartsSessions  at: aCartID.
	^ session checkOut: aCartID withCreditCard: aCreditCardID  thatExpires: aDateAndTime throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales.
	

	! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 20:32:45'!
listCart: aCartID

	|currentsession| 
	currentsession := cartsSessions   at:  aCartID ifAbsent:[^self error: self class cannotListsInvalidCartErrorMessage ].
	^currentsession  listCart
! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/1/2018 21:46:30'!
listPurchases2: anClientId with: aPassword 

	|list cartIDs cartWithCheckOut salesTotal cartsIDofCheckoutCarts|
	self autentify: anClientId  with: aPassword.	
	cartIDs:= cartsSessions keys select:[:users| (cartsSessions at: users) = anClientId ].
	cartsIDofCheckoutCarts :=checkedOutCarts select:[:ids| cartIDs includes: ids ]. 
	cartWithCheckOut := cartsSessions values select:[:elem|  cartsIDofCheckoutCarts  includes: elem ].
	
	list:= OrderedCollection new.
	
	cartsIDofCheckoutCarts do:[:idOfCheckedCarts| list addAll: (self listCart: idOfCheckedCarts )].
	
	list isEmpty ifFalse: [
	salesTotal:=cartWithCheckOut inject: 0 into:[:subtotal :sales| subtotal + sales total] .
	list addLast: salesTotal asString.
	].

	^list.! !

!RestInternalInterface methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:56:52'!
listPurchases: anClientId with: aPassword 

	| saleOfClient|
	
	self autentify: anClientId  with: aPassword.	
	
	saleOfClient:= sales detect:[:sale| sale isCustomer: anClientId ] ifNone:[^OrderedCollection  new].
	
	^saleOfClient ticket.
	


	
 ! !

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

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 00:52:31'!
cannotUseCartsOfOthersErrorMessage
^'The user did not create the cart'! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/26/2018 04:49:23'!
cannotUseCheckedOutCartErrorMessage
^'already checked out that cart'! !

!RestInternalInterface class methodsFor: 'as yet unclassified' stamp: 'z 11/26/2018 18:03:41'!
newWithUsers: anListofUsersAndPassword andProducts: aCatalog
^self new initializeWith: anListofUsersAndPassword and: aCatalog.! !


!classDefinition: #Sale category: #TusLibrosPrueba!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Sale methodsFor: 'total' stamp: 'AAAM 12/2/2018 03:48:14'!
ticket
	
	^ ticket! !


!Sale methodsFor: 'initialization' stamp: 'AAAM 12/2/2018 01:53:10'!
initializeTotal: anOwner and: aTicket

	ticket := aTicket .
	customer := anOwner .
	! !


!Sale methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:11:48'!
addToTicket: cart

ticket addToTicket: cart! !

!Sale methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:03:51'!
isCustomer: anClientId 

^(customer  = anClientId )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibrosPrueba!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AAAM 12/2/2018 01:52:17'!
of: anOwner and: aTicket

	"should assert total is not negative or 0!!"
	"message de arriba creo que es de la catedra. El metodo original era of: solo, cambie para que funcione"
	^self new initializeTotal: anOwner and: aTicket .! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/2/2018 05:29:33'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredDate withOwner: 'Bob' andID: '5000000000000000'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/1/2018 02:55:20'!
expiredDate
	
	^Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/2/2018 05:27:40'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredDate withOwner: 'Bob' andID: '5000000000000000'.! !

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


!classDefinition: #Ticket category: #TusLibrosPrueba!
Object subclass: #Ticket
	instanceVariableNames: 'total elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosPrueba'!

!Ticket methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:57:54'!
addToTicket: cart

cart list do:[:item| elements add: item  withOccurrences: (cart  occurrencesOf: item)].
total := total + cart total.! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:51:29'!
createOf: aCart 


elements:= Bag new.
total :=0.
self addToTicket: aCart.

! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:34:19'!
elements

^elements contents keys copy.
! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 05:00:30'!
isEmpty

^self elements isEmpty ! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:33:19'!
ocurrencesOf: anItem

^ elements occurrencesOf:  anItem .

! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:42:58'!
purchases

|list|
	list:= Dictionary new.
	
	self elements  do:[:item| list at: item put: (self  ocurrencesOf: item )].
	
	^list
	




! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 04:27:44'!
total

^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibrosPrueba!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'as yet unclassified' stamp: 'AAAM 12/2/2018 01:51:03'!
of: aCart

^self new createOf: aCart ! !
