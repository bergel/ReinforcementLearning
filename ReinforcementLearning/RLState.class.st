Class {
	#name : #RLState,
	#superclass : #Object,
	#instVars : [
		'grid',
		'position'
	],
	#category : #ReinforcementLearning
}

{ #category : #comparing }
RLState >> = anotherState [
	anotherState class == self class ifFalse: [ ^ false ].
	^ grid = anotherState grid and: [ position = anotherState position ]
]

{ #category : #accessing }
RLState >> grid [

	^ grid
]

{ #category : #accessing }
RLState >> grid: anObject [

	grid := anObject
]

{ #category : #comparing }
RLState >> hash [
	^ (grid asString, position asString) hash
]

{ #category : #accessing }
RLState >> position [

	^ position
]

{ #category : #accessing }
RLState >> position: anObject [

	position := anObject
]
