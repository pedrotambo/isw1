!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart aProduct aProductA aProductB aCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'support' stamp: 'PFT 6/7/2018 18:45:09'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'PFT 6/8/2018 00:31:19'!
defaultCatalog
	
	|defaultCatalog|
	defaultCatalog :=Dictionary new.
	defaultCatalog at: self itemSellByTheStore put: 10.
	^defaultCatalog
	! !

!CartTest methodsFor: 'support' stamp: 'PFT 6/7/2018 18:45:17'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'PFT 6/7/2018 18:47:45'!
itemSellByTheStore
	
	^ 'validBook'! !

!CartTest methodsFor: 'support' stamp: 'PFT 6/8/2018 00:30:51'!
setUp

	aProduct := Object new.
	aProductA := Object new.
	aProductB := Object new.

	aCatalog := Dictionary new.
	aCatalog at: aProductA put: 10.
	aCatalog at: aProductB put: 20.
	
	
	aCart := Cart acceptingItemsOf: aCatalog.! !


!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 18:48:05'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 18:49:48'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage .
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 18:50:32'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 18:01:32'!
test03canAddMoreThanOneProductToCart

	aCart add: aProductA.
	aCart add: aProductB.
	
	self assert: 2 equals: aCart productsCount.
	self assert: (aCart includes: aProductA).
	self assert: (aCart includes: aProductB)! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/8/2018 00:37:13'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 20:34:56'!
test04canAddProductsFromCatalogue
	aCatalog at: aProductA put: 1.
	aCatalog at: aProductB put: 1.
	aCart add: aProductA .
	aCart add: aProductB.
	
	self assert: 2 equals: aCart productsCount.
	self assert: (aCart includes: aProductA).
	self assert: (aCart includes: aProductB).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/8/2018 00:33:32'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 19:05:27'!
test05canNotAddProductNotIncludedInCatalogue
	
	self
		should: [ aCart add: aProduct ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aCart isEmpty.
			self assert: aCart invalidItemErrorMessage equals: anError messageText ].
			
	! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 19:06:22'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/8/2018 00:37:29'!
test06canAddMultipleUnitsOfASameProduct
	| unitsCount |
	unitsCount _ 3.
	aCart add: unitsCount of: aProductA.
	self assert: unitsCount equals: aCart productsCount.
	self assert: unitsCount equals: (aCart unitsOf: aProductA).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 19:06:34'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/8/2018 00:36:07'!
test07canAddMultipleUnitsOfASameProductFromCatalogue
	| unitsCount |
	unitsCount _ 3.
	aCatalog
		at: aProduct
		put: 10.
	aCart
		add: unitsCount
		of: aProduct.
	self
		assert: unitsCount
		equals: aCart productsCount.
	self
		assert: unitsCount
		equals: (aCart unitsOf: aProduct).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/8/2018 00:36:07'!
test08CartRemembersTheNumberOfAddedItems
	| cart |
	cart _ self createCart.
	cart
		add: 2
		of: self itemSellByTheStore.
	self assert: (cart unitsOf: self itemSellByTheStore) = 2.! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/8/2018 01:11:38'!
test08canAddMultipleUnitsForMoreThanOneProduct
	| unitsCountForA unitsCountForB |
	unitsCountForA _ 3.
	unitsCountForB _ 2.
	aCatalog at: aProductA put: 10.
	aCatalog at: aProductB put: 50.
	aCart add: unitsCountForA of: aProductA.
	aCart add: unitsCountForB of: aProductB.
	self assert: unitsCountForA + unitsCountForB equals: aCart productsCount.
	self assert: unitsCountForA equals: (aCart unitsOf: aProductA).
	self assert: unitsCountForB equals: (aCart unitsOf: aProductB).
	

	self assert: (aCart includes: aProductA).
	self assert: (aCart includes: aProductB).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 18:26:01'!
test09canRemoveProductFromCart
	
	aCart add: aProductA.
	self deny: aCart isEmpty.
	aCart removeProduct: aProductA.
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/8/2018 01:08:40'!
test10canNotRemoveProductNotIncludedInCart
	
	self
		should: [aCart removeProduct: aProduct] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: aCart isEmpty.
			self assert: aCart productIsNotInTheCart equals: anError messageText
		]! !


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


!CashierTest methodsFor: 'support' stamp: 'PFT 6/7/2018 19:19:54'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'PFT 6/7/2018 19:20:03'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CashierTest methodsFor: 'support' stamp: 'PFT 6/7/2018 19:20:15'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'PFT 6/7/2018 19:20:21'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'PFT 6/8/2018 12:13:26'!
setUp

	aProduct := Object new. 
 	aProductA := Object new.
	aProductB := Object new.
	priceOfProductA := 10 * peso.
	priceOfProductB := 23 * peso.
	
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
	
	priceList := Dictionary new.
	priceList at: aProductA put: priceOfProductA .
	priceList at: aProductB put: priceOfProductB .
	
	aCart := Cart acceptingItemsOf: priceList.
	
	
	


	
! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'productsUnits catalog'
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

!Cart methodsFor: 'accesing' stamp: 'PFT 6/10/2018 14:58:42'!
priceList
	^ catalog copy.! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/7/2018 17:59:36'!
productsCount

	^productsUnits size! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/8/2018 01:00:40'!
productsDo: aBlock

	^ productsUnits do: [:product | aBlock value: product]! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/8/2018 00:38:05'!
unitsOf: aProduct
	^ productsUnits occurrencesOf: aProduct.! !


!Cart methodsFor: 'initialization' stamp: 'PFT 6/7/2018 18:54:02'!
initializeWith: aCatalog

	productsUnits := Bag new.
	catalog := aCatalog.! !


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


!Cart methodsFor: 'assertions' stamp: 'PFT 6/7/2018 20:29:41'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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
