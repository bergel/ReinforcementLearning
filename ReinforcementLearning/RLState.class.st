Class {
	#name : #RLState,
	#superclass : #Object,
	#instVars : [
		'grid',
		'position'
	],
	#category : #'ReinforcementLearning-Core'
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
RLState >> grid: aGrid [

	grid := aGrid
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
RLState >> position: aPoint [

	position := aPoint
]

{ #category : #printing }
RLState >> printOn: str [
	str nextPutAll: 'S<'.
	str nextPutAll: self hash asString.
	str nextPutAll: '>'.	
]
