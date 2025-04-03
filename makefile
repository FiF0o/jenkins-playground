.PHONY: help

help:
	brew services --help

jenkins-run:
	brew services start jenkins-lts

jenkins-restart:
	brew services restart jenkins-lts

jenkins-upgrade:
	brew upgrade jenkins-lts

jenkins-stop:
	brew services stop jenkins-lts

jenkins-cleanup:
	brew services cleanup

compile:
	javac -d bin -sourcepath src src/HelloWorld.java

run:
	java -cp bin HelloWorld

mvn:create
	mvn archetype:generate -DgroupId=com.companyname.appname -DartifactId=appname -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

mvn:install
	cd myapp && mvn install

mvn:build
	cd myapp && mvn compile

mvn:test
	cd myapp && mvn test