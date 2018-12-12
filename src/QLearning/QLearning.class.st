Class {
	#name : #QLearning,
	#superclass : #Object,
	#instVars : [
		'alpha',
		'gamma',
		'epsilon',
		'allEpochs',
		'allPenalties',
		'qTable'
	],
	#category : #QLearning
}

{ #category : #execution }
QLearning >> execute [ 
	"
	self new execute
	"
	| state env epochs penalties reward done action random nextState info oldValue nextMax newValue |
	env := QEnvironment new.
	random := Random seed: 42.
	env := QTaxiEnvironment new.
	qTable := env createZeros.
	1000 timesRepeat: [ 
		state 	:= env reset.
		epochs := 0.
		penalties := 0.
		reward := 0.
		done := false.
		
		[ done ] whileFalse: [ 
			random next < epsilon 
				ifTrue: [ action := env actionSpace sample ]
				ifFalse: [ action := (qTable at: state) argmax ].
				
			env step: action.
			nextState := env nextState.
			reward := env reward.
			done := env isDone.
			info := env info.
			
			oldValue := (qTable at: state) at: action.
			nextMax := (qTable at: nextState) max.

			newValue := (1 - alpha) * oldValue  + (alpha * (gamma * nextMax + reward)).
			(qTable at: state) at: action put: newValue.
			
			reward == -10 ifTrue: [ penalties := penalties + 1 ].
			state := nextState.
			epochs := epochs + 1.
		]
	]

]

{ #category : #execution }
QLearning >> initialize [
	super initialize.
	alpha := 0.1.
	gamma := 0.6.
	epsilon := 0.1.
	allEpochs := OrderedCollection new.
	allPenalties := OrderedCollection new
]
