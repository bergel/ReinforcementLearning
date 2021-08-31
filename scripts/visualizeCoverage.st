"Loading all the tool suite"
[ Metacello new 
  baseline: 'Spy2'; 
  repository: 'github://ObjectProfile/Spy2'; 
  load: 'HapaoCore' ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load: 'Full' ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'ReinforcementLearning';
    repository: 'github://bergel/ReinforcementLearning:main';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ].


"Configuring the visualization"
shouldClassHaveName := true.
classNameHeight := 3.
packageNameAsRegExp := 'ReinforcementLearning*'.
numberOfMethodsToList := 10;

"Script that visualize the coverage"
profiler := 'Hapao2' asClass runTestsForPackagesMatching: packageNameAsRegExp.
classSizeScale := 'NSScale' asClass linear range: #(5 30); domain: { 0 . (profiler allClasses max: #numberOfMethods) }.
classColorCoverage := 'NSScale' asClass linear range: {Color red . Color black}; domain: { 0 . 100 }.
m := 'RSMondrian' asClass new.
m shape labeled: #packageName; color: Color white; borderColor: Color gray.
m nodes: profiler packages forEach: [ :pak |
  m shape box 
    size: [ :cls | classSizeScale scale: cls numberOfMethods ];
    color: [ :cls | classColorCoverage scale: cls coverage ];
    if: #isTestClass color: Color green darker.
  
  someBoxes := m nodes: pak classes.
  shouldClassHaveName ifTrue: [ someBoxes @ (RSLabeled new fontSize: classNameHeight) ].
  m orthoVerticalLine connectFrom: #superclass.
  m layout tidyTree
].
m build.

"Indicate the overall coverage"
lbl := RSLabel text: 'Ratio of covered methods = ', (profiler coverage asString), ' %'. 
RSLocation move: lbl above: m canvas nodes.
m canvas add: lbl.

"Show a few uncovered methods"
uncoveredMethods := profiler noncoveredMethods.
uncoveredMethods notEmpty ifTrue: [ 
  labels := RSLabel models: (uncoveredMethods copyFrom: 1 to: (uncoveredMethods size min: numberOfMethodsToList)).
  RSCellLayout new lineItemsCount: 2; on: labels.
  RSLocation move: labels below: m canvas nodes.
  labels translateBy: 0 @ 40.
  labels @ RSHighlightable red.
  m canvas addAll: labels.
  
  titleLabel := RSLabel new text: 'Some uncovered methods:'; color: Color black.
  m canvas add: titleLabel.
  RSLocation move: titleLabel above: labels.
].

"Exporting the picture"
m canvas extent: 1000 @ 1000.
RSPNGExporter new
  canvas: m canvas;
  exportToFile: 'coverage.png' asFileReference.

"We create a file that will contain the result of the test coverage"
path := '/tmp/ratio'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
stream := path asFileReference writeStream.
stream nextPutAll: profiler coverage asString.
stream close.

"Quitting Pharo"
SmalltalkImage current quitPrimitive
