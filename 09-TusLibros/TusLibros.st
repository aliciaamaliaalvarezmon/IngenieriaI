!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:58:59'!
test01ElCarritoCreadoSinElementosEstaVacio

	|carrito|
	
	carrito := Carrito novo.
	
	self assert: carrito isEmpty.! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 21:00:08'!
test02ElCarritoDejaDeEstarVacioCuandoSeAgregaUnLibro

	|carrito|
	
	carrito := Carrito novo.
	
	carrito agregarLibro: 1.
	
	self deny: carrito isEmpty.
	self assert: (carrito listarContenido includes: 1).
	! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 21:01:10'!
test03ElCarritoContieneLosLibrosQueYoAgregue

	|carrito|
	
	carrito := Carrito novo.
	
	carrito agregarLibro: 1.
	carrito agregarLibro: 2.
	carrito agregarLibro: 3.
	
	self deny: carrito isEmpty.
	self assert: (carrito listarContenido includes: 1).
	self assert: (carrito listarContenido includes: 2).
	self assert: (carrito listarContenido includes: 3).
	self deny: (carrito listarContenido includes: 4).
	self deny: (carrito listarContenido includes: 5).! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 21:02:47'!
test04ElCarritoRegistraMasDeUnMismoLibroAlAgregar

	|carrito|
	
	carrito := Carrito novo.
	
	carrito agregarLibro: 1.
	carrito agregarLibro: 1.
	
	self assert: (carrito cantLibro: 1) = 2.! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'contenido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:17:53'!
agregarLibro: aInteger 
	
	contenido add: aInteger.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:44:00'!
cantLibro: aBook 
	
	^(contenido select: [:anElement| anElement = aBook]) size.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:18:31'!
initialize

	contenido := OrderedCollection new.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:19:10'!
isEmpty
	
	^contenido size = 0.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:19:50'!
listarContenido

	^ contenido copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #TusLibros!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:14:23'!
novo
	
	^self new initialize.! !
