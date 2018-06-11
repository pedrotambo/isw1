!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart aProductNotSell aPriceList aProductSellA aProductSellB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'support' stamp: 'PFT 6/11/2018 13:11:31'!
setUp
	aProductNotSell _ Object new.
	aProductSellA _ Object new.
	aProductSellB _ Object new.
	aPriceList _ Dictionary new.
	aPriceList at: aProductSellA put: 10.
	aPriceList at: aProductSellB put: 20.
	aCart _ Cart acceptingItemsOf: aPriceList.! !


!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:00:53'!
test01NewCartsAreCreatedEmpty

	self assert: aCart isEmpty! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:11:17'!
test02CanNotAddItemsThatDoNotBelongToStore

	self should: [ aCart add: aProductNotSell ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCart invalidItemErrorMessage .
			self assert: aCart isEmpty ]! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:03:15'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	aCart add: aProductSellA.
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:07:31'!
test03CanAddMoreThanOneProductToCart

	aCart add: aProductSellA.
	aCart add: aProductSellB.
	self assert: 2 equals: aCart productsCount.
	self assert: (aCart includes: aProductSellA).
	self assert: (aCart includes: aProductSellB).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:08:28'!
test04CanNotAddNonPositiveNumberOfItems

	self should: [aCart add: 0 of: aProductSellA ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aCart invalidQuantityErrorMessage = anError messageText.
			self assert: aCart isEmpty ]! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:09:18'!
test05canNotAddMoreThanOneProductNotIncludedInCatalogue
	
	self should: [ aCart add: 2 of: aProductNotSell ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aCart invalidItemErrorMessage = anError messageText.
			self assert: aCart isEmpty ].! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:05:15'!
test06CartRemembersAddedItems
	
	aCart add: aProductSellA.
	self assert: (aCart includes: aProductSellA).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:05:30'!
test07CanAddMultipleUnitsOfASameProduct
	| unitsCount |

	unitsCount _ 3.
	
	aCart add: unitsCount of: aProductSellA.
	self assert: unitsCount equals: aCart productsCount.
	self assert: unitsCount equals: (aCart unitsOf: aProductSellA).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/11/2018 13:06:06'!
test08CanAddMultipleUnitsForMoreThanOneProduct
	| unitsCountForA unitsCountForB |
	
	unitsCountForA _ 3.
	unitsCountForB _ 2.

	aPriceList at: aProductSellA put: 10.
	aPriceList at: aProductSellB put: 50.
	aCart add: unitsCountForA of: aProductSellA.
	aCart add: unitsCountForB of: aProductSellB.
	
	self assert: unitsCountForA + unitsCountForB equals: aCart productsCount.
	self assert: unitsCountForA equals: (aCart unitsOf: aProductSellA).
	self assert: unitsCountForB equals: (aCart unitsOf: aProductSellB).
	self assert: (aCart includes: aProductSellA).
	self assert: (aCart includes: aProductSellB).! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aCart aProduct aProductA aProductB aCashier priceOfProductA priceOfProductB priceList today lastMonthOfCurrentYear aCreditCardNotExpired nextMonthOfCurrentYear expiredCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/10/2018 15:17:05'!
test01CheckOutOfEmptyCartRaiseException

	self
		should: [ Cashier checkout: aCart with: aCreditCardNotExpired ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aCart isEmpty.
			self assert: Cashier canNotcheckOutEmptyCart equals: anError messageText ].! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/10/2018 15:21:24'!
test02TotalOfCheckOutIsEqualOfPriceProduct

	aCart add: aProductA.

	self assert: (Cashier checkout: aCart with: aCreditCardNotExpired) equals: (priceList at: aProductA).! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/10/2018 15:22:29'!
test03CashierCheckoutsAQuantityOfSameProduct

	aCart add: 3 of: aProductA.
	aCart add: 2 of: aProductB.
	self assert: 
		(Cashier checkout: aCart with: aCreditCardNotExpired) equals: priceOfProductA * 3 + (priceOfProductB * 2).! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/10/2018 15:23:25'!
test04CashierRaiseExceptionWhenCheckoutOfExpiredCreditCard

	aCart add: 3 of: aProductA.
	aCart add: 2 of: aProductB.
	self
		should: [ Cashier checkout: aCart with: expiredCreditCard. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self deny: aCart isEmpty.
			self assert: Cashier expiredCreditCard equals: anError messageText.
			self assert: (aCart includesAll: 	{aProductA. aProductB}) ].! !


!CashierTest methodsFor: 'support' stamp: 'PFT 6/11/2018 13:12:52'!
setUp

	aProduct := Object new. 
 	aProductA := Object new.
	aProductB := Object new.
	priceOfProductA := 10 * peso.
	priceOfProductB := 23 * peso.

	priceList := Dictionary new.
	priceList at: aProductA put: priceOfProductA .
	priceList at: aProductB put: priceOfProductB .
	
	aCart := Cart acceptingItemsOf: priceList.
	
	today := FixedGregorianDate today.
	
	lastMonthOfCurrentYear := 
		GregorianMonthOfYear
			year: today year 
			month: (GregorianMonth numbered: (today month number -1)).
	
	nextMonthOfCurrentYear :=
		GregorianMonthOfYear
			year: today year 
			month: (GregorianMonth numbered: (today month number +1)).

	aCreditCardNotExpired := CreditCard
		number: 4500450045004500
		expiring: nextMonthOfCurrentYear
		owner: 'Rodolfo Games'
		transactionAmount: 134134134.
		
	expiredCreditCard := CreditCard 
		number: 4545454 
		expiring: lastMonthOfCurrentYear
		owner: 'Jorge Lopez' 
		transactionAmount: 100000.
	

	


	
! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'productsUnits priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accesing' stamp: 'PFT 6/7/2018 20:28:58'!
includes: aProduct

	^ productsUnits includes: aProduct.! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/8/2018 12:22:39'!
includesAll: aCollectionOfProducts

	^ aCollectionOfProducts allSatisfy: [:product | productsUnits includes: product]! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/7/2018 18:10:41'!
isEmpty

	^productsUnits isEmpty! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/10/2018 18:40:58'!
priceList
	^ priceList copy.! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/7/2018 17:59:36'!
productsCount

	^productsUnits size! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/8/2018 01:00:40'!
productsDo: aBlock

	^ productsUnits do: [:product | aBlock value: product]! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/8/2018 00:38:05'!
unitsOf: aProduct
	^ productsUnits occurrencesOf: aProduct.! !


!Cart methodsFor: 'initialization' stamp: 'PFT 6/10/2018 18:40:58'!
initializeWith: aCatalog
	productsUnits _ Bag new.
	priceList _ aCatalog.! !


!Cart methodsFor: 'adding' stamp: 'PFT 6/8/2018 00:36:49'!
add: aProduct
	
	self add: 1 of: aProduct
! !

!Cart methodsFor: 'adding' stamp: 'PFT 6/8/2018 00:32:44'!
add: aNumberOfUnitsToAdd of: aProduct

	self assertIsValidQuantity: aNumberOfUnitsToAdd.
	self assertIsValidItem: aProduct.

	productsUnits add: aProduct withOccurrences: aNumberOfUnitsToAdd ! !

!Cart methodsFor: 'adding' stamp: 'PFT 6/7/2018 18:24:53'!
addAll: aCollectionOfProducts

	aCollectionOfProducts do: [:product | self add: product]! !


!Cart methodsFor: 'assertions' stamp: 'PFT 6/10/2018 18:40:58'!
assertIsValidItem: anItem
	(priceList includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ].! !

!Cart methodsFor: 'assertions' stamp: 'PFT 6/7/2018 18:53:10'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'error messages' stamp: 'PFT 6/7/2018 18:49:34'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'PFT 6/7/2018 18:52:50'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !

!Cart methodsFor: 'error messages' stamp: 'PFT 6/8/2018 01:08:16'!
productIsNotInTheCart
	^ 'El producto que quitar no se encuentra en el carrito.'.! !


!Cart methodsFor: 'removing' stamp: 'PFT 6/8/2018 01:09:01'!
removeProduct: aProduct

	productsUnits remove: aProduct ifAbsent: [self error: self productIsNotInTheCart ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'PFT 6/7/2018 20:25:38'!
acceptingItemsOf: aPriceList
	^ self new initializeWith: aPriceList.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'PFT 6/10/2018 15:20:10'!
initializeFor: aCart with: aCreditCard
	priceList _ aCart priceList.
	cart _ aCart.
	creditCard _ aCreditCard.! !


!Cashier methodsFor: 'error messages' stamp: 'PFT 6/7/2018 19:18:23'!
canNotcheckOutEmptyCart

	^'No se puede cobrar un carro vacío'! !

!Cashier methodsFor: 'error messages' stamp: 'PFT 6/7/2018 20:52:16'!
expiredCreditCard

	^'La tarjeta de crédito que desea utilizar expiró'! !


!Cashier methodsFor: 'assertions' stamp: 'PFT 6/7/2018 23:57:20'!
assertCreditCardIsValid

	(creditCard isExpiredOn: FixedGregorianDate today) ifTrue: [ self error: self expiredCreditCard ]! !

!Cashier methodsFor: 'assertions' stamp: 'PFT 6/7/2018 20:38:23'!
assertIsNotEmptyCart

	(cart isEmpty) ifTrue: [ self error: self canNotcheckOutEmptyCart ]! !


!Cashier methodsFor: 'accesing' stamp: 'PFT 6/8/2018 01:00:50'!
checkOut
	|totalPrice|
	self assertIsNotEmptyCart.
	self assertCreditCardIsValid.
	
	totalPrice := 0.
	cart productsDo: [:product | totalPrice := totalPrice + (priceList at: product)].
	
	self debit: creditCard transactionAmount from: creditCard.
	
	^totalPrice
	
	
! !

!Cashier methodsFor: 'accesing' stamp: 'PFT 6/8/2018 00:59:12'!
debit: anAmount from: creditCard.
	

	
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'PFT 6/10/2018 15:21:05'!
checkout: aCart with: aCreditCard
	
	^(self new initializeFor: aCart with: aCreditCard) checkOut 
	! !


!Cashier class methodsFor: 'error messages' stamp: 'PFT 6/10/2018 15:15:16'!
canNotcheckOutEmptyCart

	^'No se puede cobrar un carro vacío'! !

!Cashier class methodsFor: 'error messages' stamp: 'PFT 6/10/2018 15:15:30'!
expiredCreditCard

	^'La tarjeta de crédito que desea utilizar expiró'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner transactionAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accesing' stamp: 'PFT 6/7/2018 23:51:20'!
creditCardExpiration
	
	^expiration! !

!CreditCard methodsFor: 'accesing' stamp: 'PFT 6/7/2018 23:51:15'!
creditCardNumber
	
	^number! !

!CreditCard methodsFor: 'accesing' stamp: 'PFT 6/7/2018 23:51:10'!
creditCardOwner
	
	^owner! !

!CreditCard methodsFor: 'accesing' stamp: 'PFT 6/7/2018 20:12:41'!
transactionAmount
	
	^transactionAmount! !


!CreditCard methodsFor: 'initialization' stamp: 'PFT 6/7/2018 23:51:32'!
initializeWith: aCreditCardNumber expiring: expirationDate owner: aName transactionAmount: anAmount.

	number:= aCreditCardNumber.
	expiration:= expirationDate.
	owner:= aName.
	transactionAmount := anAmount


	! !


!CreditCard methodsFor: 'queries' stamp: 'PFT 6/7/2018 23:55:48'!
isExpiredOn: aDate

	^expiration < aDate
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'PFT 6/7/2018 20:47:53'!
number: aCreditCardNumber expiring: expirationDate owner: aName transactionAmount: anAmount

	^self new initializeWith: aCreditCardNumber expiring: expirationDate owner: aName transactionAmount: anAmount.! !
