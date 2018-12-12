Class {
	#name : #QTaxiEnvironment,
	#superclass : #QEnvironment,
	#category : #QLearning
}

{ #category : #'as yet unclassified' }
QTaxiEnvironment >> createZeros [
	^ self zerosRow: 500 col: 6.
]
