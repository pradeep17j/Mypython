import time
import sys
sys.path.append("/u/ppradeepkumar/MyPython/Python-2.7.6/")
import pexpect
import re


loadgen_cmd='/var/loadgen_edge -f '
loadgen_cfg=" /var/cfg/loadgen-{:d}.xml "
loadgen_args=" --test-duration 1500 --read-op --lba-cnt 19531250 --burst-rate 65536 --num-ops 2,100 > "
loadgen_logs=" logx/{:d}.txt 2>&1 &"

class va_box_prompt(object):
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
    instance=1

    def get_login(self):
        super(loadgen_box,self).get_login()
        super(loadgen_box,self).exec_on_shell('cd /var')

    def start_loadgen_cmd(self):
        cfg= loadgen_cfg.format(self.instance)
        log= loadgen_logs.format(self.instance)
        self.exec_on_shell(loadgen_cmd+cfg+loadgen_args+log)
        self.instance+=1

stor_stats= 'show stats storage '
stor_stats1= '{:s} start-time \'{:s}\' end-time \'{:s}\' {:s} '

class stats_collect():
    start_time=None
    end_time=None
    def form_time(self):
        self.start_time= self.start_time.replace('-','/')
        self.end_time= self.end_time.replace('-','/')
    def form_stats_cmd(self,appnd):
        return stor_stats + stor_stats1.format(appnd[0],self.start_time,self.end_time,appnd[1])


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


#import pdb; pdb.set_trace()

#Probe edge
probe= va_box()
probe.hostname='oak-sh610'
probe.get_login()

# Edge on which loadgen runs
#loadgen= va_box()
loadgen= loadgen_box()
loadgen.hostname='oak-sh584'
loadgen.get_login()

# Tarpon core
tarpon= va_box()
tarpon.hostname='oak-sh809'
tarpon.get_login()

#import pdb; pdb.set_trace()


def show_systems():
    for i in handles.keys():
        print i

def start_loadgen():
    count=0
    for i in range(1,10):
        loadgen.start_loadgen_cmd()
        time.sleep(1)
        
def clear_restart_edge():
    probe.exec_on_cli("service storage restart clean")

def restart_core():
    tarpon.exec_on_cli("service restart ")

def get_stats():
    import pdb; pdb.set_trace()
    date_cmd= 'date +\'%F %T\''
    core1= stats_collect()
    edge1= stats_collect()


    core_start_time= tarpon.exec_on_shell(date_cmd)
    core1.start_time= core_start_time[0]

    edge_start_time= probe.exec_on_shell(date_cmd)
    edge1.start_time= edge_start_time[0]

    time.sleep(30)

    core_end_time= tarpon.exec_on_shell(date_cmd)
    core1.end_time= core_end_time[0]

    edge_end_time= probe.exec_on_shell(date_cmd)
    edge1.end_time= edge_end_time[0]

    core1.form_time()
    edge1.form_time()

    tmp=[]
    tmp.append('filer-bytes')
    tmp.append('filer all')
    tarpon_stats= tarpon.exec_on_cli(core1.form_stats_cmd(tmp))

    tmp=[]
    tmp.append('filer-latency')
    tmp.append('filer all')
    tarpon_stats= tarpon.exec_on_cli(core1.form_stats_cmd(tmp))

    tmp=[]
    tmp.append('lun-bytes')
    tmp.append('lun all')
    probe_stats= probe.exec_on_cli(edge1.form_stats_cmd(tmp))

    tmp=[]
    tmp.append('lun-latency')
    tmp.append('lun all')
    probe_stats= probe.exec_on_cli(edge1.form_stats_cmd(tmp))



while 1:
    print "\n\nselect options below\n"
    print "\t\t10. Start 10 Loadgen instances\n"
    print "\t\t20. Exit\n"
    print "\t\t30. Collect stats\n"
    print "\t\t31. Clean restart probe edge\n"
    print "\t\t32. restart core\n"
#   import pdb; pdb.set_trace()
    in1=raw_input("Enter here:")
    print in1

    options = {
            '10':start_loadgen,
            '20':exit,
            '30':get_stats,
            '31':clear_restart_edge,
            '32':restart_core,
            }

    options[in1]()
