# gradle-examples

This example shows how to use Gradle for dependency management. It contains two small projects: A producer that
publishes an artifact to Artifactory and a consumer that depends on and downloads the artifact.

Docker is used to run Artifactory.

The example has three parts:

- Start an Artifactory server
- Use Gradle to publish a versioned artifact in the first project
- Use Gradle to consume the versioned artifact in the second project

The example uses a Gradle plugin called
[VersionedBinaryArtifacts](https://github.com/Praqma/VersionedBinaryArtifacts) made by Praqma.

## Usage

### Prerequisites

Ensure `<user home>/.gradle/gradle.properties` has Artifactory properties set as required by the
`VersionedBinaryArtifacts` plugin, like this:

```sh
$ cat ~/.gradle/gradle.properties
...

repositoryManagerUsername=admin
repositoryManagerPassword=password
repositoryManagerUrl=http://localhost:8081/artifactory
```

### Start Artifactory container

```sh
cd infrastructure/artifactory/
./run.sh
```

Now Artifactory runs in a Docker container available on the URL above. It comes with an example repository called
`example-repo-local`. You need to go to the web UI to go through the setup wizard (you can skip all the steps).

### Publish the producer artifact

```sh
cd projects/producer/
./gradlew publish
```

This puts files in Artifactory by a number of steps:

- Read `build.properties` to run the build command: copy files from `src` to `out`
- Apply the `zip` block defined in `build.gradle` to create a zip archive of the `out` folder
- Upload to Artifactory using the repository information in the `gradle.properties` file mentioned earlier, as
  well as the `publishRepo` and `version` from `build.properties`

### Consume in the consumer project

```sh
cd projects/consumer/
./gradlew resolveDep
```

This reads `build.properties` to download the `producer` artifact from Artifactory, along with the `gradle.properties`
file specifying the connection attributes to Artifactory.

The files are downloaded to the `build/resolvedDep` folder.

### Clean up

```sh
docker rm -fv artifactory
```

## Links

- <https://github.com/Praqma/VersionedBinaryArtifacts>
- <https://github.com/praqma-training/embeddedproject>
