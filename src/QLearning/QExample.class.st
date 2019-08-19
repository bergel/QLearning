Class {
	#name : #QExample,
	#superclass : #Object,
	#instVars : [
		'qTable',
		'r',
		'eps',
		'actions'
	],
	#category : #'QLearning-Simple'
}

{ #category : #examples }
QExample >> act: state action: action [
	| p gridItem newGrid reward isDone oldCarPos |
	p := self newCarPos: state action: action.
	gridItem := (state grid at: p x) at: p y.
	newGrid := state copyGrid.
	(gridItem == self zombie) ifTrue: [ 
		reward := -100.
		isDone := true.
		(newGrid at: p x) at: p y put: self car.
	].

	(gridItem == self iceCream) ifTrue: [ 
		reward := 1000.
		isDone := true.
		(newGrid at: p x) at: p y put: self car.
	].

	(gridItem == self empty) ifTrue: [ 
		reward := -1.
		isDone := false.
		oldCarPos := state carPos.
		(newGrid at: oldCarPos x) at: oldCarPos y put: self empty.
		(newGrid at: p x) at: p y put: self car.
	].

	(gridItem == self car) ifTrue: [ 
		reward := -1.
		isDone := false.
	].

	^ { QState new grid: newGrid; carPos: p . reward . isDone }

]

{ #category : #examples }
QExample >> car [
	^ $c
]

{ #category : #examples }
QExample >> chooseAction: state [
	 ^ r next < eps 
		ifTrue: [ (1 to: 4) atRandom: r ]
		ifFalse: [ 
			| t |
			t := (self q: state action: nil).
			^ t indexOf: (t max) ]
]

{ #category : #examples }
QExample >> down [ 
	^ 2

]

{ #category : #examples }
QExample >> empty [
	^ $*
]

{ #category : #examples }
QExample >> example01 [
	<script: 'self new example01'>
	
	| grid startState nEpisodes maxEpisodeSteps minAlpha alphas gamma state totalReward alpha action result nextState reward done |
	grid := { { self iceCream . self empty } . { self zombie . self car } }.
	startState := QState new grid: grid; carPos: 2 @ 2.

	nEpisodes := 20.
	maxEpisodeSteps := 100.
	minAlpha := 0.02.
	alphas := (minAlpha to: 1.0 by: (1.0 - minAlpha) / (nEpisodes - 1)) asArray reverse.
	gamma := 1.0.
	
	1 to: nEpisodes do: [ :e |
		state := startState.
		totalReward := 0.
		alpha := alphas at: e.
		done := false.
		maxEpisodeSteps timesRepeat: [
			[ done ] whileFalse: [ 
				action := self chooseAction: state.
				result := self act: state action: action.
				nextState := result first.
				reward := result second.
				done := result third.
				totalReward := totalReward + reward.
				(self q: state) at: action put: (((self q: state) at: action) + (alpha * (reward + (gamma * (self q: nextState) max) - (self q: state action: action)))).
				state := nextState ].
		].
		Transcript show: 'Episode ', e asString, ' reward: ', totalReward asString; cr.
	].
	"------"
	"doing"
	done := false.
	state := startState.
	state logCr.
	[ done ] whileFalse: [
		| sa ac rr | 
		sa := self q: state.
		"sa logCr."
		ac := sa indexOf: sa max.
		rr := self act: state action: ac.
		state := rr first.
		state logCr.
		done := rr third.
		
	].

]

{ #category : #examples }
QExample >> example02 [
	<script: 'self new example02'>
	
	| grid startState nEpisodes maxEpisodeSteps minAlpha alphas gamma state totalReward alpha action result nextState reward done |
	grid := { { self iceCream . self empty . self empty . self empty } . 
				{ self empty . self empty . self empty . self empty } .
				{ self empty . self empty . self empty . self empty } .
				{ self empty . self empty . self zombie . self car } }.
	startState := QState new grid: grid; carPos: 4 @ 4.

	nEpisodes := 20.
	maxEpisodeSteps := 100.
	minAlpha := 0.02.
	alphas := (minAlpha to: 1.0 by: (1.0 - minAlpha) / (nEpisodes - 1)) asArray reverse.
	gamma := 1.0.
	
	1 to: nEpisodes do: [ :e |
		state := startState.
		totalReward := 0.
		alpha := alphas at: e.
		done := false.
		maxEpisodeSteps timesRepeat: [
			[ done ] whileFalse: [ 
				action := self chooseAction: state.
				result := self act: state action: action.
				nextState := result first.
				reward := result second.
				done := result third.
				totalReward := totalReward + reward.
				(self q: state) at: action put: (((self q: state) at: action) + (alpha * (reward + (gamma * (self q: nextState) max) - (self q: state action: action)))).
				state := nextState ].
		].
		Transcript show: 'Episode ', e asString, ' reward: ', totalReward asString; cr.
	].
	"------"
	"doing"
	done := false.
	state := startState.
	state logCr.
	[ done ] whileFalse: [
		| sa ac rr | 
		sa := self q: state.
		"sa logCr."
		ac := sa indexOf: sa max.
		rr := self act: state action: ac.
		state := rr first.
		state logCr.
		done := rr third.
		
	].

]

{ #category : #examples }
QExample >> example03 [
	<script: 'self new example03'>
	
	| grid startState nEpisodes maxEpisodeSteps minAlpha alphas gamma state totalReward alpha action result nextState reward done |
	grid := { { self iceCream . self empty . self zombie . self empty } . 
				{ self zombie . self empty . self empty . self empty } .
				{ self empty . self zombie . self empty . self empty } .
				{ self empty . self empty . self zombie . self car } }.
	startState := QState new grid: grid; carPos: 4 @ 4.

	nEpisodes := 20.
	maxEpisodeSteps := 100.
	minAlpha := 0.02.
	alphas := (minAlpha to: 1.0 by: (1.0 - minAlpha) / (nEpisodes - 1)) asArray reverse.
	gamma := 1.0.
	
	1 to: nEpisodes do: [ :e |
		state := startState.
		totalReward := 0.
		alpha := alphas at: e.
		done := false.
		maxEpisodeSteps timesRepeat: [
			[ done ] whileFalse: [ 
				action := self chooseAction: state.
				result := self act: state action: action.
				nextState := result first.
				reward := result second.
				done := result third.
				totalReward := totalReward + reward.
				(self q: state) at: action put: (((self q: state) at: action) + (alpha * (reward + (gamma * (self q: nextState) max) - (self q: state action: action)))).
				state := nextState ].
		].
		Transcript show: 'Episode ', e asString, ' reward: ', totalReward asString; cr.
	].
	"------"
	"doing"
	done := false.
	state := startState.
	state logCr.
	[ done ] whileFalse: [
		| sa ac rr | 
		sa := self q: state.
		"sa logCr."
		ac := sa indexOf: sa max.
		rr := self act: state action: ac.
		state := rr first.
		state logCr.
		done := rr third.
		
	].

]

{ #category : #examples }
QExample >> example04 [
	<script: 'self new example04 inspect'>
	
	| grid startState nEpisodes maxEpisodeSteps minAlpha alphas gamma state totalReward alpha action result nextState reward done size nbIter nbMaxIter res |
	size := 30.
	res := OrderedCollection  new.
	grid := (1 to: size) collect: [ :x | 
					(1 to: size) collect: [ :y | self empty ]
		 ].
	(grid at: 1) at: 1 put: self iceCream.
	(grid at: size) at: size put: self car.
	r := Random seed: 42.
	1 to: size do: [ :i | (grid at: (r nextInt: size)) at: (r nextInt: size) put: self zombie ].
	
	startState := QState new grid: grid; carPos: size @ size.

	nEpisodes := 2000.
	maxEpisodeSteps := 1800.
	minAlpha := 0.0.7.
	alphas := (minAlpha to: 1.0 by: (1.0 - minAlpha) / (nEpisodes - 1)) asArray reverse.
	gamma := 0.95.
	
	1 to: nEpisodes do: [ :e |
		state := startState.
		totalReward := 0.
		alpha := alphas at: e.
		done := false.
		maxEpisodeSteps timesRepeat: [
			[ done ] whileFalse: [ 
				action := self chooseAction: state.
				result := self act: state action: action.
				nextState := result first.
				reward := result second.
				done := result third.
				totalReward := totalReward + reward.
				(self q: state) at: action put: (((self q: state) at: action) + (alpha * (reward + (gamma * (self q: nextState) max) - (self q: state action: action)))).
				state := nextState ].
		].
		Transcript show: 'Episode ', e asString, ' reward: ', totalReward asString; cr.
		res add: totalReward.
	].
	"------"
	"doing"
	done := false.
	state := startState.
	state logCr.
	nbIter := 0.
	nbMaxIter := 100.
	[ done ] whileFalse: [
		| sa ac rr | 
		sa := self q: state.
		"sa logCr."
		ac := sa indexOf: sa max.
		rr := self act: state action: ac.
		state := rr first.
		state logCr.
		done := rr third.
		nbIter == nbMaxIter ifTrue: [ done := true ].
		nbIter := nbIter + 1.
	].
	^res
]

{ #category : #examples }
QExample >> iceCream [
	^ $i
]

{ #category : #examples }
QExample >> initialize [
	super initialize.
	qTable := Dictionary new.
	r := Random seed: 42.
	eps := 0.2.
	actions := { self up . self down . self left . self right }.
]

{ #category : #examples }
QExample >> left [
	^ 3
	
]

{ #category : #examples }
QExample >> newCarPos: state action: action [
	| p |
	p := state carPos. 
	(action == self up) ifTrue: [ p := p - (1 @ 0) ].
	(action == self down) ifTrue: [ p := p + (1 @ 0) ].
	(action == self left) ifTrue: [ p := p - (0 @ 1) ].
	(action == self right) ifTrue: [ p := p + (0 @ 1) ].
	
	p := p max: (1 @ 1).
	p := p min: (state grid first size @ state grid first size).
	^ p
	
]

{ #category : #examples }
QExample >> q: state [
	^ self q: state action: nil
]

{ #category : #examples }
QExample >> q: state action: action [
	(qTable includesKey: state) ifFalse: [ qTable at: state put: (Array new: 4 withAll: 0.0) ].
	
	action ifNil: [ ^ qTable at: state ].
	
	^ (qTable at: state) at: action
	
]

{ #category : #examples }
QExample >> right [
	^ 4
]

{ #category : #examples }
QExample >> up [
	^  1
]

{ #category : #examples }
QExample >> zombie [
	^ $z
]
