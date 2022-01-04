#! /usr/bin/perl

#This script is FlankingRegions.pl

#Author: Andrés Blanco Hortas (andres.blanco.hortas@usc.es)

##########################################################################################

use strict;
use warnings;
use Getopt::Long;


my ($data,$list,$out,$line,$name,$seq,$help,$size);
my @a;
my %chrom;

###### Get options #######
GetOptions(	"positions|p=s"  	=> \$list,
			"genome|g=s" 		=> \$data,
			"out|o=s"  		=> \$out,
			"size|s=s"	=> \$size,
			"help|h"   		=> \$help,) or die "Try 'perl FlankingRegions.pl --help' for more information.\n";
##########################

###### Check options #######
if($help){
	print "Instructions for use: perl FlankingRegions.pl [OPTIONS]...\n";
	print "Script to extract adjacent sequences to a target position.\n";
	print "\n";
	print "Options:\n";
	print "\t-p, --positions\t\tPath to the text file with the list of positions to be extracted. Format: Chrom.<tab>pos.\n";
	print "\t-g, --genome\t\tPath to the file with the genome sequences.\n";
	print "\t-o, --out\t\tPath to the output file.\n";
	print "\t-s, --size\t\tSize of the sequences on either side of the position.\n";
	print "\t-h, --help\t\tShow this help and abort.\n";
	print "\n";
	exit;
}

unless($list && $data){
	print "Error: The options 'positions' and 'genome' are required.\n";
	exit;
}

unless(-e $list){
	print "Error: the file $list does not exist\n";
	exit;
}

unless(-e $data){
	print "Error: the file $data does not exist\n";
	exit;
}

unless($size){
	print "Error: the option 'size' is necessary\n";
	exit;
}

unless($out){
	print "Error: the option 'out' is necessary\n";
	exit;
}

###########################


$seq="";
open(FILE,"$data");
while($line = <FILE>){
	$line =~ s/\r\n/\n/;
	if($line =~ /^>/){
		unless($seq eq ""){
			$chrom{$name}=$seq;
		}
		chomp($line);
		$line =~ s/>//;
		$name=$line;
		$seq="";
	}
	else{
		chomp($line);
		$seq="$seq$line";
	}
}
close(FILE);
$chrom{$name}=$seq;


open(FILE,"$list");
open(TEXT,">$out");
while($line = <FILE>){
	chomp($line);
	@a=split(/\t/,$line);
	$seq=substr($chrom{$a[1]},$a[2]-$size-1,2*$size+1);
	print TEXT ">$a[0]\n$seq\n";
}

