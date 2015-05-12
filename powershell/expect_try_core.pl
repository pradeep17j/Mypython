
use Expect;

$interactive= $ARGV[0];

@Connection_pool=();


@pri_ip=(
"oak-sh717.lab.nbttech.com",
);


@all_edges=(
"oak-vsh32",
"oak-vva15",
"oak-vva17",
"oak-vva19",
"oak-vva21",
"oak-vva22",
"oak-vva54",
"oak-vva55",
"oak-vva55",
"oak-vva56",
"oak-vva57",
"oak-vva58",
"oak-vva59",
"oak-vva60",
"oak-vva60",
"oak-vva64",
"oak-vva65",
"oak-vva66",
"oak-vva67",
"oak-vva68",
"oak-vva69",
"oak-vva70",
"oak-vva71",
"oak-vva72",
"oak-vva73",
"oak-vva75",
"oak-vva76",
"oak-vva9",
"VirtualEdge-A2",
"VirtualEdge-B2",
"VirtualEdge-C2",
"VirtualEdge-D2",
"VirtualEdge-E2",
"VirtualEdge-F2",
"VirtualEdge-G2",
"VirtualEdge-H2",
"VirtualEdge-I2",
"VirtualEdge-J2",
"VirtualEdge-K2",
"VirtualEdge-L2",
"VirtualEdge-M2",
"VirtualEdge-N2",
"VirtualEdge-O2",
"VirtualEdge-P2",
"VirtualEdge-Q2",
"VirtualEdge-R2",
"VirtualEdge-S2",
"VirtualEdge-T2",
"VirtualEdge-U2",
"VirtualEdge-V2",
"VirtualEdge-W2",
"VirtualEdge-X2",
"VirtualEdge-Y2",
"VirtualEdge-Z2",
"VirtualEdge-ZA2",
"VirtualEdge-ZB2",
"VirtualEdge-ZC2",
"VirtualEdge-ZD2",

"VirtualEdge-A3",
"VirtualEdge-B3",
"VirtualEdge-C3",
"VirtualEdge-D3",
"VirtualEdge-E3",
"VirtualEdge-F3",
"VirtualEdge-G3",
"VirtualEdge-H3",
"VirtualEdge-I3",
"VirtualEdge-J3",
"VirtualEdge-K3",
"VirtualEdge-L3",
"VirtualEdge-M3",
"VirtualEdge-N3",
"VirtualEdge-O3",
"VirtualEdge-P3",
"VirtualEdge-Q3",
"VirtualEdge-R3",
"VirtualEdge-S3",
"VirtualEdge-T3",
"VirtualEdge-U3",
"VirtualEdge-V3",
"VirtualEdge-W3",
"VirtualEdge-X3",
"VirtualEdge-Y3",
"VirtualEdge-Z3",
"VirtualEdge-ZA3",
"VirtualEdge-ZB3",
"VirtualEdge-ZC3",
"VirtualEdge-ZD3",
"VirtualEdge-ZE3",
"VirtualEdge-ZF3",
"VirtualEdge-ZG3",

"VirtualEdge-A1",
"VirtualEdge-B1",
"VirtualEdge-C1",
"VirtualEdge-D1",
"VirtualEdge-E1",
"VirtualEdge-F1",
"VirtualEdge-G1",
"VirtualEdge-H1",
"VirtualEdge-I1",
"VirtualEdge-J1",
"VirtualEdge-K1",
"VirtualEdge-L1",
"VirtualEdge-M1",
"VirtualEdge-N1",
"VirtualEdge-O1",
"VirtualEdge-P1",
"VirtualEdge-Q1",
"VirtualEdge-R1",
"VirtualEdge-S1",
"VirtualEdge-T1",
"VirtualEdge-U1",
"VirtualEdge-V1",
"VirtualEdge-W1",
"VirtualEdge-X1",
"VirtualEdge-Y1",
"VirtualEdge-Z1",
"VirtualEdge-ZA1",
"VirtualEdge-ZB1",
"VirtualEdge-ZC1",
"VirtualEdge-ZD1",
"VirtualEdge-ZE1",


);


@all_lun_ids=();
@all_edge_ids=();

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
	$exp->expect(6,
             [qr/.*password/ => sub { $exp->send("password\n");exp_continue; } ],

  #          [qr/yes\/no/ => sub { $exp->send("yes\n");exp_continue_timeout; } ],
			,[qr/^.*\s*>/ => sub { $exp->send("terminal length 0\n"); }],
    );
#	$exp->expect(4,[qr/^.*\s*>/ => sub { $exp->send("terminal length 0\n"); }]);
	$exp->expect(4,[qr/^.*\s*>/ => sub { $exp->send("en\n"); }]);
	$exp->expect(4, [qr/^.*\s*#/ => sub { $exp->send("con t\n"); }],);
	$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);

	push @Connection_pool,$exp;
}
#	push @Connection_pool,$exp->spawn($command, @parameters) or die "Cannot spawn $command: $!\n";
	
#	print "Ret  $ret ------\n";


while(1)
{

	print "\n\nselect options below\n";
	print "\t\t10. Enter the command to execute on core\n";
	print "\t\t20. Exit\n";
	print "\t\t30. Remove all edges from core\n";
	print "\t\t31. Add all edges to core\n";
	print "\t\t40. offline all luns\n";
	print "\t\t50. online all luns\n";
	print "\t\t60. remove all luns\n";
	print "\t\t61. pin all luns\n";
	print "\t\t62. unpin all luns\n";
	print "\t\t63. prepop all luns\n";
	print "\t\t64. unmap all luns\n";
	print "\t\t65. map initiator all luns\n";
	print "\t\t66. unmap initiator all luns\n";
	print "\t\t70. add luns\n";
	print "\t\t71. Execute this command on all the luns\n";
	print "\t\t80. map luns and edges\n";
	print "\t\t90. Restart DC process\n";
	print "\t\t100. Reboot box\n";


	print "\n\nEnter your selection .... ";
	my @user_input_arry=();
	my $user_in=<>;
	$user_in=~ s/\s+//g;
	chomp $user_in;
	my $loop=0;
	while($loop)
	{
		$user_in= $user_in.$user_in;
		$loop--;
	}
	print $user_in;
	
	if($user_in=~ /,/)
	{
		@user_input_arry= split /,/,$user_in;
	}
	else
	{
		push @user_input_arry,$user_in;	
	}
	my $command;


	foreach my $user_input (@user_input_arry)
	{

		if($user_input eq 10)
		{
			print "\n Enter the edge command to execute ...\n";				
			my $inf=<>;
			chomp $inf;
			$command= $inf;
			exec_this_cmd("$command\n");
		}
		if($user_input eq 20)
		{
			goto end;
		}
		if($user_input eq 30)
		{
			remove_edges();
		}
		if($user_input eq 31)
		{
			add_edges();
		}
		if($user_input eq 40)
		{
			luns_operations(oper=>"offline");
		}
		if($user_input eq 50)
		{
			luns_operations(oper=>"online");
		}
		if($user_input eq 60)
		{
			luns_operations(oper=>"remove");
		}
		if($user_input eq 61)
		{
			luns_operations(oper=>"pin");
		}
		if($user_input eq 62)
		{
			luns_operations(oper=>"unpin");
		}
		if($user_input eq 63)
		{
			luns_operations(oper=>"prepop");
		}

		if($user_input eq 64)
		{
			luns_operations(oper=>"unmap");
		}
		if($user_input eq 65)
		{
			luns_operations(oper=>"map-initiator");
		}

		if($user_input eq 66)
		{
			luns_operations(oper=>"unmap-initiator");
		}


		if($user_input eq 70)
		{
			luns_operations(oper=>"add");
		}
		if($user_input eq 71)
		{
			luns_operations(oper=>"generic");
		}
		if($user_input eq 80)
		{
			map_lun_edges();	
		}
	

	}


}


sub exec_this_cmd
{
	my $cmd= shift;

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("$cmd");}],);
		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("\n");}],);
		my $tmp= $exp->before();
		print "$tmp\n";
	}
}


sub get_lun_id
{
	my %input= @_;
	my $type= $input{type};
	@all_lun_ids=();

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		exec_this_cmd("show storage luns discovered iscsi\n");
#		exec_this_cmd("\n");
		$tmp= $exp->before();
		@out_arry= split /\n/,$tmp;
		foreach my $line(@out_arry)
		{
			if($line=~ /$type/i)
			{
				if($line=~ /^\s*(\S+)/)
				{
					push @all_lun_ids,$1;
				}
			}
		}
	}
	return @all_lun_ids;
}

sub get_edge_id
{
	my %input= @_;
	my $type= $input{type};
	@all_lun_ids=();

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		exec_this_cmd("show edge\n");
		exec_this_cmd("\n");
		$tmp= $exp->before();
		@out_arry= split /\n/,$tmp;
		foreach my $line(@out_arry)
		{
			if($line=~ /Granite-Edge Id:\s*(\S+)/)
			{
				push @all_edge_ids,$1;
			}
		}
	}
	return @all_edge_ids;
}



sub luns_operations
{
	my %input= @_;
	my $oper= $input{oper};


		if($oper=~ /offline/i)
		{
			my @all_ids= get_lun_id(type=>"configured|available");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun modify serial $id offline\n");
			}
		}
		if($oper=~ /online/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun modify serial $id online\n");
			}
		}
		if($oper=~ /remove/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun remove serial $id \n");
			}
		}
		if($oper=~ /\bpin/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun modify serial $id pinned enable \n ");
			}
		}
		if($oper=~ /unpin/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun modify serial $id pinned disable \n ");
			}
		}
		if($oper=~ /prepop/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun modify serial $id prepop enable \n");
			}
		}
		if($oper=~ /unmap/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun modify serial $id unmap\n");
			}
		}
		if($oper=~ /map-initiator/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
#				exec_this_cmd("storage lun modify serial $id auth-initiator add iqn.1991-05.com.microsoft:oak-cs226 \n");
				exec_this_cmd("storage iscsi lun-serial $id auth-initiator add iqn.1991-05.com.microsoft:oak-cs226 \n");
			}
		}
		if($oper=~ /unmap-initiator/i)
		{
			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun modify serial $id auth-initiator remove iqn.1991-05.com.microsoft:oak-cs226 \n");
			}
		}




		if($oper=~ /add/i)
		{
			print "\t\tEnter lun index number\n";
			my $index;
			if($interactive)
			{
				$index=<>;
				chomp $index;
			}
			else
			{
				$index=1;
			}

			my @all_ids= get_lun_id(type=>"available");
			foreach my $id(@all_ids)
			{
				$index= $index."_Lun";

				exec_this_cmd("storage lun add iscsi serial $id alias $index \n");
				$index++;
			}
		}
		if($oper=~ /generic/i)
		{
			print "\t\t Example commands...\n";
			print "storage lun modify serial _serial auth-initiator add iqn.1991-05.com.microsoft:oak-cs226 \n";
			print "storage lun modify serial _serial auth-initiator remove iqn.1991-05.com.microsoft:oak-cs226 \n";
			print "storage lun modify serial _serial pinned enable \n";
			print "storage lun modify serial _serial prepop disable \n";
			print "storage lun modify serial _serial prepop smart disable \n";
			print "storage lun modify serial _serial unmap\n";
			print "storage iscsi lun modify lun-serial _serial snapshot-config host oak-netapp2.lab.nbttech.com\n";
			print "storage lun modify serial _serial snapshot-config host oak-netapp2.lab.nbttech.com\n";
			print "show storage lun serial _serial snapshot all\n";
			print "\n\n\n";

			print "\t\tEnter the command to execute\n";
			my $cmd=<>;
			chomp $cmd;

			print "\t\twhat to do with specific serial pattern? Enter part of serial else none\n";

			my $ser_patt=<>;
			chomp $ser_patt;

			my @all_ids= get_lun_id(type=>"configured");
			foreach my $id(@all_ids)
			{
				my $tmp_cmd= $cmd;
				if($ser_patt!~ /none/i)
				{
					if($id!~ /$ser_patt/)
					{
						next;
					}	
				}
				$tmp_cmd=~ s/_serial/$id/;

				exec_this_cmd("$tmp_cmd\n");
			}
		}


}

sub map_lun_edges
{

	my %input= @_;
	my $oper= $input{oper};

	my @all_ids= get_lun_id(type=>"configured");
	my @edges= get_edge_id();

	foreach my $eid (@edges)
	{
		my $lunid= shift @all_ids;
		exec_this_cmd("storage lun modify serial $lunid map edge-id $eid\n");
		push @edges,$eid;
		last if(!@all_ids);
	}	
	

}



sub remove_edges
{


	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;


		$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("show edge\n"); }],);
		my $tmp= $exp->before();
		my @arry= grep (/Granite-Edge Id:/,(split /\n/,$tmp));
		foreach my $each (@arry)
		{
			if($each=~ /Granite-Edge Id:\s*(\S+)/)
			{
				$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("edge remove id $1\n"); }],);
				$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
			}
		}
	}
}

sub add_edges
{


	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;

		foreach my $each (@all_edges)
		{
			exec_this_cmd("edge add id $each\n");
			exec_this_cmd("edge id $each iscsi initiator add iqn.1991-05.com.microsoft:oak-cs226 auth None\n");
			exec_this_cmd("\n");

#			$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("edge add id $each\n"); }],);
#			$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("edge id $each iscsi initiator add iqn.1991-05.com.microsoft:oak-cs226 auth None \n"); }],);
#			$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
		}
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
		goto end;
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

