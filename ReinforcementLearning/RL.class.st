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
		'epsilon',
		'qTable',
		'rewards',
		'path',
		'stateConnections'
	],
	#category : #'ReinforcementLearning-Core'
}

{ #category : #running }
RL >> act: aState action: action [
	"Produce a new tuple {stable . reward . isDone}"
	| reward newGrid p gridItem isDone newState |
	p := self moveKnight: aState action: action.
	gridItem := aState grid atPosition: p.
	newGrid := aState grid copy.
	gridItem = $m ifTrue: [ reward := -100. isDone := true ].
	gridItem = $e ifTrue: [ reward := 1000. isDone := true ].
	('me' includes: gridItem) 
		ifFalse: [ reward := -1. isDone := false ].
	newState := RLState new grid: newGrid; position: p.
	stateConnections add: aState -> newState.
	^ { newState . reward . isDone }
]

{ #category : #actions }
RL >> actions [
	"Return the considered actions"
	^ #(1 2 3 4)
]

{ #category : #running }
RL >> chooseAction: state [
	"Choose an action for a given state"
	^ r next < epsilon
		ifTrue: [ self actions atRandom: r ]
		ifFalse: [ 
			"Return the best action"
			(self qState: state) argmax ]
]

{ #category : #accessing }
RL >> epsilon: aFloat [
	"Set the probability to explore the world. The argument is between 0.0 and 1.0. A value close to 0.0 favors choosing an action that we know is a good one (thus reducing the exploration of the grid). A value close to 1.0 favors the world exploration instead."
	epsilon := aFloat
]

{ #category : #initialization }
RL >> initialize [
	super initialize.
	r := Random seed: 42.
	numberOfEpisodes := 20.
	maxEpisodeSteps := 100.
	minAlpha := 0.02.
	gamma := 1.0.
	epsilon := 0.2.
	qTable := Dictionary new.
	rewards := OrderedCollection new.
	path := OrderedCollection new.
	stateConnections := OrderedCollection new.
]

{ #category : #visualization }
RL >> inspectorGraph [
	<inspectorPresentationOrder: 90 title: 'State graph'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: self visualizeGraph;
		yourself
]

{ #category : #visualization }
RL >> inspectorGraphContext: aContext [
	aContext withoutEvaluator
]

{ #category : #visualization }
RL >> inspectorQTable [
	<inspectorPresentationOrder: 90 title: 'QTable'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: self visualizeQTable;
		yourself
]

{ #category : #visualization }
RL >> inspectorQTableContext: aContext [
	aContext withoutEvaluator
]

{ #category : #visualization }
RL >> inspectorResult [
	<inspectorPresentationOrder: 90 title: 'Result'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: self visualizeResult;
		yourself
]

{ #category : #visualization }
RL >> inspectorResultContext: aContext [
	aContext withoutEvaluator
]

{ #category : #visualization }
RL >> inspectorReward [
	<inspectorPresentationOrder: 90 title: 'Reward'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: self visualizeReward;
		yourself
]

{ #category : #visualization }
RL >> inspectorRewardContext: aContext [
	aContext withoutEvaluator
]

{ #category : #visualization }
RL >> inspectorStartState [
	<inspectorPresentationOrder: 90 title: 'Start state'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: self visualize;
		yourself
]

{ #category : #visualization }
RL >> inspectorStartStateContext: aContext [
	aContext withoutEvaluator
]

{ #category : #visualization }
RL >> inspectorWeightedGraph [
	<inspectorPresentationOrder: 90 title: 'Weighted state graph'>
	
	^ SpRoassal3InspectorPresenter new
		canvas: self visualizeWeightedGraph;
		yourself
]

{ #category : #visualization }
RL >> inspectorWeightedGraphContext: aContext [
	aContext withoutEvaluator
]

{ #category : #accessing }
RL >> maxEpisodeSteps: anInteger [
	"Indicate how long an exploration can be"
	maxEpisodeSteps := anInteger 
]

{ #category : #actions }
RL >> moveKnight: state action: action [
	"Return the new position of a car, as a point. The action is a number from 1 to 4.
	return a new position"
	| delta |
	delta := { 0@ -1 . 0@1 . -1@0 . 1@0 } 
				at: action ifAbsent: [ self error: 'Unknown action' ].
	^ ((state position + delta) min: state grid extent) max: 1 @ 1
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
	"Set the number of exploration we need to perform"
	numberOfEpisodes := aNumber
]

{ #category : #playing }
RL >> play [
	"Return the position of the car"
	| currentState isDone actions tuple maxNumberOfSteps numberOfSteps |
	currentState := startState.
	isDone := false.
	path := OrderedCollection new.
	path add: currentState position.
	maxNumberOfSteps := 100.
	numberOfSteps := 0.
	[ isDone not and: [ numberOfSteps < maxNumberOfSteps ] ] whileTrue: [
		actions := self qState: currentState.
		tuple := self act: currentState action: actions argmax.
		currentState := tuple first.
		path add: currentState position.
		isDone := tuple third.
		numberOfSteps := numberOfSteps + 1.
	].
	
	^ path asArray
]

{ #category : #running }
RL >> qState: state [ 
	"Return the rewards associated to a state. If the state is not in the qTable, we create it"
	qTable at: state ifAbsentPut: [ Array new: self actions size withAll: 0 ].
	^ qTable at: state
]

{ #category : #running }
RL >> qState: state action: action [
	"For a particular state, return the reward of an action. If the state is not in the qTable, we create it"
	qTable at: state ifAbsentPut: [ (1 to: self actions size) collect: [ :nU | 0 ] ].
	^ (qTable at: state) at: action
]

{ #category : #running }
RL >> run [
	"This method is the core of the Q-learning algorithm"
	| alphas currentState totalReward alpha isDone currentAction tuple nextState currentReward |
	alphas := (minAlpha to: 1.0 count: numberOfEpisodes) reversed.
	rewards := OrderedCollection new.
	1 to: numberOfEpisodes do: [ :e |
		currentState := startState.
		totalReward := 0.
		alpha := alphas at: e.
		isDone := false.
		maxEpisodeSteps timesRepeat: [ 
			isDone ifFalse: [ 
				currentAction := self chooseAction: currentState.
				tuple := self act: currentState action: currentAction.
				nextState := tuple first.
				currentReward := tuple second.
				isDone := tuple third.
				totalReward := totalReward + currentReward.
				
				"The Bellman equation"
				(self qState: currentState) at: currentAction put: (
					(self qState: currentState action: currentAction) + (alpha * (currentReward + (gamma * (self qState: nextState) max) - (self qState: currentState action: currentAction)))).
				currentState := nextState
			]
		].
		rewards add: totalReward.
	].
	rewards := rewards asArray.
	^ rewards
]

{ #category : #initialization }
RL >> setInitialContent: aString [
	self setInitialGrid: (RLGrid new setContent: aString)
]

{ #category : #initialization }
RL >> setInitialGrid: aGrid [
	"Set the grid used in the initial state"
	startState := RLState new grid: aGrid
]

{ #category : #visualization }
RL >> visualize [
	| c s |
	c := startState visualize.
	path do: [ :p |
		s := RSCircle new size: 5; color: Color blue lighter lighter.
		c add: s.
		s translateTo: p - (0.5 @ 0.5) * 20.
	].
	^ c @ RSCanvasController
]

{ #category : #visualization }
RL >> visualizeGraph [
	| s allStates d m |
	s := stateConnections asSet asArray.
	d := Dictionary new.
	s do: [ :assoc | 
		(d at: assoc key ifAbsentPut: [ OrderedCollection new ]) add: assoc value ].

	allStates := qTable keys.
	m := RSMondrian new.
	m shape circle.
	m nodes: allStates.
	m line connectToAll: [ :aState | d at: aState ifAbsent: [ #() ] ].
	m layout force.
	m build.
	^ m canvas.
]

{ #category : #visualization }
RL >> visualizeQTable [
	| c state values allBoxes sortedAssociations |
	c := RSCanvas new.
	
	c add: (RSLabel text: 'State').
	c add: (RSLabel text: '^').
	c add: (RSLabel text: 'V').
	c add: (RSLabel text: '<').
	c add: (RSLabel text: '>').
	
	sortedAssociations := qTable associations reverseSortedAs: [ :assoc | assoc value average ].
	sortedAssociations do: [ :assoc |
		state := RSLabel model: assoc key.
		values := RSBox 
						models: (assoc value collect: [ :v | v round: 2 ]) 
						forEach: [ :s :m | s extent: 40 @ 20 ].
		c add: state.
		c addAll: values.
	].
	RSCellLayout new lineItemsCount: 5; gapSize: 1; on: c shapes.
	allBoxes := c shapes select: [ :s | s class == RSBox ].
	RSNormalizer color
		shapes: allBoxes;
		from: Color red darker darker; to: Color green darker darker;
		normalize.
	allBoxes @ RSLabeled middle.
	^ c @ RSCanvasController
]

{ #category : #visualization }
RL >> visualizeResult [
	"Assume that the method play was previously invoked"
	| c s |
	self play.
	c := startState visualize.
	path do: [ :p |
		s := RSCircle new size: 5; color: Color blue lighter lighter.
		c add: s.
		s translateTo: p - (0.5 @ 0.5) * 20.
	].
	^ c @ RSCanvasController
]

{ #category : #visualization }
RL >> visualizeReward [
	| c plot |
	c := RSChart new.
	plot := RSLinePlot new.
	plot y: rewards.
	c addPlot: plot.
	c addDecoration: (RSChartTitleDecoration new title: 'Reward evolution'; fontSize: 20).
	c xlabel: 'Episode' offset: 0 @ 10.
	c ylabel: 'Reward' offset: -20 @ 0.
	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new).
	c build.
	^ c canvas
]

{ #category : #visualization }
RL >> visualizeWeightedGraph [
	| s allStates d m |
	s := stateConnections asSet asArray.
	d := Dictionary new.
	s do: [ :assoc | 
		(d at: assoc key ifAbsentPut: [ OrderedCollection new ]) add: assoc value ].

	allStates := qTable keys.
	m := RSMondrian new.
	m shape circle.
	m nodes: allStates.
	m line connectToAll: [ :aState | d at: aState ifAbsent: [ #() ] ].
	m normalizeSize: [ :aState | (qTable at: aState) average ] from: 5 to: 30.
	m normalizeColor: [ :aState | (qTable at: aState) max ] from: Color gray to: Color green.
	m layout force.
	m build.
	^ m canvas.
]
