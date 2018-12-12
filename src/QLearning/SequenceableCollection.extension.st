Extension { #name : #SequenceableCollection }

{ #category : #'*QLearning' }
SequenceableCollection >> argmax [
	"Return the index of the maximum element"
	
	"#(1 4 5 -2 20) argmax"
	^ self indexOf: self max
]
