"
A QStateTest is a test class for testing the behavior of QState
"
Class {
	#name : #QStateTest,
	#superclass : #TestCase,
	#category : #'QLearning-Simple'
}

{ #category : #tests }
QStateTest >> testEquals [
	| grid s1 s2 |
	grid := { { 0 . 1 } . { 1 . 0 } }.
	s1 := QState new grid: grid; carPos: 1 @ 1.
	s2 := QState new grid: grid; carPos: 1 @ 1.
	self assert: s1 equals: s2.
	
	self assert: s1 hash equals: s2 hash
]
