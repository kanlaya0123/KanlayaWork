FROM ubuntu

WORKDIR /app 
ADD . .
RUN apt update && apt install -y bc

EXPOSE 3000
CMD ["./grade.sh"]
