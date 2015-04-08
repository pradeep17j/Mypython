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
    hostname=None
    shell=None
    cli=None
    def get_login(self):
        login(self)
        login(self,access='cli')
    def exec_on_shell(self,cmd):
        return exec_this_shell_cmd(self,cmd)
    def exec_on_cli(self,cmd):
        return exec_this_cli_cmd(self,cmd)

class loadgen_box(va_box):
    cmd= '/var/loadgen_edge -f /var/cfg/loadgen-'
    cmd= cmd+loadgen_num +'.xml'+' --test-duration 1500 --read-op --burst-rate 65536 --num-ops 2,100 &'
    output=None


cmd= 'ssh'
params= ''' -oStrictHostKeyChecking=no
    -oCheckHostIP=no -oForwardX11=no
    -oUserKnownHostsFile=/dev/null
    -oConnectTimeout=10 -oServerAliveInterval=300
    -oForwardAgent=no '''

#systems=[ probe, loadgen, tarpon ]

def login(self,access='shell'):
    hostname= self.hostname
    cmd1 = cmd + params + 'root@'+ hostname
    child= pexpect.spawn(cmd1)    
    child.logfile = sys.stdout
    index= child.expect(['password',self.COMMAND_PROMPT,pexpect.EOF])
    if index==0:
        child.sendline( '2top90!')
        child.expect(self.COMMAND_PROMPT)
    elif index!=1:
        print "Not able to login"
        sys.exit(0)

    if access is 'shell':
        self.shell= child
    elif access is 'cli':
        child.sendline('cli')
        child.expect('>')
        child.sendline('terminal length 0')
        child.expect(self.CLI_PROMPT)
        child.sendline('en')
        child.expect(self.CLI_PROMPT)
        child.sendline('con t')
        child.expect(self.CLI_PROMPT1)
        self.cli= child


#Probe edge
probe= va_box()
probe.hostname='oak-sh610'
probe.get_login()

# Edge on which loadgen runs
loadgen= va_box()
loadgen.hostname='oak-sh584'
loadgen.get_login()

# Tarpon core
tarpon= va_box()
tarpon.hostname='oak-sh809'
tarpon.get_login()

import pdb; pdb.set_trace()

def get_output_only(output):
    out= output.split('\n')
    #Except the first and last line, consider all other lines as ouput
    # Take out first line
    out.pop(0)
    #take out last line
    out.pop()
    out1= map(str.strip,out)
    return out1
    

def exec_this_cli_cmd(self,cmd,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    self.cli.sendline(cmd)
    self.cli.expect(self.CLI_PROMPT1,timeout=160)
    output= self.cli.before
    output1= get_output_only(output)
    return output1

def exec_this_shell_cmd(self,cmd,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    self.shell.sendline(cmd)
    self.shell.expect(self.COMMAND_PROMPT,timeout=160)
    output= self.shell.before
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

    import pdb; pdb.set_trace()
    core_start_time= tarpon.exec_on_shell(date_cmd)
    core_start_time[0]= "'"+core_start_time[0].replace('-','/')+"'"

    edge_start_time= probe.exec_on_shell(date_cmd)
    edge_start_time[0]= "'"+edge_start_time[0].replace('-','/')+"'" 

    time.sleep(10)

    core_end_time= tarpon.exec_on_shell(date_cmd)
    core_end_time[0]= "'"+core_end_time[0].replace('-','/')+"'"
    edge_end_time= probe.exec_on_shell(date_cmd)
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
