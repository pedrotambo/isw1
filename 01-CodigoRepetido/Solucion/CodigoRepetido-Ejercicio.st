!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: 'stream customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'LR 4/15/2018 18:24:29'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self assertRunningTimeOf: [customerBook addCustomerNamed:  'John Lennon'] isLessThan: 50.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'LR 4/15/2018 18:24:41'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	|paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertRunningTimeOf: [customerBook removeCustomerNamed: paulMcCartney ] isLessThan: 100.

	
! !

!IdiomTest methodsFor: 'testing' stamp: 'LR 4/15/2018 18:24:48'!
test03CanNotAddACustomerWithEmptyName
	
	self should: [customerBook addCustomerNamed: '']
	raise: Error 
	veryfing:
		[:anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].

! !

!IdiomTest methodsFor: 'testing' stamp: 'metodo de clase 4/14/2018 17:27:12'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
	raise: NotFound 
	veryfing:
		[:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!IdiomTest methodsFor: 'support' stamp: 'LR 4/15/2018 18:18:44'!
assertRunningTimeOf: aBlockClosure isLessThan: anAmountOfMilliseconds

	^ self assert: (self takeClosureRunningTimeInMilliseconds: aBlockClosure) < anAmountOfMilliseconds

	! !

!IdiomTest methodsFor: 'support' stamp: 'metodo de clase 4/14/2018 17:32:07'!
should: aBlockClosure raise: aTypeOfError veryfing: assertionsBlock
	

	[ aBlockClosure value. self fail ] on: aTypeOfError do: assertionsBlock! !

!IdiomTest methodsFor: 'support' stamp: 'metodo de clase 4/14/2018 17:33:56'!
takeClosureRunningTimeInMilliseconds: aBlockClosure
	
	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	^millisecondsAfterRunning - millisecondsBeforeRunning 
	! !


!IdiomTest methodsFor: 'inicialization' stamp: 'metodo de clase 4/13/2018 22:29:59'!
setUp

	customerBook := CustomerBook new.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
