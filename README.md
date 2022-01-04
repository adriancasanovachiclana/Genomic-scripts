# Genomic-scripts
This repository contains scripts for genomic data analysis

Authors: Andrés Blanco Hortas and/or Adrián Casanova Chiclana 
Mail contact: andres.blanco.hortas@usc.es, adrian.casanova@usc.es

## FlankingRegions.pl

Script to extract adjacent sequences to a target position.                                                                                                                Options:                                                                                                                        
-p, --positions   Path to the text file with the list of positions to be extracted. Format: Chrom.<tab>pos.                                                            -g, --genome      Path to the file with the genome sequences.
-o, --out         Path to the output file.
-s, --size        Size of the sequences on either side of the position.
-h, --help        Show this help and abort.
  
Command line example to extract adjacent sequences to target position from reference genome (sequence length = 201 nucleotides)
perl FlankingRegions.pl -p /targetpositions.txt -g /ReferenceGenome.fna -o /output.fasta -s 100
