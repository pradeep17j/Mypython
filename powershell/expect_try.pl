
use Expect;

@Connection_pool=();


@pri_ip=(
"10.5.39.154",
);




@pri_ip=(
#"oak-vva58.lab.nbttech.com",
#"oak-vva59.lab.nbttech.com",
#"oak-vva60.lab.nbttech.com",
#"oak-vva64.lab.nbttech.com",
#"oak-vva65.lab.nbttech.com",
#"oak-vva66.lab.nbttech.com",
#"oak-vva67.lab.nbttech.com",
#"oak-vva68.lab.nbttech.com",
#"oak-vva69.lab.nbttech.com",
#"oak-vva70.lab.nbttech.com",
#"oak-vva71.lab.nbttech.com",
#"oak-vva72.lab.nbttech.com",
#"oak-vva73.lab.nbttech.com",
#"oak-vva75.lab.nbttech.com",
#"oak-vva76.lab.nbttech.com",
#"oak-vsh32.lab.nbttech.com",
#"oak-vva15.lab.nbttech.com",
#"oak-vva17.lab.nbttech.com",
#"oak-vva19.lab.nbttech.com",
#"oak-vva21.lab.nbttech.com",
#"oak-vva22.lab.nbttech.com",
#"oak-vva54.lab.nbttech.com",
#"oak-vva55.lab.nbttech.com",
#"oak-vva56.lab.nbttech.com",
#"oak-vva57.lab.nbttech.com",
#"oak-vva9.lab.nbttech.com",
#
#
#
#
"10.5.39.190",
"10.5.39.196",
"10.5.39.204",
"10.5.39.205",
"10.5.39.206",
"10.5.39.207",
"10.5.39.210",
"10.5.39.211",
"10.5.39.212",
"10.5.39.213",
"10.5.39.214",
"10.5.39.215",
"10.5.39.216",
"10.5.39.217",
"10.5.39.218",
"10.5.39.219",
"10.5.39.220",
"10.5.39.221",
"10.5.39.222",
"10.5.39.223",
"10.5.39.224",
"10.5.39.225",
"10.5.39.226",
"10.5.39.227",
"10.5.39.229",
"10.5.39.230",
"10.5.39.162",
"10.5.39.167",
"10.5.39.151",
"10.5.39.247",

#"10.5.19.151",
#"10.5.19.152",
#"10.5.19.159",
#"10.5.19.162",
#"10.5.19.163",
#"10.5.19.164",
#"10.5.19.170",
#"10.5.19.171",
#"10.5.19.174",
#"10.5.19.176",
#"10.5.19.182",
#"10.5.19.187",
#"10.5.19.197",
#"10.5.19.199",
#"10.5.19.203",
#"10.5.19.206",
#"10.5.19.207",
#"10.5.19.208",
#"10.5.19.210",
#"10.5.19.211",
#"10.5.19.212",
#"10.5.19.213",
#"10.5.19.215",
#"10.5.19.216",
#"10.5.19.218",
#"10.5.19.219",
#"10.5.19.220",
#"10.5.19.224",
#"10.5.19.231",
#"10.5.19.233",
#"10.5.19.244",
#"10.5.19.249",
#
#"10.5.25.153",
#"10.5.25.154",
#"10.5.25.190",
#"10.5.25.192",
#"10.5.25.193",
#"10.5.25.197",
#"10.5.25.198",
#"10.5.25.199",
#"10.5.25.200",
#"10.5.25.201",
#"10.5.25.202",
#"10.5.25.203",
#"10.5.25.204",
#"10.5.25.205",
#"10.5.25.206",
#"10.5.25.207",
#"10.5.25.208",
#"10.5.25.209",
#"10.5.25.214",
#"10.5.25.219",
#"10.5.25.225",
#"10.5.25.226",
#"10.5.25.227",
#"10.5.25.228",
#"10.5.25.229",
#"10.5.25.230",
#"10.5.25.232",
#"10.5.25.233",
#"10.5.25.234",
#"10.5.25.235",
#"10.5.25.236",
#"10.5.25.237",
#"10.5.25.238",
#


);



if(0)
{
@pri_ip=(
"10.5.19.151",
"10.5.19.152",
"10.5.19.159",
"10.5.19.162",
"10.5.19.163",
"10.5.19.164",
"10.5.19.170",
"10.5.19.171",
"10.5.19.174",
"10.5.19.176",
"10.5.19.182",
"10.5.19.187",
"10.5.19.197",
"10.5.19.199",
"10.5.19.203",
"10.5.19.206",
"10.5.19.207",
"10.5.19.208",
"10.5.19.210",
"10.5.19.211",
"10.5.19.212",
"10.5.19.213",
"10.5.19.215",
"10.5.19.216",
"10.5.19.218",
"10.5.19.219",
"10.5.19.220",
"10.5.19.224",
"10.5.19.231",
"10.5.19.233",
"10.5.19.244",
"10.5.19.249",

);


@pri_ip=(
"10.5.25.153",
"10.5.25.154",
"10.5.25.190",
"10.5.25.192",
"10.5.25.193",
"10.5.25.197",
"10.5.25.198",
"10.5.25.199",
"10.5.25.200",
"10.5.25.201",
"10.5.25.202",
"10.5.25.203",
"10.5.25.204",
"10.5.25.205",
"10.5.25.206",
"10.5.25.207",
"10.5.25.208",
"10.5.25.209",
"10.5.25.214",
"10.5.25.219",
"10.5.25.225",
"10.5.25.226",
"10.5.25.227",
"10.5.25.228",
"10.5.25.229",
"10.5.25.230",
"10.5.25.232",
"10.5.25.233",
"10.5.25.234",
"10.5.25.235",
"10.5.25.236",
"10.5.25.237",
"10.5.25.238",

);

}

#=cut

=b

%has=(
 "00:50:56:00:00:01"=> "VirtualEdge-A2",
 "00:50:56:00:00:02"=> "VirtualEdge-B2",
 "00:50:56:00:00:03"=> "VirtualEdge-C2",
 "00:50:56:00:00:04"=> "VirtualEdge-D2",
 "00:50:56:00:00:05"=> "VirtualEdge-E2",
 "00:50:56:00:00:06"=> "VirtualEdge-F2",
 "00:50:56:00:00:07"=> "VirtualEdge-G2",
 "00:50:56:00:00:08"=> "VirtualEdge-H2",
 "00:50:56:00:00:09"=> "VirtualEdge-I2",
 "00:50:56:00:00:0a"=> "VirtualEdge-J2",
 "00:50:56:00:00:0b"=> "VirtualEdge-K2",
 "00:50:56:00:00:0c"=> "VirtualEdge-L2",
 "00:50:56:00:00:0d"=> "VirtualEdge-M2",
 "00:50:56:00:00:0e"=> "VirtualEdge-N2",
 "00:50:56:00:00:0f"=> "VirtualEdge-O2",
 "00:50:56:00:00:10"=> "VirtualEdge-P2",
 "00:50:56:00:00:11"=> "VirtualEdge-Q2",
 "00:50:56:00:00:12"=> "VirtualEdge-R2",
 "00:50:56:00:00:13"=> "VirtualEdge-S2",
 "00:50:56:00:00:14"=> "VirtualEdge-T2",
 "00:50:56:00:00:15"=> "VirtualEdge-U2",
 "00:50:56:00:00:16"=> "VirtualEdge-V2",
 "00:50:56:00:00:17"=> "VirtualEdge-W2",
 "00:50:56:00:00:18"=> "VirtualEdge-X2",
 "00:50:56:00:00:19"=> "VirtualEdge-Y2",
 "00:50:56:00:00:1a"=> "VirtualEdge-Z2",

 "00:50:56:00:00:1b"=> "VirtualEdge-ZA2",
 "00:50:56:00:00:1c"=> "VirtualEdge-ZB2",
 "00:50:56:00:00:1d"=> "VirtualEdge-ZC2",
 "00:50:56:00:00:1e"=> "VirtualEdge-ZD2",
);

=cut

%has=(
 "00:50:56:00:01:01"=> "VirtualEdge-A1",
 "00:50:56:00:01:02"=> "VirtualEdge-B1",
 "00:50:56:00:01:03"=> "VirtualEdge-C1",
 "00:50:56:00:01:04"=> "VirtualEdge-D1",
 "00:50:56:00:01:05"=> "VirtualEdge-E1",
 "00:50:56:00:01:06"=> "VirtualEdge-F1",
 "00:50:56:00:01:07"=> "VirtualEdge-G1",
 "00:50:56:00:01:08"=> "VirtualEdge-H1",
 "00:50:56:00:01:09"=> "VirtualEdge-I1",
 "00:50:56:00:01:0a"=> "VirtualEdge-J1",
 "00:50:56:00:01:0b"=> "VirtualEdge-K1",
 "00:50:56:00:01:0c"=> "VirtualEdge-L1",
 "00:50:56:00:01:0d"=> "VirtualEdge-M1",
 "00:50:56:00:01:0e"=> "VirtualEdge-N1",
 "00:50:56:00:01:0f"=> "VirtualEdge-O1",
 "00:50:56:00:01:10"=> "VirtualEdge-P1",
 "00:50:56:00:01:11"=> "VirtualEdge-Q1",
 "00:50:56:00:01:12"=> "VirtualEdge-R1",
 "00:50:56:00:01:13"=> "VirtualEdge-S1",
 "00:50:56:00:01:14"=> "VirtualEdge-T1",
 "00:50:56:00:01:15"=> "VirtualEdge-U1",
 "00:50:56:00:01:16"=> "VirtualEdge-V1",
 "00:50:56:00:01:17"=> "VirtualEdge-W1",
 "00:50:56:00:01:18"=> "VirtualEdge-X1",
 "00:50:56:00:01:19"=> "VirtualEdge-Y1",
 "00:50:56:00:01:1a"=> "VirtualEdge-Z1",
 "00:50:56:00:01:1b"=> "VirtualEdge-ZA1",
 "00:50:56:00:01:1c"=> "VirtualEdge-ZB1",
 "00:50:56:00:01:1d"=> "VirtualEdge-ZC1",
 "00:50:56:00:01:1e"=> "VirtualEdge-ZD1",
 "00:50:56:00:01:1f"=> "VirtualEdge-ZE1",

);


%has=(

 "00:50:56:00:02:01"=> "VirtualEdge-A3",
 "00:50:56:00:02:02"=> "VirtualEdge-B3",
 "00:50:56:00:02:03"=> "VirtualEdge-C3",
 "00:50:56:00:02:04"=> "VirtualEdge-D3",
 "00:50:56:00:02:05"=> "VirtualEdge-E3",
 "00:50:56:00:02:06"=> "VirtualEdge-F3",
 "00:50:56:00:02:07"=> "VirtualEdge-G3",
 "00:50:56:00:02:08"=> "VirtualEdge-H3",
 "00:50:56:00:02:09"=> "VirtualEdge-I3",
 "00:50:56:00:02:0a"=> "VirtualEdge-J3",
 "00:50:56:00:02:0b"=> "VirtualEdge-K3",
 "00:50:56:00:02:0c"=> "VirtualEdge-L3",
 "00:50:56:00:02:0d"=> "VirtualEdge-M3",
 "00:50:56:00:02:0e"=> "VirtualEdge-N3",
 "00:50:56:00:02:0f"=> "VirtualEdge-O3",
 "00:50:56:00:02:10"=> "VirtualEdge-P3",
 "00:50:56:00:02:11"=> "VirtualEdge-Q3",
 "00:50:56:00:02:12"=> "VirtualEdge-R3",
 "00:50:56:00:02:13"=> "VirtualEdge-S3",
 "00:50:56:00:02:14"=> "VirtualEdge-T3",
 "00:50:56:00:02:15"=> "VirtualEdge-U3",
 "00:50:56:00:02:16"=> "VirtualEdge-V3",
 "00:50:56:00:02:17"=> "VirtualEdge-W3",
 "00:50:56:00:02:18"=> "VirtualEdge-X3",
 "00:50:56:00:02:19"=> "VirtualEdge-Y3",
 "00:50:56:00:02:1a"=> "VirtualEdge-Z3",
 "00:50:56:00:02:1b"=> "VirtualEdge-ZA3",
 "00:50:56:00:02:1c"=> "VirtualEdge-ZB3",
 "00:50:56:00:02:1d"=> "VirtualEdge-ZC3",
 "00:50:56:00:02:1e"=> "VirtualEdge-ZD3",
 "00:50:56:00:02:1f"=> "VirtualEdge-ZE3",
 "00:50:56:00:02:20"=> "VirtualEdge-ZF3",
 "00:50:56:00:02:21"=> "VirtualEdge-ZG3",


);


#=cut


#=cut


foreach $each_ip(@pri_ip)
{
	my $exp;
	$exp = new Expect;
	$exp->raw_pty(1);  


#	$exp->log_stdout(0);
#	$exp->exp_internal(1);
#	$exp->debug(3);

	$command="ssh";
	@parameters=();

#=b
            my @parameters = qw[ -oStrictHostKeyChecking=no
                                  -oCheckHostIP=no
                                  -oForwardX11=no
                                  -oUserKnownHostsFile=/dev/null
                                  -oConnectTimeout=10
                                  -oServerAliveInterval=300
                                  -oForwardAgent=no ];
#=cut

	push @parameters,"admin\@$each_ip";


	$ret= $exp->spawn($command, @parameters) or die "Cannot spawn $command: $!\n";
	$exp->expect(4,
             [qr/.*password/ => sub { $exp->send("password\n"); } ],
           #  [qr/.*password/ => sub { $exp->send("password\n");exp_continue; } ],

#            [qr/yes\/no/ => sub { $exp->send("yes\n");exp_continue_timeout; } ],
			 [qr/^.*\s*>/ => sub { $exp->send("terminal length 0\n"); }]
    );
#	$exp->expect(4,[qr/^.*\s*>/ => sub { $exp->send("terminal length 0\n"); }]);
	$exp->expect(4,[qr/^.*\s*>/ => sub { $exp->send("en\n"); }]);
	$exp->expect(4, [qr/^.*\s*#/ => sub { $exp->send("con t\n"); }],);

if(0)
{
#	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("username admin nopassword\n"); }],);
#	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("interface aux dhcp\n"); }],);
	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("show interface primary br\n"); }],);
#	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("show interface aux br\n"); }],);
	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
	$tmp= $exp->before();
	if($tmp=~ /HW address:\s*(\S+)/)
	{
		my $t1= lc $1;
#		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("hostname $has{$t1}\n"); }],);

        if(0)
        {

		if($t1=~ /(\S+):(\S+):(\S+):(\S+):(\S+):(\S+)/)
		{

	$str= <<END;
http://apexzero.nbttech.com/license/license.cgi?m_reason=For+Pradeep&m_security=Xtop90!&m_macaddr=00%3A$2%3A$3%3A$4%3A$5%3A$6&m_tiedinfo=&m_serial=
END
		}
		chomp $str;
		print "$str\n";
		$cmd= "wget \'$str\' -O licx";
		$out= `$cmd`;
		print "$out\n";

		$apply_lic= `grep -e GRANITE- -e PROFSRV- -e VLAB- licx`;
		
		@arry_lic= split /\n/,$apply_lic;
		foreach my $lice(@arry_lic)
		{
			$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("license install $lice\n"); }],);
		}

        }

		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("write mem\n"); }],);
		

	}
	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);

}

	push @Connection_pool,$exp;
}
#	push @Connection_pool,$exp->spawn($command, @parameters) or die "Cannot spawn $command: $!\n";
	
#	print "Ret  $ret ------\n";


while(1)
{

	print "\n\nselect options below\n";
	print "\t\t1. Enter the command to execute on all Edges\n";
	print "\t\t2. Exit\n";
	print "\t\t3. Remove cores from edges\n";
	print "\t\t4. Add cores to edges\n";
	print "\t\t5. Restart edge process\n";
	print "\t\t6. Reboot VMs\n";
	print "\t\t7. Take snapshots\n";
	print "\t\t8. remove snapshots\n";

	$user_input=<>;
	chomp $user_input;
	my $command;

	if($user_input eq 1)
	{
		print "\n Enter the edge command to execute ...\n";				
		my $inf=<>;
		chomp $inf;
		$command= $inf;
		exec_this_cmd($command);
	}
	if($user_input eq 2)
	{
		goto end;
	}
	if($user_input eq 3)
	{
		remove_edges();
	}
	if($user_input eq 4)
	{
		add_edges();
	}
	if($user_input eq 5)
	{
		restart_edges();
	}
	if($user_input eq 6)
	{
		reboot_vm();
	}
	if($user_input eq 7)
	{
		take_snaps();
	}
	if($user_input eq 8)
	{
		remove_snaps();
	}
	if($user_input eq 10)
	{
		$i=10;
		while($i>0)
		{
			remove_edges();
			sleep 50;
			add_edges();
			$i--;
		}
	}

=b
	foreach my $conn(@Connection_pool)
	{
	
		my $exp= $conn;
		my $cmd= $command;
	
	#	flock(MYFILE,2);
	
#		$exp->expect(4, [qr/^.*\s*#/ => sub { $exp->send("con t\n"); }],);
		$ret= $exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("show host\n");}],);
	
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
		$tmp= $exp->before();
		if($tmp=~ /Hostname\s*:\s*(\S+)/)
		{
			$hname=$1;
			chomp $hname;
		}
		$cmd=~ s/h_name/$hname/;
		
#		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("storage core remove host 10.5.146.160 force\n"); }],);
		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("$cmd\n"); }],);
	#	$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("storage core add host 10.5.146.160 edge-id $hname local-interface aux\n"); }],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
#		sleep 1;
	
	#	$exp->clear_accum();
	
	#	flock(MYFILE,8);
	
	
	}
=cut


}

sub exec_this_cmd
{
	my $cmd= shift;

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("$cmd\n");}],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
	}
}


sub take_snaps
{

	print "\t\twhat to do with specific serial pattern? Enter part of serial else none\n";
	my $ser_patt=<>;
	chomp $ser_patt;

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		exec_on_a_edge(conn=>$exp,cmd=>"show storage iscsi luns");	
		my $tmp= $exp->before();
		my @arry= grep (/Assigned\s*Serial/,split /\n/,$tmp);
		foreach my $e(@arry)
		{
			if($e=~ /Locally Assigned Serial:\s*(\S+)/)
			{
				my $lun_ser=$1;
				if($lun_ser=~ /$ser_patt/)
				{
					exec_on_a_edge(conn=>$exp,cmd=>"storage lun serial $lun_ser snapshot create");	
#					exec_this_cmd("storage lun serial $lun_ser snapshot create");
				}
			}	
		}
	}

}

sub exec_on_a_edge
{
	my %input= @_;
	my $exp= $input{conn};
	my $cmd= $input{cmd};

	$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("$cmd\n");}],);
	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
}


sub remove_snaps
{

	print "\t\twhat to do with specific serial pattern? Enter part of serial else none\n";
	my $ser_patt=<>;
	chomp $ser_patt;

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;

		exec_on_a_edge(conn=>$exp,cmd=>"show storage iscsi luns");	
		my $tmp= $exp->before();
		my @arry= grep (/Assigned\s*Serial/,split /\n/,$tmp);
		foreach my $e(@arry)
		{
			if($e=~ /Locally Assigned Serial:\s*(\S+)/)
			{
				my $lun_ser=$1;
				if($ser_patt!~ /null/i)
				{
					next if($lun_ser!~ /$ser_patt/);
				}

				exec_on_a_edge(conn=>$exp,cmd=>"show storage lun serial $lun_ser snapshot all");	
				my $tmp= $exp->before();
				my @arry1= grep (/Snapshot ID/,split /\n/,$tmp);

				foreach my $e1(@arry1)
				{
					if($e1=~ /Snapshot ID:\s*(\S+)/)
					{
						my $snap_id= $1;
						exec_on_a_edge(conn=>$exp,cmd=>"storage lun serial $lun_ser snapshot remove id $snap_id\n");	
					}
				}

			}	
		}
	}

}



sub add_edges
{
	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("show host\n");}],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
		$tmp= $exp->before();
		if($tmp=~ /Hostname\s*:\s*(\S+)/)
		{
			$hname=$1;
			chomp $hname;
		}

		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("storage core add host 10.5.146.160 edge-id $hname local-interface aux\n"); }],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
	}

}


sub remove_edges
{


	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;


		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("storage core remove host 10.5.146.160 force\n"); }],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
	}
}

sub reboot_vm
{
	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("reload\n"); }],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
	}
	exit;
}

sub restart_edges
{

	print "\t\tClean restart (y/n)?\n";

	my $user_input=<>;
	chomp $user_input;
	my $command;
	$command="service storage restart";
	$command= $command." clean" if($user_input=~ /y/i);
	
	

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("$command\n"); }],);
		$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
	}
}



end:	

foreach my $conn(@Connection_pool)
{
#	flock(MYFILE,2);
	my $exp= $conn;

#	$exp->exp_internal(1);
#	$exp->debug(3);

#	$conn->raw_pty(1);  
#	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("show info\n"); }],);
#	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("show version\n"); }],);
	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("exit\n"); }],);
	$exp->expect(4, [qr/^.*\s*#/ => sub { $exp->send("exit\n"); }],);
	$exp->soft_close();
#	flock(MYFILE,8);
}

exit;

