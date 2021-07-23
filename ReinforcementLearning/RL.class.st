Class {
	#name : #RL,
	#superclass : #Object,
	#instVars : [
		'startState',
		'r',
		'numberOfEpisodes',
		'maxEpisodeSteps',
		'minAlpha',
		'gamma',
		'eps',
		'qTable',
		'rewards',
		'path'
	],
	#category : #'ReinforcementLearning-Core'
}

{ #category : #running }
RL >> act: aState action: action [
	| reward newGrid p gridItem isDone |
	p := self newCar: aState action: action.
	gridItem := aState grid atPosition: p.
	newGrid := aState grid copy.
	gridItem = $z ifTrue: [ reward := -100. isDone := true ].
	gridItem = $i ifTrue: [ reward := 1000. isDone := true ].
	('zi' includes: gridItem) ifFalse: [ reward := -1. isDone := false ].
"	gridItem = $. ifTrue: [ reward := -1. isDone := false. 
		newGrid atPosition: aState position put: $. .
		newGrid atPosition: p put: $c ].
	gridItem = $c ifTrue: [ reward := -1. isDone := false ]."
	^ { RLState new grid: newGrid; position: p . reward . isDone }

]

{ #category : #actions }
RL >> actions [
	"Return the considered actions"
	^ #(1 2 3 4)
]

{ #category : #running }
RL >> chooseAction: state [
	^ r next < eps
		ifTrue: [ self actions atRandom: r ]
		ifFalse: [ (self qState: state) argmax ]

]

{ #category : #initialization }
RL >> initialize [
	super initialize.
	r := Random seed: 42.
	numberOfEpisodes := 20.
	maxEpisodeSteps := 100.
	minAlpha := 0.02.
	gamma := 1.0.
	eps := 0.2.
	qTable := Dictionary new.
	rewards := OrderedCollection new.
	path := OrderedCollection new
]

{ #category : #running }
RL >> newCar: state action: action [
	"Return the new position of a car, as a point. The action is a number from 1 to 4.
	**Maybe we should have a RLCar class**
	return a new position"
	| delta |
	delta := { 0@ -1 . 0@1 . -1@0 . 1@0 } at: action ifAbsent: [ self error: 'Unknown action' ].
	^ ((state position + delta) min: state grid extent) max: 1 @ 1

]

{ #category : #accessing }
RL >> numberOfEpisodes: aNumber [
	numberOfEpisodes := aNumber
]

{ #category : #playing }
RL >> play [
	"Return the position of the car"
	| currentState isDone path actions tupple |
	currentState := startState.
	isDone := false.
	path := OrderedCollection new.
	path add: currentState position.
	[ isDone ] whileFalse: [
		actions := self qState: currentState.
		tupple := self act: currentState action: actions argmax.
		currentState := tupple first.
		path add: currentState position.
		isDone := tupple third.
	].
	
	^ path asArray
	
]

{ #category : #running }
RL >> qState: state [ 
	qTable at: state ifAbsentPut: [ (1 to: self actions size) collect: [ :nU | 0 ] ].
	^ qTable at: state
]

{ #category : #running }
RL >> qState: state action: action [
	qTable at: state ifAbsentPut: [ (1 to: self actions size) collect: [ :nU | 0 ] ].
	^ (qTable at: state) at: action
]

{ #category : #running }
RL >> run [

	| alphas currentState totalReward alpha isDone currentAction tupple nextState currentReward result |
	alphas := (minAlpha to: 1.0 count: numberOfEpisodes) reversed.
	result := OrderedCollection new.
	1 to: numberOfEpisodes do: [ :e |
		currentState := startState.
		totalReward := 0.
		alpha := alphas at: e.
		isDone := false.
		maxEpisodeSteps timesRepeat: [ 
			isDone ifFalse: [ 
				currentAction := self chooseAction: currentState.
				tupple := self act: currentState action: currentAction.
				nextState := tupple first.
				currentReward := tupple second.
				isDone := tupple third.
				totalReward := totalReward + currentReward.
				
				(self qState: currentState) at: currentAction put: (
					(self qState: currentState action: currentAction) + (alpha * (currentReward + (gamma * (self qState: nextState) max) - (self qState: currentState action: currentAction)))).
				currentState := nextState
			]
		].
		result add: totalReward.
	].
	^ result asArray












]

{ #category : #initialization }
RL >> setInitialContent: aString [
	self setInitialGrid: (RLGrid new setContent: aString)
]

{ #category : #initialization }
RL >> setInitialGrid: aGrid [
	startState := RLState new grid: aGrid; position: 1 @ 1.

]

{ #category : #accessing }
RL >> startState [
	^ startState
]

{ #category : #visualization }
RL >> visualizeStartState [
	<inspectorPresentationOrder: 90 title: 'Start state'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: startState visualize;
		yourself
]
