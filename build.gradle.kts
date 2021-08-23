plugins {
    // Java support
    java
    // parser/lexer plugin
    antlr
    // Publishing
    `maven-publish`
}

group = "com.schilderschris.gjsyntax"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

sourceSets {
    main {
        java.srcDir("src/main/antlr")
    }
    test {
        java.srcDir("src/test")
    }
}

dependencies {
    antlr("org.antlr:antlr4:4.+")
}

tasks {
    generateGrammarSource {
        arguments = arguments + listOf("-visitor", "-package", "com.schilderschris.gjsyntax", "-Xexact-output-dir")
    }

    compileJava {
        dependsOn("generateGrammarSource")
    }
}

configure<PublishingExtension> {
    publications {
        create<MavenPublication>("maven") {
            artifactId = project.name
            from(components["java"])
        }
    }
    repositories {
        maven {
            name = "repsy"
            credentials(PasswordCredentials::class)
            url = uri("https://panel.repsy.io/mvn/chrisschilders/gert-js/")
        }
    }
}