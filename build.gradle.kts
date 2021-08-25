plugins {
    java
    antlr
    `maven-publish`
//    signing
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
    antlr("org.antlr:antlr4:4.9.2")
}

tasks {
    generateGrammarSource {
        arguments = arguments + listOf("-visitor", "-package", "com.schilderschris.gjsyntax", "-Xexact-output-dir")
    }

    compileJava {
        sourceCompatibility = "11"
        targetCompatibility = "11"
        options.encoding = "UTF-8"

        dependsOn("generateGrammarSource")
    }
}

configure<PublishingExtension> {
    publications {
        create<MavenPublication>("maven") {
            artifactId = project.name
            from(components["java"])

            pom {
                name.set("Gert-Js Syntax Specification")
                description.set("GJSyntax specs written in ANTLR4.")
                url.set("https://gert-js.vercel.app/")
                licenses {
                    license {
                        name.set("The Apache License, Version 2.0")
                        url.set("http://www.apache.org/licenses/LICENSE-2.0.txt")
                    }
                }
                developers {
                    developer {
                        id.set("SchildersChris")
                        name.set("Chris Schilders")
                    }
                }
            }
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
//
//signing {
//    sign(publishing.publications["maven"])
//}