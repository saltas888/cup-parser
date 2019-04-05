# CUP parser to java
The language supports the concatenation operator over strings, function definitions and calls, conditionals (if-else i.e, every "if" must be followed by an "else"), and the following logical expressions:

is-prefix-of (string1 prefix string2): Whether string1 is a prefix of string2.
is-suffix-of (string1 suffix string2): Whether string1 is a suffix of string2.
All values in the language are strings.
## Execution instructions:

$ make compile
$ make execute < input.txt
## Examples
### #1
*Input:*
```java
    name()  {
        "John"
    }
    
    surname() {
        "Doe"
    }
    
    fullname(first_name, sep, last_name) {
        first_name + sep + last_name
    }

    name()
    surname()
    fullname(name(), " ", surname())
```
*Output (Java):*
```java
public class Main {
    public static void main(String[] args) {
        System.out.println(name());
        System.out.println(surname());
        System.out.println(fullname(name(), " ", surname()));
    }

    public static String name() {
        return "John";
    }

    public static String surname() {
        return "Doe";
    }

    public static String fullname(String firstname, String sep, String last_name) {
        return first_name + sep + last_name;
    }
```
}
### #2

*Input:*
```java
    name() {
        "John"
    }

    repeat(x) {
        x + x
    }

    cond_repeat(c, x) {
        if (c prefix "yes")
            if("yes" prefix c)
                repeat(x)
            else
                x
        else
            x
    }

    cond_repeat("yes", name())
    cond_repeat("no", "Jane")
```

### #3

*Input:*
```java
    findLangType(langName) {
        if ("Java" prefix langName)
            if(langName prefix "Java")
                "Static"
            else
                if("script" suffix langName)
                    "Dynamic"
                else
                    "Unknown"
        else
            if ("script" suffix langName)
                "Probably Dynamic"
            else
                "Unknown"
    }

    findLangType("Java")
    findLangType("Javascript")
    findLangType("Typescript")
```
