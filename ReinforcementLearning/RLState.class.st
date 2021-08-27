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
	"Two states are identical if (i) they have the same class, (ii) the same grid, and (iii) the same position of the knight"
	anotherState class == self class ifFalse: [ ^ false ].
	^ grid = anotherState grid and: [ position = anotherState position ]
]

{ #category : #accessing }
RLState >> grid [
	"Return the grid associated to the state"
	^ grid
]

{ #category : #accessing }
RLState >> grid: aGrid [
	"Set the grid associated to the state"
	grid := aGrid
]

{ #category : #comparing }
RLState >> hash [
	"The hash of a state is a combination of the hash of the grid with the hash of the position"
	^ grid hash bitXor: position hash
]

{ #category : #initialization }
RLState >> initialize [
	super initialize.
	position := 1 @ 1
]

{ #category : #visualization }
RLState >> inspectorVisualization [
	<inspectorPresentationOrder: 90 title: 'Visualization'>
	| canvas |
	canvas := self visualize.
	canvas @ RSCanvasController.
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]

{ #category : #accessing }
RLState >> position [
	"Return the knight position"
	^ position
]

{ #category : #accessing }
RLState >> position: aPoint [
	"Set the knight position"
	position := aPoint
]

{ #category : #printing }
RLState >> printOn: str [
	"Give a string representation of a state"
	str nextPutAll: 'S<'.
	str nextPutAll: self hash asString.
	str nextPutAll: '>'.	
]

{ #category : #visualization }
RLState >> visualize [
	"Visualize the grid and the knight position"
	| c knightShape |	
	c := grid visualize.
	knightShape := RSCircle new size: 15; color: Color blue lighter lighter.
	c add: knightShape.
	knightShape translateTo: self position - (0.5 @ 0.5) * 20.
	^ c 
]

{ #category : #visualization }
RLState >> visualizeWithoutGrid [
	| c |
	c := RSCanvas new.
	c add: (RSLabel text: 'Grid is not initialized, add a grid please').
	^ c
	
]
