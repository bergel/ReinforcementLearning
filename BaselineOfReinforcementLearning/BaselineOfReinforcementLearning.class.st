Class {
	#name : #BaselineOfReinforcementLearning,
	#superclass : #BaselineOf,
	#category : #BaselineOfReinforcementLearning
}

{ #category : #baselines }
BaselineOfReinforcementLearning >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #'ReinforcementLearning';
			baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src'; loads: #('Full') ].
		spec 
			group: 'default' with: #(''Roassal3'' 'ReinforcementLearning' ). ].

]
