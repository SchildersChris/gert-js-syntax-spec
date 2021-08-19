plugins {
    // Java support
    id("java")
    // Kotlin support
    id("org.jetbrains.kotlin.jvm") version "1.5.10"
    // gradle-intellij-plugin - read more: https://github.com/JetBrains/gradle-intellij-plugin
    id("org.jetbrains.intellij") version "1.1.2"
    // parser/lexer plugin
    id("antlr")
}

group = "com.schilderschris.gjsyntax"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

sourceSets {
    main {
        java.srcDir("src/main")
    }
    test {
        java.srcDir("src/test")
    }
}

dependencies {
    implementation(kotlin("stdlib"))
    antlr("org.antlr:antlr4:4.+")
}


tasks {
    generateGrammarSource {
        arguments = arguments + listOf("-visitor", "-package", "com.schilderschris.gjsyntax", "-Xexact-output-dir")

        doLast {
            val parserPackagePath = "${outputDirectory.canonicalPath}/com/schilderschris/gjsyntax/"

            file(parserPackagePath).mkdirs()

            copy {
                from(outputDirectory.canonicalPath)
                into(parserPackagePath)
                include("GJSyntax*")
            }
            delete(fileTree(outputDirectory.canonicalPath) {
                include("GJSyntax*")
            })
        }
    }

    compileKotlin {
        dependsOn("generateGrammarSource")
    }
}