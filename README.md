Ballerina GraalVM Native Image Support
======================================

This repository provides basic ballerina samples with GraalVM `native-image` commands which can be
used to generate executable files. 

## Prerequisites

1. **Install Ballerina**.

   The samples are tested with Ballerina SwanLake `2201.2.0`. Visit [Ballerina Download](https://ballerina.io/downloads/) 
to download and install the latest version.

2. **Install GraalVM with GraalVM `native-image` tool**.

   The commands are tested against GraalVM CE `22.2.0` with Java 11. Visit [GraalVM Quick Start](https://www.graalvm.org/java/quickstart/)
to install GraalVM and `native-image` tool.

## Building a native image for a sample

1. **Generate the `jar` file**.

   Build the ballerina sample using `bal build` command. By default, this will create a `jar` file 
in the `target/bin` directory of the package root directory.

2. **Generate the native image**.

    After generating the `jar` file for the sample, specify the `jar` file path and the name of the 
output image in the run `native-image-common.sh`. Run the following command to generate the 
executable : `sh native-image-common.sh`.

3. **Run and test the native image**.

> **Note** : The `native-image-common.sh` and `common-configs` are created to support building native 
images of all the samples in this repository. So using this command will give some warnings which can 
be neglected.

## Handling native image failures for new samples

    The above steps can be also used to create native images of new Ballerina samples. For a new sample 
there can failures in building or running the native image. This [blog](https://simply-how.com/fix-graalvm-native-image-compilation-issues) consists useful informationon handling such errors. Also for failures which occur during the runtime 
the [GraalVM Tracing Agent](https://github.com/oracle/graal/blob/master/docs/reference-manual/native-image/AutomaticMetadataCollection.md) can be used to generate the configuration files.
