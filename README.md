# Spark_SentiLib_NLP
In this repository you can find the Dockerfile and code used during my Master's Thesis

# How to make it work

1. Install docker, in this case we want to use it in a Linux distribution. You can find the tutorial here: https://docs.docker.com/engine/install/

2. Download the repository.

3. Download files located in this drive: https://drive.google.com/drive/folders/1s_K-ioCcQ7n8Ob-m4h-mz0-bMGtrRurN and move them inside the repository, exactly in the same folder where Dockerfile is located.

4. Use the comand "_docker build -t=NAME_OF_DOCKER_IMAGE ._" in a terminal inside the file where Dockerfile is located

5. Now you can create a container from the image, I suggest using the next command in your terminal:

_docker run \
-it \
-p 9870:9870 \
-p 9864:9864 \
-p 9866:9866 \
-p 9865:9865 \
-p 9867:9867 \
-p 4040:4040 \
-p 6066:6066 \
-p 7077:7077 \
-p 9080:9080 \
-p 8881:8881 \
-p 8888:8888 \
-p 8080:8080 \
-p 8081:8081 \
--gpus all \
--name NAME_OF_DOCKER_CONTAINER \
NAME_OF_DOCKER_IMAGE_

6. Use the command "_bash init.sh_" to finish the installation.

7. You have to change your user in order to use Hadoop and Anaconda. You can easily change your user with "_su user_" and get back to root with "_exit_".

8. In order to initiate hadoop don't forget to format only once the _Namenode_ with the command "_hdfs namenode -format_". You can initiate hadoop from _/usr/local/hadoop/sbin_ with the commands "_./start-dfs.sh_" and "_start-yarn.sh_". Also you can stop Hadoop daemons with "_./stop-dfs.sh_" and "_./stop-yarn.sh_" you can also stop all the daemons with only "_./stop-all.sh_".

9. In case you want to use Spark from Anaconda you have to move to "_home/user/_" and write "_jupyter notebook --ip 0.0.0.0_" then you can see a link that will open Jupyter Notebook interface in your browser. I recommend running first "_Installed_libraries.ipynb_", this file will install the required libraries in your Anaconda environment inside the container.

 
