!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 01:46:30'!
* unNumeroDePeano 
	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:34:43'!
+ unNumeroDePeano

	^ unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 01:44:58'!
- unNumeroDePeano

	Error signal: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 03:46:06'!
/ unNumeroDePeano 
	
	unNumeroDePeano = I
		ifTrue: [ ^self ]
		ifFalse: [ Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ]! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 02:03:49'!
> unNumeroDePeano

	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 02:15:49'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 01:44:48'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'No se representan numeros negativos ni el cero'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/30/2018 21:31:09'!
multiplicarmePor: unNumeroDePeano
	^ unNumeroDePeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:28:46'!
next
	
	next := II.
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:05:01'!
previous

	self error: 'El 1 no tiene antecesor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PFT 3/30/2018 21:06:42'!
restarmeA: unNumeroDePeano

	^unNumeroDePeano previous
	! !

I instVarNamed: 'next' put: nil!

!classDefinition: #II category: #Peano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/30/2018 21:31:09'!
* unNumeroDePeano
	^ unNumeroDePeano multiplicarmePor: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:42:22'!
+ unNumeroDePeano

	^ previous + (unNumeroDePeano next)! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/30/2018 21:07:06'!
- unNumeroDePeano
	^ unNumeroDePeano restarmeA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 03:47:10'!
/ unNumeroDePeano

	| diferencia resultado |
	
	unNumeroDePeano > self
		ifTrue: [ ^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
		
	
	resultado := I.
	
	unNumeroDePeano = self
		ifTrue: [ ^resultado]
		ifFalse:
			[
				diferencia := self - unNumeroDePeano.
				
				diferencia > unNumeroDePeano
					ifTrue: [^resultado + (diferencia / unNumeroDePeano)]
					ifFalse: [ unNumeroDePeano = diferencia ifTrue: [^resultado + I] ifFalse: [^resultado]]
			].! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 02:02:02'!
> unNumeroDePeano

	unNumeroDePeano = I
		ifTrue: [ ^true ] 
		ifFalse: [ ^self previous > unNumeroDePeano previous ]! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/27/2018 02:15:58'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:51'!
initialize

	next := III	! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/30/2018 21:31:09'!
multiplicarmePor: unNumeroDePeano
	^ self + (self * unNumeroDePeano previous).! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:26:27'!
next

	next ifNil: [
		next := self cloneNamed: (self name , 'I' ).
		next previous: self
	].

	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:46:53'!
previous

	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:22:35'!
previous: numeroAnterior

	previous := numeroAnterior
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/22/2018 21:52:19'!
removeAllNext

	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil	
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'PFT 3/30/2018 21:07:06'!
restarmeA: unNumeroDePeano
	^ unNumeroDePeano previous - self previous.! !

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: I!

!classDefinition: #III category: #Peano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Peano!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
* unNumeroDePeano
	^ unNumeroDePeano multiplicarmePor: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
+ unNumeroDePeano

	^ previous + (unNumeroDePeano next)! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
- unNumeroDePeano
	^ unNumeroDePeano restarmeA: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
/ unNumeroDePeano

	| diferencia resultado |
	
	unNumeroDePeano > self
		ifTrue: [ ^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
		
	
	resultado := I.
	
	unNumeroDePeano = self
		ifTrue: [ ^resultado]
		ifFalse:
			[
				diferencia := self - unNumeroDePeano.
				
				diferencia > unNumeroDePeano
					ifTrue: [^resultado + (diferencia / unNumeroDePeano)]
					ifFalse: [ unNumeroDePeano = diferencia ifTrue: [^resultado + I] ifFalse: [^resultado]]
			].! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
> unNumeroDePeano

	unNumeroDePeano = I
		ifTrue: [ ^true ] 
		ifFalse: [ ^self previous > unNumeroDePeano previous ]! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un numero mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:36'!
initialize

	next := IIII! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
multiplicarmePor: unNumeroDePeano
	^ self + (self * unNumeroDePeano previous).! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
next

	next ifNil: [
		next := self cloneNamed: (self name , 'I' ).
		next previous: self
	].

	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
previous

	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
previous: numeroAnterior

	previous := numeroAnterior
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
removeAllNext

	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil	
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:15:49'!
restarmeA: unNumeroDePeano
	^ unNumeroDePeano previous - self previous.! !

III instVarNamed: 'next' put: IIII!
III instVarNamed: 'previous' put: II!

!classDefinition: #IIII category: #Peano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Peano!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
* unNumeroDePeano
	^ unNumeroDePeano multiplicarmePor: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
+ unNumeroDePeano

	^ previous + (unNumeroDePeano next)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
- unNumeroDePeano
	^ unNumeroDePeano restarmeA: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
/ unNumeroDePeano

	| diferencia resultado |
	
	unNumeroDePeano > self
		ifTrue: [ ^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
		
	
	resultado := I.
	
	unNumeroDePeano = self
		ifTrue: [ ^resultado]
		ifFalse:
			[
				diferencia := self - unNumeroDePeano.
				
				diferencia > unNumeroDePeano
					ifTrue: [^resultado + (diferencia / unNumeroDePeano)]
					ifFalse: [ unNumeroDePeano = diferencia ifTrue: [^resultado + I] ifFalse: [^resultado]]
			].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
> unNumeroDePeano

	unNumeroDePeano = I
		ifTrue: [ ^true ] 
		ifFalse: [ ^self previous > unNumeroDePeano previous ]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un numero mayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
multiplicarmePor: unNumeroDePeano
	^ self + (self * unNumeroDePeano previous).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
next

	next ifNil: [
		next := self cloneNamed: (self name , 'I' ).
		next previous: self
	].

	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
previous

	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
previous: numeroAnterior

	previous := numeroAnterior
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
removeAllNext

	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil	
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 3/31/2018 18:16:01'!
restarmeA: unNumeroDePeano
	^ unNumeroDePeano previous - self previous.! !

IIII instVarNamed: 'next' put: nil!
IIII instVarNamed: 'previous' put: III!
II initialize!
III initialize!