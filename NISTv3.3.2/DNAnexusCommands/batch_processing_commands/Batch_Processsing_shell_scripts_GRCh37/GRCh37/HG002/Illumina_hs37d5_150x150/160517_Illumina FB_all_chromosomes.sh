#FreeBayes
#Adjustments to options needed for each run:
#input bam, -isorted_bam
#output vcf filename prefix, -ioutput_prefix
#set reference genome, -igenome_fastagz
#set chromosome for bamtools, -itargets_bed
#output path, --destination

#HG002 run 5/17/16, ran 17 min up to to ~3hrs
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.1.bam -ioutput_prefix=HG002_1_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/1.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.2.bam -ioutput_prefix=HG002_2_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/2.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.3.bam -ioutput_prefix=HG002_3_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/3.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.4.bam -ioutput_prefix=HG002_4_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/4.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.5.bam -ioutput_prefix=HG002_5_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/5.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.6.bam -ioutput_prefix=HG002_6_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/6.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.7.bam -ioutput_prefix=HG002_7_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/7.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.8.bam -ioutput_prefix=HG002_8_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/8.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.9.bam -ioutput_prefix=HG002_9_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/9.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.10.bam -ioutput_prefix=HG002_10_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/10.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.11.bam -ioutput_prefix=HG002_11_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/11.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.12.bam -ioutput_prefix=HG002_12_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/12.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.13.bam -ioutput_prefix=HG002_13_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/13.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.14.bam -ioutput_prefix=HG002_14_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/14.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.15.bam -ioutput_prefix=HG002_15_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/15.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.16.bam -ioutput_prefix=HG002_16_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/16.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.17.bam -ioutput_prefix=HG002_17_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/17.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.18.bam -ioutput_prefix=HG002_18_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/18.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.19.bam -ioutput_prefix=HG002_19_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/19.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.20.bam -ioutput_prefix=HG002_20_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/20.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.21.bam -ioutput_prefix=HG002_21_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/21.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.22.bam -ioutput_prefix=HG002_22_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/22.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.X.bam -ioutput_prefix=HG002_X_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/X.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.Y.bam -ioutput_prefix=HG002_Y_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/Y.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/
dx run -y freebayes -isorted_bams=GIAB:/HG002/Illumina/HG002.hs37d5.300x_novoalign.MT.bam -ioutput_prefix=HG002_MT_hs37d5_novoalign_Ilmn150bp300X_FB -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/MT.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0" --destination=/HG002/Illumina/FreeBayes_output/