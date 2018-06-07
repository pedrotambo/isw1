!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart aCatalogue aProduct aProductA aProductB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'support' stamp: 'PFT 6/7/2018 14:08:09'!
setUp

	aCart := Cart new.
	aCatalogue := Catalogue new.
	aProduct := Product new.
	aProductA := Product new.
	aProductB := Product new.! !


!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:07:04'!
test01canCreateEmptyCart

	self assert: aCart isEmpty.
	self assert: 0 equals: aCart productsCount.! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:06:56'!
test02canAddProductToCart

	aCart addProduct: aProduct.
	self assert: (aCart includes: aProduct).
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:08:21'!
test03canAddMoreThanOneProductToCart

	aCart addProduct: aProductA.
	aCart addProduct: aProductB.
	
	self assert: 2 equals: aCart productsCount.
	self assert: (aCart includes: aProductA).
	self assert: (aCart includes: aProductB).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:08:30'!
test04canAddProductsFromCatalogue

	aCatalogue addProduct: aProductA.
	aCatalogue addProduct: aProductB.

	aCart addProduct: aProductA from: aCatalogue.
	aCart addProduct: aProductB from: aCatalogue.
	
	self assert: 2 equals: aCart productsCount.
	self assert: (aCart includes: aProductA).
	self assert: (aCart includes: aProductB).! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:14:21'!
test05canNotAddProductNotIncludedInCatalogue
	
	self 
		should: [ aCart addProduct: aProduct from: aCatalogue ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: aCart isEmpty.
			self assert: Cart productIsNotAvailableInTheCatalogue equals: anError messageText
		]! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:08:54'!
test06canAddMultipleUnitsOfASameProduct
	| unitsCount |

	unitsCount := 3.
	
	aCart addProduct: aProduct units: unitsCount.
	
	self assert: unitsCount equals: aCart productsCount.
	self assert: unitsCount equals: (aCart unitsOf: aProduct).
	! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:09:51'!
test07canAddMultipleUnitsOfASameProductFromCatalogue
	| unitsCount |

	unitsCount := 3.
	aCatalogue addProduct: aProduct.

	
	aCart addProduct: aProduct units: unitsCount from: aCatalogue.
	
	self assert: unitsCount equals: aCart productsCount.
	self assert: unitsCount equals: (aCart unitsOf: aProduct).
	! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:22:37'!
test08canAddMultipleUnitsForMoreThanOneProduct
	| unitsCountForA unitsCountForB products |

	unitsCountForA := 3.
	unitsCountForB := 2.
	aCatalogue addProducts: {aProductA. aProductB}.
	
	aCart addProduct: aProductA units: unitsCountForA from: aCatalogue.
	aCart addProduct: aProductB units: unitsCountForB from: aCatalogue.
	
	self assert: (unitsCountForA+unitsCountForB) equals: aCart productsCount.
	self assert: unitsCountForA equals: (aCart unitsOf: aProductA).
	self assert: unitsCountForB equals: (aCart unitsOf: aProductB).
	
	products := aCart products.
	self assert: (products includes: aProductA).
	self assert: (products includes: aProductB).
	! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:12:17'!
test09canRemoveProductFromCart
	
	aCart addProduct: aProduct.
	self deny: aCart isEmpty.
	
	aCart removeProduct: aProduct.
	self assert: aCart isEmpty.
	! !

!CartTest methodsFor: 'testing' stamp: 'PFT 6/7/2018 14:13:47'!
test10canNotRemoveProductNotIncludedInCart
	
	self
		should: [aCart removeProduct: aProduct] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: aCart isEmpty.
			self assert: Cart productIsNotInTheCart equals: anError messageText
		]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'productsUnits'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accesing' stamp: 'LR 6/6/2018 22:52:25'!
includes: aProduct

	^ productsUnits includesKey: aProduct.! !

!Cart methodsFor: 'accesing' stamp: 'LR 6/6/2018 22:49:28'!
isEmpty

	^productsUnits keys isEmpty! !

!Cart methodsFor: 'accesing' stamp: 'PFT 6/7/2018 14:20:43'!
products

	^ productsUnits keys copy! !

!Cart methodsFor: 'accesing' stamp: 'LR 6/6/2018 22:53:09'!
productsCount
	| sum |
	
	sum := 0.
	productsUnits valuesDo: [:units | sum := sum + units].
	^sum! !

!Cart methodsFor: 'accesing' stamp: 'LR 6/6/2018 22:57:42'!
unitsOf: aProduct 
	
	^productsUnits at: aProduct ifAbsent: [0]. ! !


!Cart methodsFor: 'initialization' stamp: 'LR 6/6/2018 22:46:36'!
initialize

	productsUnits := Dictionary new.! !


!Cart methodsFor: 'adding' stamp: 'LR 6/6/2018 22:46:45'!
addProduct: aProduct
		
	productsUnits add: (aProduct -> 1).
! !

!Cart methodsFor: 'adding' stamp: 'PFT 6/7/2018 14:02:29'!
addProduct: aProduct from: aCatalogue

	(aCatalogue includes: aProduct) 
		ifTrue: [self addProduct: aProduct ]
		ifFalse: [^self error: self class productIsNotAvailableInTheCatalogue]! !

!Cart methodsFor: 'adding' stamp: 'LR 6/6/2018 22:47:04'!
addProduct: aProduct units: numberOfUnitsToAdd
		
	productsUnits add: (aProduct -> numberOfUnitsToAdd).
! !

!Cart methodsFor: 'adding' stamp: 'PFT 6/7/2018 14:02:04'!
addProduct: aProduct units: numberOfUnits from: aCatalogue

	(aCatalogue includes: aProduct) 
		ifTrue: [self addProduct: aProduct units: numberOfUnits]
		ifFalse: [^self error: self class productIsNotAvailableInTheCatalogue]! !


!Cart methodsFor: 'removing' stamp: 'PFT 6/7/2018 14:00:23'!
removeProduct: aProduct

	productsUnits removeKey: aProduct ifAbsent: [self error: self class productIsNotInTheCart ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'PFT 6/4/2018 21:40:36'!
with: aLibrary

	^self new initializeWith: aLibrary! !


!Cart class methodsFor: 'error descriptions' stamp: 'PFT 6/7/2018 14:01:39'!
productIsNotAvailableInTheCatalogue

	^'El producto que desea agregar no se encuentra en el catálogo.'! !

!Cart class methodsFor: 'error descriptions' stamp: 'PFT 6/7/2018 14:01:43'!
productIsNotInTheCart

	^'El producto que desea quitar no se encuentra en el carrito.'! !


!classDefinition: #Catalogue category: #TusLibros!
Object subclass: #Catalogue
	instanceVariableNames: 'products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'initialization' stamp: 'LR 6/6/2018 22:50:37'!
initialize
	products := Set new.! !

!Catalogue methodsFor: 'initialization' stamp: 'LR 6/6/2018 22:50:43'!
initializeWith: aCollectionOfProducts
	products := Set new.
	aCollectionOfProducts do: [:aProduct | products add: aProduct]! !


!Catalogue methodsFor: 'accesing' stamp: 'PFT 6/5/2018 12:55:44'!
includes: aProduct 
	^products includes: aProduct ! !


!Catalogue methodsFor: 'adding' stamp: 'PFT 6/5/2018 12:51:35'!
addProduct: aProduct 
	products add: aProduct! !

!Catalogue methodsFor: 'adding' stamp: 'PFT 6/7/2018 14:10:49'!
addProducts: aCollectionOfProducts
	
	aCollectionOfProducts do: [:product | products add: product]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: #TusLibros!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'instance creation' stamp: 'PFT 6/4/2018 21:39:14'!
with: aCollectionOfBooks

	^self new initializeWith: aCollectionOfBooks! !


!classDefinition: #Product category: #TusLibros!
Object subclass: #Product
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
