import os
from invoke import task
from fabric import Connection


@task
def installPackages(ctx):
    ctx.run("apt-get install -y docker.io")

@task
def buildDataBase(ctx):
    temp_dir = "/tmp/docker_db/"
    copyFolder(ctx, origin_path='.', destiny_path=temp_dir);
    print("Building docker image")
    with ctx.cd(temp_dir):
        ctx.run("docker build --tag='bd_renfe' .", warn=True)

@task(buildDataBase)
def startDataBase(ctx):
    print("Starting docker container")
    ctx.run("docker kill bd_renfe", warn=True)
    ctx.run("docker rm bd_renfe", warn=True)
    ctx.run("docker run -p=0.0.0.0:5432:5432 --name bd_renfe -d bd_renfe:latest")

@task
def uname(ctx):
    ctx.run("uname -a")


def copyFolder(ctx, destiny_path, origin_path='.'):
    for root, subdirectories, files in os.walk(origin_path):
        destiny_subdir = os.path.join(destiny_path, root)
        ctx.run('mkdir -p {}'.format(destiny_subdir))
        for file in files:
            origin_file = os.path.join(root, file)
            destiny_file = os.path.join(destiny_subdir, file)
            ctx.put(origin_file, remote=destiny_file)

