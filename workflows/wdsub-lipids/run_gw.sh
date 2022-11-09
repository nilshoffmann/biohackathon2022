# -----------------------------------------------------------------------
# CONFIGURATION VARIABLES
shex_files_path='wdsub-lipids';
shex_file_names=(lipids);
results_files_path='results';
data_files_path='data';
workdir=${pwd}
# -----------------------------------------------------------------------
# DO NOT MODIFY ANYTHING BELOW THIS LINE!!!

echo 'Welcome to WDSub GenWiki!';
echo 'This script will create a subset for each defined shape.';

echo 'Pulling wdsub docker image...';
docker pull wesogroup/wdsub:0.0.28;



for shex_file_name in "${shex_file_names[@]}"
do
    echo "Creating subset for ${shex_files_path}/${shex_file_name}.shex";
    dockerID=`docker run --rm --name wdsub -d \
    	-v "$workdir/$data_files_path:/data" \
        -v "$workdir/$shex_files_path:/shex" \
        -v "$workdir/$results_files_path:/dumps" \
        wesogroup/wdsub:0.0.28 dump \
        -o /dumps/result_$shex_file_name.ttl.gz \
        -s /shex/$shex_file_name.shex \
        --processor WDTK \
        --dumpFormat Turtle \
        --dumpMode OnlyMatched \
        --schemaFormat ShExC \
        /data/20141124.json.gz;`
    echo "Subsetting is being created  for ${shex_files_path}/${shex_file_name}.shex";
    echo "Check ${dockerID} for progres" 
done
