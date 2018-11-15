!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'testing' stamp: 'AAAM 11/14/2018 02:52:37'!
test01ElCarritoCreadoSinElementosEstaVacio

	|carrito editorial|
	
	editorial := Editorial novo.
	
	
	
	carrito := Carrito novoWith: editorial.
	
	self assert: carrito isEmpty.! !

!TusLibrosTests methodsFor: 'testing' stamp: 'AAAM 11/14/2018 03:44:12'!
test02ElCarritoDejaDeEstarVacioCuandoSeAgregaUnLibro

	|carrito editorial|
	
	editorial := Editorial novo.
	
	editorial addToCatalogo: 1 with: 2.
	
	
	carrito := Carrito novoWith: editorial.
	
	carrito agregarLibro: 1.
	
	self deny: carrito isEmpty.
	self assert: (carrito listarContenido includes: 1).
	! !

!TusLibrosTests methodsFor: 'testing' stamp: 'AAAM 11/14/2018 03:50:36'!
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

!TusLibrosTests methodsFor: 'testing' stamp: 'AAAM 11/15/2018 14:55:05'!
test04AlAgregarMasDeUnMismoLibroAlCarritoSeAgreganAlCarrito

	|carrito editorial|
	
	editorial := Editorial novo.
	
	editorial addToCatalogo: 1 with: 2.
	
	
	carrito := Carrito novoWith: editorial.
	
	carrito agregarLibro: 1.
	carrito agregarLibro: 1.
	
	self assert: (carrito cantLibro: 1) = 2.! !

!TusLibrosTests methodsFor: 'testing' stamp: 'AAAM 11/15/2018 15:01:36'!
test05NoSePuedeAgregarAlCarritoUnLibroQueNoEsDeLaEditorial

	|carrito editorial|
	
	editorial := Editorial novo.
	
	 
	carrito := Carrito novoWith: editorial .
	
	
	
	
	self
		should: [ carrito agregarLibro: 1. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Carrito seQuiereAgregarLibroQueNoEstaEnElCatalogo.
			self deny: (carrito listarContenido  includes: 1)].! !

!TusLibrosTests methodsFor: 'testing' stamp: 'AAAM 11/15/2018 15:09:30'!
test06NoSePuedeAgregarLibroAlCarritoSiNoHayStock

|carrito editorial|
	
	editorial := Editorial novo.
	carrito := Carrito novoWith: editorial .
	
	
	editorial addToCatalogo: 1 with: 1.
	
	
	carrito agregarLibro: 1.
	
	
	
	self
		should: [ carrito agregarLibro: 1. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Carrito noHayStockErrorMessage. 
			self assert: (carrito cantLibro: 1) = 1].! !

!TusLibrosTests methodsFor: 'testing' stamp: 'AAAM 11/15/2018 15:21:45'!
test07AgregarEspecificandoLaCantidadDelLibrosIgualesAComprarAgregaTodosAlContenidoDelCarrito

|carrito editorial|
	
	editorial := Editorial novo.
	carrito := Carrito novoWith: editorial .
	
	
	editorial addToCatalogo: 1 with: 1.
	editorial addToCatalogo: 5 with: 5.
	editorial addToCatalogo: 2 with: 1.
	editorial addToCatalogo: 3 with: 5.
	editorial addToCatalogo: 4 with: 3.
	
	carrito agregarLibro: 1.
	carrito agregarLibro: 5 with: 5.
	
	self assert: (carrito listarContenido includes: 1).
	self assert: (carrito listarContenido  includes: 5).
	self assert: (carrito cantLibro: 1) = 1.
	self assert: (carrito cantLibro: 5) = 5.
	
	
	
	
	
! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'contenido editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'error handling' stamp: 'n 11/15/2018 10:30:30'!
noExisteElLibro

	^self error: self class seQuiereAgregarLibroQueNoEstaEnElCatalogo.! !

!Carrito methodsFor: 'error handling' stamp: 'n 11/15/2018 10:29:50'!
noHayStock
	
	^self error: self class noHayStockErrorMessage.! !


!Carrito methodsFor: 'initializing' stamp: 'AAAM 11/15/2018 14:44:21'!
initializeWith:anEditorial

	contenido := OrderedCollection new.
	editorial:= anEditorial .
	editorial agregarCarrito: self.! !


!Carrito methodsFor: 'accessing' stamp: 'n 11/15/2018 10:22:57'!
agregarLibro: aBook 
	
	"(editorial estaEnElCatalogo: aBook) ifFalse:[^self error: self class seQuiereAgregarLibroQueNoEstaEnElCatalogo. ]ifTrue: [(editorial hayStock: aBook ) ifTrue:[contenido add: aBook.editorial compreLibro: aBook.^self] ifFalse: [^self error: self class noHayStockErrorMessage]]"
	
	
		editorial puedoAgregar: aBook carrito: self.
	! !

!Carrito methodsFor: 'accessing' stamp: 'AAAM 11/15/2018 15:17:25'!
agregarLibro: aBook with: aQuantity

	aQuantity timesRepeat: [self agregarLibro: aBook]. 
	! !

!Carrito methodsFor: 'accessing' stamp: 'z 11/12/2018 20:44:00'!
cantLibro: aBook 
	
	^(contenido select: [:anElement| anElement = aBook]) size.! !

!Carrito methodsFor: 'accessing' stamp: 'z 11/12/2018 20:19:10'!
isEmpty
	
	^contenido size = 0.! !

!Carrito methodsFor: 'accessing' stamp: 'z 11/12/2018 20:19:50'!
listarContenido

	^ contenido copy.! !


!Carrito methodsFor: 'accessing-private' stamp: 'n 11/15/2018 10:32:22'!
agregarConfirmado: aBook

	editorial compreLibro: aBook.
	contenido add: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #TusLibros!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'instance creation' stamp: 'AAAM 11/14/2018 02:51:25'!
novoWith: anEditorial
	
	^self new initializeWith: anEditorial.! !


!Carrito class methodsFor: 'error handling' stamp: 'AAAM 11/14/2018 04:08:02'!
noHayStockErrorMessage
	^'no hay stock de este libro en estos momentos'! !

!Carrito class methodsFor: 'error handling' stamp: 'AAAM 11/14/2018 02:57:35'!
seQuiereAgregarLibroQueNoEstaEnElCatalogo
	^'Ese libro no esta a la venta'.! !


!classDefinition: #CatalogoState category: #TusLibros!
Object subclass: #CatalogoState
	instanceVariableNames: 'editorial book'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CatalogoState methodsFor: 'initializing' stamp: 'n 11/15/2018 11:15:45'!
initializeWith: aEditorial and: aBook.
	
	editorial := aEditorial .
	book := aBook.! !


!CatalogoState methodsFor: 'asking' stamp: 'n 11/15/2018 11:28:24'!
sePuedeComprar

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogoState class' category: #TusLibros!
CatalogoState class
	instanceVariableNames: ''!

!CatalogoState class methodsFor: 'initialize' stamp: 'n 11/15/2018 11:27:49'!
for: aEditorial and: aBook

	|state|
	
	state := self allSubclasses detect: [:subClassState | subClassState isFor: aEditorial and: aBook].
	^state new initializeWith: aEditorial and: aBook.! !

!CatalogoState class methodsFor: 'initialize' stamp: 'n 11/15/2018 11:03:43'!
isFor: aEditorial and: aBook

	^self subclassResponsibility .
	! !


!classDefinition: #NoExisteElLibro category: #TusLibros!
CatalogoState subclass: #NoExisteElLibro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NoExisteElLibro methodsFor: 'asking' stamp: 'n 11/15/2018 11:24:37'!
sePuedeComprar

	editorial noExisteElLibro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoExisteElLibro class' category: #TusLibros!
NoExisteElLibro class
	instanceVariableNames: ''!

!NoExisteElLibro class methodsFor: 'initialize' stamp: 'n 11/15/2018 11:23:03'!
isFor: aEditorial and: aBook

	^((aEditorial estaEnElCatalogo: aBook)not). ! !


!classDefinition: #NoHayStock category: #TusLibros!
CatalogoState subclass: #NoHayStock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NoHayStock methodsFor: 'asking' stamp: 'n 11/15/2018 11:24:49'!
sePuedeComprar

	editorial noHayStock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoHayStock class' category: #TusLibros!
NoHayStock class
	instanceVariableNames: ''!

!NoHayStock class methodsFor: 'initialize' stamp: 'n 11/15/2018 11:19:09'!
isFor: aEditorial and: aBook

	^((aEditorial estaEnElCatalogo: aBook)) and: [((aEditorial hayStock: aBook) not)].! !


!classDefinition: #SePuedeComprar category: #TusLibros!
CatalogoState subclass: #SePuedeComprar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SePuedeComprar methodsFor: 'asking' stamp: 'n 11/15/2018 11:28:00'!
sePuedeComprar

	editorial compraConfirmada: book.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SePuedeComprar class' category: #TusLibros!
SePuedeComprar class
	instanceVariableNames: ''!

!SePuedeComprar class methodsFor: 'initialize' stamp: 'n 11/15/2018 11:19:17'!
isFor: aEditorial and: aBook

	^(aEditorial estaEnElCatalogo: aBook) and: [(aEditorial hayStock: aBook)].! !


!classDefinition: #Editorial category: #TusLibros!
Object subclass: #Editorial
	instanceVariableNames: 'carritos catalogo carritoUltimaOperacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Editorial methodsFor: 'initializing' stamp: 'AAAM 11/15/2018 14:43:43'!
initializar
	
	catalogo := Dictionary new.
	carritos := OrderedCollection new.
	carritoUltimaOperacion := Carrito novoWith: self.! !


!Editorial methodsFor: 'adding-private' stamp: 'n 11/15/2018 11:27:33'!
compraConfirmada: aBook

	carritoUltimaOperacion agregarConfirmado: aBook.! !

!Editorial methodsFor: 'adding-private' stamp: 'AAAM 11/14/2018 04:07:24'!
compreLibro:aBook

|oldvalue|

oldvalue := catalogo at: aBook.
catalogo at: aBook put: oldvalue-1.! !

!Editorial methodsFor: 'adding-private' stamp: 'n 11/15/2018 11:25:19'!
puedoAgregar: aBook carrito: aCarrito

	"(self estaEnElCatalogo: aBook) ifTrue: [(self hayStock: aBook) ifTrue: [aCarrito agregarConfirmado: aBook] ifFalse: [aCarrito noHayStock]] ifFalse: [aCarrito noExisteElLibro."
		carritoUltimaOperacion := aCarrito.
		(CatalogoState for: self and: aBook) sePuedeComprar.
		! !


!Editorial methodsFor: 'addingBooksToCatalogue' stamp: 'AAAM 11/14/2018 03:39:03'!
addToCatalogo: aBook 
	
	
	catalogo add: aBook ! !

!Editorial methodsFor: 'addingBooksToCatalogue' stamp: 'AAAM 11/14/2018 03:27:27'!
addToCatalogo: aBook with: aQuantity

	
	
	catalogo at: aBook put: aQuantity .
! !


!Editorial methodsFor: 'addingCart' stamp: 'AAAM 11/15/2018 14:43:54'!
agregarCarrito: aCarrito

	carritos add: aCarrito.! !


!Editorial methodsFor: 'error handling' stamp: 'n 11/15/2018 11:25:54'!
noExisteElLibro

	carritoUltimaOperacion noExisteElLibro.! !

!Editorial methodsFor: 'error handling' stamp: 'n 11/15/2018 11:26:27'!
noHayStock

	carritoUltimaOperacion noHayStock.! !


!Editorial methodsFor: 'inspecting' stamp: 'AAAM 11/14/2018 04:00:35'!
estaEnElCatalogo: aBook 
	
	^catalogo includesKey: aBook.
	
	! !

!Editorial methodsFor: 'inspecting' stamp: 'AAAM 11/14/2018 03:58:53'!
hayStock: aBook 
	^ (catalogo  at: aBook ) > 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Editorial class' category: #TusLibros!
Editorial class
	instanceVariableNames: 'carritos'!

!Editorial class methodsFor: 'class initialization' stamp: 'AAAM 11/14/2018 02:53:48'!
novo
	^self new initializar.! !

