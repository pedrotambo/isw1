!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: 'stack pushedObject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'setup' stamp: 'PFT 4/26/2018 15:08:06'!
setUp

	stack := OOStack new.
	pushedObject :=	'Something'! !


!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:03:28'!
test01StackShouldBeEmptyWhenCreated
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:04:01'!
test02PushAddElementsToTheStack

	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:04:23'!
test03PopRemovesElementsFromTheStack

	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:06:37'!
test04PopReturnsLastPushedObject

	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:05:06'!
test05StackBehavesLIFO

	| firstPushedObject secondPushedObject |

	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:06:47'!
test06TopReturnsLastPushedObject

	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:07:00'!
test07TopDoesNotRemoveObjectFromStack

	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:07:08'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:07:20'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'PFT 4/26/2018 15:07:33'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'PFT 4/25/2018 00:38:28'!
initialize

	top := OOStackBase new.
	size := 0! !


!OOStack methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:00:36'!
isEmpty

	^top isStackBase! !

!OOStack methodsFor: 'accesing' stamp: 'PFT 4/25/2018 00:39:29'!
size

	^size! !

!OOStack methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:26:38'!
top

	^top object! !


!OOStack methodsFor: 'adding' stamp: 'PFT 4/26/2018 14:43:43'!
push: anObject

	|stackElement|
	stackElement := OOStackElement with: anObject andPrevious: top.
	top := stackElement.
	size := size + 1! !


!OOStack methodsFor: 'removing' stamp: 'PFT 4/26/2018 14:52:38'!
pop

	|elementPopped|
	elementPopped := top object.
	top := top previous.
	size := size - 1.
	^elementPopped
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackComponent category: #'Stack-Exercise'!
Object subclass: #OOStackComponent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackComponent methodsFor: 'accesing' stamp: 'PFT 4/26/2018 14:59:52'!
isStackBase

	"Returns true if stacked component is a stack base"
	self subclassResponsibility .! !

!OOStackComponent methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:18:54'!
object

	"Returns the stacked object"
	self subclassResponsibility.! !

!OOStackComponent methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:19:27'!
previous

	"Return the previous StackElement"
	self subclassResponsibility .! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
OOStackComponent subclass: #OOStackBase
	instanceVariableNames: 'previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:00:45'!
isStackBase

	^true! !

!OOStackBase methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:23:29'!
object

	^self error: OOStack stackEmptyErrorDescription.! !

!OOStackBase methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:06:45'!
previous

	^self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
OOStackComponent subclass: #OOStackElement
	instanceVariableNames: 'previous object'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:01:03'!
isStackBase
	
	^false! !

!OOStackElement methodsFor: 'accesing' stamp: 'LR 4/26/2018 00:24:38'!
object

	^object.! !

!OOStackElement methodsFor: 'accesing' stamp: 'PFT 4/25/2018 00:19:20'!
previous

	^previous! !


!OOStackElement methodsFor: 'initialization' stamp: 'PFT 4/26/2018 14:35:54'!
initializeWith: anObject andPrevious: aPreviousStackComponent

	object := anObject.
	previous := aPreviousStackComponent

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: #'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'instance creation' stamp: 'PFT 4/26/2018 14:37:28'!
with: anObject andPrevious: aPreviousStackComponent
	
	^self new initializeWith: anObject andPrevious: aPreviousStackComponent

	! !
