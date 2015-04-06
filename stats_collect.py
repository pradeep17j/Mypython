import time
import sys
sys.path.append("/u/ppradeepkumar/MyPython/Python-2.7.6/")
import pexpect
import re

cmd= 'ssh'
params= ''' -oStrictHostKeyChecking=no
    -oCheckHostIP=no -oForwardX11=no
    -oUserKnownHostsFile=/dev/null
    -oConnectTimeout=10 -oServerAliveInterval=300
    -oForwardAgent=no '''

COMMAND_PROMPT = re.compile('\[admin\@\S+ \S+\]#')
CLI_PROMPT = re.compile('\S+\s*(>|#|\(config\)\s*#)')
CLI_PROMPT1 = re.compile('\S+\s*\(config\)\s*#')

#Probe edge
probe='oak-sh610'

# Edge on which loadgen runs
loadgen='oak-sh584'

# Tarpon core
tarpon='oak-sh809'

systems=[ probe, loadgen, tarpon ]

def login(hostname,access='shell'):
    cmd1 = cmd + params + 'root@'+ hostname
    child= pexpect.spawn(cmd1)    
    child.logfile = sys.stdout
    index= child.expect(['password',COMMAND_PROMPT,pexpect.EOF])
    if index==0:
        child.sendline( '2top90!')
        child.expect(COMMAND_PROMPT)
    elif index!=1:
        print "Not able to login"
        sys.exit(0)

    if access is 'shell':
        return child
    elif access is 'cli':
        child.sendline('cli')
        child.expect('>')
        child.sendline('terminal length 0')
        child.expect(CLI_PROMPT)
        child.sendline('en')
        child.expect(CLI_PROMPT)
        child.sendline('con t')
        child.expect(CLI_PROMPT1)
        return child


access_types={'shell':None,'cli':None}
handles={}
for i in systems:
    dict1= access_types.copy()
    for j in access_types.keys():
        login_handle= login(i,access=j)
        dict1[j]=login_handle
    handles[i]=dict1

def get_output_only(output,cmd_pat=False,prompt_pat=False):
    import pdb; pdb.set_trace()
    tmp1= output.split('\n')
    out=[];
    #Except the first and last line, consider all other lines as ouput
    # Take out first line
    out.pop(0)
    #take out last line
    out.pop()
    return out
    

def exec_this_cli_cmd(cmd,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    child.sendline(cmd)
    child.expect(CLI_PROMPT1,timeout=160)
    output= child.before
    return output

def exec_this_shell_cmd(cmd,this_handle,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    this_handle.sendline(cmd)
    this_handle.expect(COMMAND_PROMPT,timeout=160)
    output= this_handle.before
    output1= get_output_only(output,cmd_pat=cmd,prompt_pat=COMMAND_PROMPT)
    return output1


def show_systems():
    for i in handles.keys():
        print i

def get_stats():
    import pdb; pdb.set_trace()
    date_cmd= 'date +\'%F %T\''
    for i in handles.keys():
        if(i is tarpon):
            shell= handles[i]['shell']
            cli= handles[i]['cli']
            start_time= exec_this_shell_cmd(date_cmd,shell)
            time.sleep(10)
            end_time= exec_this_shell_cmd(date_cmd,shell)


while 1:
    print "\n\nselect options below\n"
    print "\t\t10. Start 10 Loadgen instances\n"
    print "\t\t20. Exit\n"
    print "\t\t30. Collect stats\n"
    print "\t\t31. Clean restart probe edge\n"
    print "\t\t32. Collect stats on Probe edge\n"
#   import pdb; pdb.set_trace()
    in1=raw_input("Enter here:")
    print in1

    options = {
            '10':show_systems,
            '20':exit,
            '30':get_stats,
#            '31':add_luns,
#            '32':remove_luns,
            }

    options[in1]()
