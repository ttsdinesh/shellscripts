#This script backs up modified files tracked by git, as .gz file
#Author ttsdinesh@gmail.com
#Add this to bash_profile with alias something like gitbkp

bkp_dir='/Users/dthangaraj/git_bkp' #Location to which the backup will be zipped
bkp_file="$bkp_dir/git_bkp_`date +%Y_%b_%d_%H_%M_%S`.gz"
git_location='<apth to the git repo>'

echo "Git Status"
git -C $git_location status | grep modified | sed -e 's/modified:   //g' | tr "\t" "/" | tr -s " " | awk -v my_var=$git_location '{print my_var $0;}'
echo "Backing up files from $git_location as $bkp_file" 
tar -zcvf $bkp_file $(git -C $git_location status | grep modified | sed -e 's/modified:   //g' | tr "\t" "/" | tr -s " " | awk -v my_var=$git_location '{print my_var $0;}')

