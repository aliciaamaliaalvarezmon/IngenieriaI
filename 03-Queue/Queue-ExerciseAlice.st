!classDefinition: #QueueTest category: #'Queue-ExerciseAlice'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseAlice'!

!QueueTest methodsFor: 'test' stamp: 'n 9/30/2018 12:55:01'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'CGCM 9/27/2018 16:34:58'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #Queue category: #'Queue-ExerciseAlice'!
Object subclass: #Queue
	instanceVariableNames: 'contents size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseAlice'!

!Queue methodsFor: 'initialization' stamp: 'n 9/30/2018 13:08:45'!
inizialitation

	contents := OrderedCollection new.
	size := 0.
	
	! !


!Queue methodsFor: 'testing' stamp: 'AAAM 10/2/2018 23:49:38'!
content

 ^contents! !

!Queue methodsFor: 'testing' stamp: 'AAAM 10/2/2018 23:48:59'!
contents

 ^contents! !

!Queue methodsFor: 'testing' stamp: 'n 9/30/2018 14:24:49'!
isEmpty

	^self size == 0.! !

!Queue methodsFor: 'testing' stamp: 'n 9/30/2018 14:24:40'!
isNotEmpty

	^self size > 0.! !

!Queue methodsFor: 'testing' stamp: 'n 9/30/2018 14:08:21'!
size

	^size.! !


!Queue methodsFor: 'actions' stamp: 'AAAM 10/2/2018 23:46:14'!
dequeue

	^ (DesencoladorDeQueues desencoladorPara: self) deQueue.! !

!Queue methodsFor: 'actions' stamp: 'n 9/30/2018 13:10:12'!
enqueue: anElement

	contents add: anElement.
	size := (size +1).! !

!Queue methodsFor: 'actions' stamp: 'AAAM 10/2/2018 23:55:11'!
next
	
	
	^  (DesencoladorDeQueues desencoladorPara: self) next.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-ExerciseAlice'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions' stamp: 'n 9/30/2018 15:12:56'!
queueEmptyErrorDescription
	^'Queue is empty'.! !


!Queue class methodsFor: 'as yet unclassified' stamp: 'n 9/30/2018 12:54:16'!
new

	^self basicNew inizialitation.! !


!classDefinition: #DesencoladorDeQueues category: #'Queue-ExerciseAlice'!
Queue subclass: #DesencoladorDeQueues
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseAlice'!

!DesencoladorDeQueues methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:35:08'!
deQueue

self subclassResponsibility ! !

!DesencoladorDeQueues methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:49:52'!
initializePara: aQueue

	contents := aQueue content.
	size := aQueue size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DesencoladorDeQueues class' category: #'Queue-ExerciseAlice'!
DesencoladorDeQueues class
	instanceVariableNames: ''!

!DesencoladorDeQueues class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:36:42'!
deQueue: unaQueue

^self subclassResponsibility .! !

!DesencoladorDeQueues class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:38:17'!
desencoladorPara: unaQueue
	
	| desencoladorClass |

	desencoladorClass _ self subclasses detect: [ :unDesencoladorClass | unDesencoladorClass deQueue: unaQueue ].
	
	^ desencoladorClass para: unaQueue.! !

!DesencoladorDeQueues class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:36:06'!
para: unaQueue

^self new initializePara: unaQueue.! !


!classDefinition: #DesencoladorDeQueuesConElementos category: #'Queue-ExerciseAlice'!
DesencoladorDeQueues subclass: #DesencoladorDeQueuesConElementos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseAlice'!

!DesencoladorDeQueuesConElementos methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:41:57'!
deQueue

|firstElement|


	firstElement := contents removeFirst.
	size := (size -1).
	
	^firstElement.! !

!DesencoladorDeQueuesConElementos methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:54:58'!
next

	^contents at: 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DesencoladorDeQueuesConElementos class' category: #'Queue-ExerciseAlice'!
DesencoladorDeQueuesConElementos class
	instanceVariableNames: ''!

!DesencoladorDeQueuesConElementos class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:39:43'!
deQueue: unaQueue

^ unaQueue isNotEmpty. ! !


!classDefinition: #DesencoladorDeQueuesVacias category: #'Queue-ExerciseAlice'!
DesencoladorDeQueues subclass: #DesencoladorDeQueuesVacias
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseAlice'!

!DesencoladorDeQueuesVacias methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:43:03'!
deQueue

	self error: self class queueEmptyErrorDescription .	
! !

!DesencoladorDeQueuesVacias methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:43:08'!
next

self error: self class queueEmptyErrorDescription .	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DesencoladorDeQueuesVacias class' category: #'Queue-ExerciseAlice'!
DesencoladorDeQueuesVacias class
	instanceVariableNames: ''!

!DesencoladorDeQueuesVacias class methodsFor: 'as yet unclassified' stamp: 'AAAM 10/2/2018 23:40:32'!
deQueue: unaQueue

^ unaQueue isEmpty. ! !
