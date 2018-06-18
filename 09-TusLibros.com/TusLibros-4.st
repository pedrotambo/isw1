!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
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


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosSystemTest category: #TusLibros!
TestCase subclass: #TusLibrosSystemTest
	instanceVariableNames: 'testObjectsFactory system timeNow user password invalidUser invalidPassword today pastMonth nextMonth cartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemTest methodsFor: 'support' stamp: 'PFT 6/18/2018 14:47:40'!
createCartWithProducts: aCollectionOfProductsWithQuantities
	
	| cartID | 
	
	cartID := system createCartFor: user using: password.
	aCollectionOfProductsWithQuantities keysAndValuesDo: [:key :value |
		system add: value of: key to: cartID.
	].

	^cartID.

	! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'PFT 6/18/2018 00:04:05'!
debit: anAmount from: aCreditCard 

! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'PFT 6/18/2018 03:40:39'!
defaultProducts

	| products |
	
	products := Dictionary new.
	
	products at: testObjectsFactory itemSellByTheStore put: 1.
	products at: testObjectsFactory anotherItemSellByTheStore put: 2.
	
	^products
	! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'PFT 6/17/2018 23:29:16'!
now

	^ timeNow value! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'PFT 6/18/2018 03:29:02'!
systemCheckOutWithNotExpiredCreditCard: aCartID
	
	^system 
		checkOut: aCartID 
		charging: 4545450046003200
		expiring: nextMonth
		owner: 'Pepe Sánchez'.
	! !


!TusLibrosSystemTest methodsFor: 'setUp' stamp: 'PFT 6/18/2018 14:47:45'!
setUp
	testObjectsFactory _ StoreTestObjectsFactory new.
	
	system _ TusLibrosSystem
		acceptingItemsOf: testObjectsFactory defaultCatalog
		with: testObjectsFactory defaultClients
		throught: self
		usingTimeOf: self.
	
	timeNow _ [ DateAndTime now ].
	
	user _ testObjectsFactory defaultClient.
	password _ testObjectsFactory defaultPassword.
	invalidUser _ testObjectsFactory defaultInvalidClient.
	invalidPassword _ testObjectsFactory defaultInvalidPassword.
	today _ testObjectsFactory today.
	nextMonth _ Month month: today monthIndex year: today yearNumber + 1.
	pastMonth _ Month month: today monthIndex year: today yearNumber - 1.
	
	cartID := system createCartFor: user using: password.! !


!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 14:47:50'!
test01SystemCanCreateCartWithValidUserAndPass

	| cartID |
	
	cartID := system createCartFor: user using: password.

	self assert: (system list: cartID) isEmpty.
	
	
	
	
	
	

! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 14:47:54'!
test02SystemCanNotCreateCartWithInvalidUser

	self 
		should: [system createCartFor: invalidUser using: password]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: anError messageText = system errorInvalidClientMessage.
		].

	
	
	
	
	
	

! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 14:47:58'!
test03SystemCanNotCreateCartWithInvalidPassword

	self 
		should: [system createCartFor: user using: invalidPassword]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: anError messageText = system errorInvalidPasswordMessage.
		].

	
	
	
	
	
	

! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 03:32:41'!
test04SystemCanAddItemToValidCart

	system add: 1 of: testObjectsFactory itemSellByTheStore to: cartID.
	
	self assert: ( (system list: cartID) includes: testObjectsFactory itemSellByTheStore).
	

	
	
	
	

! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 03:41:21'!
test05SystemCanMoreThanOneItemToValidCart

	| items |
	
	system add: 1 of: testObjectsFactory itemSellByTheStore to: cartID.
	system add: 2 of: testObjectsFactory anotherItemSellByTheStore to: cartID.

	items := system list: cartID.

	self assert: (items includes: testObjectsFactory itemSellByTheStore).
	self assert: (items occurrencesOf: testObjectsFactory itemSellByTheStore) = 1.

	self assert: (items includes: testObjectsFactory anotherItemSellByTheStore).
	self assert: (items occurrencesOf: testObjectsFactory anotherItemSellByTheStore) = 2.


	
	
	
	
	
	

! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 03:43:02'!
test06CanCheckOutCartWithNotExpiredCreditCard
	
	| cartID |
	
	cartID := self createCartWithProducts: self defaultProducts.

	system 
		checkOut: cartID 
		charging: 4545450046003200 
		expiring: nextMonth 
		owner: 'Pepe Sánchez'.
	
	
	
	
	
	

! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 03:40:53'!
test07CanNotCheckOutCartWithExpiredCreditCard
	| cartID |
	
	cartID := self createCartWithProducts: self defaultProducts.

	self should: [
		system 
			checkOut: cartID 
			charging: 4545450046003200 
			expiring: pastMonth
			owner: 'Pepe Sánchez'. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |		
				self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.]
	
	
	
	
	
	

! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 04:03:00'!
test08CanListOnePurchaseOfClient
	| items listOfpurchases purchases cartID |

	cartID := self createCartWithProducts: self defaultProducts.

	items _ system list: cartID.
	
	self assert: (items includes: testObjectsFactory itemSellByTheStore).
	self assert: (items occurrencesOf: testObjectsFactory itemSellByTheStore) = 1.
	self assert: (items includes: testObjectsFactory anotherItemSellByTheStore).
	self assert: (items occurrencesOf: testObjectsFactory anotherItemSellByTheStore) = 2.
	
	system
		checkOut: cartID
		charging: 4545450046003200
		expiring: nextMonth
		owner: 'Pepe Sánchez'.
	
	listOfpurchases _ system listPurchasesOf: user with: password.
	purchases _ listOfpurchases key.
	self assert: (purchases includes: testObjectsFactory itemSellByTheStore).
	self assert: (purchases includes: testObjectsFactory anotherItemSellByTheStore).
	self assert: listOfpurchases value equals: testObjectsFactory itemSellByTheStorePrice + (2 * testObjectsFactory anotherItemSellByTheStorePrice).! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 03:52:14'!
test09CanListMoreThanOnePurchaseOfClient
	| cartID otherCartID purchases |

	cartID := self createCartWithProducts: self defaultProducts.
	otherCartID := self createCartWithProducts: (Dictionary new at: (testObjectsFactory itemSellByTheStore) put: 3; yourself).
	
	self systemCheckOutWithNotExpiredCreditCard: cartID.
	self systemCheckOutWithNotExpiredCreditCard: otherCartID.

	purchases _ system listPurchasesOf: user with: password.
	
	self assert: (purchases key includes: testObjectsFactory itemSellByTheStore).
	self assert: (purchases key includes: testObjectsFactory anotherItemSellByTheStore).
	self assert: purchases value equals: 4 * testObjectsFactory itemSellByTheStorePrice + (2 * testObjectsFactory anotherItemSellByTheStorePrice).! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 04:07:59'!
test10CanNotListExpiredCart

	| cartID |
	
	cartID := self createCartWithProducts: self defaultProducts.

	timeNow := [DateAndTime now + (Duration minutes: 30)].
	
	self 
		should: [ system list: cartID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: system errorSessionExpiredMessage equals: anError messageText.
		]

	! !

!TusLibrosSystemTest methodsFor: 'testing' stamp: 'PFT 6/18/2018 04:08:08'!
test11CanNotCheckOutExpiredCart
	
	| cartID |
	
	cartID := self createCartWithProducts: self defaultProducts.

	timeNow _ [ DateAndTime now + (Duration minutes: 30) ].
	self
		should: [ self systemCheckOutWithNotExpiredCreditCard: cartID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: system errorSessionExpiredMessage
				equals: anError messageText ].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'PFT 6/17/2018 21:18:20'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


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


!Cart methodsFor: 'accesing' stamp: 'PFT 6/18/2018 02:01:16'!
items

	^items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'PFT 6/18/2018 02:25:47'!
createSale

	^ Sale of: total for: cart items 
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
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'PFT 6/16/2018 19:39:19'!
initializeWith: creditCardNumber expiring: aMonthOfYear owner: aName

	number := creditCardNumber.
	expiration := aMonthOfYear.
	owner := aName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'PFT 6/16/2018 19:38:42'!
number: creditCardNumber expiring: aMonthOfYear owner: aName

	^self new initializeWith: creditCardNumber expiring: aMonthOfYear owner: aName! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'PFT 6/18/2018 02:27:07'!
items
	
	^ items! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'PFT 6/18/2018 02:26:29'!
initializeTotal: aTotal for: aCollectionOfItems

	total := aTotal.
	items := aCollectionOfItems! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'PFT 6/18/2018 02:26:09'!
of: aTotal for: aCollectionOfItems

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal for: aCollectionOfItems! !


!classDefinition: #Session category: #TusLibros!
Object subclass: #Session
	instanceVariableNames: 'client cart creation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'initialization' stamp: 'PFT 6/18/2018 01:32:11'!
initializeFor: aClientID acceptingItemsOf: aCatalog createdOn: aTime
	client _ aClientID.
	cart _ Cart acceptingItemsOf: aCatalog.
	creation _ aTime.! !


!Session methodsFor: 'adding' stamp: 'PFT 6/18/2018 01:18:20'!
addToCart: anAmount of: aProduct

	cart add: anAmount of: aProduct.! !


!Session methodsFor: 'accesing' stamp: 'PFT 6/17/2018 15:48:01'!
cart

	^cart! !

!Session methodsFor: 'accesing' stamp: 'PFT 6/17/2018 15:48:14'!
client

	^client! !

!Session methodsFor: 'accesing' stamp: 'PFT 6/18/2018 01:32:11'!
isExpiredOn: aTime
	^ (Duration minutes: 30) < (creation to: aTime) duration.! !

!Session methodsFor: 'accesing' stamp: 'PFT 6/18/2018 03:05:52'!
items

	^cart items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: #TusLibros!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'PFT 6/18/2018 01:32:42'!
for: aClientID acceptingItemsOf: aCart createdOn: aTime
	^ self new
		initializeFor: aClientID
		acceptingItemsOf: aCart
		createdOn: aTime.! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PFT 6/15/2018 14:03:25'!
anotherItemSellByTheStore
	
	^ 'other validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PFT 6/15/2018 14:05:47'!
anotherItemSellByTheStorePrice
	
	^20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'PFT 6/17/2018 16:22:21'!
anotherClient
	^ 'another valid user'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'PFT 6/17/2018 16:22:48'!
anotherClientPassword
	^ 'another valid password'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'PFT 6/14/2018 21:19:05'!
defaultClient
	^ 'valid user'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'PFT 6/14/2018 21:20:19'!
defaultClients
	
	^ Dictionary new	
		at: self defaultClient
		put: self defaultPassword;
		yourself.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'PFT 6/14/2018 21:27:22'!
defaultInvalidClient
	^ 'invalid user'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'PFT 6/14/2018 21:32:06'!
defaultInvalidPassword

	^'invalid password'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'PFT 6/14/2018 21:19:38'!
defaultPassword
	^ 'valid password'.! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'PFT 6/18/2018 03:21:08'!
defaultCatalog
	
	| catalog |
	

	catalog := Dictionary new.
	catalog at: self itemSellByTheStore put: self itemSellByTheStorePrice.
	catalog at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice.
	
	^catalog
		! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PFT 6/16/2018 19:40:53'!
notExpiredCreditCard
	
	
	^CreditCard number: 4545460045003400 expiring: (Month month: today monthIndex year: today yearNumber + 1) owner: 'Pepe Sanchez'.
	
	
"	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)"! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosSystem category: #TusLibros!
Object subclass: #TusLibrosSystem
	instanceVariableNames: 'catalog merchantProcessor clientsDataBase transactionID systemTime cartID sessions salesBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystem methodsFor: 'initialization' stamp: 'PFT 6/18/2018 15:38:22'!
initializeAcepptingItemsOf: aCatalog with: aClientsDataBase throught: aMerchantProcessor usingTimeOf: aSystemTime
	catalog _ aCatalog.
	merchantProcessor _ aMerchantProcessor.
	systemTime _ aSystemTime.
	
	"ID Client -> Password"
	clientsDataBase _ aClientsDataBase.

	"ID Cart -> (ClientID, Cart, creation)"
	sessions _ Dictionary new.

	"ID Client -> Sales"
	salesBooks _ Dictionary new.
	
	cartID _ 0.
	transactionID _ 0.
	
	
! !


!TusLibrosSystem methodsFor: 'queries' stamp: 'PFT 6/18/2018 02:19:48'!
add: anAmount of: aProduct to: aCartID
	
	self assertValidCartAndSessionIsNotExpired: aCartID.

	(sessions at: aCartID) addToCart: anAmount of: aProduct.! !

!TusLibrosSystem methodsFor: 'queries' stamp: 'PFT 6/18/2018 14:40:57'!
checkOut: cartID charging: aCreditCardNumber expiring: aMonthOfYear owner: aName

	self assertValidCartAndSessionIsNotExpired: cartID.
	self checkOut: cartID charging: (CreditCard number: aCreditCardNumber expiring: aMonthOfYear owner: aName).	
	self finishSessionOf: cartID.
	
	^self newTransactionID.! !

!TusLibrosSystem methodsFor: 'queries' stamp: 'PFT 6/18/2018 14:48:37'!
createCartFor: aClientID using: passwordOfClient
	| cartID |
	
	self authenticate: aClientID using: passwordOfClient.

	cartID _ self newCartID.
	sessions at: cartID put: 	(Session for: aClientID acceptingItemsOf: catalog createdOn: systemTime now).

	^ cartID.


	! !

!TusLibrosSystem methodsFor: 'queries' stamp: 'PFT 6/18/2018 03:06:20'!
list: aCartID

	self assertValidCartAndSessionIsNotExpired: aCartID.
	
	^(sessions at: aCartID) items! !

!TusLibrosSystem methodsFor: 'queries' stamp: 'PFT 6/18/2018 14:49:10'!
listPurchasesOf: aClientID with: passwordOfClient
	| purchases total |
	
	self authenticate: aClientID using: passwordOfClient.

	purchases := Bag new.
	total := 0.
	(self salesBookOf: aClientID) do: [:sale |		
		purchases addAll: sale items.
		total := total + sale total ].

	^purchases -> total
	! !


!TusLibrosSystem methodsFor: 'error messages' stamp: 'PFT 6/18/2018 01:02:13'!
errorInvalidCartMessage

	^'ID de Carrito inválido'! !

!TusLibrosSystem methodsFor: 'error messages' stamp: 'PFT 6/14/2018 20:44:07'!
errorInvalidClientMessage

	^'Cliente inválido'! !

!TusLibrosSystem methodsFor: 'error messages' stamp: 'PFT 6/14/2018 20:44:19'!
errorInvalidPasswordMessage

	^'La contraseña es inválida'! !

!TusLibrosSystem methodsFor: 'error messages' stamp: 'PFT 6/17/2018 23:21:06'!
errorSessionExpiredMessage

	^'La sesión del carrito expiró'! !


!TusLibrosSystem methodsFor: 'assertions' stamp: 'PFT 6/18/2018 04:06:17'!
assertSessionIsNotExpiredFor: aCartID
	
	((sessions at: aCartID) isExpiredOn: systemTime now)
			ifTrue: [sessions removeKey: aCartID. self error: self errorSessionExpiredMessage ].! !

!TusLibrosSystem methodsFor: 'assertions' stamp: 'PFT 6/18/2018 01:54:35'!
assertValidCart: aCartID
	
	sessions at: aCartID ifAbsent: [ self error: self errorInvalidCartMessage ].

! !

!TusLibrosSystem methodsFor: 'assertions' stamp: 'PFT 6/18/2018 04:04:44'!
assertValidCartAndSessionIsNotExpired: aCartID
	self assertValidCart: aCartID.
	self assertSessionIsNotExpiredFor: aCartID.! !

!TusLibrosSystem methodsFor: 'assertions' stamp: 'PFT 6/18/2018 14:56:45'!
authenticate: aClientID using: passwordOfClient
	| passwordOfDB |
	passwordOfDB _ clientsDataBase
			at: aClientID 
			ifAbsent: [ self error: self errorInvalidClientMessage ].
	passwordOfDB = passwordOfClient ifFalse: [ self error: self errorInvalidPasswordMessage ].! !


!TusLibrosSystem methodsFor: 'queries - private' stamp: 'PFT 6/18/2018 14:56:26'!
checkOut: aCartID charging: aCreditCard
	
	| session cashier |
	
	session := sessions at: aCartID.
	cashier := Cashier
		toCheckout: session cart
		charging: aCreditCard
		throught: merchantProcessor
		on: systemTime now
		registeringOn: (self salesBookOf: session client).
	cashier checkOut
	! !

!TusLibrosSystem methodsFor: 'queries - private' stamp: 'PFT 6/18/2018 14:35:04'!
finishSessionOf: cartID

	sessions removeKey: cartID.! !

!TusLibrosSystem methodsFor: 'queries - private' stamp: 'PFT 6/18/2018 14:50:07'!
newCartID
	
	| newCartID |	
	newCartID _ cartID.	
	cartID _ cartID + 1.	
	^ newCartID.! !

!TusLibrosSystem methodsFor: 'queries - private' stamp: 'PFT 6/18/2018 14:49:54'!
newTransactionID

	| newTransactionID |
	newTransactionID := transactionID.
	transactionID := transactionID +1.
	^newTransactionID! !

!TusLibrosSystem methodsFor: 'queries - private' stamp: 'PFT 6/18/2018 03:02:17'!
salesBookOf: aClientID
	
	^salesBooks at: aClientID ifAbsentPut: [OrderedCollection new]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystem class' category: #TusLibros!
TusLibrosSystem class
	instanceVariableNames: ''!

!TusLibrosSystem class methodsFor: 'instance creation' stamp: 'PFT 6/17/2018 22:53:35'!
acceptingItemsOf: aCatalog with: aClientsDataBase throught: aMerchantProcessor usingTimeOf: aSystemTime

	^self new initializeAcepptingItemsOf: aCatalog with: aClientsDataBase throught: aMerchantProcessor usingTimeOf: aSystemTime.! !
