Class {
	#name : #QState,
	#superclass : #Object,
	#instVars : [
		'grid',
		'carPos'
	],
	#category : #'QLearning-Simple'
}

{ #category : #comparing }
QState >> = anotherState [
	anotherState class == self class ifFalse: [ ^ false ].
	^ self grid = anotherState grid and: [ self carPos = anotherState carPos ]
]

{ #category : #accessing }
QState >> carPos [
	^ carPos
]

{ #category : #accessing }
QState >> carPos: anObject [
	carPos := anObject
]

{ #category : #copying }
QState >> copyGrid [
	^ grid deepCopy
]

{ #category : #accessing }
QState >> grid [
	^ grid
]

{ #category : #accessing }
QState >> grid: anObject [
	grid := anObject
]

{ #category : #comparing }
QState >> hash [
	^ self grid hash bitXor: self carPos hash
]

{ #category : #printing }
QState >> printOn: str [
	str nextPutAll: 'State(grid='.
	str nextPutAll: grid asString.
	str nextPutAll: ', car_pos='.
	str nextPutAll: carPos asString.
	str nextPutAll: ')'
]
