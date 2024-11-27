#!/bin/bash

### Create the response FIFO
rm -f response
mkfifo response
RESPONSE="HTTP/1.1 404 NotFound\r\n\r\n\r\nNot Found"

function handlepage()
{
#echo response=$RESPONSE
echo -e "HTTP/1.1 200 OK\n\rContent-Type: text/html\n\r\n\r$RESPONSE" > response
}

function handle404()
{
echo -e "HTTP/1.1 404 NotFound\r\n\r\n\r\n404 Not Found" > response
}

function handleRequest() {
  while read line; do
    #echo $line
    trline=`echo $line | tr -d '[\r\n]'`

    [ -z "$trline" ] && break
   
    HEADLINE_REGEX='(.*?)\s(.*?)\sHTTP.*?'

    [[ "$trline" =~ $HEADLINE_REGEX ]] &&
    REQUEST=$(echo $trline | sed -E "s/$HEADLINE_REGEX/\1 \2/")

  done

  OLDIFS="$IFS"
  IFS='?' tokens=( $REQUEST )
  REQ=${tokens[0]}
  ARG=${tokens[1]}
  IFS='&' args=( $ARG )
  #echo args=${tokens[*]}
  IFS="$OLDIFS" # restore IFS

  #case "$REQUEST" in
  #case "${tokens[0]}" in
  case "$REQ" in
  "GET /")
	  RESPONSE=`cat main.html`
	  handlepage
	  ;;
  "GET /PLAINHTML") 
	  RESPONSE=`cat plain.html`
	  handlepage
	  ;;
  "GET /FRAMES") 
	  RESPONSE=`cat frames.html`
	  handlepage
	  ;;
  "GET /DYNAMIC") 
	  RESPONSE=`./dynamic.bash`
	  handlepage
	  ;;
  "GET /GUI") 
	  RESPONSE=`cat gui.html`
	  handlepage
	  ;;
  "GET /GUIPROC") 
	  ./guiproc.bash ${args[*]} 
	  RESPONSE=`cat gui.html`
	  handlepage
	  ;;
   *) handle404
	  ;;
esac

}

while [ 1 ]
do
#echo 'Listening on 3000...'
cat response | nc -lN 3000 | handleRequest
done
