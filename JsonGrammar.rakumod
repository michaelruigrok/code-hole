unit module JsonGrammar;

grammar JSON is export {
	token TOP { <value> }
	token value { ( <string> | <boolean> | <null> | <number> | <array> | <object> ) }
	token string { \" <-[\"\v\b]>* \" }
	token boolean { (true|false) }
	token null { null }

	token number { \-? <digit>+ <decimal>? <exponent>? }
	token decimal { \. <digit>+ }
	token exponent { <[eE]> <digit>+ }

	rule array { ( \[ \] | \[ (<value> \, )* <value> \] ) }
	rule object { (
		\{ \} 
		|
		\{ (<string> \: <value> \, )* <string> \: <value> \}
	) }
}
