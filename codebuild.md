# CodeBuild
A fully managed intergration service that compiles source code, runs tests and produces software packages/artifacts that are ready to deploy. It eliminates the need to provision, manage, patch, update and scale your own build servers.

## Benefits of CodeBuild

CodeBuild provides these benefits:

* **Fully managed** – CodeBuild eliminates the need to set up, patch, update, and manage your own build servers.

* **On demand** – CodeBuild scales on demand to meet your build needs. You pay only for the number of build minutes you consume. No need to provision/scale servers

* **Out of the box** – CodeBuild provides preconfigured build environments for the most popular programming languages. All you need to do is point to your build script to start your first build. Prepackaged servers

## How to run CodeBuild

It can be accessed via the AWS CodeBuild console or AWS CodePipeline console. You can also automate the running of CodeBuild by using the AWS Command Line Interface (AWS CLI) or the AWS SDKs. 

It can be added to the build stage and also the test stage in a pipeline.

### Notes and other concepts:
* As input, you must provide CodeBuild with a **build project**

    **A build project** includes information about how to run a build, where to find the source code, which build environment to use, which build commands to run and where to store the build output. You can create a build project via the AWS CLI or the AWS management console.

* If there is any output, the build environment uploads its output to an **S3 bucket**. That output becomes the input for the next stage.

* A **build stage** is needed ONLY if your code artifacts need to be built/packaged. E.g. For Java, you build a JAR file; whereas, simple HTML does not beed to be built.

* A **buildspec** refers to a collection of build commandes and related settings, in a YAML format that codebuild uses to run a build.
    - You can include a buildspec as part ofthe source code or you can define the buildspec when creating a build project.
    - Without a buildspec, CodeBuild can not successfully convert your build input into build output or locate the build output artifact in the build environment to upload to your build output bucket.
    - If a buildspec is included/bundled with the source code, by default, the file should be name **buildspec.yml** and placed in the root of your source directory.
    - You can specify only 1 buildspec for a build projectt, regardless of the buildspec file's name.