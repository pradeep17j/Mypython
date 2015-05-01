
use Expect;

$interactive= $ARGV[0];

@Connection_pool=();


@pri_ip=(
#"oak-sh717.lab.nbttech.com",
#"oak-sh287.lab.nbttech.com",
"oak-sh809.lab.nbttech.com",
);


@all_edges=(
"VirtualEdge-1",
"VirtualEdge-2",
"VirtualEdge-3",
"VirtualEdge-4",
"VirtualEdge-5",
"VirtualEdge-6",
"VirtualEdge-7",
"VirtualEdge-8",
"VirtualEdge-9",
"VirtualEdge-10",
"VirtualEdge-11",
"VirtualEdge-12",
"VirtualEdge-13",
"VirtualEdge-14",
"VirtualEdge-15",
"VirtualEdge-16",
"VirtualEdge-17",
"VirtualEdge-18",
"VirtualEdge-19",
"VirtualEdge-20",
"VirtualEdge-21",
"VirtualEdge-22",
"VirtualEdge-23",
"VirtualEdge-24",
"VirtualEdge-25",
"VirtualEdge-26",
"VirtualEdge-27",
"VirtualEdge-28",
"VirtualEdge-29",
"VirtualEdge-30",
"VirtualEdge-31",
"VirtualEdge-32",
"VirtualEdge-33",
"VirtualEdge-34",
"VirtualEdge-35",
"VirtualEdge-36",
"VirtualEdge-37",
"VirtualEdge-38",
"VirtualEdge-39",
"VirtualEdge-40",
"VirtualEdge-41",
"VirtualEdge-42",
"VirtualEdge-43",
"VirtualEdge-44",
"VirtualEdge-45",
"VirtualEdge-46",
"VirtualEdge-47",
"VirtualEdge-48",
"VirtualEdge-49",
"VirtualEdge-50",
"VirtualEdge-51",
"VirtualEdge-52",
"VirtualEdge-53",
"VirtualEdge-54",
"VirtualEdge-55",
"VirtualEdge-56",
"VirtualEdge-57",
"VirtualEdge-58",
"VirtualEdge-59",
"VirtualEdge-60",
"VirtualEdge-61",
"VirtualEdge-62",
"VirtualEdge-63",
"VirtualEdge-64",
"VirtualEdge-65",
"VirtualEdge-66",
"VirtualEdge-67",
"VirtualEdge-68",
"VirtualEdge-69",
"VirtualEdge-70",
"VirtualEdge-71",
"VirtualEdge-72",
"VirtualEdge-73",
"VirtualEdge-74",
"VirtualEdge-75",
"VirtualEdge-76",
"VirtualEdge-77",
"VirtualEdge-78",
"VirtualEdge-79",
"VirtualEdge-80",
"VirtualEdge-81",
"VirtualEdge-82",
"VirtualEdge-83",
"VirtualEdge-84",
"VirtualEdge-85",
"VirtualEdge-86",
"VirtualEdge-87",
"VirtualEdge-88",
"VirtualEdge-89",
"VirtualEdge-90",
"VirtualEdge-91",
"VirtualEdge-92",
"VirtualEdge-93",
"VirtualEdge-94",
"VirtualEdge-95",
"VirtualEdge-96",
"VirtualEdge-97",
"VirtualEdge-98",
"VirtualEdge-99",
"VirtualEdge-100",
"VirtualEdge-101",
"VirtualEdge-102",
"VirtualEdge-103",
"VirtualEdge-104",
"VirtualEdge-105",
"VirtualEdge-106",
"VirtualEdge-107",
"VirtualEdge-108",
"VirtualEdge-109",
"VirtualEdge-110",
"VirtualEdge-111",
"VirtualEdge-112",
"VirtualEdge-113",
"VirtualEdge-114",
"VirtualEdge-115",
"VirtualEdge-116",
"VirtualEdge-117",
"VirtualEdge-118",
"VirtualEdge-119",
"VirtualEdge-120",
"VirtualEdge-121",
"VirtualEdge-122",
"VirtualEdge-123",
"VirtualEdge-124",
"VirtualEdge-125",
"VirtualEdge-126",
"VirtualEdge-127",
"VirtualEdge-128",
"VirtualEdge-129",
"VirtualEdge-130",
"VirtualEdge-131",
"VirtualEdge-132",
"VirtualEdge-133",
"VirtualEdge-134",
"VirtualEdge-135",
"VirtualEdge-136",
"VirtualEdge-137",
"VirtualEdge-138",
"VirtualEdge-139",
"VirtualEdge-140",
"VirtualEdge-141",
"VirtualEdge-142",
"VirtualEdge-143",
"VirtualEdge-144",
"VirtualEdge-145",
"VirtualEdge-146",
"VirtualEdge-147",
"VirtualEdge-148",
"VirtualEdge-149",
"VirtualEdge-150",
);


@all_edges=(
'oak-sh815',
);

# Sum total of edges

# Edges only for oak-sh717

#@all_edges=$edge_id_hash{$pri_ip[0]};

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

my @repeat;

while(1)
{

	print "\n\nselect options below\n";
	print "\t\t10. Enter the command to execute on core\n";
	print "\t\t20. Exit\n";
	print "\t\t30. Remove all edges from core\n";
	print "\t\t31. Add all edges to core\n";
	print "\t\t32. Remove specifiC edges from core\n";
	print "\t\t33. Add specific edges to core\n";
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
	print "\t\t91. Repeat prev cmd\n";
	print "\t\t100. Reboot box\n";


	print "\n\nEnter your selection .... ";
	my @user_input_arry=();
	my $user_in=<>;

	print "$user_in  --------------\n";

	$user_in=~ s/\s+//g;
	chomp $user_in;

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
		if($user_input eq 32)
		{
			remove_edges_specific();
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

	if($interactive)
	{
		print " pls provide the edge id \n";
		my $edge_id=<>;
		chomp $edge_id;
		push @all_edge_ids,$edge_id;
$DB::single=1;
		return @all_edge_ids;
	}

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;
		exec_this_cmd("show edge\n");
#		exec_this_cmd("\n");
		$tmp= $exp->before();

		@edge_list= split /Granite-Edge/,$tmp;

		foreach my $each_edge(@edge_list)
		{
			if($each_edge=~ /Address\s*:\s*Unknown/)
			{
	#			next;
			}

			@out_arry= split /\n/,$each_edge;
			foreach my $line(@out_arry)
			{
				if($line=~ / Id:\s*(\S+)/)
				{
					push @all_edge_ids,$1;
				}
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
			my @all_ids= get_lun_id(type=>"configured|available");
			foreach my $id(@all_ids)
			{
				exec_this_cmd("storage lun remove serial $id force\n");
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
			my $add_count;
			print "\t\tHow many luns do you want to add , Enter all if all to be added\n";
			$add_count=<>;
			chomp $add_count;


			print "\t\tEnter lun index number\n";
			my $index;
			if($interactive)
			{
				$index=<>;
				chomp $index;
			}
			else
			{
				$index=100;
			}
			print "\t\twhat to do with specific serial pattern? Enter part of serial else none\n";

			my $ser_patt=<>;
			chomp $ser_patt;


			my @all_ids= get_lun_id(type=>"available");
			foreach my $id(@all_ids)
			{
#				$index= $index."55";
				$index= $index;

				if($ser_patt!~ /none/i)
				{
					if($id!~ /$ser_patt/)
					{
						next;
					}	
				}


				exec_this_cmd("storage lun add iscsi serial $id alias $index \n");
				$index++;
				if($add_count!~ /all/)
				{
					last if(!$add_count);
					$add_count--;
				}
			}
		}
		if($oper=~ /generic/i)
		{
			print "\t\t Example commands...\n";
			print "storage lun modify serial _serial auth-initiator add iqn.1991-05.com.microsoft:oak-cs226 \n";
			print "storage lun modify serial _serial auth-initiator remove iqn.1991-05.com.microsoft:oak-cs226 \n";
			print "storage lun modify serial _serial pinned enable \n";
			print "storage lun modify serial _serial prepop disable \n";
			print "storage lun modify serial _serial prepop start-now \n";
			print "storage lun modify serial _serial prepop smart disable \n";
			print "storage lun modify serial _serial unmap\n";
			print "storage lun modify serial _serial snapshot-config host oak-netapp2.lab.nbttech.com\n";
			print "show storage lun serial _serial snapshot all\n";
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

sub remove_edges_specific
{


	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;

		foreach my $each (@all_edges)
		{
			$exp->expect(14, [qr/^.*config\)\s*#/ => sub { $exp->send("edge remove id $each\n"); }],);
			$exp->expect(4, [qr/^.*config\)\s*#/ => sub { $exp->send("\n"); }],);
		}
	}
}


sub add_edges
{

	print "\t\tHow many edges do you want to add , Enter all if all to be added\n";
	my $add_count=<>;
	chomp $add_count;

	foreach my $conn(@Connection_pool)
	{
		my $exp= $conn;

		foreach my $each (@all_edges)
		{
			exec_this_cmd("edge add id $each\n");
			exec_this_cmd("edge id $each iscsi initiator add iqn.1991-05.com.microsoft:oak-cs226 auth None\n");
			exec_this_cmd("edge id $each iscsi initiator add iqn.1994-05.com.redhat:84c711a44090 auth None\n");
			exec_this_cmd("\n");

			if($add_count!~ /all/)
			{
				last if(!$add_count);
				$add_count--;
			}

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

