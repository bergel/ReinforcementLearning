Extension { #name : #SequenceableCollection }

{ #category : #'*ReinforcementLearning' }
SequenceableCollection >> argmax [
	"#(1 -3 5 1) argmax"
	^ self indexOf: (self max)
]
