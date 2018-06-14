!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'aTestFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'support' stamp: 'LR 6/13/2018 18:57:50'!
setUp
	aTestFactory := TestFactory new.! !


!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:00:48'!
test01NewCartsAreCreatedEmpty

	self assert: aTestFactory aCart isEmpty! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:17:12'!
test02CanNotAddItemsThatDoNotBelongToStore
	self
		should: [ aTestFactory aCart add: aTestFactory aProductNotForSale ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aTestFactory aCart invalidItemErrorMessage.
			self assert: aTestFactory aCart isEmpty ].! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:15:58'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore
	aTestFactory aCart add: aTestFactory aProductForSaleA.
	self deny: aTestFactory aCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:16:27'!
test03CanAddMoreThanOneProductToCart
	aTestFactory aCart add: aTestFactory aProductForSaleA.
	aTestFactory aCart add: aTestFactory aProductForSaleB.
	self
		assert: 2
		equals: aTestFactory aCart productsCount.
	self assert: (aTestFactory aCart includes: aTestFactory aProductForSaleA).
	self assert: (aTestFactory aCart includes: aTestFactory aProductForSaleB).! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:15:58'!
test04CanNotAddNonPositiveNumberOfItems
	self
		should: [
			aTestFactory aCart
				add: 0
				of: aTestFactory aProductForSaleA ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aTestFactory aCart invalidQuantityErrorMessage = anError messageText.
			self assert: aTestFactory aCart isEmpty ].! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:17:12'!
test05canNotAddMoreThanOneProductNotIncludedInCatalogue
	self
		should: [
			aTestFactory aCart
				add: 2
				of: aTestFactory aProductNotForSale ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aTestFactory aCart invalidItemErrorMessage = anError messageText.
			self assert: aTestFactory aCart isEmpty ].! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:15:58'!
test06CartRemembersAddedItems
	aTestFactory aCart add: aTestFactory aProductForSaleA.
	self assert: (aTestFactory aCart includes: aTestFactory aProductForSaleA).! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:15:58'!
test07CanAddMultipleUnitsOfASameProduct
	| unitsCount |
	unitsCount _ 3.
	aTestFactory aCart
		add: unitsCount
		of: aTestFactory aProductForSaleA.
	self
		assert: unitsCount
		equals: aTestFactory aCart productsCount.
	self
		assert: unitsCount
		equals: (aTestFactory aCart unitsOf: aTestFactory aProductForSaleA).! !

!CartTest methodsFor: 'testing' stamp: 'LR 6/13/2018 19:16:27'!
test08CanAddMultipleUnitsForMoreThanOneProduct
	| unitsCountForA unitsCountForB |
	unitsCountForA _ 3.
	unitsCountForB _ 2.
	aTestFactory aPriceList
		at: aTestFactory aProductForSaleA
		put: 10.
	aTestFactory aPriceList
		at: aTestFactory aProductForSaleB
		put: 50.
	aTestFactory aCart
		add: unitsCountForA
		of: aTestFactory aProductForSaleA.
	aTestFactory aCart
		add: unitsCountForB
		of: aTestFactory aProductForSaleB.
	self
		assert: unitsCountForA + unitsCountForB
		equals: aTestFactory aCart productsCount.
	self
		assert: unitsCountForA
		equals: (aTestFactory aCart unitsOf: aTestFactory aProductForSaleA).
	self
		assert: unitsCountForB
		equals: (aTestFactory aCart unitsOf: aTestFactory aProductForSaleB).
	self assert: (aTestFactory aCart includes: aTestFactory aProductForSaleA).
	self assert: (aTestFactory aCart includes: aTestFactory aProductForSaleB).! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'merchantInteraction aTestFactory merchantCalled'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:57:44'!
test01CheckOutOfEmptyCartRaiseException
	
	self
		should: [
			(Cashier
				toCheckout: aTestFactory aCart
				charging: aTestFactory aNotExpiredCreditCard
				on: aTestFactory today
				registeringOn: aTestFactory aSalesBook) checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aTestFactory aCart isEmpty.
			self assert: Cashier canNotcheckOutEmptyCart equals: anError messageText.
			self assert: aTestFactory aSalesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:57:37'!
test02TotalOfCheckOutIsEqualOfPriceProduct
 
	| aCashier |
	
	aTestFactory aCart add: aTestFactory aProductForSaleA.

	aCashier _ Cashier
		toCheckout: aTestFactory aCart
		charging: aTestFactory aNotExpiredCreditCard
		on: aTestFactory today
		registeringOn: aTestFactory aSalesBook.
	self assert: aCashier checkOut equals: (aTestFactory aPriceList at: aTestFactory aProductForSaleA).! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:57:30'!
test03CashierCheckoutsAQuantityOfSameProduct

	| aCashier |
	
	aTestFactory aCart add: 3 of: aTestFactory aProductForSaleA.
	aTestFactory aCart add: 2 of: aTestFactory aProductForSaleB.

	aCashier _ Cashier
		toCheckout: aTestFactory aCart
		charging: aTestFactory aNotExpiredCreditCard
		on: aTestFactory today
		registeringOn: aTestFactory aSalesBook.

	self assert: aCashier checkOut equals: aTestFactory priceOfProductA * 3 + (aTestFactory priceOfProductB * 2).
	self deny: aTestFactory aSalesBook isEmpty.! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:48:39'!
test04CashierRaiseExceptionWhenCheckoutOfExpiredCreditCard
	
	aTestFactory aCart add: 3 of: aTestFactory aProductForSaleA.
	aTestFactory aCart add: 2 of: aTestFactory aProductForSaleB.
	
	self
		should: [
			(Cashier
				toCheckout: aTestFactory aCart
				charging: aTestFactory anExpiredCreditCard
				on: aTestFactory today
				registeringOn: aTestFactory aSalesBook) checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self deny: aTestFactory aCart isEmpty.
			self assert: Cashier expiredCreditCard 	equals: anError messageText.
			self assert: (aTestFactory aCart includesAll: {aTestFactory aProductForSaleA. aTestFactory aProductForSaleB}).
			self assert: aTestFactory aSalesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:52:35'!
test05creditCardIsStolen
	
	| aCashier |

	aTestFactory aCart add: 3 of: aTestFactory aProductForSaleA.
	aTestFactory aCart add: 2 of: aTestFactory aProductForSaleB.
	
	aCashier _ Cashier
		toCheckout: aTestFactory aCart
		charging: aTestFactory aNotExpiredCreditCard
		on: aTestFactory today
		registeringOn: aTestFactory aSalesBook.

	merchantInteraction _ [ self error: 'Tarjeta Robada' ].

	self
		should: [ aCashier checkOutUsing: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cashier stolenCreditCard equals: anError messageText.
			self assert: (aTestFactory aCart includesAll: {aTestFactory aProductForSaleA. aTestFactory aProductForSaleB}).
			self assert: aTestFactory aSalesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:52:58'!
test06CreditCardNoCredit

	| aCashier |

	aTestFactory aCart add: 3 of: aTestFactory aProductForSaleA.
	aTestFactory aCart add: 2 of: aTestFactory aProductForSaleB.
	
	aCashier _ Cashier
		toCheckout: aTestFactory aCart
		charging: aTestFactory aNotExpiredCreditCard
		on: aTestFactory today
		registeringOn: aTestFactory aSalesBook.
	
	merchantInteraction _ [ self error: 'Tarjeta sin crédito' ].

	self
		should: [ aCashier checkOutUsing: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cashier noCreditCreditCard equals: anError messageText.
			self assert: (aTestFactory aCart includesAll: {aTestFactory aProductForSaleA. aTestFactory aProductForSaleB}).
			self assert: aTestFactory aSalesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:57:13'!
test07DebitIsSuccessful
	
	| total aCashier |

	aTestFactory aCart add: 3 of: aTestFactory aProductForSaleA.
	aTestFactory aCart add: 2 of: aTestFactory aProductForSaleB.

	aCashier _ Cashier
		toCheckout: aTestFactory aCart
		charging: aTestFactory aNotExpiredCreditCard
		on: aTestFactory today
		registeringOn: aTestFactory aSalesBook.

	merchantCalled _ false.

	merchantInteraction _ [ merchantCalled _ true ].

	self
		shouldnt: [ total _ aCashier checkOutUsing: self ]
		raise: Error.
	self assert: merchantCalled.
	self assert: aTestFactory aSalesBook notEmpty.
	self assert: aTestFactory aSalesBook first total = total.! !

!CashierTest methodsFor: 'testing' stamp: 'PFT 6/14/2018 13:56:41'!
test08NoInteractionWithMerchantProcessorWhenExpiredCreditCard

	aTestFactory aCart add: 3 of: aTestFactory aProductForSaleA.
	aTestFactory aCart add: 2 of: aTestFactory aProductForSaleB.
	
	merchantCalled _ false.
	
	merchantInteraction _ [ merchantCalled _ true ].
	
	self
		should: [
			(Cashier
				toCheckout: aTestFactory aCart
				charging: aTestFactory anExpiredCreditCard
				on: aTestFactory today
				registeringOn: aTestFactory aSalesBook) checkOutUsing: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cashier expiredCreditCard equals: anError messageText.
			self deny: merchantCalled ].! !


!CashierTest methodsFor: 'support' stamp: 'PFT 6/11/2018 21:16:28'!
debit: anAmount from: aCreditCard

	merchantInteraction value! !

!CashierTest methodsFor: 'support' stamp: 'LR 6/13/2018 19:27:42'!
setUp
	aTestFactory := TestFactory new.! !


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
	instanceVariableNames: 'cart creditCard salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'PFT 6/11/2018 19:30:18'!
initializeFor: aCart with: aCreditCard registeringOn: aSalesBook
	
	creditCard _ aCreditCard.
	cart _ aCart.
	salesBook := aSalesBook.


	
! !


!Cashier methodsFor: 'accesing' stamp: 'LR 6/14/2018 10:43:34'!
checkOut
	|totalPrice priceList|

	priceList := cart priceList .
	totalPrice := 0.
	cart productsDo: [:product | totalPrice := totalPrice + (priceList at: product)].
		
	salesBook add: (Sale of: totalPrice).
		
	^totalPrice
	
	
! !

!Cashier methodsFor: 'accesing' stamp: 'PFT 6/14/2018 13:51:51'!
checkOutUsing: aMerchantProcessor

	| totalPrice priceList |

	priceList _ cart priceList.
	totalPrice _ 0.
	cart productsDo: [ :product | totalPrice _ totalPrice + (priceList at: product) ].

	aMerchantProcessor debit: totalPrice from: creditCard.
	
	salesBook add: (Sale of: totalPrice).
	
	^ totalPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'PFT 6/11/2018 19:29:24'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [ self error: self canNotcheckOutEmptyCart ]

	! !

!Cashier class methodsFor: 'assertions' stamp: 'PFT 6/11/2018 19:28:31'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self expiredCreditCard ]

	
! !


!Cashier class methodsFor: 'instance creation' stamp: 'PFT 6/14/2018 13:46:07'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook
	self assertIsNotEmpty: aCart.
	self
		assertIsNotExpired: aCreditCard
		on: aDate.
	^ self new
		initializeFor: aCart
		with: aCreditCard
		registeringOn: aSalesBook.! !


!Cashier class methodsFor: 'error messages' stamp: 'PFT 6/10/2018 15:15:16'!
canNotcheckOutEmptyCart

	^'No se puede cobrar un carro vacío'! !

!Cashier class methodsFor: 'error messages' stamp: 'PFT 6/10/2018 15:15:30'!
expiredCreditCard

	^'La tarjeta de crédito que desea utilizar expiró'! !

!Cashier class methodsFor: 'error messages' stamp: 'PFT 6/11/2018 20:22:22'!
noCreditCreditCard

	^'Tarjeta sin crédito'! !

!Cashier class methodsFor: 'error messages' stamp: 'PFT 6/11/2018 20:20:12'!
stolenCreditCard

	^'Tarjeta Robada'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accesing' stamp: 'PFT 6/7/2018 23:51:15'!
creditCardNumber
	
	^number! !

!CreditCard methodsFor: 'accesing' stamp: 'PFT 6/7/2018 23:51:10'!
creditCardOwner
	
	^owner! !


!CreditCard methodsFor: 'initialization' stamp: 'LR 6/14/2018 10:55:57'!
initializeWith: aCreditCardNumber expiring: expirationDate owner: aName

	number:= aCreditCardNumber.
	expiration:= expirationDate.
	owner:= aName.


	! !


!CreditCard methodsFor: 'queries' stamp: 'PFT 6/11/2018 18:15:23'!
isExpiredOn: aDate

	^expiration < aDate
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LR 6/14/2018 10:56:27'!
number: aCreditCardNumber expiring: expirationDate owner: aName

	^self new initializeWith: aCreditCardNumber expiring: expirationDate owner: aName! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'PFT 6/11/2018 18:40:09'!
initializeWith: anAmount

	total := anAmount! !


!Sale methodsFor: 'accesing' stamp: 'PFT 6/11/2018 19:32:19'!
total

	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: 'total'!

!Sale class methodsFor: 'instance creation' stamp: 'PFT 6/11/2018 18:39:52'!
of: anAmount

	^self new initializeWith: anAmount! !


!classDefinition: #TestFactory category: #TusLibros!
Object subclass: #TestFactory
	instanceVariableNames: 'aCart aProductNotSell aPriceList aProductSellA aProductSellB priceOfProductA priceOfProductB aSalesBook today anExpiredCreditCard aNotExpiredCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:02:47'!
aCart
	^aCart ! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/14/2018 10:41:25'!
aNotExpiredCreditCard
	^ aNotExpiredCreditCard.! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:09:14'!
aPriceList
	^aPriceList! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:15:58'!
aProductForSaleA
	^ aProductSellA.! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:16:27'!
aProductForSaleB
	^ aProductSellB.! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:17:12'!
aProductNotForSale
	^ aProductNotSell.! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:25:39'!
aSalesBook
	^aSalesBook ! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/14/2018 10:41:05'!
anExpiredCreditCard
	^ anExpiredCreditCard.! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:25:04'!
priceOfProductA
	^priceOfProductA! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:25:14'!
priceOfProductB
	^priceOfProductB! !

!TestFactory methodsFor: 'support' stamp: 'LR 6/13/2018 19:29:54'!
today
	^today ! !


!TestFactory methodsFor: 'initialization' stamp: 'LR 6/14/2018 10:56:56'!
initialize
	| lastMonthOfCurrentYear nextMonthOfCurrentYear |
	today _ FixedGregorianDate today.
	lastMonthOfCurrentYear _ GregorianMonthOfYear
		year: today year
		month: (GregorianMonth numbered: today month number - 1).
	nextMonthOfCurrentYear _ GregorianMonthOfYear
		year: today year
		month: (GregorianMonth numbered: today month number + 1).
	aProductNotSell _ Object new.
	aProductSellA _ Object new.
	priceOfProductA _ 10 * peso.
	aProductSellB _ Object new.
	priceOfProductB _ 23 * peso.
	aPriceList _ Dictionary new.
	aPriceList
		at: aProductSellA
		put: priceOfProductA.
	aPriceList
		at: aProductSellB
		put: priceOfProductB.
	aCart _ Cart acceptingItemsOf: aPriceList.
	aSalesBook _ OrderedCollection new.
	aNotExpiredCreditCard _ CreditCard
		number: 4500450045004500
		expiring: nextMonthOfCurrentYear
		owner: 'Rodolfo Games'.
	anExpiredCreditCard _ CreditCard
		number: 4545454
		expiring: lastMonthOfCurrentYear
		owner: 'Jorge Lopez'.! !
