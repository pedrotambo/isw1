!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'test25ShouldBeAbleToQueryInvestmentEarnings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |

	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.    
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self 
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	
	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.
	
	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).
	
	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:29'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:30'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'PFT 5/14/2018 17:42:33'!
accountSummaryLinesOf: aReceptiveAccount
	^ (AccountSummary with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'PFT 5/14/2018 18:00:02'!
accountTransferNetOf: aReceptiveAccount
	^ (AccountTransferNet with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'PFT 5/14/2018 18:08:06'!
investmentEarningsOf: aReceptiveAccount
	^ (AccountInvestmentEarnings with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'PFT 5/14/2018 18:08:50'!
investmentNetOf: aReceptiveAccount
	^ (AccountInvestmentNet with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'PFT 5/14/2018 20:20:25'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	^(PortfolioTreePrinter with: aPortfolio naming: aDictionary) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'PFT 5/17/2018 01:27:22'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	^(ReversePortfolioTreePrinter with: aPortfolio naming: aDictionary) value! !


!classDefinition: #AccountInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountInvestmentEarnings
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:20:18'!
value
	
	| investmentEarnings |
	
	investmentEarnings := 0.
	account transactionsDo: [:transaction | investmentEarnings := investmentEarnings + (transaction accept: self)].
	^investmentEarnings
! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:22:52'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^ aCertificateOfDeposit earningsAtTheEndOfInvestment
	! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:16:36'!
visitDeposit: aDeposit
	^ 0! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:16:31'!
visitTransfer: aTransfer
	^ 0! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:16:27'!
visitWithdraw: aWithdraw
	^ 0! !


!AccountInvestmentEarnings methodsFor: 'initialization' stamp: 'PFT 5/14/2018 18:07:20'!
initializeWith: anAccount

	account := anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentEarnings class
	instanceVariableNames: ''!

!AccountInvestmentEarnings class methodsFor: 'as yet unclassified' stamp: 'PFT 5/14/2018 18:07:33'!
with:	anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #AccountInvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountInvestmentNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 13:50:10'!
value
	
	| investmentNet |
	
	investmentNet := 0.
	account transactionsDo: [:transaction | investmentNet := investmentNet + (transaction accept: self)].
	^investmentNet
! !

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'PFT 5/14/2018 19:46:55'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^ aCertificateOfDeposit value.! !

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:17:24'!
visitDeposit: aDeposit
	^ 0! !

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:17:21'!
visitTransfer: aTransfer
	^ 0! !

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:17:17'!
visitWithdraw: aWithdraw
	^ 0! !


!AccountInvestmentNet methodsFor: 'initialization' stamp: 'PFT 5/14/2018 03:39:10'!
initializeWith: anAccount

	account := anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentNet class
	instanceVariableNames: ''!

!AccountInvestmentNet class methodsFor: 'as yet unclassified' stamp: 'PFT 5/14/2018 03:39:24'!
with:	anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:17:32'!
value
	
	| summaryLines |
	
	summaryLines := OrderedCollection new.
	account transactionsDo: [:transaction | summaryLines add: (transaction accept: self)].
	^summaryLines

! !

!AccountSummary methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:20:39'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^ 'Plazo fijo por ' , aCertificateOfDeposit value asString ,
	   ' durante ' , aCertificateOfDeposit numberOfDays asString ,
	   ' dias a una tna de ' , (aCertificateOfDeposit tna * 100) asString , '%'.
	! !

!AccountSummary methodsFor: 'visiting' stamp: 'PFT 5/14/2018 19:47:10'!
visitDeposit: aDeposit
	^ 'Deposito por ' , aDeposit value asString.! !

!AccountSummary methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:22:41'!
visitTransfer: aTransfer
	^ 'Transferencia por ' , aTransfer valueForBalance asString.! !

!AccountSummary methodsFor: 'visiting' stamp: 'PFT 5/14/2018 19:47:36'!
visitWithdraw: aWithdraw
	^ 'Extraccion por ' , aWithdraw value asString.! !


!AccountSummary methodsFor: 'initialization' stamp: 'PFT 5/10/2018 21:05:25'!
initializeWith: anAccount

	account := anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'PFT 5/10/2018 21:05:03'!
with:	anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'accesing' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'PFT 5/14/2018 17:01:12'!
valueForBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'PFT 5/14/2018 03:59:09'!
initializeWith: anAmountOfMoney tna: rateOfInvest days: daysOfInvestment on: anAccount

	value := anAmountOfMoney.
	tna := rateOfInvest .
	numberOfDays := daysOfInvestment.
	account := anAccount.
! !


!CertificateOfDeposit methodsFor: 'private' stamp: 'PFT 5/17/2018 14:24:33'!
numberOfDays

	^numberOfDays ! !

!CertificateOfDeposit methodsFor: 'private' stamp: 'PFT 5/17/2018 14:24:39'!
tna

	^tna! !

!CertificateOfDeposit methodsFor: 'private' stamp: 'PFT 5/14/2018 03:50:37'!
value

	^value! !

!CertificateOfDeposit methodsFor: 'private' stamp: 'PFT 5/14/2018 04:01:47'!
valueForBalance

	^value * -1! !


!CertificateOfDeposit methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:23:26'!
accept: aVisitor
	^ aVisitor visitCertificateOfDeposit: self! !


!CertificateOfDeposit methodsFor: 'accesing' stamp: 'PFT 5/17/2018 14:21:35'!
earningsAtTheEndOfInvestment
	
	^ value * (tna / 360) * numberOfDays! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'PFT 5/14/2018 04:00:21'!
register: anAmountOfMoney during: numberOfDays at: rateOfInvest on: anAccount

	|certificateOfDeposit|
	
	certificateOfDeposit := self new initializeWith: anAmountOfMoney tna: rateOfInvest days: numberOfDays on: anAccount.
	
	anAccount register: certificateOfDeposit.
	
	^certificateOfDeposit ! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'accesing' stamp: 'PFT 5/17/2018 14:28:08'!
value

	^value! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'private' stamp: 'PFT 5/10/2018 18:57:47'!
valueForBalance

	^value! !


!Deposit methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:23:40'!
accept: aVisitor
	^ aVisitor visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'accesing' stamp: 'PFT 5/10/2018 20:34:22'!
transfer

	^transfer! !

!TransferDeposit methodsFor: 'accesing' stamp: 'PFT 5/10/2018 20:42:48'!
value
	
	^transfer value! !


!TransferDeposit methodsFor: 'initialization' stamp: 'PFT 5/10/2018 20:54:05'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferDeposit methodsFor: 'private' stamp: 'PFT 5/10/2018 20:34:16'!
valueForBalance

	^transfer value! !


!TransferDeposit methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:34:35'!
accept: aVisitor
	^ aVisitor visitTransfer: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'PFT 5/10/2018 20:57:15'!
with: aTransfer on: anAccount

	| withdraw |
	
	withdraw := self new initializeWith: aTransfer.
	anAccount register: withdraw.
	
	
	^ withdraw! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'accesing' stamp: 'PFT 5/10/2018 20:33:34'!
transfer

	^transfer! !

!TransferWithdraw methodsFor: 'accesing' stamp: 'PFT 5/10/2018 20:42:42'!
value
	
	^transfer value! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'PFT 5/10/2018 20:53:50'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferWithdraw methodsFor: 'private' stamp: 'PFT 5/10/2018 20:33:58'!
valueForBalance

	^transfer value * -1! !


!TransferWithdraw methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:34:02'!
accept: aVisitor
	^ aVisitor visitTransfer: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'PFT 5/10/2018 20:57:05'!
with: aTransfer on: anAccount

	| withdraw |
	
	withdraw := self new initializeWith: aTransfer.
	anAccount register: withdraw.
	
	
	^ withdraw! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'accesing' stamp: 'PFT 5/10/2018 18:52:31'!
value

	^ value! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'private' stamp: 'PFT 5/10/2018 18:56:55'!
valueForBalance

	^value * -1! !


!Withdraw methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:33:36'!
accept: aVisitor
	^ aVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:17:47'!
value

	| transferNet |
	
	transferNet := 0.
	account transactionsDo: [:transaction | transferNet := transferNet + (transaction accept: self)].
	^transferNet
! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:23:13'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^ 0! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:23:00'!
visitDeposit: aDeposit
	^ 0! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:23:04'!
visitTransfer: aTransfer
	^ aTransfer valueForBalance! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'PFT 5/17/2018 02:23:08'!
visitWithdraw: aDeposit
	^ 0! !


!AccountTransferNet methodsFor: 'initialization' stamp: 'PFT 5/17/2018 02:23:21'!
initializeWith: anAccount

	account := anAccount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'as yet unclassified' stamp: 'PFT 5/10/2018 21:43:10'!
with: anAccount

	^ self new initializeWith: anAccount.! !


!classDefinition: #PortfolioTreePrinter category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio namesDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTreePrinter methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:20:36'!
value

	^portfolio accept: self
	! !

!PortfolioTreePrinter methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:33:07'!
visitPortfolio: aPortfolio
		
	|lines|
	
	lines := OrderedCollection with: (namesDictionary at: aPortfolio).
	
	aPortfolio accountsDo: [:account | lines addAll: (self addStartingSpaceToAll: (account accept: self) )].
	^lines
	

! !

!PortfolioTreePrinter methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:19:18'!
visitReceptiveAccount: aReceptiveAccount
	
	^OrderedCollection with: (namesDictionary at: aReceptiveAccount)! !


!PortfolioTreePrinter methodsFor: 'support' stamp: 'PFT 5/17/2018 01:20:19'!
addStartingSpaceToAll: aCollectionOfStrings
		
	^aCollectionOfStrings 
		inject: OrderedCollection new
		into: [:stringsWithSpace :string | stringsWithSpace add: ' ', string. stringsWithSpace]
! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'PFT 5/17/2018 01:20:11'!
initializeWith: aPortfolio namesDictionary: aDictionary

	portfolio := aPortfolio.
	namesDictionary := aDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'as yet unclassified' stamp: 'PFT 5/14/2018 19:54:34'!
with: aPortfolio naming: aDictionary

	^self new initializeWith: aPortfolio namesDictionary: aDictionary
! !


!classDefinition: #ReversePortfolioTreePrinter category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #ReversePortfolioTreePrinter
	instanceVariableNames: 'portfolio namesDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReversePortfolioTreePrinter methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:26:23'!
value

	^portfolio accept: self
	! !

!ReversePortfolioTreePrinter methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:33:36'!
visitPortfolio: aPortfolio
		
	|lines|
	
	lines := OrderedCollection with: (namesDictionary at: aPortfolio).
	
	aPortfolio accountsDo: [:account | lines addAllFirst: (self addStartingSpaceToAll: (account accept: self) )].
	^lines
	

! !

!ReversePortfolioTreePrinter methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:26:23'!
visitReceptiveAccount: aReceptiveAccount
	
	^OrderedCollection with: (namesDictionary at: aReceptiveAccount)! !


!ReversePortfolioTreePrinter methodsFor: 'support' stamp: 'PFT 5/17/2018 01:26:23'!
addStartingSpaceToAll: aCollectionOfStrings
		
	^aCollectionOfStrings 
		inject: OrderedCollection new
		into: [:stringsWithSpace :string | stringsWithSpace add: ' ', string. stringsWithSpace]
! !


!ReversePortfolioTreePrinter methodsFor: 'initialization' stamp: 'PFT 5/17/2018 01:26:23'!
initializeWith: aPortfolio namesDictionary: aDictionary

	portfolio := aPortfolio.
	namesDictionary := aDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReversePortfolioTreePrinter class' category: #'PortfolioTreePrinter-Ejercicio'!
ReversePortfolioTreePrinter class
	instanceVariableNames: ''!

!ReversePortfolioTreePrinter class methodsFor: 'as yet unclassified' stamp: 'PFT 5/17/2018 01:26:23'!
with: aPortfolio naming: aDictionary

	^self new initializeWith: aPortfolio namesDictionary: aDictionary
! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'accesing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'private' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'initialization' stamp: 'PFT 5/7/2018 20:56:05'!
initializeWith: aCollectionOfAccounts

	accounts := aCollectionOfAccounts ! !

!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'accesing' stamp: 'PFT 5/14/2018 20:12:26'!
accounts
	
	^accounts! !

!Portfolio methodsFor: 'accesing' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'accesing' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'accesing' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'visiting' stamp: 'PFT 5/14/2018 20:31:01'!
accept: aTypeOfQuery

	^aTypeOfQuery visitPortfolio: self! !

!Portfolio methodsFor: 'visiting' stamp: 'PFT 5/17/2018 14:29:26'!
accountsDo: aBlock

	^self accounts do: aBlock! !

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


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

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


!ReceptiveAccount methodsFor: 'accesing' stamp: 'PFT 5/10/2018 19:58:35'!
balance

	^ transactions inject: 0 into: [ :balance :transaction |  balance + transaction valueForBalance]! !


!ReceptiveAccount methodsFor: 'modifyng' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:36:26'!
accept: aVisitor

	^aVisitor visitReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'visiting' stamp: 'PFT 5/17/2018 01:53:59'!
transactionsDo: aBlock

	^self transactions do: aBlock! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'PFT 5/10/2018 19:16:55'!
initializeFor: aPositiveValue

	value := aPositiveValue ! !


!Transfer methodsFor: 'accesing' stamp: 'PFT 5/10/2018 20:34:48'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'PFT 5/10/2018 19:17:05'!
for: aPositiveValue

	^self new initializeFor: aPositiveValue! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'PFT 5/10/2018 20:52:03'!
register: aPositiveValue from: fromAccount to: toAccount
	
	| transfer |
		
	transfer _ self for: aPositiveValue.
	
	TransferDeposit with: transfer on: toAccount.
	TransferWithdraw with: transfer on: fromAccount.
	
	^ transfer.! !
