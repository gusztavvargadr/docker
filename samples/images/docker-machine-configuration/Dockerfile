FROM hashicorp/terraform:0.11.7

WORKDIR /app
VOLUME /data

ADD main.tf /app
ADD templates /app/templates

ADD init.sh /
RUN /init.sh

ADD apply.sh /
ENTRYPOINT [ "/apply.sh" ]
