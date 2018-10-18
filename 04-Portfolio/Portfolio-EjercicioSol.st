!classDefinition: #AccountTransaction category: #'Portfolio-EjercicioSol'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-EjercicioSol'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-EjercicioSol'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-EjercicioSol'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-EjercicioSol'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/15/2018 21:12:56'!
isRegisteredByAnReceptiveAccount: anReceptiveAccount

^ anReceptiveAccount  registerADeposit: self.! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/16/2018 00:05:56'!
valueForBalance

^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-EjercicioSol'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-EjercicioSol'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-EjercicioSol'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AAAM 10/15/2018 21:13:25'!
isRegisteredByAnReceptiveAccount: anReceptiveAccount

^ anReceptiveAccount  registerAWithdraw: self.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'AAAM 10/16/2018 00:06:19'!
valueForBalance

^ value*-1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-EjercicioSol'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-EjercicioSol'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-EjercicioSol'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!classDefinition: #AccountorPortfolio category: #'Portfolio-EjercicioSol'!
SummarizingAccount subclass: #AccountorPortfolio
	instanceVariableNames: 'receptiveAccountsorPorfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-EjercicioSol'!

!AccountorPortfolio methodsFor: 'nil' stamp: 'AAAM 10/16/2018 00:40:21'!
hasRegistered: aTransiction

^receptiveAccountsorPorfolios hasRegisteredInPortfolio: aTransiction.! !

!AccountorPortfolio methodsFor: 'nil' stamp: 'AAAM 10/15/2018 23:00:27'!
initializeWith: anAccountorPortfolio

receptiveAccountsorPorfolios  := anAccountorPortfolio .! !


!AccountorPortfolio methodsFor: 'as yet unclassified' stamp: 'AAAM 10/15/2018 23:01:21'!
balance

 ^receptiveAccountsorPorfolios  balance.! !

!AccountorPortfolio methodsFor: 'as yet unclassified' stamp: 'AAAM 10/16/2018 15:41:56'!
doesManage: anAccount

	
^ receptiveAccountsorPorfolios doesManageInPortfolio: anAccount! !

!AccountorPortfolio methodsFor: 'as yet unclassified' stamp: 'AAAM 10/16/2018 15:08:42'!
transactions

^ receptiveAccountsorPorfolios transactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountorPortfolio class' category: #'Portfolio-EjercicioSol'!
AccountorPortfolio class
	instanceVariableNames: ''!

!AccountorPortfolio class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/15/2018 22:51:50'!
with: anAcountorPortfolio

 ^ self new initializeWith: anAcountorPortfolio .! !


!classDefinition: #Portfolio category: #'Portfolio-EjercicioSol'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'receptiveAccountsorPorfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-EjercicioSol'!

!Portfolio methodsFor: 'balance' stamp: 'AAAM 10/15/2018 23:01:45'!
balance

	^ receptiveAccountsorPorfolios sum:[:atr| atr balance] ifEmpty:[^0]. "ifEmpty no deberia estar porque porfolio empieza con almenos dos cuentas."! !


!Portfolio methodsFor: 'testing' stamp: 'AAAM 10/16/2018 14:43:52'!
doesManage: anAccount

receptiveAccountsorPorfolios detect:[: atr| atr doesManage: anAccount] ifNone:[^false]."creo que no hay que tirar este error aca[self error: self class  accountNotManagedMessageDescription]."

	
^ true
! !

!Portfolio methodsFor: 'testing' stamp: 'AAAM 10/16/2018 14:41:29'!
hasRegistered: aTransaction



receptiveAccountsorPorfolios detect:[: atr| atr hasRegistered: aTransaction] ifNone:[^false]."creo que no hay que tirar este error aca[self error: self class  accountNotManagedMessageDescription]."

	
^ true! !


!Portfolio methodsFor: 'transactions' stamp: 'AAAM 10/18/2018 11:08:57'!
transactions 

 |transactionsarray|

 transactionsarray := OrderedCollection new.

receptiveAccountsorPorfolios  collect:[:atr| transactionsarray addAllFirst:atr transactions]."Aca me quedan los array de transacciones."
	
	
^transactionsarray 
! !

!Portfolio methodsFor: 'transactions' stamp: 'AAAM 10/16/2018 15:26:25'!
transactionsOf: anAccount 

	|theAccount|
	
	theAccount := receptiveAccountsorPorfolios detect:[: atr| atr doesManage: anAccount] ifNone:[^self error: self class  accountNotManagedMessageDescription].
	
	^theAccount transactions. ! !


!Portfolio methodsFor: 'initializing' stamp: 'AAAM 10/18/2018 12:19:31'!
initializeFor: aCollectionOfAccounts 


(self isValida: aCollectionOfAccounts )  ifTrue:[
	receptiveAccountsorPorfolios := aCollectionOfAccounts collect:[:atr| AccountorPortfolio with: atr ].
].
(self isValida: aCollectionOfAccounts )  ifFalse:[
	^self error: self class accountAlreadyManagedErrorMessage .
]. 
! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'AAAM 10/16/2018 15:44:37'!
doesManageInPortfolio: anAccount

^ (self = anAccount) or: [self doesManage: anAccount] ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AAAM 10/16/2018 00:43:24'!
hasRegisteredInPortfolio: aTransiction.

receptiveAccountsorPorfolios detect:[: atr| atr hasRegistered: aTransiction] ifNone:[^false].

^true! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AAAM 10/18/2018 12:26:11'!
isValida: aCollectionOfAccounts


|helpingCollection|

helpingCollection:= aCollectionOfAccounts collect:[:atr|self noestaRepetido: atr enColleccion: aCollectionOfAccounts ].



^ helpingCollection size= aCollectionOfAccounts  size. ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AAAM 10/18/2018 12:26:24'!
noestaRepetido: element enColleccion: aCollectionOfAccountsWithoutElement 

|vecesQueSeRepite|
vecesQueSeRepite := aCollectionOfAccountsWithoutElement  collect: [:atr| atr = element].  

^ vecesQueSeRepite  size =1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-EjercicioSol'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'AAAM 10/18/2018 12:02:18'!
with: leftAccount with: rightAccount



 ^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AAAM 10/18/2018 10:41:42'!
withAll: aCollectionOfAccounts

 ^ self new initializeFor: aCollectionOfAccounts .! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-EjercicioSol'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-EjercicioSol'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'AAAM 10/16/2018 00:03:37'!
register: aTransaction

	aTransaction isRegisteredByAnReceptiveAccount: self ."class = Deposit ifTrue:[transactions add: aTransaction]."
	 "class = Withdraw  ifTrue:[transactions  add: aTransaction value *-1]." "Vamos a redefinir los metodos en deposit/withdraw, pero tal vez no debería ser trabajo de la clase"
	
	 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AAAM 10/16/2018 00:05:26'!
balance

	"^transactions sum:[:atr| (atr isKindOf: Deposit) ifTrue:[atr value] ifFalse:[atr value *-1] ] ifEmpty:[^0]."
	^ transactions sum:[:atr| atr valueForBalance] ifEmpty:[^0].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'transactions-private' stamp: 'AAAM 10/16/2018 00:41:32'!
hasRegisteredInPortfolio: aTransiction.

^self hasRegistered: aTransiction.! !

!ReceptiveAccount methodsFor: 'transactions-private' stamp: 'AAAM 10/15/2018 21:18:31'!
registerADeposit: anDepositTransaction

^transactions add: anDepositTransaction! !

!ReceptiveAccount methodsFor: 'transactions-private' stamp: 'AAAM 10/16/2018 00:06:45'!
registerAWithdraw: anWithdrawTransaction

^transactions  add: anWithdrawTransaction ! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AAAM 10/16/2018 15:45:48'!
doesManageInPortfolio: anAccount

^ self doesManage: anAccount.! !
