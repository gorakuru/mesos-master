FROM gorakuru/mesos-ready:1.0
MAINTAINER gorakuru <msr.tmr@gmail.com>

RUN wget http://www.apache.org/dist/mesos/0.23.0/mesos-0.23.0.tar.gz
RUN tar -zxvf mesos-0.23.0.tar.gz
RUN cd mesos-0.23.0 && mkdir build && cd build && ../configure && make

RUN cd /mesos-0.23.0/build && easy_install src/python/dist/mesos.interface-0.23.0-py2.7.egg
RUN mkdir -p /var/lib/mesos/executors/ && wget https://raw.github.com/mesosphere/mesos-docker/master/bin/mesos-docker -O /var/lib/mesos/executors/docker && chmod a+x /var/lib/mesos/executors/docker

#RUN tar zxvf /mesos-0.23.0/3rdparty/zookeeper-3.4.5.tar.gz && cp /zookeeper-3.4.5/conf/zoo_sample.cfg /zookeeper-3.4.5/conf/zoo.cfg

ADD setip.sh /setip.sh
#CMD sleep 3m && sh /setip.sh && /zookeeper-3.4.5/bin/zkServer.sh start && /mesos-0.23.0/build/bin/mesos-master.sh --work_dir=/var/lib/mesos --zk=zk://localhost:2181/mesos --quorum=1
CMD sleep 3m && sh /setip.sh && /mesos-0.23.0/build/bin/mesos-master.sh --work_dir=/var/lib/mesos --ip=`hostname -i`