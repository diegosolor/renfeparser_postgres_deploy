from invoke import task

@task
def buildDataBase(ctx):
    print("Building docker image")
    ctx.run("docker build --tag='bd_renfe' .", hide='out')
    ctx.run("docker tag 'bd_renfe' bd_renfe:latest", hide='out')

@task(buildDataBase)
def startDataBase(ctx):
    print("Starting docker container")
    ctx.run("docker kill bd_renfe", warn=True)
    ctx.run("docker rm bd_renfe", warn=True)
    ctx.run("docker run -p=0.0.0.0:5432:5432 --name bd_renfe -d bd_renfe:latest")

