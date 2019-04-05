all: compile

compile:
	jflex scanner.flex
	java -jar ../java-cup-11b.jar -dump_states -interface -parser  Parser parser.cup
	javac -cp ../java-cup-11b-runtime.jar *.java

execute:
	java -cp ../java-cup-11b-runtime.jar:. Main < input.txt

clean:
	rm -f *.class *~ Scanner.java sym.java Parser.java
