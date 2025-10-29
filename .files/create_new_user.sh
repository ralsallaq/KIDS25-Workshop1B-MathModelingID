#!/bin/bash
source $HOME/.myven/bin/activate
user=$(head -1 $HOME/.files/user_list.txt)
sed -i 1d  $HOME/.files/user_list.txt
echo -e "====================================================\n \
         ========== YOU ARE PARTICIPANT $user ===============\n \
	 ====================================================\n"
userDir="participant-$user"
mkdir $HOME/$userDir
echo "Descending into $HOME/$userDir"
cd $HOME/$userDir 
touch YOUARE-participant-$user
cp $HOME/.files/CovidModel_SIR.ipynb .
PORTNUM=$(python -c "import numpy as np; 
rand_num=np.random.choice(9,4) 
unpermmitted = list(range(1015,1020)) + list(range(0,1000))
port_str=np.array_str(rand_num).replace('[','').replace(']','').replace(' ','')
#while int(port_str) in unpermmitted:
while int(port_str) < 8000:
    rand_num=np.random.choice(9,4);
    port_str=np.array_str(rand_num).replace('[','').replace(']','').replace(' ','')
print(port_str)
")

echo "participant $user port  = $PORTNUM"
echo -e "====================================================\n \
         ===== Open new terminal/cmd window and run =========\n \
	 ssh -N -L $PORTNUM:localhost:$PORTNUM azureuser@20.115.101.96\n \
	 ==== and enter the VM password when prompted =======\n"
echo "ssh -N -L $PORTNUM:localhost:$PORTNUM azureuser@20.115.101.96" > command_to_run_on_new_window.info
cmd="jupyter-lab --no-browser --port=$PORTNUM"
echo "source $HOME/.myven/bin/activate" > command_to_initiate_jupyter.sh
echo "$cmd" >> command_to_initiate_jupyter.sh
chmod u+x command_to_initiate_jupyter.sh
echo -e "============ Initiating jupyter-lab =============\n \
         ==== Running $cmd =====\n"
#eval $cmd
echo -e "Instructions:\n \
	1. view the contents of command_to_run_on_new_window.info:
           cat command_to_run_on_new_window.info\n \
        2. Open a new command window:
	   A. If you are using Windows computer open a cmd window by searching for 'cmd' in the search bar and clicking on the Command Prompt from the results\n \
	   B. If you are using Mac OS then open Applications and look for terminal, click it to open.\n \
	3. Type or copy paste the command from 1. above and click enter\n \
	4. Type the VM password\n \
	5. If all is good the terminal will sort of appear to be frozen after you entered the password, leave this command/terminal window open at all times and minimize it as no more work is needed on it. \n \
	6. To intiate Jupyter from within your participant directory run\n \
	   ./command_to_initiate_jupyter.sh\n \
	7. If all goes well you will see messages such as\n \
	   To access the server, open this file in a browser:\n \
	       file:///....\n \
	    Or copy and paste one of the URLs:\n \
	       http://localhost:...\n \
	8. Open your favorite browser on your laptop.\n \
	9. Copy the entire URL line that starts with http://localhost:\n \
	    and paste it into your local browser to view your own notebook copy\n \
	10. Report any issues to the Workshop facilitator." > Instructions



#[W 2025-10-26 12:23:42.441 ServerApp] Permission to listen on port 1015 denied.
#[W 2025-10-26 12:23:42.441 ServerApp] Permission to listen on port 1016 denied.
#[W 2025-10-26 12:23:42.441 ServerApp] Permission to listen on port 1017 denied.
#[W 2025-10-26 12:23:42.442 ServerApp] Permission to listen on port 1018 denied.
#[W 2025-10-26 12:23:42.442 ServerApp] Permission to listen on port 1019 denied.
