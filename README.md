# theia-python3
Testing out the VS Code Python extension in Theia

# Installation
For a clean install and testing, build a docker image:
```
git clone git@github.com:jgbradley1/theia-python3.git
cd theia-python3
docker build -t theia-python3 .
```
# Testing
After building the docker image:
```
docker run -it -p 3000:3000 theia-python3
```

