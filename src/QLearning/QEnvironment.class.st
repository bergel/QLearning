Class {
	#name : #QEnvironment,
	#superclass : #Object,
	#category : #QLearning
}

{ #category : #initialization }
QEnvironment >> done [
]

{ #category : #initialization }
QEnvironment >> info [
]

{ #category : #initialization }
QEnvironment >> observation [
]

{ #category : #initialization }
QEnvironment >> render [
]

{ #category : #initialization }
QEnvironment >> reset [ 
	
]

{ #category : #initialization }
QEnvironment >> reward [
]

{ #category : #'as yet unclassified' }
QEnvironment >> zerosRow: nbRow col: nbCol [

	^ Array2D rows: nbRow columns: nbCol element: 0
]
