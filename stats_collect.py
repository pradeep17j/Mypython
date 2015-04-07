import time
import sys
sys.path.append("/u/ppradeepkumar/MyPython/Python-2.7.6/")
import pexpect
import re

class va_box_prompt:
    COMMAND_PROMPT=None
    CLI_PROMPT=None
    CLI_PROMPT1=None
    def __init__(self):
        self.COMMAND_PROMPT= re.compile('\[admin\@\S+ \S+\]#')
        self.CLI_PROMPT= re.compile('\S+\s*(>|#|\(config\)\s*#)')
        self.CLI_PROMPT1= re.compile('\S+\s*\(config\)\s*#')

class va_box(va_box_prompt):
    host_name=None
    shell=None
    cli=None
    

    


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

def get_output_only(output):
    out= output.split('\n')
    #Except the first and last line, consider all other lines as ouput
    # Take out first line
    out.pop(0)
    #take out last line
    out.pop()
    out1= map(str.strip,out)
    return out1
    

def exec_this_cli_cmd(cmd,this_handle,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    this_handle.sendline(cmd)
    this_handle.expect(CLI_PROMPT1,timeout=160)
    output= this_handle.before
    output1= get_output_only(output)
    return output1

def exec_this_shell_cmd(cmd,this_handle,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    this_handle.sendline(cmd)
    this_handle.expect(COMMAND_PROMPT,timeout=160)
    output= this_handle.before
    output1= get_output_only(output)
    return output1


def show_systems():
    for i in handles.keys():
        print i

loadgen_num=1
def start_loadgen():
    loadgen_shell = handles[loadgen]['shell']

    cmd= '/var/loadgen_edge -f /var/cfg/'+'loadgen-'+ loadgen_num +'.xml'+' --test-duration 1500 --read-op --burst-rate 65536 --num-ops 2,100 &'
    count=0
    for i in range(1,10):
        exec_this_shell_cmd(cmd,loadgen_shell)
        loadgen_num= loadgen_num+i
        

def get_stats():
    date_cmd= 'date +\'%F %T\''

    tarpon_shell= handles[tarpon]['shell']
    tarpon_cli= handles[tarpon]['cli']
    probe_shell= handles[probe]['shell']
    probe_cli= handles[probe]['cli'] 

    core_start_time= exec_this_shell_cmd(date_cmd,tarpon_shell)
    core_start_time[0]= "'"+core_start_time[0].replace('-','/')+"'"
    edge_start_time= exec_this_shell_cmd(date_cmd,probe_shell)
    edge_start_time[0]= "'"+edge_start_time[0].replace('-','/')+"'" 
    time.sleep(10)
    core_end_time= exec_this_shell_cmd(date_cmd,tarpon_shell)
    core_end_time[0]= "'"+core_end_time[0].replace('-','/')+"'"
    edge_end_time= exec_this_shell_cmd(date_cmd,probe_shell)
    edge_end_time[0]= "'"+edge_end_time[0].replace('-','/')+"'"

    core_stats_cmd= "show stats storage filer-latency start-time "
    core_stats_cmd= core_stats_cmd + core_start_time[0] + ' end-time ' + core_end_time[0] + ' filer all'
    import pdb; pdb.set_trace()
    tarpon_stats= exec_this_cli_cmd(core_stats_cmd,tarpon_cli)

    probe_stats_cmd= "show stats storage lun-latency start-time "
    probe_stats_cmd= probe_stats_cmd + edge_start_time[0] + ' end-time ' + edge_end_time[0] + ' lun all'
    probe_stats= exec_this_cli_cmd(probe_stats_cmd,probe_cli)


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
            '10':start_loadgen,
            '20':exit,
            '30':get_stats,
#            '31':add_luns,
#            '32':remove_luns,
            }

    options[in1]()
