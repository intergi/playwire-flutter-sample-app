allprojects {
    repositories {
        google()
        mavenCentral()
        maven("https://android-sdk.is.com/")
        maven("https://artifact.bytedance.com/repository/pangle/")
        maven("https://cboost.jfrog.io/artifactory/chartboost-ads/")
        maven("https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea")
        maven("https://repo.pubmatic.com/artifactory/public-repos/")
        maven("https://maven.ogury.co")
        maven("https://s3.amazonaws.com/smaato-sdk-releases/")
        maven("https://verve.jfrog.io/artifactory/verve-gradle-release")
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
