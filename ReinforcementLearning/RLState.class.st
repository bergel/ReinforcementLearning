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

{ #category : #initialization }
RLState >> initialize [
	super initialize.
	position := 1 @ 1
]

{ #category : #visualization }
RLState >> inspectorVisualization [
	<inspectorPresentationOrder: 90 title: 'Visualization'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: self visualize;
		yourself
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

{ #category : #visualization }
RLState >> visualize [
	| c carShape |
	grid ifNil: [ ^ self visualizeWithoutGrid ].
	
	c := grid visualize.
	carShape := RSCircle new size: 20; color: Color blue lighter lighter.
	c add: carShape.
	carShape translateBottomRightTo: self position * 20.
	^ c 
]

{ #category : #visualization }
RLState >> visualizeWithoutGrid [
	| c |
	c := RSCanvas new.
	c add: (RSLabel text: 'Grid is not initialized, add a grid please').
	^ c
	
]
