!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:20:37'!
affectBalance: currentBalance  

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'AAAM 10/19/2018 23:32:36'!
printTransaction

^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
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


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 20:37:28'!
affectBalance: currentBalance  

	^currentBalance + self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/19/2018 23:32:46'!
printTransaction

^'Deposito por ',self value printString  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #InvestmentDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #InvestmentDeposit
	instanceVariableNames: 'certificateofdeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:40:48'!
affectBalance: currentBalance  

^currentBalance - self value! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:38:51'!
certificateOfDeposit

^certificateofdeposit ! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:45:46'!
duration

^ certificateofdeposit duration! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:37:37'!
initializeWithCertificate: anCertificateofDeposit .

certificateofdeposit := anCertificateofDeposit .! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:45:30'!
interest

^ certificateofdeposit interest! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 02:13:28'!
investmentEarnings

^ certificateofdeposit investmentEarnings! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:59:15'!
investmentNet

^ self value! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 02:20:30'!
printTransaction

^'Plazo fijo por ',self value printString, ' durante ', self duration printString, ' dias a una tna de ', self interest printString,'%'. ! !

!InvestmentDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:38:22'!
value

^ certificateofdeposit value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentDeposit class
	instanceVariableNames: ''!

!InvestmentDeposit class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:36:47'!
withCertificate: anCertificateofDeposit.

^self new initializeWithCertificate: anCertificateofDeposit .! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'transfer' stamp: 'HAW 10/18/2018 21:05:34'!
transfer

	^transfer ! !


!TransferLeg methodsFor: 'initialization' stamp: 'HAW 10/18/2018 21:07:15'!
initializeRelatedTo: aTransfer 
	
	transfer := aTransfer ! !


!TransferLeg methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:35:56'!
value

	^transfer value! !


!TransferLeg methodsFor: 'as yet unclassified' stamp: 'n 10/20/2018 16:40:56'!
printTransaction

^'Transferencia por ',(self affectBalance: 0) printString.! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'n 10/20/2018 17:07:25'!
transferNet

	^(self affectBalance: 0).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'HAW 10/18/2018 21:07:07'!
relatedTo: aTransfer 
	
	^self new initializeRelatedTo: aTransfer ! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:34:58'!
affectBalance: currentBalance

	^currentBalance + self value! !



!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:34:40'!
affectBalance: currentBalance

	^currentBalance - self value! !



!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 20:36:35'!
affectBalance: currentBalance  

	^currentBalance - self value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AAAM 10/19/2018 23:33:05'!
printTransaction

^'Extraccion por ',self value printString  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #CertificateOfDeposit
	instanceVariableNames: 'investment duration interest value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:46:32'!
duration

^duration ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:34:59'!
initializeOf: anAmount during: aNumberOfDays  at: anInteresRate 

value:= anAmount .
duration := aNumberOfDays .
interest := anInteresRate .
investment := InvestmentDeposit withCertificate: self.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 02:01:21'!
interest

^interest* 100

! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 02:01:18'!
investment

^investment ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 02:15:50'!
investmentEarnings

^ value*(interest/360)*duration ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:46:16'!
value

^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:01:39'!
of: anAmount during: aNumberOfDays  at: anInteresRate 

^self new initializeOf: anAmount during: aNumberOfDays  at: anInteresRate ! !

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 01:28:24'!
register: anAmount  during: aNumberOfDays at: anInteresRate  on: anAccount 

|certificate|

certificate:= self of: anAmount during: aNumberOfDays  at: anInteresRate .
anAccount register: certificate investment.
	
^certificate! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

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


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
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


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AAAM 10/20/2018 02:11:55'!
investmentEarnings

^transactions inject:0 into:[:parcialNet :movements| parcialNet + movements investmentEarnings].! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'n 10/20/2018 19:16:55'!
investmentNet
	|investments|
	
	investments := transactions select: [:anElement | anElement class = InvestmentDeposit ].

	^investments inject:0 into:[:parcialNet :movements| parcialNet + movements investmentNet].! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AAAM 10/19/2018 22:06:11'!
summaryLines


|Summary|
Summary := OrderedCollection new.

transactions do:[:anLIne  | Summary add: anLIne printTransaction.].

^Summary! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'n 10/20/2018 19:15:11'!
transferNet
	|transfers|
	
	transfers := transactions select: [:anElement | anElement class = TransferWithdraw or: anElement class = TransferDeposit ].
	
	^transfers inject:0 into:[:parcialNet :movements| parcialNet + movements transferNet]. ! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

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

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
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
