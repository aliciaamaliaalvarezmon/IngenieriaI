!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:20:37'!
affectBalance: currentBalance  

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:10:38'!
accept: aVisitor

^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HAW 10/18/2018 21:06:37'!
for: anAmount

	self subclassResponsibility ! !


!AccountTransaction class methodsFor: 'registering' stamp: 'HAW 10/18/2018 19:48:18'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio2'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'duration interest value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:55:35'!
accept: aVisitor

	aVisitor visitACertificateDeposit: self. ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/21/2018 01:36:57'!
affectBalance: currentBalance  

^currentBalance - self value! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:46:32'!
duration

^duration ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/21/2018 01:39:21'!
initializeOf: anAmount during: aNumberOfDays  at: anInteresRate 

value:= anAmount .
duration := aNumberOfDays .
interest := anInteresRate .! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:16:10'!
interest

^interest

! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:46:16'!
value

^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio2'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:01:39'!
of: anAmount during: aNumberOfDays  at: anInteresRate 

^self new initializeOf: anAmount during: aNumberOfDays  at: anInteresRate ! !

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/21/2018 01:38:53'!
register: anAmount  during: aNumberOfDays at: anInteresRate  on: anAccount 

|certificate|

certificate:= self of: anAmount during: aNumberOfDays  at: anInteresRate .
anAccount register: certificate.
	
^certificate! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 20:37:28'!
affectBalance: currentBalance  

	^currentBalance + self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:11:27'!
accept: aVisitor


 	aVisitor visitADeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!TransferLeg methodsFor: 'transfer' stamp: 'HAW 10/18/2018 21:05:34'!
transfer

	^transfer ! !


!TransferLeg methodsFor: 'initialization' stamp: 'HAW 10/18/2018 21:07:15'!
initializeRelatedTo: aTransfer 
	
	transfer := aTransfer ! !


!TransferLeg methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:35:56'!
value

	^transfer value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'HAW 10/18/2018 21:07:07'!
relatedTo: aTransfer 
	
	^self new initializeRelatedTo: aTransfer ! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio2'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!TransferDeposit methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:34:58'!
affectBalance: currentBalance

	^currentBalance + self value! !


!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:12:04'!
accept: aVisitor


 	aVisitor visitATransferDeposit: self! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio2'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!TransferWithdraw methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:34:40'!
affectBalance: currentBalance

	^currentBalance - self value! !


!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:12:21'!
accept: aVisitor


 	aVisitor visitATransferWithdraw: self! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 20:36:35'!
affectBalance: currentBalance  

	^currentBalance - self value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:12:47'!
accept: aVisitor


 	aVisitor visitAWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountVisitor category: #'PortfolioTreePrinter-Ejercicio2'!
Object subclass: #AccountVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:43:27'!
initializeFor: anAccount

account := anAccount.  

! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:13:39'!
value

^self subclassResponsibility ! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:56:09'!
visitACertificateDeposit: aCertificate

	^self subclassResponsibility .! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 18:57:14'!
visitADeposit:aDeposit

^self subclassResponsibility ! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 18:58:40'!
visitATransferDeposit:aTransferDeposit

^self subclassResponsibility ! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 18:58:11'!
visitATransferWithdraw:aTransferWithdraw

^self subclassResponsibility ! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:02:19'!
visitAWithdraw:aWithdraw

^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountVisitor class' category: #'PortfolioTreePrinter-Ejercicio2'!
AccountVisitor class
	instanceVariableNames: ''!

!AccountVisitor class methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:00:45'!
for: anAccount

^self new initializeFor: anAccount! !


!classDefinition: #AccountInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio2'!
AccountVisitor subclass: #AccountInvestmentEarnings
	instanceVariableNames: 'acum'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:05:21'!
value

	acum := 0.
	
	account unVisitador: self.
	
	^acum ! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:16:58'!
visitACertificateDeposit: aCertificate

	acum := acum + ( aCertificate value*( aCertificate interest/360)* aCertificate duration).! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:05:37'!
visitADeposit:aDeposit

^0! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:05:52'!
visitATransferDeposit:aTransferDeposit

^0! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:06:05'!
visitATransferWithdraw:aTransferWithdraw

^0! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:06:17'!
visitAWithdraw:aWithdraw

^0! !


!classDefinition: #AccountInvestmentNet category: #'PortfolioTreePrinter-Ejercicio2'!
AccountVisitor subclass: #AccountInvestmentNet
	instanceVariableNames: 'cuenta'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:01:10'!
value

	cuenta:= 0. 

	account unVisitador: self.	
		
	^cuenta .! !

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:56:51'!
visitACertificateDeposit: aCertificate

	^ cuenta := cuenta + aCertificate value.! !

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:54:10'!
visitADeposit: aDeposit

^0! !

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:54:27'!
visitATransferDeposit: aTransferDeposit

^0! !

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:54:40'!
visitATransferWithdraw: aTransferWithdraw


^0! !

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:54:53'!
visitAWithdraw: aWithdraw


^0! !


!classDefinition: #AccountSummaryLines category: #'PortfolioTreePrinter-Ejercicio2'!
AccountVisitor subclass: #AccountSummaryLines
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:43:05'!
value

	lines:= OrderedCollection new	.
	
	account unVisitador: self.
	
	^lines
	
	 ! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:16:37'!
visitACertificateDeposit: aCertificate

	lines add: 'Plazo fijo por ',aCertificate value printString, ' durante ', aCertificate duration printString, ' dias a una tna de ', (aCertificate interest* 100) printString,'%'. ! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:19:55'!
visitADeposit: aDeposit

	lines add: 'Deposito por ',aDeposit value printString.! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:20:09'!
visitATransferDeposit: aTransferDeposit

lines add: 'Transferencia por ',aTransferDeposit value   printString.! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:32:57'!
visitATransferWithdraw: aTransferWithdraw


lines add: 'Transferencia por ',aTransferWithdraw value negated printString  ! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:32:43'!
visitAWithdraw: aWithdraw


lines add: 'Extraccion por ',aWithdraw value printString  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryLines class' category: #'PortfolioTreePrinter-Ejercicio2'!
AccountSummaryLines class
	instanceVariableNames: ''!

!AccountSummaryLines class methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:24:43'!
for: anAccount

^self new initializeFor: anAccount! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio2'!
AccountVisitor subclass: #AccountTransferNet
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:46:42'!
value

	net := 0.
	account unVisitador: self.
	
	^net! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:59:58'!
visitACertificateDeposit: aCertificate

^0! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:47:11'!
visitADeposit: aDeposit

	^net +0.! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:47:46'!
visitATransferDeposit: aTransferDeposit

	net := net + aTransferDeposit value.! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:47:57'!
visitATransferWithdraw: aTransferWithdraw


	net := net + aTransferWithdraw value negated .! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:47:02'!
visitAWithdraw: aWithdraw


	^net + 0! !


!classDefinition: #PortfolioTree category: #'PortfolioTreePrinter-Ejercicio2'!
Object subclass: #PortfolioTree
	instanceVariableNames: 'diccionario portfolio arbol'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:26:32'!
initializeFor: aPortfolio with: aDictonary

portfolio := aPortfolio .
diccionario := aDictonary .

! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 21:08:25'!
value

arbol := OrderedCollection  new.

arbol add: (diccionario  at: portfolio).

portfolio  unVisitador: self.

^arbol! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:39:38'!
visitAPortfolio: aPortfolio

	! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:41:35'!
visitAReceiveAccount: aReceiveAccount
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTree class' category: #'PortfolioTreePrinter-Ejercicio2'!
PortfolioTree class
	instanceVariableNames: ''!

!PortfolioTree class methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 20:24:49'!
for: aPortfolio with: aDictonary

	^self new initializeFor: aPortfolio with: aDictonary .! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio2'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio2'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 21:08:57'!
accept: aVisitator

	aVisitator visitAPortfolio: self.
	
	self unVisitador: aVisitator.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 21:08:34'!
unVisitador: aVisitator
	
	accounts do: [:anAccount | anAccount accept: aVisitator ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio2'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 20:20:37'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 21:09:54'!
accept: unVisitor

	unVisitor visitAReceiveAccount: self.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'na 10/22/2018 19:32:01'!
unVisitador: aVisitor

	^transactions do: [:aTransaction | aTransaction accept: aVisitor].! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio2'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio2'!

!Transfer methodsFor: 'initialization' stamp: 'HAW 10/18/2018 21:08:52'!
initializeOf: anAmount 
	
	value := anAmount.
	depositLeg := TransferDeposit relatedTo: self .
	withdrawLeg := TransferWithdraw relatedTo: self 
	
	! !


!Transfer methodsFor: 'legs' stamp: 'HAW 10/18/2018 20:53:34'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'HAW 10/18/2018 20:53:26'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 21:08:33'!
value

	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'HAW 10/18/2018 21:07:39'!
of: anAmount 

	^self new initializeOf: anAmount ! !


!Transfer class methodsFor: 'registering' stamp: 'HAW 10/18/2018 20:50:53'!
register: anAmount from: fromAccount to: toAccount 

	|transfer |
	
	transfer := self of: anAmount.
	fromAccount register: transfer withdrawLeg.
	toAccount register: transfer depositLeg.
	
	^transfer! !
