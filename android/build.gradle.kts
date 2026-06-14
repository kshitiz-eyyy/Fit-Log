plugins {
<<<<<<< HEAD
    id("com.android.application") version "8.11.1" apply false
    id("kotlin-android") apply false
    id("dev.flutter.flutter-gradle-plugin") apply false
=======
>>>>>>> 9a7a72e6196ad528029b6f5ba74592e00fb661fd
    id("com.google.gms.google-services") version "4.4.1" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}