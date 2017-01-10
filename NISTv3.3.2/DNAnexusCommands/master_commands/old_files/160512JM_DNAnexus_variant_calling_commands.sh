################################### I L L U M I N A ######################################

#Split novoalign bam file by chrom and add read groups for GATK
#bam files generated by NHGRI and available at: ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/NHGRI_Illumina300X_novoalign_bams/HG001.hs37d5.300x.bam and ....bai
#Note that we do this in 3 separate processes on DNAnexus to parallelize, but this isn't required as long as there is sufficient disk space (~1.2TB)
#Sorted mappings (sorted_bam): HG001.hs37d5.300x_novoalign.bam
#Sorted mappings index (index_bai): HG001.hs37d5.300x_novoalign.bai
#Read group ID (rgid): 1
#Read group LB (rglb): all
#Read group PL (rgpl): illumina
#Read group PU (rgpu): all
#Read group SM (rgsm): NA12878
#Output examples for first 3 chrom's:
#Index1 (bai1): HG001.hs37d5.300x_novoalign.1.bai
#Index2 (bai2): HG001.hs37d5.300x_novoalign.2.bai
#Index3 (bai3): HG001.hs37d5.300x_novoalign.3.bai
#Bam1 (bam1): HG001.hs37d5.300x_novoalign.1.bam
#Bam2 (bam2): HG001.hs37d5.300x_novoalign.2.bam
#Bam3 (bam3): HG001.hs37d5.300x_novoalign.3.bam
dx run GIAB:/Workflow/samtools_splitchrom_addrg_1to5 -isorted_bam=HG001.hs37d5.300x_novoalign.bam -iindex_bai=HG001.hs37d5.300x_novoalign.bai -irgid=1 -irglb=all -irgpl=illumina -irgpu=all -irgsm=NA12878 
dx run GIAB:/Workflow/samtools_splitchrom_addrg_6to12 -isorted_bam=HG001.hs37d5.300x_novoalign.bam -iindex_bai=HG001.hs37d5.300x_novoalign.bai -irgid=1 -irglb=all -irgpl=illumina -irgpu=all -irgsm=NA12878 
dx run GIAB:/Workflow/samtools_splitchrom_addrg_13toMT -isorted_bam=HG001.hs37d5.300x_novoalign.bam -iindex_bai=HG001.hs37d5.300x_novoalign.bai -irgid=1 -irglb=all -irgpl=illumina -irgpu=all -irgsm=NA12878 

#GATK Haplotype Caller
#Adjustments to options needed for each run:
#set chromosome, -L
#input bam, -isorted_bam
#input bai, -isorted_bai
#output gvcf filename prefix, -ioutput_prefix
dx run GIAB:/Workflow/GATK_V3.5/gatk-haplotypecaller-v35 -isorted_bam=HG001.hs37d5.300x_novoalign.20.bam -isorted_bai=HG001.hs37d5.300x_novoalign.20.bai -ioutput_prefix=HG001_20_hs37d5_novoalign_Ilmn150bp300X_GATKHC_gvcf -iextra_options="-L 20 -stand_call_conf 2 -stand_emit_conf 2 -A BaseQualityRankSumTest -A ClippingRankSumTest -A Coverage -A FisherStrand -A LowMQ -A RMSMappingQuality -A ReadPosRankSumTest -A StrandOddsRatio -A HomopolymerRun -A TandemRepeatAnnotator"

#GATK gvcf --> vcf conversion
#Adjustments to options needed for each run:
#input "vcf", -ivcfs
#input .vcf.tbi, -ivcfs
#output vcf filename prefix (adjust for RL and chemistry), -iprefix
dx run GIAB:/Workflow/GATK_V3.5/gatk-genotype-gvcfs-v3.5 -ivcfs=HG001_20_hs37d5_novoalign_Ilmn150bp300X_GATKHC_gvcf.vcf.gz -ivcfs=HG001_20_hs37d5_novoalign_Ilmn150bp300X_GATKHC_gvcf.vcf.gz.tbi -iprefix=HG001_20_hs37d5_novoalign_Ilmn150bp300X_GATKHC

#FreeBayes
#Adjustments to options needed for each run:
#input bam, -isorted_bam
#output vcf filename prefix, -ioutput_prefix
#set reference genome, -igenome_fastagz
#set chromosome for bamtools, -itargets_bed
dx run freebayes -isorted_bams=HG001.hs37d5.300x_novoalign.20.bam -ioutput_prefix=HG001_20_hs37d5_novoalign_Ilmn150bp300X_FB_regiontest -igenome_fastagz="Reference Genome Files:/H. Sapiens - GRCh37 - hs37d5 (1000 Genomes Phase II)/hs37d5.fa.gz" -igenotype_qualities=TRUE -itargets_bed="GIAB:/Workflow/Chromosome_bed_files/20.bed" -istandard_filters=FALSE -iadvanced_options="-F 0.05 -m 0"

#GATK CallableLoci
#Adjustments to options needed for each run:
#input bam, -iinput_bam
#input bai, -iinput_bai
#output files prefix, -ioutput_prefix
#set region/chromosome, -L 
#maximum coverage threshold (dependent on platform-- 2x median depth=560 for Illumina), -maxDepth
dx run GIAB:/Workflow/GATK_V3.5/gatk-callableloci-v3.5 -iinput_bam=HG001.hs37d5.300x_novoalign.20.bam -iinput_bai=HG001.hs37d5.300x_novoalign.20.bai -ioutput_prefix=HG001_hs37d5_novoalign_Ilmn150bp300X_callableloci -iextra_options="-L 20 -minDepth 20 -mmq 20 -maxDepth 560"

#Combine individual bed files into one bed
#Adjustments to options needed for each run:
#directory where bed files are located
#set name of output file, -iprefix
#set output directory, --destination
bed_inputs=""
for l in `dx ls "GIAB:/NA12878/Illumina/CallableLoci_output/*.bed"`; do bed_inputs="-ibeds=/NA12878/Illumina/CallableLoci_output/$l $bed_inputs"; done
dx run GIAB:/Workflow/bed-combineallchrom $bed_inputs -iprefix=HG001_ALLCHROM_hs37d5_novoalign_Ilmn150bp300X_callableloci --destination=/NA12878/Illumina/CallableLoci_output/

#Combine individual vcf files from GATK into one vcf
#Adjustments to options needed for each run:
#directory where vcf files are located
#set name of output file, -iprefix
#set output directory, --destination
vcf_inputs=""
for l in `dx ls "GIAB:/NA12878/Illumina/GATKHC_output/*GATKHC.vcf.gz"`; do vcf_inputs="-ivcfs=/NA12878/Illumina/GATKHC_output/$l $vcf_inputs"; done
dx run GIAB:/Workflow/vcf-combineallchrom $vcf_inputs -iprefix=HG001_ALLCHROM_hs37d5_novoalign_Ilmn150bp300X_GATKHC  --destination=/NA12878/Illumina/GATKHC_output/

#Combine individual vcf files from FreeBayes into one vcf
#Adjustments to options needed for each run:
#directory where vcf files are located
#set name of output file, -iprefix
#set output directory, --destination
vcf_inputs=""
for l in `dx ls "GIAB:/NA12878/Illumina/FreeBayes_output/*FB.vcf.gz"`; do vcf_inputs="-ivcfs=/NA12878/Illumina/FreeBayes_output/$l $vcf_inputs"; done
dx run GIAB:/Workflow/vcf-combineallchrom $vcf_inputs -iprefix=HG001_ALLCHROM_hs37d5_novoalign_Ilmn150bp300X_FB  --destination=/NA12878/Illumina/FreeBayes_output/

###################################### S O L I D ######################################### 

#AddOrReplaceReadGroups using Picard
#Replace Read Groups for each sample
#Adjustments to options needed for each run:
#input bam, I
#output bam, O
#RGID = genome_date_lane 
#RGLB = vial # used for library
#RGPL = solid (platform used)
#RGSM = genome (ex. HG001)
#RGPU= lane #
java -jar /Applications/bfx_tools/picard-tools-1.141/picard.jar AddOrReplaceReadGroups I=/Volumes/Boron/LifescopeMappingData/13_09_20_Hg19_map_1/outputs/pair.mapping/5500W_13_09_20_FC1_1_L01_17/5500W_13_09_20_FC1_1_L01-1-Idx_17-17.bam O=/Volumes/Boron/LifescopeMappingData/HG001_5500W_combined/AddReplaceRG/5500W_13_09_20_FC1_1_L01_17.bam RGID=HG001_130920_L1 RGLB=3 RGPU=1 RGPL=solid RGSM=HG001 VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=true

#Merge and Index using Samtools
#Merge bams by genome/run with Samtools
#Adjustments to options needed for each run:
#input bams -- create txt file listing paths for all bam to be merged
#output bam -- specify path to new merged file
samtools merge -b /Users/jmcdani/Documents/GiaB/GiAB_informatics_work/SOLiD Data/HG1_analysis/files_for_processing/130920_merge.txt /Volumes/Boron/LifescopeMappingData/HG001_5500W_combined/samtools_merged_indexed/130920_HG001_merged.bam
#output indexed bam -- specify path to indexed merged bam
samtools index /Volumes/Boron/LifescopeMappingData/HG001_5500W_combined/samtools_merged_indexed/130920_HG001_merged.bam

#Reheader and reindex merged bam files
#create new header removing chr and changing M-->MT
sed 's/chrM/MT/;s/chr//‘ bam.hdr > bam.b37.hdr
#Adjustments to options needed for each run:
#provide paths to inputs and outputs
samtools reheader bam.b37.hdr bam1.bam > bam.b37.bam
samtools index bam.b37.bam

#Split merged bam by chromosome, removed MT
dx run -y GIAB:/Workflow/samtools_splitchrom_addrg_reord_1to5 -isorted_bam=HG001_hg19_solid5500_PE50x50bp.bam -iindex_bai=HG001_hg19_solid5500_PE50x50bp.bam.bai -irgid=1 -irglb=all -irgpl=solid -irgpu=all -irgsm=NA12878 
dx run -y GIAB:/Workflow/samtools_splitchrom_addrg_reord_6to12 -isorted_bam=HG001_hg19_solid5500_PE50x50bp.bam -iindex_bai=HG001_hg19_solid5500_PE50x50bp.bam.bai -irgid=1 -irglb=all -irgpl=solid -irgpu=all -irgsm=NA12878 
dx run -y GIAB:/Workflow/samtools_splitchrom_addrg_reord_13toMT -isorted_bam=HG001_hg19_solid5500_PE50x50bp.bam -iindex_bai=HG001_hg19_solid5500_PE50x50bp.bam.bai -irgid=1 -irglb=all -irgpl=solid -irgpu=all -irgsm=NA12878 

#GATK Haplotype Caller
#Adjustments to options needed for each run:
#set chromosome, -L
#input bam, -isorted_bam
#input bai, -isorted_bai
#output gvcf filename prefix (adjust for RL and chemistry), -ioutput_prefix
dx run -y GIAB:/Workflow/GATK_V3.5/gatk-haplotypecaller-v35 -isorted_bam=GIAB:/NA12878/SOLID/130920_PE50x50bp/HG001_hg19_solid5500_PE50x50bp.20.bam -isorted_bai=GIAB:/NA12878/SOLID/130920_PE50x50bp/HG001_hg19_solid5500_PE50x50bp.20.bai -ioutput_prefix=HG001_20_hg19_solid5500_PE50x50bp_GATKHC_gvcf -iextra_options="-L 20 -stand_call_conf 2 -stand_emit_conf 2 -A BaseQualityRankSumTest -A ClippingRankSumTest -A Coverage -A FisherStrand -A LowMQ -A RMSMappingQuality -A ReadPosRankSumTest -A StrandOddsRatio -A HomopolymerRun -A TandemRepeatAnnotator"

#GATK gvcf --> vcf conversion
#Adjustments to options needed for each run:
#input "vcf", -ivcfs
#input .vcf.tbi, -ivcfs
#output vcf filename prefix, -iprefix
dx run -y GIAB:/Workflow/GATK_V3.5/gatk-genotype-gvcfs-v3.5 -ivcfs=HG001_20_hg19_solid5500_PE50x50bp_GATKHC_gvcf.vcf.gz -ivcfs=HG001_20_hg19_solid5500_PE50x50bp_GATKHC_gvcf.vcf.gz.tbi -iprefix=HG001_20_hg19_solid5500_PE50x50bp_GATKHC

#GATK CallableLoci
#Adjustments to options needed for each run:
#input bam, -iinput_bam
#input bai, -iinput_bai
#output files prefix, -ioutput_prefix
#set region/chromosome, -L 
#maximum coverage threshold (dependent on platform-- 2x median (12) = 24 for SOLiD), -maxDepth
dx run -y GIAB:/Workflow/GATK_V3.5/gatk-callableloci-v3.5 -iinput_bam=GIAB:/NA12878/SOLID/130920_PE50x50bp/HG001_hg19_solid5500_PE50x50bp.20.bam -iinput_bai=GIAB:/NA12878/SOLID/130920_PE50x50bp/HG001_hg19_solid5500_PE50x50bp.20.bai -ioutput_prefix=HG001_20_hg19_solid5500_PE50x50bp_callableloci -iextra_options="-L 20 -minDepth 20 -mmq 20 -maxDepth 24"

#Combine individual bed files into one bed
#Adjustments to options needed for each run:
#directory where bed files are located
#set name of output file, -iprefix
#set output directory, --destination
bed_inputs=""
for l in `dx ls "GIAB:/NA12878/SOLID/130920_PE50x50bp/callableLoci_output/*.bed"`; do bed_inputs="-ibeds=/NA12878/Illumina/CallableLoci_output/$l $bed_inputs"; done
dx run GIAB:/Workflow/bed-combineallchrom $bed_inputs -iprefix=HG001_ALLCHROM_hg19_solid5500_PE50x50bp_callableloci --destination=/NA12878/SOLID/130920_PE50x50bp/callableLoci_output/

#Combine individual vcf files into one vcf
#Adjustments to options needed for each run:
#directory where vcf files are located
#set name of output file, -iprefix
#set output directory, --destination
vcf_inputs=""
for l in `dx ls "GIAB:/NA12878/SOLID/130920_PE50x50bp/GATKHC_output/*GATKHC.vcf.gz"`; do vcf_inputs="-ivcfs=/NA12878/SOLID/130920_PE50x50bp/GATKHC_output/$l $vcf_inputs"; done
dx run GIAB:/Workflow/vcf-combineallchrom $vcf_inputs -iprefix=HG001_ALLCHROM_hg19_solid5500_PE50x50bp_GATKHC  --destination=/NA12878/SOLID/130920_PE50x50bp/GATKHC_output/

######################### C O M P L E T E  G E N O M I C S ###############################    

#Generate vcf and bed from Complete Genomics vcfBeta
#vcfbeta file for NA12878 downloaded from ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/analysis/CompleteGenomics_RMDNA_11272014/ASM/vcfBeta-GS000025639-ASM.vcf.bz2
#Adjustments to options needed for each run:
#split by chromosome, -ichrom
#location for output files, -destination
dx run GIAB:/Workflow/integration-prepare-cg -ivcf_in=/NA12878/Complete_Genomics/vcfBeta-GS000025639-ASM.vcf.bz2 -ichrom=20 --destination=/NA12878/Complete_Genomics/
  
################################## I O N  T O R R E N T ##################################  

#GATK 3.5 callableLoci
#Adjustments to options needed for each run:
#Split bed by chromosome, -L 
#adjust ouput name for each chromosome, -output_prefix
dx run GIAB:/Workflow/GATK_V3.5/gatk-callableloci-v3.5 -iinput_bam=GIAB:/NA12878/Ion_Torrent/IonXpress_020_rawlib.b37.bam -iinput_bai=GIAB:/NA12878/Ion_Torrent/IonXpress_020_rawlib.b37.bam.bai -ioutput_prefix=HG001_20_hs37d5_IonExome_callableloci -iextra_options="-L 20 -minDepth 20 -mmq 20"

#Generate formatted vcf and bed from Ion vcf and targets.bed and callableloci.bed
#NA12878 Ion vcf at ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/analysis/IonTorrent_TVC_06302015/TSVC_variants_defaultlowsetting.vcf
#Ion exome targets bed at ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/analysis/IonTorrent_TVC_06302015/AmpliseqExome.20141120_effective_regions.bed
#Adjustments to options needed for each run:
#bed file for desired chromosome, -icallablelocibed
#split by chromosome, -ichrom
#location for output files, -destination
dx run GIAB:/Workflow/integration-prepare-ion -ivcf_in=/NA12878/Ion_Torrent/TSVC_variants_defaultlowsetting.vcf -icallablelocibed=/NA12878/Ion_Torrent/callableLoci_output/HG001_20_hs37d5_IonExome_callableloci.bed -itargetsbed=/NA12878/Ion_Torrent/AmpliseqExome.20141120_effective_regions.bed -ichrom=20 --destination=/NA12878/Ion_Torrent/

############################ C A L L S E T   T A B L E S #################################

#Order callsets in the callset table from what you believe to be highest quality to 
#lowest quality data.  Ideally the first dataset should be the one with local phasing information
#as this is the only one from which phasing information is used.  It is important to confirm
#that ordering of the callset table with comparisons to other callsets and manual inspection.
#Optimization of ordering of callsets might be required. 

########################## I N T E G R A T I O N  v 3 . 1 . 1 ############################

#Form high-confidence vcf and bed by integrating all individual vcf and bed files (excluding SOLID)
#multiple input vcfs from different datasets and variant callers: -ivcfs
#multiple input bed from different datasets, either output of GATK callableloci or not callable regions: -ibeds
#multiple annotations files from variant callers describing annotations for one-class filtering model: -iannotations
#tab-delimited file with vcf, bed, and annotations file names and which technology, dataset, and callset: -icallsettable
#putative structural variant regions to exclude from high-confidence regions: -isvbed
#split by chromosome, -ichrom
#location for output files, -destination
dx run -y GIAB:/Workflow/nist-integration-v3.1 -ivcfs=/NA12878/Complete_Genomics/Integration_prepare_cg_output/vcfBeta-GS000025639-ASM_20.vcf.gz -ivcfs=/NA12878/Illumina/GATKHC_output/HG001_20_hs37d5_novoalign_Ilmn150bp300X_GATKHC.vcf.gz -ivcfs=/NA12878/Illumina/FreeBayes_output/HG001_20_hs37d5_novoalign_Ilmn150bp300X_FB.vcf.gz -ivcfs=/NA12878/Ion_Torrent/Integration_prepare_ion_output/TSVC_variants_defaultlowsetting_20.vcf.gz -ivcfs=/NA12878/SOLID/130920_PE50x50bp/GATKHC_output/HG001_20_hg19_solid5500_PE50x50bp_GATKHC.vcf.gz -ivcfs=/NA12878/SOLID/131114_SE75bp/GATKHC_output/HG001_20_hg19_solid5500_SE75bp_GATKHC.vcf.gz -ibeds=/NA12878/Complete_Genomics/Integration_prepare_cg_output/vcfBeta-GS000025639-ASM_notcallable_20.bed -ibeds=/NA12878/Illumina/CallableLoci_output/HG001_20_hs37d5_novoalign_Ilmn150bp300X_callableloci.bed -ibeds=/NA12878/Ion_Torrent/Integration_prepare_ion_output/TSVC_variants_defaultlowsetting_notcallable_20.bed -ibeds=/Workflow/Chromosome_bed_files/20.bed -iannotations=/NA12878/Annotation_files/GATK_Annotations.txt -iannotations=/NA12878/Annotation_files/Freebayes_Annotations.txt -iannotations=/NA12878/Annotation_files/CG_Annotations.txt -iannotations=/NA12878/Annotation_files/Ion_Annotations.txt -icallsettable=/NA12878/callset_tables/NA12878_RM8398_Datasets_CG_Illumina_Ion_Solid5500_Files_20.txt -isvbed=/NA12878/PacBio_MetaSV_svclassify_mergedSVs.bed -ichrom=20 -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_20_v3.1b --destination=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/

##################### COMBINE INDIVIDUAL CHROMOSOME VCF AND BED FILES ####################

#Combine individual chromosome vcf and bed files into single file for use in IGV
#Adjustments to options needed for each run:
#bed_inputs - adjust path for inputs
#new same for output file, -iprefix
#output path, --destination
#*_callablemultinter_gtO.bed -- BED file with at least 1 technology callable
bed_inputs=""
for l in `dx ls "GIAB:/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/*_callablemultinter_gt0.bed"`; do bed_inputs="-ibeds=GIAB:/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/$l $bed_inputs"; done
dx run GIAB:/Workflow/bed-combineallchrom $bed_inputs -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2a_callablemultinter_gt0 --destination=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/

#*_filteredsites.bed  --BED file with 50bp regions around not-high-confidence sites
bed_inputs=""
for l in `dx ls "GIAB:/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/*_filteredsites.bed"`; do bed_inputs="-ibeds=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/$l $bed_inputs"; done
dx run GIAB:/Workflow/bed-combineallchrom $bed_inputs -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2a_filteredsites --destination=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/

#*_highconf.bed  --High-confidence BED file with at least 1 technology callable
bed_inputs=""
for l in `dx ls "GIAB:/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/*_highconf.bed"`; do bed_inputs="-ibeds=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/$l $bed_inputs"; done
dx run GIAB:/Workflow/bed-combineallchrom $bed_inputs -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2a_highconf.bed --destination=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/

#*_all.vcf.gz  -- All integrated variants, including uncertain variants as filtered rows.
vcf_inputs=""
for l in `dx ls "GIAB:/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/*v3.2a_all.vcf.gz"`; do vcf_inputs="-ivcfs=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/$l $vcf_inputs"; done
dx run GIAB:/Workflow/vcf-combineallchrom $vcf_inputs -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2a_all  --destination=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/

#*_highconf_vcf.gz -- High-confidence integrated variants.
vcf_inputs=""
for l in `dx ls "GIAB:/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/*highconf.vcf.gz"`; do vcf_inputs="-ivcfs=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/$l $vcf_inputs"; done
dx run GIAB:/Workflow/vcf-combineallchrom $vcf_inputs -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2a_highconf --destination=/NA12878/Integration_v3.2_output/160510_Ill_CG_Ion_Solid_v3.2a/

################## COMPARE OTHERS CALLS TO NEW HIGH CONFIDENCE CALLS #####################

#Compare other callsets to high-confidence calls to confirm their accuracy

#run on combined chromosomes 
#Compare to Platinum Genomes, kmer-filtered, removing 50bp from edges of bed files
dx run -y GIAB:/Workflow/compare-callsets -ivcfhighconfgz=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.vcf.gz -ivcfhighconftbi=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.vcf.gz.tbi -ibedhighconf=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.bed -ivcftestgz=/NA12878/PlatinumGenomes/platinum_NA12878_v7.1.0-kmer_filtered.vcf.gz -ivcftesttbi=/NA12878/PlatinumGenomes/platinum_NA12878_v7.1.0-kmer_filtered.vcf.gz.tbi -ibedtest=/NA12878/PlatinumGenomes/platinum_all_slop50.bed -isvbed=/NA12878/PacBio_MetaSV_svclassify_mergedSVs.bed -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion_newSV_v3.1.1_compare_PG7.1kmerslop50 --destination=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/comp_PG7.1kmerslop50/

#Compare to old NIST v2.19 high-confidence calls
dx run -y GIAB:/Workflow/compare-callsets -ivcfhighconfgz=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.vcf.gz -ivcfhighconftbi=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.vcf.gz.tbi -ibedhighconf=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.bed -ivcftestgz=/NA12878/AllFDAdatasets_131103_allcall_UGHapMerge_HetHomVarPASS_VQSRv2.19_2mindatasets_5minYesNoRatio_all_nouncert_excludesimplerep_excludesegdups_excludedecoy_excludeRepSeqSTRs_noCNVs.vcf.gz -ivcftesttbi=/NA12878/AllFDAdatasets_131103_allcall_UGHapMerge_HetHomVarPASS_VQSRv2.19_2mindatasets_5minYesNoRatio_all_nouncert_excludesimplerep_excludesegdups_excludedecoy_excludeRepSeqSTRs_noCNVs.vcf.gz.tbi -ibedtest=/NA12878/union13callableMQonlymerged_addcert_nouncert_excludesimplerep_excludesegdups_excludedecoy_excludeRepSeqSTRs_noCNVs_v2.19_2mindatasets_5minYesNoRatio.bed -isvbed=/NA12878/PacBio_MetaSV_svclassify_mergedSVs.bed -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion_newSV_v3.1.1_compare_NIST2.19 --destination=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/comp_NIST2.19/

#Compare to freebayes calls from moleculo
dx run -y GIAB:/Workflow/compare-callsets -ivcfhighconfgz=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.vcf.gz -ivcfhighconftbi=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.vcf.gz.tbi -ibedhighconf=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.1b_highconf.bed -ivcftestgz=/NA12878/NA12878.moleculo.bwa-mem.20140110_fb09910.maxcompgap50.vcf.gz -ivcftesttbi=/NA12878/NA12878.moleculo.bwa-mem.20140110_fb09910.maxcompgap50.vcf.gz.tbi -ibedtest=/Workflow/Chromosome_bed_files/all.bed -isvbed=/NA12878/PacBio_MetaSV_svclassify_mergedSVs.bed -iprefix=NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion_newSV_v3.1.1_compare_moleculoFB --destination=/NA12878/Integration_v3.1_output/160422_Ill_CG_Ion_Solid/using_svbed_PacBio/comp_moleculoFB/
   