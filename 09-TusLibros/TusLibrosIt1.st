!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 02:52:37'!
test01ElCarritoCreadoSinElementosEstaVacio

	|carrito editorial|
	
	editorial := Editorial novo.
	
	
	
	carrito := Carrito novoWith: editorial.
	
	self assert: carrito isEmpty.! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 03:44:12'!
test02ElCarritoDejaDeEstarVacioCuandoSeAgregaUnLibro

	|carrito editorial|
	
	editorial := Editorial novo.
	
	editorial addToCatalogo: 1 with: 2.
	
	
	carrito := Carrito novoWith: editorial.
	
	carrito agregarLibro: 1.
	
	self deny: carrito isEmpty.
	self assert: (carrito listarContenido includes: 1).
	! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 03:50:36'!
test03ElCarritoContieneLosLibrosQueYoAgregue

	|carrito editorial|
	
	editorial := Editorial novo.
	
	
	editorial addToCatalogo: 1with: 1.
	editorial addToCatalogo: 2 with: 1.
	editorial addToCatalogo: 3 with:1.
	carrito := Carrito novoWith: editorial.
	
	carrito agregarLibro: 1.
	carrito agregarLibro: 2.
	carrito agregarLibro: 3.
	
	self deny: carrito isEmpty.
	self assert: (carrito listarContenido includes: 1).
	self assert: (carrito listarContenido includes: 2).
	self assert: (carrito listarContenido includes: 3).
	self deny: (carrito listarContenido includes: 4).
	self deny: (carrito listarContenido includes: 5).! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 03:50:47'!
test04AlAgregarMasDeUnMismoLibroAlCarritoSeAgreganAlCarrito

	|carrito editorial|
	
	editorial := Editorial novo.
	
	editorial addToCatalogo: 1 with: 2.
	
	
	carrito := Carrito novoWith: editorial.
	
	carrito agregarLibro: 1.
	carrito agregarLibro: 1.
	
	self assert: (carrito cantLibro: 1) = 2.! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 04:01:12'!
test05NoSePuedeAgregarAlCarritoUnLibroQueNoEsDeLaEditorial

	|carrito editorial|
	
	editorial := Editorial novo.
	
	 
	carrito := Carrito novoWith: editorial .
	
	
	
	
	self
		should: [ carrito agregarLibro: 1. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Carrito seQuiereAgregarLibroQueNoEstaEnElCatalogo. ].! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 04:08:39'!
test06NoSePuedeAgregarAlCarritoSiNoHayStockDeEseLibro

|carrito editorial|
	
	editorial := Editorial novo.
	carrito := Carrito novoWith: editorial .
	
	
	editorial addToCatalogo: 1 with: 1.
	
	
	carrito agregarLibro: 1.
	
	
	
	self
		should: [ carrito agregarLibro: 1. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Carrito noHayStockErrorMessage ].! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'contenido editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'n 11/15/2018 10:32:22'!
agregarConfirmado: aBook

	editorial compreLibro: aBook.
	contenido add: aBook.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'n 11/15/2018 10:22:57'!
agregarLibro: aBook 
	
	"(editorial estaEnElCatalogo: aBook) ifFalse:[^self error: self class seQuiereAgregarLibroQueNoEstaEnElCatalogo. ]ifTrue: [(editorial hayStock: aBook ) ifTrue:[contenido add: aBook.editorial compreLibro: aBook.^self] ifFalse: [^self error: self class noHayStockErrorMessage]]"
	
	
		editorial puedoAgregar: aBook carrito: self.
	! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:44:00'!
cantLibro: aBook 
	
	^(contenido select: [:anElement| anElement = aBook]) size.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'n 11/15/2018 10:22:22'!
initializeWith:anEditorial

	contenido := OrderedCollection new.
	editorial:= anEditorial .
	editorial agregarCarrito: self.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:19:10'!
isEmpty
	
	^contenido size = 0.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'z 11/12/2018 20:19:50'!
listarContenido

	^ contenido copy.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'n 11/15/2018 10:30:30'!
noExisteElLibro

	^self error: self class seQuiereAgregarLibroQueNoEstaEnElCatalogo.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'n 11/15/2018 10:29:50'!
noHayStock
	
	^self error: self class noHayStockErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #TusLibros!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 02:51:25'!
novoWith: anEditorial
	
	^self new initializeWith: anEditorial.! !


!Carrito class methodsFor: 'error handling' stamp: 'AAAM 11/14/2018 04:08:02'!
noHayStockErrorMessage
	^'no hay stock de este libro en estos momentos'! !

!Carrito class methodsFor: 'error handling' stamp: 'AAAM 11/14/2018 02:57:35'!
seQuiereAgregarLibroQueNoEstaEnElCatalogo
	^'Ese libro no esta a la venta'.! !


!classDefinition: #Editorial category: #TusLibros!
Object subclass: #Editorial
	instanceVariableNames: 'carritos catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Editorial methodsFor: 'initializing' stamp: 'n 11/15/2018 10:28:13'!
initializar
	
	catalogo := Dictionary new.
	carritos := OrderedCollection new.! !


!Editorial methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 03:39:03'!
addToCatalogo: aBook 
	
	
	catalogo add: aBook ! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 03:27:27'!
addToCatalogo: aBook with: aQuantity

	
	
	catalogo at: aBook put: aQuantity .
! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'n 11/15/2018 10:22:14'!
agregarCarrito: aCarrito

	carritos add: aCarrito.! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 04:07:24'!
compreLibro:aBook

|oldvalue|

oldvalue := catalogo at: aBook.
catalogo at: aBook put: oldvalue-1.! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 04:00:35'!
estaEnElCatalogo: aBook 
	
	^catalogo includesKey: aBook.
	
	! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 03:58:53'!
hayStock: aBook 
	^ (catalogo  at: aBook ) > 0! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'n 11/15/2018 10:27:44'!
puedoAgregar: aBook carrito: aCarrito

	(self estaEnElCatalogo: aBook) ifTrue: [(self hayStock: aBook) ifTrue: [aCarrito agregarConfirmado: aBook] ifFalse: [aCarrito noHayStock]] ifFalse: [aCarrito noExisteElLibro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Editorial class' category: #TusLibros!
Editorial class
	instanceVariableNames: 'carritos'!

!Editorial class methodsFor: 'class initialization' stamp: 'AAAM 11/14/2018 02:53:48'!
novo
	^self new initializar.! !


!Editorial class methodsFor: 'as yet unclassified' stamp: 'AAAM 11/14/2018 02:26:05'!
notABookFromTheEditorialErrorMesagge

^'editorial does not sell this book'! !
