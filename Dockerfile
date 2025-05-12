FROM public.ecr.aws/ubuntu/ubuntu:24.04 AS builder
RUN apt-get update && apt-get install -y openjdk-8-jdk
WORKDIR /app
ADD HelloWorldServer.java .

RUN javac -source 8 -target 8 HelloWorldServer.java -d .

FROM public.ecr.aws/ubuntu/jre:21-24.04_stable

COPY --from=builder /app/HelloWorldServer.class .

CMD [ "exec", "java", "-cp", "/", "HelloWorldServer" ]

# See the image size: sudo docker images
# Run it with sudo docker run -d -p 8080:8080 --name jre-container-web -e TZ=UTC <<IMAGE NAME>>
