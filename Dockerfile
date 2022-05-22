FROM ubuntu:20.04

# Actualización e instalación de programas básicos para llevar a cabo todas las instalaciones
RUN apt update -y; apt upgrade -y; apt install -y curl; apt-get install -y nano; apt-get -y install openssh-client; apt-get install -y git; apt-get install -y pip   

# Creamos el nuevo usuario para utilizar con Hadoop y usar bashrc.
RUN useradd -ms /bin/bash user

# Instalación de Java en su versión 8
RUN apt install -y openjdk-8-jdk-headless

WORKDIR /Downloads

# Instalación de Hadoop 3.3.2
RUN curl https://dlcdn.apache.org/hadoop/common/hadoop-3.3.2/hadoop-3.3.2.tar.gz --output hadoop-3.3.2.tar.gz; tar xvf hadoop-3.3.2.tar.gz; mv hadoop-3.3.2 /usr/local; rm hadoop-3.3.2.tar.gz

# Sobreescribimos el archivo .bashrc con las rutas necesarias para Java
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /home/user/.bashrc; echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /home/user/.bashrc

# Sobreescribimos el archivo .bashrc con las rutas necesarias para Hadoop
RUN echo 'export HADOOP_HOME=/usr/local/hadoop-3.3.2' >> /home/user/.bashrc; echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> /home/user/.bashrc

# Sobreescribimos el archivo hadoop-env.sh con las rutas necesarias para Hadoop
RUN echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /usr/local/hadoop-3.3.2/etc/hadoop/hadoop-env.sh; echo 'HADOOP_HOME=/usr/local/hadoop-3.3.2' >> /usr/local/hadoop-3.3.2/etc/hadoop/hadoop-env.sh; echo 'export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop' >> /usr/local/hadoop-3.3.2/etc/hadoop/hadoop-env.sh

# Configuración de Hadoop
ADD configs/ /usr/local/hadoop-3.3.2/etc/hadoop/
RUN chmod 777 /usr/local/hadoop-3.3.2

# Instalación de Spark 3.2.1
RUN curl https://dlcdn.apache.org/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz --output spark-3.2.1.tar.gz; tar xvf spark-3.2.1.tar.gz; rm spark-3.2.1.tar.gz; mv spark-3.2.1-bin-hadoop3.2 /usr/local
RUN echo 'export SPARK_HOME=/usr/local/spark-3.2.1-bin-hadoop3.2' >> /home/user/.bashrc && echo 'export SPARK_DIST_CLASSPATH=$(hadoop classpath)' >> /home/user/.bashrc && echo 'export PATH=$PATH:$HADOOP_HOME/bin:$SPARK_HOME/bin' >> /home/user/.bashrc

# Instalación de Anaconda 2021.11
RUN apt-get install wget
RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh

# Instalación de la librería SentiLib
WORKDIR /usr/local
RUN git clone https://github.com/WGraterol64/SentiLib.git
ADD checkpoints-20220518T164429Z-001.zip /usr/local/SentiLib/image_utils/
ADD YOLO-weights-20220518T164626Z-001.zip /usr/local/SentiLib/image_utils/
WORKDIR /usr/local/SentiLib/image_utils/
RUN apt-get install -y zip
RUN unzip checkpoints-20220518T164429Z-001.zip; rm checkpoints-20220518T164429Z-001.zip
RUN unzip YOLO-weights-20220518T164626Z-001.zip; rm YOLO-weights-20220518T164626Z-001.zip
WORKDIR /usr/local/SentiLib
RUN pip install .

# Instalación de spacy
RUN pip install -U pip setuptools wheel; pip install -U spacy

# Instalación nltk
RUN pip install -U nltk

# Añadimos los scripts de Jupyter Notebook a la carpeta de usuario
ADD scripts/ /home/user
ADD texto.txt /home/user/Datos/
ADD englishST.txt /home/user
RUN chmod 777 /home/user/DataFrame_Batch.ipynb /home/user/DataFrame_Streaming.ipynb /home/user/RDDs_Batch.ipynb /home/user/RDDs_Streamming.ipynb /home/user/Installed_libraries.ipynb /home/user/Datos/texto.txt /home/user/englishST.txt

# Exponemos los puertos necesarios
EXPOSE 9870 9864 9865 9866 9867 4040 6066 7077 9080 8881 8888 8080 8081

RUN pip install spark-nlp==3.4.3

WORKDIR /

# Script de inicio
ADD init.sh /
ADD user.sh /


