!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!classDefinition: #RestInternalInterfaceTest category: #TusLibros!
TestCase subclass: #RestInternalInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior rest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:23:07'!
test01CannotCreateCartIfTheUserIDIsInvalid


	self
		should: [ rest createCart: 'Trudis' withPassword: testObjectsFactory defaultPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
		 ]



! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:23:11'!
test02CannotCreateCartIfThePasswordIsInvalid


	self
		should: [ rest createCart:  testObjectsFactory defaultUser withPassword: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.

			 ]



! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:23:29'!
test03CreateCartIfBothUserAndPasswordAreCorrect

	|cartID |

	cartID:=rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	
	self assert: cartID isInteger.
	self assert: (rest listCart: cartID)isEmpty. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:23:35'!
test04CannotAddToCartNotCreatedByThisInterface

	self
		should: [  rest addtoCart: 1 thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotAddToInvalidCartErrorMessage.
			
	]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:23:41'!
test04bCannotListCartNotCreatedByThisInterface


	self
		should: [  rest listCart: 1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anotherError | 
			self assert: anotherError messageText = RestInternalInterface cannotListsInvalidCartErrorMessage.			
		 ]. 
 
	 

! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:23:51'!
test05CartsCreatedShouldHaveDifferentIDs

	| cartID cartID2 |


	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	cartID2:= rest createCart: 'Caro'  withPassword: 2 .

	self assert: (rest listCart: cartID)isEmpty. 
	self assert: (rest listCart: cartID2)isEmpty. 	 
	self deny: (cartID = cartID2 ). 

! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 05:08:10'!
test06CannotAddToCartABookNotSoldByTheEditorial
	
	|cartID|
	
	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	
	self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemNotSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface invalidItemErrorMessage.
				self assert: (rest listCart: cartID)isEmpty. 
		]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 05:09:03'!
test07CannotAddToCartNonPositiveNumberOfBooks
	| cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	
	self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 0 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface invalidQuantityErrorMessage."preguntar si pueden ser errores de cart o tenemos que cambiar los errores de cart para que reporten a rest"
			self assert: (rest listCart: cartID)isEmpty. 
			 ]. 
	 

! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:24:24'!
test08AddingBooksToCartAddsToTheLists
	| cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .

	rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore.

	self assert:( (rest listCart: cartID ) at: 1) equals: (testObjectsFactory itemSellByTheStore asString) .! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 12:53:49'!
test08bAddingMoreThanOneBookToCartAddsToTheLists
	
	| cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .

	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore2.
	self assert: ((rest listCart: cartID ) at: 1) equals: (testObjectsFactory itemSellByTheStore asString).
	self assert: ((rest listCart: cartID ) at: 2) equals: 2.
	self assert: ((rest listCart: cartID ) at: 3) equals: (testObjectsFactory itemSellByTheStore2 asString).
	self assert: ((rest listCart: cartID ) at: 4) equals: 1.
	self assert:( (rest listCart: cartID ) size = 4).
	
	self assert: (rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 05:07:14'!
test09CannotCheckOutEmptyCart

	|cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .

	self
		should:[rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  today throught: self  andIsOwnedBy: testObjectsFactory defaultUser]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cartCanNotBeEmptyErrorMessage .
				self assert: (rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword )isEmpty .
	]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 05:06:06'!
test10CanNotCheckoutWithAnExpiredCreditCart

	| cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

	self
		should:[rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  expiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword )isEmpty .
	]. 
	 ! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 05:08:47'!
test11CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .

	debitBehavior := [ :anAmount :aCreditCard | self error: RestInternalInterface creditCardHasNoCreditErrorMessage].
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

	self
		should:[rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory   notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface creditCardHasNoCreditErrorMessage.
			self assert: (rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword )isEmpty .	 
	]. 
! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:25:32'!
test12DoingCheckOutRegistersTheSell

	|creditCard cartID debitedAmout debitedCreditCard total   |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	creditCard:=  testObjectsFactory notExpiredCreditCard .
	
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total:= rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser .

	self assert: (debitedCreditCard igual: creditCard). 
	self assert: debitedAmout = total.
	self deny: (rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'n 12/3/2018 10:38:06'!
test13CannotAddToCartAfterDoingCheckOut

	|  cartID |

	cartID:= rest createCart:testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
.	
	rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser .

	self
		should: [  rest addtoCart: cartID thisNumberOfCopies: 1 ofThisBook: testObjectsFactory itemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotUseCheckedOutCartErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:25:57'!
test14CannotShowPurchasesWIthUSerOfPasswordInvalid

	| cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword:testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	
	 rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser .


	self
		should: [ rest listPurchases: 'Trudis' with: testObjectsFactory defaultPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
	].
	self
		should: [ rest listPurchases: testObjectsFactory defaultUser with: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface canNotCreateCartWIthInvalidOwner.
	].
	self deny: (rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword )isEmpty .! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:26:08'!
test15CannotCheckoutCartTwice

	|  cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
		
	rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser .
	
	self
		should: [ rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  today throught: self andIsOwnedBy: testObjectsFactory defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotUseCheckedOutCartErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'n 12/3/2018 10:41:10'!
test16CannotCheckoutCartNotCreatedByUser
	|  cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	.	

self
		should: [ rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  today throught: self andIsOwnedBy: 'Maria' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cartHasNotBeenCreatedByOwner.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'n 12/3/2018 10:41:24'!
test17CannotCheckOutWithInvalidId
	
	|  cartID |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	
	self
		should: [ rest checkout: cartID withCreditCart: testObjectsFactory invalidCreditCartID thatExpires: testObjectsFactory notExpiredDate  throught: self andIsOwnedBy: testObjectsFactory defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface cannotCreateWithInvalidTargetIDErrorMessage.
	]. ! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 02:26:40'!
test18ShowPurchasesShowsCorrectValues
	
	|purchases cartID  |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	 rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser .


purchases:= rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword.
self deny: purchases  isEmpty .
self assert: purchases elements size = 1.
self assert: (purchases ocurrencesOf: testObjectsFactory itemSellByTheStore ) =4.
self assert: purchases total = (testObjectsFactory itemSellByTheStorePrice *4) .! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'n 12/3/2018 10:41:46'!
test19ShowPurchasesCollectsSalesOfMultipleCarts
	
	|purchases  cartID cartID2 |

	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword .
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	 rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser .

cartID2:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword.
rest addtoCart: cartID2 thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.

purchases:= rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword.
self deny: purchases  isEmpty .
self assert: purchases elements size = 1.
self assert: (purchases ocurrencesOf: testObjectsFactory itemSellByTheStore ) =4.
self assert: purchases total = (testObjectsFactory itemSellByTheStorePrice *4) .

rest checkout: cartID2 withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser .

purchases:= rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword.
self deny: purchases  isEmpty .
self assert: purchases elements size = 1.
self assert: (purchases ocurrencesOf: testObjectsFactory itemSellByTheStore ) =6.
self assert: purchases total = (testObjectsFactory itemSellByTheStorePrice *6) .! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'n 12/3/2018 10:42:04'!
test20AdvancingClockAdvancesTheClockInRest
	|startHour rest clock |
	clock := ManualClock initialization: DateAndTime now.
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog usingClock: clock.
	
	startHour:= clock now.
	clock advanceTime: 2 minutes.
		
	self assert: rest now = clock now.
	
	clock reverseTime: 2 minutes.
	self assert: rest now = clock now.
	self assert: rest now = startHour .
! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 12:45:39'!
test21CannotCheckoutCartAfter30MinutesHavePassed
	| rest cartID clock |
	clock := ManualClock initialization: DateAndTime now.
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog usingClock: clock.
		
	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	clock advanceTime:  31 minutes.
	
	self
		should: [ rest checkout: cartID withCreditCart: testObjectsFactory validCreditCartID thatExpires: testObjectsFactory  notExpiredDate throught: self andIsOwnedBy: testObjectsFactory defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface expiredCartSessionErrorMessage.
			self assert: (rest listPurchases: testObjectsFactory defaultUser with: testObjectsFactory defaultPassword )isEmpty
	]. 

	! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 12:56:58'!
test22CannotAddToCartAfter30MinutesHavePassed
	| rest cartID clock |
	clock := ManualClock initialization: DateAndTime now.
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog usingClock: clock.
		
	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword.
	
	
	clock advanceTime:  31 minutes.
	
	self
		should: [ rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface expiredCartSessionErrorMessage.
			clock reverseTime:  31 minutes.
			self assert: (rest listCart: cartID )isEmpty .
			
	]. 

	! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 12:58:29'!
test23CannotListsCartAfter30MinutesHavePassed
	| rest cartID clock |
	clock := ManualClock initialization: DateAndTime now.
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog usingClock: clock.
		
	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	clock advanceTime:  31 minutes.
	
	self
		should: [ rest listCart: cartID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = RestInternalInterface expiredCartSessionErrorMessage.
			clock reverseTime:  31 minutes.
			self assert: ((rest listCart: cartID ) at: 1) equals: (testObjectsFactory itemSellByTheStore asString).
			self assert: ((rest listCart: cartID ) at: 2) equals: 2.
			self assert: ((rest listCart: cartID ) size) equals: 2.
	]. 

	! !

!RestInternalInterfaceTest methodsFor: 'tests' stamp: 'AAAM 12/3/2018 01:22:18'!
test24CartActualizesClockAfterOperation
	| rest cartID clock |
	clock := ManualClock initialization: DateAndTime now.
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory defaultCatalog usingClock: clock.
		
	cartID:= rest createCart: testObjectsFactory defaultUser  withPassword: testObjectsFactory defaultPassword.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	
	clock advanceTime:  10 minutes.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.
	clock advanceTime:  20 minutes.
	
	self deny: (rest listCart: cartID)isEmpty .
	clock advanceTime:  30 minutes.
	rest addtoCart: cartID thisNumberOfCopies: 2 ofThisBook: testObjectsFactory itemSellByTheStore.	! !


!RestInternalInterfaceTest methodsFor: 'setUp' stamp: 'AAAM 12/3/2018 02:22:56'!
setUp 
|clock|
	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	clock := ManualClock initialization: DateAndTime now.
	rest:= RestInternalInterface newWithUsers: self registeredUsersDefault andProducts: testObjectsFactory 	defaultCatalog usingClock: clock.
	
	! !


!RestInternalInterfaceTest methodsFor: 'testing-private' stamp: 'AAAM 11/25/2018 20:05:24'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard .! !

!RestInternalInterfaceTest methodsFor: 'testing-private' stamp: 'AAAM 12/3/2018 01:22:29'!
registeredUsersDefault

|dic|

dic := Dictionary new.
dic at: testObjectsFactory defaultUser put: testObjectsFactory defaultPassword.
dic at:  'Caro' put: 2.
^dic

! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!Cart methodsFor: 'queries' stamp: 'AAAM 12/1/2018 22:11:32'!
list
	
	^items contents keys copy.! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
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


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'cart cartID sessionOwner checkedOut restInterface timeOfLastOperation state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'sessionOperations' stamp: 'AAAM 12/3/2018 04:30:19'!
addtoCartThisNumberOfCopies: aNumber ofThisBook: aBook.

state:= CartSessionState  for: self.

state addToCartCopies: aNumber ofThisBook: aBook.
! !

!CartSession methodsFor: 'sessionOperations' stamp: 'AAAM 12/3/2018 04:53:52'!
checkOut: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales

	|total|
	self assertTheClientOwnsTheCart: aUserID.
	
	state:= CartSessionState for: self.
	total:= state stateCheckOut: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales.

^total
	
	
	
	! !

!CartSession methodsFor: 'sessionOperations' stamp: 'AAAM 12/3/2018 04:14:39'!
initializeCartSession: aCart with: anCartID andOwner: anOwnerID by:aRestInterface

cart := aCart .
cartID := anCartID .
sessionOwner := anOwnerID.
checkedOut := false .
restInterface := aRestInterface.
timeOfLastOperation := aRestInterface  now.
state:= CartSessionState  for: self.! !

!CartSession methodsFor: 'sessionOperations' stamp: 'AAAM 12/3/2018 04:53:24'!
listCart

|list|
	state:= CartSessionState for: self.
	list:= state sessionStateListCart.
	
	^list
	! !


!CartSession methodsFor: 'sessionOperations-private' stamp: 'AAAM 12/3/2018 04:57:38'!
addWhenSessionNotExpiredToCart: aNumber ofThisBook: aBook .

cart add: aNumber of: aBook .

timeOfLastOperation := restInterface now.
! !

!CartSession methodsFor: 'sessionOperations-private' stamp: 'AAAM 12/3/2018 04:57:44'!
checkOutCartWhenSessionNotExpired: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales 

|creditCard cashier total|
creditCard:= CreditCard expiringOn: aMonthAndYear withOwner: aUserID andID: aCreditCardID .
	cashier:= Cashier toCheckout: cart charging: creditCard throught: aMerchantProcessor on: DateAndTime now registeringOn: sales.
	
	
	total:=cashier checkOut.  
	checkedOut:= true.
	timeOfLastOperation  := restInterface now.
	
	^total.! !

!CartSession methodsFor: 'sessionOperations-private' stamp: 'AAAM 12/3/2018 04:57:12'!
listNotExpiredCart

|itemlist|

	itemlist:= OrderedCollection new.
	
	cart list do:[:itemName| itemlist add: itemName. itemlist add: (cart occurrencesOf: itemName)].
	timeOfLastOperation  := restInterface now.
	
	^itemlist.! !

!CartSession methodsFor: 'sessionOperations-private' stamp: 'AAAM 12/3/2018 04:36:24'!
operateCheckedOutCart.

^self error: self class cannotUseCheckedOutCartErrorMessage! !

!CartSession methodsFor: 'sessionOperations-private' stamp: 'AAAM 12/3/2018 04:38:32'!
operateOnExpiredSessionCart.

^self error: self class expiredCartSessionErrorMessage! !


!CartSession methodsFor: 'assertions' stamp: 'AAAM 12/3/2018 05:44:31'!
assertTheClientOwnsTheCart: aUserID .

(sessionOwner  = aUserID )ifFalse:[^self error: self class cartHasNotBeenCreatedByOwner]! !


!CartSession methodsFor: 'state-private' stamp: 'AAAM 12/3/2018 03:45:08'!
cartHasBeenCheckedOut
^checkedOut ! !

!CartSession methodsFor: 'state-private' stamp: 'AAAM 12/3/2018 03:48:37'!
sessionHasNotExpired

^(timeOfLastOperation  + 30 minutes) >= restInterface  now! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 04:24:01'!
cannotUseCheckedOutCartErrorMessage

^'Cart Has Been Checked Out'! !

!CartSession class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:27:45'!
cartHasNotBeenCreatedByOwner

^'cart has not been created by this person'! !

!CartSession class methodsFor: 'error-handling' stamp: 'AAAM 12/2/2018 21:42:54'!
expiredCartSessionErrorMessage

^'The session has expired'! !


!CartSession class methodsFor: 'initialization' stamp: 'AAAM 12/1/2018 22:57:22'!
createCartSession: aCart withID: anCartID andOwner: anOwnerID byInterface: aRest

^self new initializeCartSession: aCart with: anCartID andOwner: anOwnerID by: aRest .! !


!classDefinition: #CartSessionState category: #TusLibros!
Object subclass: #CartSessionState
	instanceVariableNames: 'cartSession'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:07:21'!
addToCartCopies: aNumber ofThisBook: aBook.

^self subclassResponsibility ! !

!CartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 05:33:58'!
sessionStateListCart
^self subclassResponsibility .! !

!CartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 05:33:41'!
stateCheckOut: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales

^self subclassResponsibility ! !


!CartSessionState methodsFor: 'intialize' stamp: 'AAAM 12/3/2018 03:38:36'!
initializeFor: aCartSession

	cartSession := aCartSession ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSessionState class' category: #TusLibros!
CartSessionState class
	instanceVariableNames: ''!

!CartSessionState class methodsFor: 'initialization' stamp: 'AAAM 12/3/2018 03:26:53'!
for: aCartSession
	| stateClass |
	
	stateClass := self allSubclasses detect: [:anStateClass | anStateClass isFor: aCartSession ].	
	^stateClass new initializeFor: aCartSession. ! !

!CartSessionState class methodsFor: 'initialization' stamp: 'AAAM 12/3/2018 03:26:09'!
isFor: aCartSession

^self subclassResponsibility 
! !


!classDefinition: #CheckedOutCartState category: #TusLibros!
CartSessionState subclass: #CheckedOutCartState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckedOutCartState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:36:44'!
addToCartCopies: aNumber ofThisBook: aBook.

cartSession  operateCheckedOutCart .! !

!CheckedOutCartState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:55:30'!
sessionStateListCart

^cartSession listNotExpiredCart.

! !

!CheckedOutCartState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:36:05'!
stateCheckOut: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales.

cartSession  operateCheckedOutCart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckedOutCartState class' category: #TusLibros!
CheckedOutCartState class
	instanceVariableNames: ''!

!CheckedOutCartState class methodsFor: 'initialization' stamp: 'AAAM 12/3/2018 04:48:28'!
isFor: aCartSession

^aCartSession cartHasBeenCheckedOut and: (aCartSession  sessionHasNotExpired )
! !


!classDefinition: #ExpiredCartSessionState category: #TusLibros!
CartSessionState subclass: #ExpiredCartSessionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ExpiredCartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:38:48'!
addToCartCopies: aNumber ofThisBook: aBook.


cartSession  operateOnExpiredSessionCart ! !

!ExpiredCartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:55:11'!
sessionStateListCart

cartSession operateOnExpiredSessionCart 
! !

!ExpiredCartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:55:06'!
stateCheckOut: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales.

cartSession  operateOnExpiredSessionCart.


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExpiredCartSessionState class' category: #TusLibros!
ExpiredCartSessionState class
	instanceVariableNames: ''!

!ExpiredCartSessionState class methodsFor: 'initialization' stamp: 'AAAM 12/3/2018 04:49:23'!
isFor: aCartSession

^aCartSession  sessionHasNotExpired not! !


!classDefinition: #NotExpiredCartSessionState category: #TusLibros!
CartSessionState subclass: #NotExpiredCartSessionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NotExpiredCartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:55:37'!
addToCartCopies: aNumber ofThisBook: aBook.

^cartSession  addWhenSessionNotExpiredToCart: aNumber ofThisBook: aBook .! !

!NotExpiredCartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:55:42'!
sessionStateListCart

^cartSession listNotExpiredCart.
! !

!NotExpiredCartSessionState methodsFor: 'operations' stamp: 'AAAM 12/3/2018 04:55:47'!
stateCheckOut: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales

^cartSession  checkOutCartWhenSessionNotExpired: aCartID withCreditCard: aCreditCardID  thatExpires: aMonthAndYear throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotExpiredCartSessionState class' category: #TusLibros!
NotExpiredCartSessionState class
	instanceVariableNames: ''!

!NotExpiredCartSessionState class methodsFor: 'initialization' stamp: 'AAAM 12/3/2018 03:49:30'!
isFor: aCartSession

^(aCartSession cartHasBeenCheckedOut not) and: (aCartSession  sessionHasNotExpired )! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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

!classDefinition: 'Cashier class' category: #TusLibros!
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


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner identification'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'AAAM 12/3/2018 01:42:00'!
expirationDate
	
	^expiration ! !

!CreditCard methodsFor: 'testing' stamp: 'AAAM 12/3/2018 01:56:41'!
igual:anotherCard

^ (identification  = anotherCard identity) and: (owner  = anotherCard  owner ) and: (expiration = anotherCard  expirationDate ).! !

!CreditCard methodsFor: 'testing' stamp: 'AAAM 12/1/2018 04:08:19'!
isExpiredOn: aDate 
	
	^expiration start < (Month  month: aDate monthIndex year: aDate yearNumber)  start! !


!CreditCard methodsFor: 'initialization' stamp: 'AAAM 12/3/2018 01:42:40'!
initializeExpiringOn: aMonth withOwner: anOwner andID: anID .

self assertValidID: anID.
	expiration := aMonth. 
	owner:= anOwner .
	identification:= anID .
	! !


!CreditCard methodsFor: 'accesing' stamp: 'AAAM 12/2/2018 05:28:38'!
assertValidID: anID.

(anID size = 16 and: anID  asInteger  > 0) ifFalse:[^self error: self class cannotCreateWithInvalidTargetIDErrorMessage]! !

!CreditCard methodsFor: 'accesing' stamp: 'AAAM 12/2/2018 01:35:06'!
identity

^identification ! !

!CreditCard methodsFor: 'accesing' stamp: 'AAAM 12/2/2018 01:34:41'!
owner

^owner ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AAAM 12/2/2018 05:23:16'!
cannotCreateWithInvalidTargetIDErrorMessage

^'The ID is invalid'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'AAAM 12/1/2018 02:22:29'!
expiringOn: aMonth withOwner: anOwner andID: anID
	
	^self new initializeExpiringOn: aMonth withOwner: anOwner andID: anID .! !


!classDefinition: #ManualClock category: #TusLibros!
Object subclass: #ManualClock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'manageTime' stamp: 'AAAM 12/2/2018 20:45:51'!
advanceTime: aDuration

time := time + aDuration .

! !

!ManualClock methodsFor: 'manageTime' stamp: 'AAAM 12/2/2018 20:46:45'!
now

^time! !

!ManualClock methodsFor: 'manageTime' stamp: 'AAAM 12/2/2018 21:07:51'!
reverseTime: aDuration 
	
	time := time - aDuration.! !


!ManualClock methodsFor: 'initialization' stamp: 'AAAM 12/2/2018 20:45:36'!
initializeClock: anStartDateAndTime

time:= anStartDateAndTime .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #TusLibros!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'initialize' stamp: 'AAAM 12/1/2018 19:34:55'!
initialization: anStartMoment

^self new initializeClock: anStartMoment .! !


!classDefinition: #RestInternalInterface category: #TusLibros!
Object subclass: #RestInternalInterface
	instanceVariableNames: 'authentification cartsSessions lastCartID catalog sales clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInternalInterface methodsFor: 'creating' stamp: 'AAAM 12/2/2018 20:03:17'!
initializeWith: anListofUsersAndPassword and: aCatalog usingClock: aclock.

	authentification := anListofUsersAndPassword .
	catalog := aCatalog.

	sales:= OrderedCollection  new.
	
	cartsSessions:= Dictionary  new.
	
	lastCartID:= 0.
	
	clock:= aclock.
	

! !


!RestInternalInterface methodsFor: 'restOperations' stamp: 'AAAM 12/1/2018 23:11:32'!
addtoCart: aCartID thisNumberOfCopies: aNumber ofThisBook: aBook 
	
	
	
	^(cartsSessions at: aCartID ifAbsent:[^self error: self class cannotAddToInvalidCartErrorMessage] ) addtoCartThisNumberOfCopies: aNumber ofThisBook: aBook.
	! !

!RestInternalInterface methodsFor: 'restOperations' stamp: 'AAAM 12/2/2018 01:31:33'!
checkout: aCartID withCreditCart: aCreditCardID thatExpires: aDateAndTime throught: aMerchantProcessor andIsOwnedBy: aUserID

	|session |
	
	
	session := cartsSessions  at: aCartID.
	^ session checkOut: aCartID withCreditCard: aCreditCardID  thatExpires: aDateAndTime throught: aMerchantProcessor andIsOwnedBy:aUserID registeringOn: sales.
	

	! !

!RestInternalInterface methodsFor: 'restOperations' stamp: 'AAAM 12/1/2018 22:58:00'!
createCart: aClientID withPassword: aPassword

	self autentify: aClientID  with: aPassword.	
	lastCartID := lastCartID  +1.
	cartsSessions at: lastCartID  put:(CartSession createCartSession: (Cart acceptingItemsOf: catalog) withID: lastCartID andOwner: aClientID byInterface: self ).
	^lastCartID .! !

!RestInternalInterface methodsFor: 'restOperations' stamp: 'AAAM 12/3/2018 04:53:01'!
listCart: aCartID

	|currentsession| 
	currentsession := cartsSessions   at:  aCartID ifAbsent:[^self error: self class cannotListsInvalidCartErrorMessage ].
	^currentsession  listCart
! !

!RestInternalInterface methodsFor: 'restOperations' stamp: 'AAAM 12/2/2018 04:56:52'!
listPurchases: anClientId with: aPassword 

	| saleOfClient|
	
	self autentify: anClientId  with: aPassword.	
	
	saleOfClient:= sales detect:[:sale| sale isCustomer: anClientId ] ifNone:[^OrderedCollection  new].
	
	^saleOfClient ticket.
	


	
 ! !


!RestInternalInterface methodsFor: 'time-private' stamp: 'AAAM 12/2/2018 20:47:03'!
now

^clock now! !


!RestInternalInterface methodsFor: 'restOperations-private' stamp: 'AAAM 11/24/2018 22:25:09'!
autentify: aClientID with: aPassword

(authentification  keys includes: aClientID ) ifFalse:[^ self error: self class  canNotCreateCartWIthInvalidOwner ].

(authentification  at: aClientID)  = aPassword ifFalse:[^self error: self class canNotCreateCartWIthInvalidOwner ].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInternalInterface class' category: #TusLibros!
RestInternalInterface class
	instanceVariableNames: ''!

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:06:28'!
canNotChargeAnExpiredCreditCardErrorMessage.

^Cashier canNotChargeAnExpiredCreditCardErrorMessage.! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 11/22/2018 20:30:07'!
canNotCreateCartWIthInvalidOwner
	^'No es el usuario o contraseña valido'! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 11/24/2018 23:52:54'!
cannotAddToInvalidCartErrorMessage

^'this cart is not valid to the interface'! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:03:28'!
cannotCreateWithInvalidTargetIDErrorMessage.

^CreditCard cannotCreateWithInvalidTargetIDErrorMessage.! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 11/25/2018 00:18:32'!
cannotListsInvalidCartErrorMessage

^'Cannot list a cart not  created by this interface'! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/2/2018 00:52:31'!
cannotUseCartsOfOthersErrorMessage
^'The user did not create the cart'! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 04:25:04'!
cannotUseCheckedOutCartErrorMessage

^ CartSession cannotUseCheckedOutCartErrorMessage
! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:07:31'!
cartCanNotBeEmptyErrorMessage .

^Cashier  cartCanNotBeEmptyErrorMessage .! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:45:07'!
cartHasNotBeenCreatedByOwner

^CartSession cartHasNotBeenCreatedByOwner! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:05:38'!
creditCardHasNoCreditErrorMessage.
^Cashier creditCardHasNoCreditErrorMessage.! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/2/2018 21:42:27'!
expiredCartSessionErrorMessage

^CartSession  expiredCartSessionErrorMessage! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:08:26'!
invalidItemErrorMessage

^Cart invalidItemErrorMessage.! !

!RestInternalInterface class methodsFor: 'error-handling' stamp: 'AAAM 12/3/2018 05:09:34'!
invalidQuantityErrorMessage

^Cart invalidQuantityErrorMessage.
! !


!RestInternalInterface class methodsFor: 'instance creation' stamp: 'AAAM 12/2/2018 20:02:38'!
newWithUsers: anListofUsersAndPassword andProducts: aCatalog usingClock: clock.

^self new initializeWith: anListofUsersAndPassword and: aCatalog usingClock: clock.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'AAAM 12/2/2018 03:48:14'!
ticket
	
	^ ticket! !

!Sale methodsFor: 'total' stamp: 'AAAM 12/2/2018 22:51:59'!
total
	
	^ ticket total! !


!Sale methodsFor: 'initialization' stamp: 'AAAM 12/2/2018 01:53:10'!
initializeTotal: anOwner and: aTicket

	ticket := aTicket .
	customer := anOwner .
	! !


!Sale methodsFor: 'verifyingClient' stamp: 'AAAM 12/2/2018 04:03:51'!
isCustomer: anClientId 

^(customer  = anClientId )! !


!Sale methodsFor: 'adding' stamp: 'AAAM 12/2/2018 04:11:48'!
addToTicket: cart

ticket addToTicket: cart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AAAM 12/2/2018 01:52:17'!
of: anOwner and: aTicket

	"should assert total is not negative or 0!!"
	"message de arriba creo que es de la catedra. El metodo original era of: solo, cambie para que funcione"
	^self new initializeTotal: anOwner and: aTicket .! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AAAM 12/3/2018 01:13:13'!
defaultPassword

^'1'! !

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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/3/2018 01:12:57'!
defaultUser 

^'Bob'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/3/2018 01:32:56'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredDate withOwner: self defaultUser  andID:self validCreditCartID .! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/1/2018 02:55:20'!
expiredDate
	
	^Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/3/2018 01:32:31'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredDate withOwner: self defaultUser andID: self validCreditCartID .! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AAAM 12/1/2018 04:01:00'!
notExpiredDate
	
	^Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AAAM 12/3/2018 01:12:35'!
invalidCreditCartID


	
	^'000000000000001'! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AAAM 11/25/2018 19:16:31'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AAAM 12/3/2018 01:11:59'!
validCreditCartID


	
	^'0000000000000001'! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'total elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'operations' stamp: 'AAAM 12/2/2018 04:57:54'!
addToTicket: cart

cart list do:[:item| elements add: item  withOccurrences: (cart  occurrencesOf: item)].
total := total + cart total.! !

!Ticket methodsFor: 'operations' stamp: 'AAAM 12/2/2018 04:33:19'!
ocurrencesOf: anItem

^ elements occurrencesOf:  anItem .

! !

!Ticket methodsFor: 'operations' stamp: 'AAAM 12/2/2018 04:42:58'!
purchases

|list|
	list:= Dictionary new.
	
	self elements  do:[:item| list at: item put: (self  ocurrencesOf: item )].
	
	^list
	




! !

!Ticket methodsFor: 'operations' stamp: 'AAAM 12/2/2018 04:27:44'!
total

^total! !


!Ticket methodsFor: 'initialize' stamp: 'AAAM 12/2/2018 05:51:29'!
createOf: aCart 


elements:= Bag new.
total :=0.
self addToTicket: aCart.

! !


!Ticket methodsFor: 'testing' stamp: 'AAAM 12/2/2018 04:34:19'!
elements

^elements contents keys copy.
! !

!Ticket methodsFor: 'testing' stamp: 'AAAM 12/2/2018 05:00:30'!
isEmpty

^self elements isEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'initialization' stamp: 'AAAM 12/2/2018 01:51:03'!
of: aCart

^self new createOf: aCart ! !
