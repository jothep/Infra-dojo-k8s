FROM openjdk:11-jre-slim
COPY abc-config /usr/src/myapp/abc-config
COPY run.sh /usr/src/myapp/run.sh
RUN chmod +x /usr/src/myapp/run.sh
#RUN /bin/bash --login -c "source /usr/src/myapp/abc-config && echo $AC_ALBAN > /usr/src/myapp/file.txt"
#RUN . /usr/src/myapp/abc-config
#RUN echo $AC_ALBAN > /usr/src/myapp/file.txt
#RUN /bin/bash --login -c "cat /usr/src/myapp/abc-config >> ~/.bashrc && echo $AC_ALBAN > /usr/src/myapp/file.txt"
WORKDIR /usr/src/myapp
CMD ["sh", "-c", ". /usr/src/myapp/abc-config && /usr/src/myapp/run.sh"]