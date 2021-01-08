#!/bin/bash
 sleep 60 &
echo "*----informations sur le processus courrant de pid "$$"----*"
ps o pid,ppid,state $$
echo "je suis $$ je termine avant mon fils $!"
echo "mon fils $! est maintenant adopté par init de ppid 1"
ps o pid,ppid,state,command  $! &
  
